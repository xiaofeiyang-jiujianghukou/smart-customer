package com.ai.agent.splitter;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import org.apache.pdfbox.text.TextPosition;
import org.springframework.ai.document.Document;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

public class FontSizeSplitter {

    private static final Pattern CHAPTER_PATTERN = Pattern.compile("^第([^章]+)章\\s*(.+)$");
    private static final Pattern SECTION_PATTERN = Pattern.compile("^([0-9]+\\.[0-9]+)\\s*(.*)");

    private static class LineInfo {
        String text;
        float fontSize;
        public LineInfo(String text, float fontSize) {
            this.text = text;
            this.fontSize = fontSize;
        }
    }

    private List<Document> documents = new ArrayList<>();
    private String currentChapterTitle = "";
    private String currentSectionTitle = "";
    private StringBuilder currentContent = new StringBuilder();

    // 全局基准字号（即“第一章”的字号）
    private static float GLOBAL_STANDARD_FONT_SIZE = 0;

    public List<Document> split(File pdfFile) throws IOException {
        documents.clear();
        currentChapterTitle = "";
        currentSectionTitle = "";
        currentContent.setLength(0);

        List<LineInfo> allLines = new ArrayList<>();

        try (PDDocument document = PDDocument.load(pdfFile)) {
            CustomTextStripper stripper = new CustomTextStripper();
            stripper.setSortByPosition(false);
            stripper.getText(document);
            allLines = stripper.getAllLines();
        }

        if (!allLines.isEmpty()) {
            processWithBacktracking(allLines);
        }

        // 结束时保存最后一段
        saveCurrentDocument();
        return documents;
    }

    private void processWithBacktracking(List<LineInfo> allLines) {
        int firstChapterIndex = -1;

        // --- 第一步：定位“第一章”，并设定全局基准字号 ---
        for (int i = 0; i < allLines.size(); i++) {
            LineInfo line = allLines.get(i);
            if (CHAPTER_PATTERN.matcher(line.text).find()) {
                firstChapterIndex = i;
                GLOBAL_STANDARD_FONT_SIZE = line.fontSize;
                System.out.println("🎯 基准字号设定为: " + GLOBAL_STANDARD_FONT_SIZE + " (基于 " + line.text + ")");
                break;
            }
        }

        if (firstChapterIndex == -1) {
            System.err.println("⚠️ 未找到第一章");
            return;
        }

        // --- 第二步：回溯处理前置内容（报告摘要） ---
        int startIndex = firstChapterIndex;
        for (int i = 0; i < firstChapterIndex; i++) {
            LineInfo line = allLines.get(i);
            // 只要字号接近基准字号，就是同级标题
            if (Math.abs(line.fontSize - GLOBAL_STANDARD_FONT_SIZE) < 1.0f) {
                startIndex = i;
                System.out.println("✅ 找到前置标题: " + line.text);
                break;
            }
        }

        // --- 第三步：流式处理 ---
        for (int i = startIndex; i < allLines.size(); i++) {
            handleLine(allLines.get(i).text, allLines.get(i).fontSize);
        }
    }

    private void handleLine(String text, float fontSize) {
        String line = text.trim();
        if (line.isEmpty()) return;

        boolean isMainHeader = false;
        boolean isSection = false;

        // 1. 标准章匹配：第X章
        if (CHAPTER_PATTERN.matcher(line).find()) {
            isMainHeader = true;
        }
        // 2. 标准节匹配：X.X
        else if (SECTION_PATTERN.matcher(line).find()) {
            isSection = true;
        }
        // 3. 【核心修复】通用大字号标题识别（解决附录问题）
        // 逻辑拆解：
        // A. 字号必须接近基准字号（说明它是标题级别）
        // B. 必须排除掉已经被 SECTION_PATTERN 匹配的情况（防止 X.X 被误判）
        // 注意：这里去掉了 `currentChapterTitle.isEmpty()` 的限制！
        // 这样在第七章之后，遇到同样字号的“附录”，也能被识别出来。
        else if (Math.abs(fontSize - GLOBAL_STANDARD_FONT_SIZE) < 1.0f) {
            isMainHeader = true;
            System.out.println("🔍 [字号突变] 识别到通用大标题: " + line);
        }

        handleContent(line, isMainHeader, isSection);
    }

