package com.dlut.platform.domain;

import com.dlut.platform.domain.enumVo.PRODUCT_ENUM;
import java.io.Serializable;
import java.util.Date;

public class SysOrderLog implements Serializable {
    private static final long serialVersionUID = 5588299423484192138L;
    private Integer id;
    private Integer orderId;
    private PRODUCT_ENUM orderStatusOld;
    private PRODUCT_ENUM orderStatus;
    private Integer creatorId;
    private String creatorName;
    private Date createDate;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public PRODUCT_ENUM getOrderStatusOld() {
        return orderStatusOld;
    }

    public void setOrderStatusOld(PRODUCT_ENUM orderStatusOld) {
        this.orderStatusOld = orderStatusOld;
    }

    public PRODUCT_ENUM getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(PRODUCT_ENUM orderStatus) {
        this.orderStatus = orderStatus;
    }

    public Integer getCreatorId() {
        return creatorId;
    }

    public void setCreatorId(Integer creatorId) {
        this.creatorId = creatorId;
    }

    public String getCreatorName() {
        return creatorName;
    }

    public void setCreatorName(String creatorName) {
        this.creatorName = creatorName;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
}