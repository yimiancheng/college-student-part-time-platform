package com.dlut.platform.domain.enumVo;

import com.dlut.platform.domain.common.BaseEnum;

public enum PRODUCT_ENUM implements BaseEnum {
    PUBLISH("发布"),
    OFF("下架"),
    OVER("售空"),

    ORDER_CRERATE("订单创建"),
    ORDER_SHIP("订单发货"),
    ORDER_OVER("订单完成"),
    ORDER_CANCEL("订单取消"),

    LIKE_NORMAL("收藏"),
    LIKE_DEL("删除");

    PRODUCT_ENUM(String name) {
        this.name = name;
    }

    @Override
    public String getName() {
        return name;
    }

    private String name;
}
