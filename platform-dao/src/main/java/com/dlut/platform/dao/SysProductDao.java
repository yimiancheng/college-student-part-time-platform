package com.dlut.platform.dao;

import com.dlut.platform.domain.SysProduct;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

public interface SysProductDao {
    SysProduct selectProducts(Integer id);

    SysProduct selectBaseProducts(Integer id);

    String selectProductName(Integer id);

    List<SysProduct> selectProductsList(Map<String,Object> params);

    int insertProduct(SysProduct record);

    int updateProductById(SysProduct record);

    List<SysProduct> selectBaseProductsByType(@Param("skuTypeId") Integer skuTypeId);
}