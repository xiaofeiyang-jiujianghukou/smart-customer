//package com.ai.agent.customer.base.framework.config.handler;
//
//import org.apache.ibatis.type.BaseTypeHandler;
//import org.apache.ibatis.type.JdbcType;
//import org.apache.ibatis.type.MappedTypes;
//
//import java.sql.CallableStatement;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.ArrayList;
//import java.util.List;
//
///**
// * 处理 PostgreSQL pgvector 类型与 Java List<Float> 的转换
// * 数据库格式: "[0.1, 0.2, 0.3]"
// * Java 格式: List<Float>
// */
//@MappedTypes(List.class)
//public class PgVectorTypeHandler extends BaseTypeHandler<List<Float>> {
//
//    @Override
//    public void setNonNullParameter(PreparedStatement ps, int i, List<Float> parameter, JdbcType jdbcType) throws SQLException {
//        if (parameter == null) {
//            ps.setNull(i, jdbcType.TYPE_CODE); // 或者使用特定的 vector oid
//            return;
//        }
//        // 方案 A: 使用 pgvector 库 (推荐，更稳健)
//        // Vector vector = new Vector(parameter.stream().mapToDouble(Float::doubleValue).toArray());
//        // ps.setObject(i, vector);
//
//        // 方案 B: 手动拼接字符串 (无额外依赖，兼容性好)
//        // PG Vector 格式要求: "[1.0,2.0,3.0]"
//        StringBuilder sb = new StringBuilder("[");
//        for (int j = 0; j < parameter.size(); j++) {
//            sb.append(parameter.get(j));
//            if (j < parameter.size() - 1) {
//                sb.append(",");
//            }
//        }
//        sb.append("]");
//        ps.setString(i, sb.toString());
//    }
//
//    @Override
//    public List<Float> getNullableResult(ResultSet rs, String columnName) throws SQLException {
//        return parseVector(rs.getString(columnName));
//    }
//
//    @Override
//    public List<Float> getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
//        return parseVector(rs.getString(columnIndex));
//    }
//
//    @Override
//    public List<Float> getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
//        return parseVector(cs.getString(columnIndex));
//    }
//
//    private List<Float> parseVector(String content) throws SQLException {
//        if (content == null || content.isEmpty() || "null".equals(content)) {
//            return null;
//        }
//        // 去除首尾的 [ ]
//        if (content.startsWith("[") && content.endsWith("]")) {
//            content = content.substring(1, content.length() - 1);
//        }
//
//        if (content.isEmpty()) {
//            return new ArrayList<>();
//        }
//
//        String[] parts = content.split(",");
//        List<Float> result = new ArrayList<>(parts.length);
//        for (String part : parts) {
//            result.add(Float.parseFloat(part.trim()));
//        }
//        return result;
//    }
//}
