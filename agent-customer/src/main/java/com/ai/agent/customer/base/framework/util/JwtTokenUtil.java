//package com.ai.agent.customer.base.framework.util;
//
//import io.jsonwebtoken.*;
//import io.jsonwebtoken.security.Keys;
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.stereotype.Component;
//
//import javax.crypto.SecretKey;
//import java.nio.charset.StandardCharsets;
//import java.util.Date;
//
//@Slf4j
//@Component
//public class JwtTokenUtil {
//
//    @Value("${app.jwt.secret:YourSuperSecretKeyForDevelopmentOnly1234567890}")
//    private String secret;
//
//    @Value("${app.jwt.expiration:86400000}") // 24小时
//    private long expiration;
//
//    private SecretKey getSigningKey() {
//        return Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8));
//    }
//
//    public String generateToken(String userId) {
//        Date now = new Date();
//        Date expiryDate = new Date(now.getTime() + expiration);
//
//        return Jwts.builder()
//                .subject(userId)
//                .issuedAt(now)
//                .expiration(expiryDate)
//                .signWith(getSigningKey())
//                .compact();
//    }
//
//    public String getUserIdFromToken(String token) {
//        try {
//            Claims claims = Jwts.parser()
//                    .verifyWith(getSigningKey())
//                    .build()
//                    .parseSignedClaims(token)
//                    .getPayload();
//            return claims.getSubject();
//        } catch (JwtException e) {
//            log.error("Invalid JWT token: {}", e.getMessage());
//            return null;
//        }
//    }
//
//    public boolean validateToken(String token) {
//        return getUserIdFromToken(token) != null;
//    }
//}
