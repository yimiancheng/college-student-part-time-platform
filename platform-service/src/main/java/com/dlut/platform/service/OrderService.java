package com.dlut.platform.service;

import com.dlut.platform.domain.SysOrder;
import com.dlut.platform.domain.SysOrderLog;
import com.dlut.platform.domain.common.ReturnMsg;
import java.util.List;
import java.util.Map;

/**
 * OrderService
 *
 * @date 2019/5/14 13:46
 */
public interface OrderService {
    /**
     * 提交订单
     */
    ReturnMsg submitOrder(SysOrder sysOrder) throws Exception;

    /**
     * 查询我的订单
     */
    List<SysOrder> myOrderList(Map<String,Object> params);

    /**
     * 查询我的销售订单
     */
    List<SysOrder> buyOrderList(Map<String,Object> params);

    /**
     * 查询订单日志
     */
    List<SysOrderLog> orderLogList(Integer orderId);

    /**
     * 修改订单状态
     */
    ReturnMsg addOrderLog(SysOrderLog sysOrderLog);
}
