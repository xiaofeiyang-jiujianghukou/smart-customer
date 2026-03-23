//package com.ai.agent.customer.base.framework.util;
//
//import io.jsonwebtoken.Claims;
//import io.jsonwebtoken.JwtException;
//import io.jsonwebtoken.Jwts;
//import io.jsonwebtoken.security.Keys;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.stereotype.Component;
//
//import javax.crypto.SecretKey;
//import java.nio.charset.StandardCharsets;
//import java.util.Date;
//import java.util.HashMap;
//import java.util.Map;
//
//@Component
//public class JwtUtils {
//
//    @Value("${jwt.secret}")
//    private String jwtSecret;
//
//    @Value("${jwt.expiration}")
//    private int jwtExpirationMs;
//
//    // 生成签名密钥
//    private SecretKey getSigningKey() {
//        return Keys.hmacShaKeyFor(jwtSecret.getBytes(StandardCharsets.UTF_8));
//    }
//
//    // 生成JWT令牌
//    public String generateToken(String username) {
//        Map<String, Object> claims = new HashMap<>();
//
//        return Jwts.builder()
//                .claims(claims)                 // 设置自定义claims
//                .subject(username)               // 设置主题（用户名）
//                .issuedAt(new Date())            // 设置签发时间
//                .expiration(new Date(System.currentTimeMillis() + jwtExpirationMs))  // 设置过期时间
//                .signWith(getSigningKey())       // 签名
//                .compact();                       // 生成token
//    }
//
//    // 从令牌中获取用户名
//    public String getUserNameFromToken(String token) {
//        return getClaims(token).getSubject();
//    }
//
//    // 获取所有claims
//    private Claims getClaims(String token) {
//        return Jwts.parser()
//                .verifyWith(getSigningKey())      // 0.12.x 使用 verifyWith 设置验证密钥
//                .build()                           // 构建parser
//                .parseSignedClaims(token)          // 解析token，注意是 parseSignedClaims
//                .getPayload();                      // 获取payload（即claims）
//    }
//
//    // 验证令牌
//    public boolean validateToken(String token) {
//        try {
//            Jwts.parser()
//                    .verifyWith(getSigningKey())
//                    .build()
//                    .parseSignedClaims(token);
//            return true;
//        } catch (JwtException | IllegalArgumentException e) {
//            // 令牌无效或过期
//            return false;
//        }
//    }
//
//    // 检查令牌是否过期
//    public boolean isTokenExpired(String token) {
//        try {
//            Claims claims = getClaims(token);
//            return claims.getExpiration().before(new Date());
//        } catch (Exception e) {
//            return true;
//        }
//    }
//}
