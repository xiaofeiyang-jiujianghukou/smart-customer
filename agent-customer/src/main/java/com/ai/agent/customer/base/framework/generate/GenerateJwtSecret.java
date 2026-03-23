//package com.ai.agent.customer.base.framework.generate;
//
//import java.security.SecureRandom;
//import java.util.Base64;
//
//public class GenerateJwtSecret {
//    public static void main(String[] args) {
//        // 生成 256-bit (32字节) 的密钥
//        SecureRandom secureRandom = new SecureRandom();
//        byte[] keyBytes = new byte[32]; // 32字节 = 256位
//        secureRandom.nextBytes(keyBytes);
//
//        // Base64编码
//        String secret = Base64.getEncoder().encodeToString(keyBytes);
//        System.out.println("生成的JWT Secret: " + secret);
//
//        // 或者生成 512-bit (64字节)
//        byte[] keyBytes512 = new byte[64];
//        secureRandom.nextBytes(keyBytes512);
//        String secret512 = Base64.getEncoder().encodeToString(keyBytes512);
//        System.out.println("512-bit Secret: " + secret512);
//    }
//}