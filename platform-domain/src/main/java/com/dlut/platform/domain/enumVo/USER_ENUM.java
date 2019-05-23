package com.dlut.platform.domain.enumVo;

import com.dlut.platform.domain.common.BaseEnum;

/**
 * USER_ENUM
 *
 * @date 2019/3/8 16:09
 */
public enum USER_ENUM implements BaseEnum {
    SYS_MNG("系统管理员"),
    TEACHER("老师"),
    STUDENT("学生"),

    NORMAL("正常"),
    FORBIDDEN_LOGIN("禁止登录");


    USER_ENUM(String name) {
        this.name = name;
    }

    @Override
    public String getName() {
        return name;
    }

    private String name;
}
