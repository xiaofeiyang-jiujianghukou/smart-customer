//package com.ai.agent.customer.base.framework.config.interceptor;
//
//import com.truejarvis.common.ErrorCode;
//import com.truejarvis.common.exception.BusinessException;
//import lombok.RequiredArgsConstructor;
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.http.server.ServerHttpRequest;
//import org.springframework.http.server.ServerHttpResponse;
//import org.springframework.stereotype.Component;
//import org.springframework.web.socket.WebSocketHandler;
//import org.springframework.web.socket.server.HandshakeInterceptor;
//
//import java.net.URI;
//import java.util.Map;
//
//@Slf4j
//@Component
//@RequiredArgsConstructor
//public class AuthHandshakeInterceptor implements HandshakeInterceptor {
//
//    // TODO: 注入 JwtTokenUtil 进行真实验证
//    // private final JwtTokenUtil jwtTokenUtil;
//
//    @Override
//    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response,
//                                   WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {
//        URI uri = request.getURI();
//        String token = extractToken(uri.getQuery());
//
//        if (token == null || token.isEmpty()) {
//            log.warn("WebSocket handshake failed: Missing token");
//            return false; // 拒绝握手
//        }
//
//        try {
//            // 【模拟】解析 Token 获取 UserId
//            // 真实场景：String userId = jwtTokenUtil.getUserIdFromToken(token);
//            String userId = validateTokenAndExtractUserId(token);
//
//            if (userId == null) {
//                throw new BusinessException(ErrorCode.UNAUTHORIZED, "Invalid token");
//            }
//
//            // 将 userId 存入 attributes，后续在 Handler 中通过 session.getAttributes() 获取
//            attributes.put("userId", userId);
//
//            // 生成或获取 connectionId (这里简单用 userId 代替，生产建议用 UUID)
//            attributes.put("connectionId", userId + "-" + System.currentTimeMillis());
//
//            log.info("WebSocket handshake success for user: {}", userId);
//            return true;
//        } catch (Exception e) {
//            log.error("WebSocket authentication failed", e);
//            return false;
//        }
//    }
//
//    @Override
//    public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response,
//                               WebSocketHandler wsHandler, Exception exception) {
//        // 握手后逻辑，通常为空
//    }
//
//    private String extractToken(String query) {
//        if (query == null) return null;
//        for (String param : query.split("&")) {
//            String[] pair = param.split("=");
//            if ("token".equals(pair[0]) && pair.length > 1) {
//                return pair[1];
//            }
//        }
//        return null;
//    }
//
//    private String validateTokenAndExtractUserId(String token) {
//        // TODO: 替换为真实的 JWT 验证逻辑
//        // if (jwtTokenUtil.validateToken(token)) return jwtTokenUtil.getUserId(token);
//
//        // Mock: 假设 token 就是 userId (仅开发测试用)
//        return token.startsWith("user-") ? token : null;
//    }
//}