    private void handleContent(String line, boolean isMainHeader, boolean isSection) {
        if (isMainHeader) {
            // 遇到新的大标题，保存上一段
            saveCurrentDocument();
            currentChapterTitle = line;
            currentSectionTitle = "";
            currentContent.setLength(0);
        }
        else if (isSection) {
            // 遇到小节，保存上一段
            saveCurrentDocument();
            currentSectionTitle = line;
            currentContent.setLength(0);
        }
        else {
            // 普通正文
            if (!currentChapterTitle.isEmpty()) {
                currentContent.append(line).append("\n");
            }
        }
    }

    private void saveCurrentDocument() {
        if (currentContent.length() == 0) return;

        String displayTitle = currentSectionTitle.isEmpty() ? currentChapterTitle : currentSectionTitle;

        Map<String, Object> metadata = new HashMap<>();
        metadata.put("chapter", currentChapterTitle);
        metadata.put("section_title", displayTitle);

        documents.add(new Document(currentContent.toString(), metadata));
        currentContent.setLength(0);
    }

    private class CustomTextStripper extends PDFTextStripper {
        private final List<LineInfo> allLines = new ArrayList<>();
        private final StringBuilder lineText = new StringBuilder();
        private Float currentLineFontSize = null;
        private float lastY = Float.MAX_VALUE;

        public CustomTextStripper() throws IOException {
            super();
            // 关键设置：关闭自动去重，确保我们能拿到每一个字符
            this.setShouldSeparateByBeads(false);
        }

        public List<LineInfo> getAllLines() {
            return allLines;
        }

        @Override
        protected void processTextPosition(TextPosition text) {
            String character = text.getUnicode();
            float y = text.getY();

            // === 核心修复：在源头清洗和修复字符 ===
            if (character != null) {
                // 1. 使用 Unicode 标准化 (NFKC) 修复连字
                // 这会自动将 "ﬀ" (连字) 拆解为 "ff"，将 "ﬁ" 拆解为 "fi"
                // 这是最科学、最通用的方法，无需硬编码任何单词
                character = java.text.Normalizer.normalize(character, java.text.Normalizer.Form.NFKC);

                // 2. 移除所有非法的控制字符
                // 这能彻底解决 PostgreSQL 的 0x00 报错问题
                // \\p{Cntrl} 匹配所有控制字符，&&[^\r\n] 排除掉正常的换行和回车
                character = character.replaceAll("[\\p{Cntrl}&&[^\r\n]]", "");
            }

            // === 原有的换行和拼接逻辑保持不变 ===
            if (currentLineFontSize != null && Math.abs(y - lastY) > (currentLineFontSize / 2)) {
                String line = lineText.toString().trim();
                if (!line.isEmpty()) {
                    allLines.add(new LineInfo(line, currentLineFontSize));
                }
                lineText.setLength(0);
                currentLineFontSize = null;
            }

            if (character != null) {
                lineText.append(character);
            }

            if (currentLineFontSize == null && character != null && !character.trim().isEmpty()) {
                currentLineFontSize = text.getFontSizeInPt();
            }
            lastY = y;
        }
    }

    // --- 测试 ---
    public static void main(String[] args) throws IOException {
        FontSizeSplitter splitter = new FontSizeSplitter();
        Resource resource = new ClassPathResource("pdfs/唯寻报告.pdf");

        if (!resource.exists()) { System.err.println("❌ 文件不存在"); return; }

        List<Document> docs = splitter.split(resource.getFile());
        System.out.println("\n=== 最终结果 ===");
        for (Document doc : docs) {
            System.out.println(doc.getMetadata().get("chapter") + " - " + doc.getMetadata().get("section_title"));
            System.out.println("内容预览: " + doc.getText());
        }
    }
}