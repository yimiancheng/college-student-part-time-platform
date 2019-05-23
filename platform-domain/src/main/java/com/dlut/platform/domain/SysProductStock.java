package com.dlut.platform.domain;

import java.io.Serializable;
import java.util.Date;

public class SysProductStock implements Serializable {
    private static final long serialVersionUID = 6412086872632737242L;
    private Integer id;
    private Integer skuId;
    private Integer num;
    private Integer numStock;
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

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    public Integer getNumStock() {
        return numStock;
    }

    public void setNumStock(Integer numStock) {
        this.numStock = numStock;
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