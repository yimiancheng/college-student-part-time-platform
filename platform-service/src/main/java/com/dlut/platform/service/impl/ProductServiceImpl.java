package com.dlut.platform.service.impl;

import com.dlut.platform.dao.SysProductDao;
import com.dlut.platform.dao.SysProductStockDao;
import com.dlut.platform.dao.SysProductTypesDao;
import com.dlut.platform.domain.SysProduct;
import com.dlut.platform.domain.SysProductStock;
import com.dlut.platform.domain.SysProductTypes;
import com.dlut.platform.domain.common.ReturnMsg;
import com.dlut.platform.domain.enumVo.PRODUCT_ENUM;
import com.dlut.platform.service.ProductService;
import com.dlut.platform.util.GsonUtil;
import com.dlut.platform.util.LoginContext;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * ProductServiceImpl
 *
 * @date 2019/5/11 16:18
 */
@Service
public class ProductServiceImpl implements ProductService {
    private static Logger infoLog = Logger.getLogger("infoLog");
    private static Logger errLog = Logger.getLogger("errorLog");
    @Resource
    private SysProductTypesDao sysProductTypesDao;
    @Resource
    private SysProductDao sysProductDao;
    @Resource
    private SysProductStockDao sysProductStockDao;

    @Override
    public List<SysProductTypes> selectProductTypes() {
        return sysProductTypesDao.selectProductTypes();
    }

    @Override
    public Map<String, Object> select2ProductTypes() {
        Map<String, Object> result = new HashMap<>();
        List<HashMap<Integer, String>> rows = sysProductTypesDao.select2ProductTypes();
        result.put("results", rows);
        result.put("total", rows.size());
        return result;
    }

    @Override
    @Transactional
    public ReturnMsg addProductType(SysProductTypes sysProductTypes) {
        ReturnMsg returnMsg = new ReturnMsg();
        int rows = sysProductTypesDao.insertProductType(sysProductTypes);

        if(rows == 1) {
            return returnMsg;
        }
        else {
            returnMsg.setSuccess(false);
            returnMsg.setResultMessage("影响行数不为1, rows = " + rows);
            return returnMsg;
        }
    }

    @Override
    @Transactional
    public ReturnMsg updateProductType(SysProductTypes sysProductTypes) {
        ReturnMsg returnMsg = new ReturnMsg();
        sysProductTypesDao.updateProductType(sysProductTypes);
        return returnMsg;
    }

    @Override
    public ReturnMsg delProductType(List<Integer> idList) {
        ReturnMsg returnMsg = new ReturnMsg();
        int rows = sysProductTypesDao.deleteByPrimaryKey(idList);
        infoLog.info("删除商品类目： param idList size = " + idList.size() + " | db size = " + rows);
        return returnMsg;
    }

    @Override
    @Transactional
    public ReturnMsg saveProduct(SysProduct sysProduct) {
        ReturnMsg returnMsg = new ReturnMsg();
        sysProduct.setSkuStatus(PRODUCT_ENUM.PUBLISH);
        sysProductDao.insertProduct(sysProduct);

        if(sysProduct.getId() == null) {
            returnMsg.setSuccess(false);
            returnMsg.setResultMessage("获取数据库主键失败！");
            return returnMsg;
        }

        sysProductStockDao.insertProductStock(sysProduct);
        infoLog.info("product id = " + sysProduct.getId() + " | product stock id = " + sysProduct.getSkuStockId());
        return returnMsg;
    }

    @Override
    public Object productList(Map<String,Object> params) {
        return sysProductDao.selectProductsList(params);
    }

    @Override
    @Transactional
    public ReturnMsg updateProduct(SysProduct sysProduct) {
        ReturnMsg returnMsg = new ReturnMsg();
        int rows = sysProductDao.updateProductById(sysProduct);
        infoLog.info("product id = " + sysProduct.getId() + " | 更新条数 = " + rows);

        if(sysProduct.getSkuNum() != null) {
            SysProductStock sysProductStock = new SysProductStock();
            sysProductStock.setSkuId(sysProduct.getId());
            sysProductStock.setNum(sysProduct.getSkuNum());
            rows = sysProductStockDao.updateProductStockNum(sysProductStock);
            infoLog.info("product id = " + sysProduct.getId() + " | 更新库存条数 = " + rows);
        }

        return returnMsg;
    }

    @Override
    public Map<String,Object> skuItem(Integer id) {
        Map<String,Object> map = new HashMap<>();
        SysProduct sysProduct = sysProductDao.selectProducts(id);

        if(sysProduct == null) {
            map.put("error", "商品不存在！");
        }
        else if(!PRODUCT_ENUM.PUBLISH.equals(sysProduct.getSkuStatus())) {
            map.put("error", "商品已下架或者售空！");
        }

        if(sysProduct != null) {
            map.put("skuContent", sysProduct.getSkuContent());
            sysProduct.setSkuContent(null);
            map.put("sysProduct", sysProduct);
        }

        return map;
    }

    @Override
    public Map<String, Object> skuItemTradePage(Integer id) {
        Map<String,Object> map = new HashMap<>();
        SysProduct sysProduct = sysProductDao.selectBaseProducts(id);
        int buyStock = 0;

        if(sysProduct == null) {
            map.put("error", "商品不存在！");
        }
        else if(!PRODUCT_ENUM.PUBLISH.equals(sysProduct.getSkuStatus())) {
            map.put("error", "商品已下架或者售空！");
        }
        else if(sysProduct.getBuyDate() != null && new Date().before(sysProduct.getBuyDate())) {
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            map.put("error", "商品为开售，开售时间为：" + simpleDateFormat.format(sysProduct.getBuyDate()));
        }
        else if(sysProduct.getProductStock() != null) {
            buyStock = sysProduct.getProductStock().getNum();

            if(sysProduct.getProductStock().getNumStock() != null) {
                buyStock = buyStock - sysProduct.getProductStock().getNumStock();
            }

            if(buyStock < 1) {
                map.put("error", "商品已售空！");
            }
        }

        if(sysProduct != null) {
            map.put("sysProduct", sysProduct);
            map.put("buyStock", buyStock);
        }

        return map;
    }

    @Override
    public List<SysProduct> selectSkus(Integer skuTypeId) {
        return sysProductDao.selectBaseProductsByType(skuTypeId);
    }
}
