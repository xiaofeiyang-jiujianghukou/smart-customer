//package com.ai.agent.customer.base.framework.config.filter;
//
//import com.truejarvis.util.JwtUtils;
//import jakarta.servlet.FilterChain;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
//import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.stereotype.Component;
//import org.springframework.util.StringUtils;
//import org.springframework.web.filter.OncePerRequestFilter;
//
//import java.io.IOException;
//
//@Component
//public class AuthTokenFilter extends OncePerRequestFilter {
//
//    @Autowired
//    private JwtUtils jwtUtils;
//
//    @Override
//    protected void doFilterInternal(HttpServletRequest request,
//                                    HttpServletResponse response,
//                                    FilterChain filterChain) throws ServletException, IOException {
//
//        // 放过公开接口
//        String path = request.getServletPath();
//        if (isPublicPath(path)) {
//            filterChain.doFilter(request, response);
//            return;
//        }
//
//        try {
//            String token = extractJwtFromRequest(request);
//
//            if (token == null) {
//                // 没有token，返回401
//                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Missing token");
//                return;
//            }
//
//            if (!jwtUtils.validateToken(token)) {
//                // token无效，返回401
//                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid token");
//                return;
//            }
//
//            // token有效，设置认证信息
//            String username = jwtUtils.getUserNameFromToken(token);
//            UsernamePasswordAuthenticationToken authentication =
//                    new UsernamePasswordAuthenticationToken(username, null, null);
//            SecurityContextHolder.getContext().setAuthentication(authentication);
//
//            filterChain.doFilter(request, response);
//
//        } catch (Exception e) {
//            logger.error("认证失败", e);
//            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Authentication failed");
//        }
//    }
//
//    private boolean isPublicPath(String path) {
//        return path.equals("/api/auth/login") ||
//                path.equals("/api/auth/register") ||
//                path.startsWith("/public/");
//    }
//
//    private String extractJwtFromRequest(HttpServletRequest request) {
//        String bearerToken = request.getHeader("Authorization");
//        if (StringUtils.hasText(bearerToken) && bearerToken.startsWith("Bearer ")) {
//            return bearerToken.substring(7);
//        }
//        return null;
//    }
//}
