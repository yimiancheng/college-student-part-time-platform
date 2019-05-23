package com.dlut.platform.service;

import com.dlut.platform.domain.SysProduct;
import com.dlut.platform.domain.SysProductTypes;
import com.dlut.platform.domain.common.ReturnMsg;
import java.util.List;
import java.util.Map;

/**
 * ProductService
 *
 * @date 2019/5/11 16:16
 */
public interface ProductService {
    /**
     * 查询商品的一级类目
     */
    List<SysProductTypes> selectProductTypes();

    /**
     * 添加商品的一级类目
     */
    ReturnMsg addProductType(SysProductTypes sysProductTypes);

    /**
     * 修改商品的一级类目
     */
    ReturnMsg updateProductType(SysProductTypes sysProductTypes);

    /**
     * 删除商品的一级类目
     */
    ReturnMsg delProductType(List<Integer> idList);

    /**
     * 下拉组件数据
     */
    Map<String,Object> select2ProductTypes();

    /**
     * 保存商品信息
     */
    ReturnMsg saveProduct(SysProduct sysProduct);

    /**
     * 查询商品列表
     */
    Object productList(Map<String,Object> params);

    /**
     * 更新商品信息
     */
    ReturnMsg updateProduct(SysProduct sysProduct);

    /**
     * 商详页显示商品信息
     */
    Map<String,Object> skuItem(Integer id);

    /**
     * 结算页显示商品信息
     */
    Map<String,Object> skuItemTradePage(Integer id);

    /**
     * 首页展示商品
     */
    List<SysProduct> selectSkus(Integer skuTypeId);
}
