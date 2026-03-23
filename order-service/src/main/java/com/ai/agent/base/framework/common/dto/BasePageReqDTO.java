package com.ai.agent.base.framework.common.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

@SuperBuilder
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Schema(description = "分页查询请求实体基础信息")
public class BasePageReqDTO {

    @Schema(description = "当前页数(默认为1)", defaultValue = "1")
    @NotNull(message = "当前页不能为空")
    private Integer pageIndex = 1;

    @Schema(description = "每页条数(默认10条)", defaultValue = "10")
    @NotNull(message = "分页条数不能为空")
    private final Integer pageSize =10;

    @Schema(description = "开始分页点", hidden = true)
    public Integer getPageStart() {
        return this.pageIndex * this.pageSize - this.pageSize;
    }
}
