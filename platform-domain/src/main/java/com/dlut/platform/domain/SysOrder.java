package com.dlut.platform.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class SysOrder implements Serializable {
    private static final long serialVersionUID = 4166722342053578762L;
    private Integer id;
    private Integer skuId;
    private Double skuPrice;
    private Integer skuNum;
    private Double orderPrice;
    private Integer buyUserId;
    private Integer skuUserId;
    private Date createDate;
    private Date updateDate;
    private String orderContent;

    private String buyUserName;
    private String skuName;
    private List<SysOrderLog> orderLogs;
    private UserVo userVo;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSkuId() {
        return skuId;
    }

    public void setSkuId(Integer skuId) {
        this.skuId = skuId;
    }

    public Double getSkuPrice() {
        return skuPrice;
    }

    public void setSkuPrice(Double skuPrice) {
        this.skuPrice = skuPrice;
    }

    public Integer getSkuNum() {
        return skuNum;
    }

    public void setSkuNum(Integer skuNum) {
        this.skuNum = skuNum;
    }

    public Double getOrderPrice() {
        return orderPrice;
    }

    public void setOrderPrice(Double orderPrice) {
        this.orderPrice = orderPrice;
    }

    public Integer getBuyUserId() {
        return buyUserId;
    }

    public void setBuyUserId(Integer buyUserId) {
        this.buyUserId = buyUserId;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public String getOrderContent() {
        return orderContent;
    }

    public void setOrderContent(String orderContent) {
        this.orderContent = orderContent == null ? null : orderContent.trim();
    }

    public String getSkuName() {
        return skuName;
    }

    public void setSkuName(String skuName) {
        this.skuName = skuName;
    }

    public List<SysOrderLog> getOrderLogs() {
        return orderLogs;
    }

    public void setOrderLogs(List<SysOrderLog> orderLogs) {
        this.orderLogs = orderLogs;
    }

    public Integer getSkuUserId() {
        return skuUserId;
    }

    public void setSkuUserId(Integer skuUserId) {
        this.skuUserId = skuUserId;
    }

    public UserVo getUserVo() {
        return userVo;
    }

    public void setUserVo(UserVo userVo) {
        this.userVo = userVo;
    }

    public String getBuyUserName() {
        return buyUserName;
    }

    public void setBuyUserName(String buyUserName) {
        this.buyUserName = buyUserName;
    }
}