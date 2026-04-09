package com.ai.agent.controller;

import com.ai.agent.manager.PdfManager;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/pdf")
public class PdfImportController {

    private final PdfManager pdfManager;

    public PdfImportController(PdfManager pdfManager) {
        this.pdfManager = pdfManager;
    }

    @PostMapping("/import")
    public String importPdfs(@RequestParam(defaultValue = "classpath:pdfs/") String folder) {
        return pdfManager.importPdfs(folder);
    }
}