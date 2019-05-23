package com.dlut.platform.domain;

import com.dlut.platform.domain.enumVo.PRODUCT_ENUM;
import java.io.Serializable;
import java.util.Date;

public class SysProductLike implements Serializable {
    private static final long serialVersionUID = 8613919787091066270L;
    private Integer id;
    private Integer skuId;
    private String skuName;
    private Integer userId;
    private PRODUCT_ENUM skuStatus;
    private Date createDate;
    private Date updateDate;

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

    public String getSkuName() {
        return skuName;
    }

    public void setSkuName(String skuName) {
        this.skuName = skuName;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public PRODUCT_ENUM getSkuStatus() {
        return skuStatus;
    }

    public void setSkuStatus(PRODUCT_ENUM skuStatus) {
        this.skuStatus = skuStatus;
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
}