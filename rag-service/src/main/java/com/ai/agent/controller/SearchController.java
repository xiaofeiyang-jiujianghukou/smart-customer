package com.ai.agent.controller;

import com.ai.agent.base.framework.common.Result;
import com.ai.agent.manager.SearchManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/search")
public class SearchController {

    @Autowired
    private SearchManager searchManager;

    @GetMapping("/hybrid")
    public String hybridSearch(
            @RequestParam(defaultValue = "里程碑事件") String q,
            @RequestParam(defaultValue = "10") int topK) {
        return searchManager.hybridSearch(q, topK);
    }



    @GetMapping("/vector")
    public String vectorSearch(
            @RequestParam(defaultValue = "里程碑事件") String q,
            @RequestParam(defaultValue = "10") int topK) {
        return searchManager.vectorSearch(q, topK);
    }
}