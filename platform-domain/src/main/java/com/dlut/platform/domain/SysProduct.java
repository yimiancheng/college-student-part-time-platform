package com.dlut.platform.domain;

import com.dlut.platform.domain.enumVo.PRODUCT_ENUM;
import java.io.Serializable;
import java.util.Date;

public class SysProduct implements Serializable {
    private static final long serialVersionUID = 6378301604223211700L;
    private Integer id;
    private Integer userId;
    private Integer skuTypeId;
    private String skuName;
    private String skuImg;
    private String tradePosition;
    private Double price;
    private String creatorname;
    private PRODUCT_ENUM skuStatus;
    private Byte skuAttr;
    private Boolean daofou;
    private Date createDate;
    private Date updateDate;
    private String skuContent;
    private Date buyDate;

    private SysProductStock productStock;

    private Integer skuNum;
    private Integer skuStockId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getSkuTypeId() {
        return skuTypeId;
    }

    public void setSkuTypeId(Integer skuTypeId) {
        this.skuTypeId = skuTypeId;
    }

    public String getSkuName() {
        return skuName;
    }

    public void setSkuName(String skuName) {
        this.skuName = skuName == null ? null : skuName.trim();
    }

    public String getSkuImg() {
        return skuImg;
    }

    public void setSkuImg(String skuImg) {
        this.skuImg = skuImg == null ? null : skuImg.trim();
    }

    public String getTradePosition() {
        return tradePosition;
    }

    public void setTradePosition(String tradePosition) {
        this.tradePosition = tradePosition == null ? null : tradePosition.trim();
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getCreatorname() {
        return creatorname;
    }

    public void setCreatorname(String creatorname) {
        this.creatorname = creatorname == null ? null : creatorname.trim();
    }

    public PRODUCT_ENUM getSkuStatus() {
        return skuStatus;
    }

    public void setSkuStatus(PRODUCT_ENUM skuStatus) {
        this.skuStatus = skuStatus;
    }

    public Boolean getDaofou() {
        return daofou;
    }

    public void setDaofou(Boolean daofou) {
        this.daofou = daofou;
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

    public String getSkuContent() {
        return skuContent;
    }

    public void setSkuContent(String skuContent) {
        this.skuContent = skuContent == null ? null : skuContent.trim();
    }

    public Byte getSkuAttr() {
        return skuAttr;
    }

    public void setSkuAttr(Byte skuAttr) {
        this.skuAttr = skuAttr;
    }

    public Date getBuyDate() {
        return buyDate;
    }

    public void setBuyDate(Date buyDate) {
        this.buyDate = buyDate;
    }

    public Integer getSkuNum() {
        return skuNum;
    }

    public void setSkuNum(Integer skuNum) {
        this.skuNum = skuNum;
    }

    public Integer getSkuStockId() {
        return skuStockId;
    }

    public void setSkuStockId(Integer skuStockId) {
        this.skuStockId = skuStockId;
    }

    public SysProductStock getProductStock() {
        return productStock;
    }

    public void setProductStock(SysProductStock productStock) {
        this.productStock = productStock;
    }
}