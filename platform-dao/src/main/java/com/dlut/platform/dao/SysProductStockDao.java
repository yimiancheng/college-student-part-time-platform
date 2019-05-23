package com.dlut.platform.dao;

import com.dlut.platform.domain.SysProduct;
import com.dlut.platform.domain.SysProductStock;
import org.apache.ibatis.annotations.Param;

public interface SysProductStockDao {
    SysProductStock selectSkuStock(@Param("id") Integer skuId);

    int insertProductStock(SysProduct record);

    int updateProductStock(SysProductStock record);

    int updateProductStockNum(SysProductStock record);
}