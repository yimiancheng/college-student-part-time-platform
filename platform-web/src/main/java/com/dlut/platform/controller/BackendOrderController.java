package com.dlut.platform.controller;

import com.dlut.platform.controller.util.ControllerUtil;
import com.dlut.platform.domain.SysOrder;
import com.dlut.platform.domain.SysOrderLog;
import com.dlut.platform.domain.UserVo;
import com.dlut.platform.domain.common.ReturnMsg;
import com.dlut.platform.domain.enumVo.PRODUCT_ENUM;
import com.dlut.platform.interceptor.annotation.Permission;
import com.dlut.platform.service.OrderService;
import com.dlut.platform.util.GsonUtil;
import com.dlut.platform.util.LoginContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * OrderController
 *
 * @date 2019/5/14 18:22
 */
@Controller
@RequestMapping("/my/order")
@Permission("STUDENT")
public class BackendOrderController extends ControllerUtil {
    @Autowired
    private OrderService orderService;

    @RequestMapping({"/page", ""})
    public String pageBackend() {
        return "order/orderList";
    }

    @RequestMapping({"/buypage"})
    public String buyPageBackend() {
        return "order/buyOrderList";
    }

    @RequestMapping("/myOrderList")
    @ResponseBody
    public String myOrderList(@RequestBody(required = false) Map<String, Object> params, HttpServletRequest request) {
        params = convertTableMap(params, request);
        List<SysOrder> sysOrderList = orderService.myOrderList(params);
        return GsonUtil.toEnumJson(sysOrderList);
    }

    @RequestMapping("/buyOrderList")
    @ResponseBody
    public String buyOrderList(@RequestBody(required = false) Map<String, Object> params, HttpServletRequest request) {
        params = convertTableMap(params, request);
        List<SysOrder> sysOrderList = orderService.buyOrderList(params);
        return GsonUtil.toEnumJson(sysOrderList);
    }

    private Map<String, Object> convertTableMap(Map<String, Object> params, HttpServletRequest request) {
        params = super.convertTableMap(params);
        UserVo userVo = LoginContext.getLoginContext(request);
        Integer selectUserId = userVo.getAdmin() != null && userVo.getAdmin() ? null : userVo.getId();
        params.put("selectUserId", selectUserId);
        return params;
    }

    @RequestMapping("/orderLogList")
    @ResponseBody
    public String orderLogList(@RequestParam Integer orderId) {
        List<SysOrderLog> sysOrderLogs = orderService.orderLogList(orderId);
        return GsonUtil.toEnumJson(sysOrderLogs);
    }

    @RequestMapping("/addOrderLog")
    @ResponseBody
    public String addOrderLog(SysOrderLog sysOrderLog, HttpServletRequest request,
        String orderStatusOldName, String orderStatusName)
    {
        UserVo userVo = LoginContext.getLoginContext(request);

        if(userVo != null) {
            sysOrderLog.setCreatorId(userVo.getId());
            sysOrderLog.setCreatorName(userVo.getUsername());
        }

        sysOrderLog.setOrderStatusOld(super.convertToEnum(orderStatusOldName, PRODUCT_ENUM.class));
        sysOrderLog.setOrderStatus(super.convertToEnum(orderStatusName, PRODUCT_ENUM.class));
        ReturnMsg returnMsg = orderService.addOrderLog(sysOrderLog);
        return GsonUtil.toEnumJson(returnMsg);
    }
}
