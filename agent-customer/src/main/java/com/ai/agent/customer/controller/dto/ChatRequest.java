package com.ai.agent.customer.controller.dto;

import lombok.*;

@Data
public class ChatRequest {
    private Long userId;
    private String message;
}
