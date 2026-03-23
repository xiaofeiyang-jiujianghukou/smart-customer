package com.ai.agent.base.framework.common.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;

@Data
@Schema(description = "分页查询返回实体基础信息")
public class BasePageResDTO<T> {

    @Schema(description = "总记录数")
    private long totalCount = 0;
    @Schema(description = "详情")
    private List<T> data;

}
