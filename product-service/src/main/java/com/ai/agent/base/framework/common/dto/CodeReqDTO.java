package com.ai.agent.base.framework.common.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
@Schema(description = "通用编号入参")
public class CodeReqDTO {

    @Schema(description = "编号")
    @NotBlank(message = "编号不能为空")
    private String code;
}
