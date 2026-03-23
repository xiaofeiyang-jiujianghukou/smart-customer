package com.ai.agent.customer.agent.framework.meta;

import lombok.Data;

import java.util.List;

@Data
public class AgentPlan {

    private List<AgentStep> steps;
}
