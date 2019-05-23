package com.dlut.platform.service.impl;

import com.dlut.platform.dao.SysOrderDao;
import com.dlut.platform.dao.SysOrderLogDao;
import com.dlut.platform.dao.SysProductStockDao;
import com.dlut.platform.dao.UserDao;
import com.dlut.platform.domain.*;
import com.dlut.platform.domain.common.ReturnMsg;
import com.dlut.platform.domain.enumVo.PRODUCT_ENUM;
import com.dlut.platform.service.OrderService;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * OrderServiceImpl
 *
 * @date 2019/5/14 13:47
 */
@Service
public class OrderServiceImpl implements OrderService {
    private static Logger infoLog = Logger.getLogger("infoLog");
    private static Logger errLog = Logger.getLogger("errorLog");
    @Resource
    private SysProductStockDao sysProductStockDao;
    @Resource
    private SysOrderDao sysOrderDao;
    @Resource
    private SysOrderLogDao sysOrderLogDao;
    @Resource
    private UserDao userDao;

    @Override
    @Transactional
    public ReturnMsg submitOrder(SysOrder sysOrder) throws Exception {
        ReturnMsg returnMsg = new ReturnMsg();

        UserVo userVoDb = userDao.selectOrderUserInfoById(sysOrder.getSkuUserId());

        if(userVoDb == null) {
            returnMsg.setErrorResultMessage("商家不存在！");
            throw new SysException("orderError", returnMsg);
        }

        SysProductStock sysProductStock = sysProductStockDao.selectSkuStock(sysOrder.getSkuId());

        if(sysProductStock == null) {
            returnMsg.setErrorResultMessage("商品不存在！");
            throw new SysException("orderError", returnMsg);
        }

        SysProductStock sysProductStockDb = new SysProductStock();
        sysProductStockDb.setId(sysProductStock.getId());
        sysProductStockDb.setUpdateDate(sysProductStock.getUpdateDate());
        sysProductStockDb.setNum(sysProductStock.getNum());
        int orderNum = sysOrder.getSkuNum();

        if(sysProductStock.getNumStock() == null) {
            sysProductStockDb.setNumStock(orderNum);
        }
        else {
            sysProductStockDb.setNumStock(sysProductStock.getNumStock() + orderNum);
        }

        if(sysProductStockDb.getNumStock() > sysProductStock.getNum()) {
            returnMsg.setErrorResultMessage("超过商品可售库存，请调整购买商品数量！");
            throw new SysException("orderError", returnMsg);
        }

        int rows = sysProductStockDao.updateProductStock(sysProductStockDb);
        infoLog.info("更新库存成功！ rows = " + rows);

        if(rows != 1) {
            returnMsg.setErrorResultMessage("库存更新失败！");
            throw new SysException("orderError", returnMsg);
        }

        sysOrderDao.insertOrder(sysOrder);
        infoLog.info("订单保存成功！order id = " + sysOrder.getId());

        SysOrderLog sysOrderLog = new SysOrderLog();
        sysOrderLog.setOrderId(sysOrder.getId());
        sysOrderLog.setCreatorId(sysOrder.getBuyUserId());
        sysOrderLog.setOrderStatus(PRODUCT_ENUM.ORDER_CRERATE);
        sysOrderLog.setCreatorName(sysOrder.getBuyUserName());
        sysOrderLogDao.addOrderLog(sysOrderLog);
        infoLog.info("订单状态保存成功！");

        Map<String, Object> orderMap = new HashMap<>();
        orderMap.put("orderId", sysOrder.getId());
        orderMap.put("userVo", userVoDb);
        returnMsg.setResult(orderMap);
        return returnMsg;
    }

    @Override
    public List<SysOrder> myOrderList(Map<String, Object> params) {
        return sysOrderDao.selectOrderList(params);
    }

    @Override
    public List<SysOrder> buyOrderList(Map<String, Object> params) {
        return sysOrderDao.selectBuyOrderList(params);
    }

    @Override
    public List<SysOrderLog> orderLogList(Integer orderId) {
        return sysOrderLogDao.selectOrderStatusTimeLine(orderId);
    }

    @Override
    public ReturnMsg addOrderLog(SysOrderLog sysOrderLog) {
        ReturnMsg returnMsg = new ReturnMsg();

        if(PRODUCT_ENUM.ORDER_CANCEL.equals(sysOrderLog.getOrderStatus())) {
            infoLog.info(PRODUCT_ENUM.ORDER_CANCEL.getName() + " | orderId = " + sysOrderLog.getOrderId());
            SysOrder sysOrder = sysOrderDao.selectOrderById(sysOrderLog.getOrderId());

            if(sysOrder == null) {
                returnMsg.setErrorResultMessage("订单号不存在！orderId = " + sysOrderLog.getOrderId());
                return returnMsg;
            }

            SysProductStock sysProductStock = sysProductStockDao.selectSkuStock(sysOrder.getSkuId());

            if(sysProductStock == null) {
                returnMsg.setErrorResultMessage("商品不存在！skuId = " + sysOrder.getSkuId());
                return returnMsg;
            }

            SysProductStock sysProductStockDb = new SysProductStock();
            sysProductStockDb.setId(sysProductStock.getId());
            sysProductStockDb.setUpdateDate(sysProductStock.getUpdateDate());
            sysProductStockDb.setNum(sysProductStock.getNum());
            int orderNum = sysOrder.getSkuNum();

            if(sysProductStock.getNumStock() == null || sysProductStock.getNumStock() < orderNum) {
                returnMsg.setErrorResultMessage("商品已售库存数据错误，请联系管理员！numStock = " +
                    sysProductStock.getNumStock());
                return returnMsg;
            }
            else {
                sysProductStockDb.setNumStock(sysProductStock.getNumStock() - orderNum);
            }

            int rows = sysProductStockDao.updateProductStock(sysProductStockDb);
            infoLog.info("更新库存成功！ rows = " + rows);
        }

        sysOrderLogDao.addOrderLog(sysOrderLog);
        return returnMsg;
    }
}
