package com.ai.agent.customer.controller;

import com.ai.agent.customer.controller.dto.ChatRequest;
import com.ai.agent.customer.service.AiPlanService;
import com.ai.agent.customer.service.AiService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/chat")
public class ChatController {

    @Autowired
    private AiService aiService;

    @Autowired
    private AiPlanService aiPlanService;

    @PostMapping("chat")
    public String chat(@RequestBody ChatRequest req) {
        return aiService.chat(req.getUserId(), req.getMessage());
    }

    @PostMapping("planChat")
    public String planChat(@RequestBody ChatRequest req) {
        return aiPlanService.chat(req.getUserId(), req.getMessage());
    }
}
