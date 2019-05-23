package com.dlut.platform.controller;

import com.alibaba.fastjson.JSON;
import com.dlut.platform.domain.SysException;
import com.dlut.platform.domain.SysOrder;
import com.dlut.platform.domain.UserVo;
import com.dlut.platform.domain.common.ReturnMsg;
import com.dlut.platform.interceptor.annotation.Permission;
import com.dlut.platform.service.OrderService;
import com.dlut.platform.util.GsonUtil;
import com.dlut.platform.util.LoginContext;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.UUID;

/**
 * SysOrderController
 *
 * @date 2019/5/14 13:39
 */
@Controller
@RequestMapping("/order")
@Permission("STUDENT")
public class SysOrderController {
        private static org.apache.log4j.Logger LOG = org.apache.log4j.Logger.getLogger("infoLog");

    @Autowired
    private OrderService orderService;

    @RequestMapping({"/page", ""})
    public ModelAndView order(String uuid, ModelAndView modelAndView, HttpServletRequest request) {
        String viewName = "redirect:/index";

        if(StringUtils.isNotBlank(uuid)) {
            HttpSession httpSession = request.getSession();
            Object obj = httpSession.getAttribute(uuid);

            if(obj != null && obj instanceof ReturnMsg) {
                viewName = "orderPage";
                LOG.info("uuid : " + uuid + " | " + JSON.toJSONString(obj));
                httpSession.setAttribute("order", obj);
               // session.removeAttribute(uuid);
            }
        }

        modelAndView.setViewName(viewName);
        return modelAndView;
    }

    @RequestMapping("/submitOrder")
    @ResponseBody
    public String submitOrder(SysOrder sysOrder, HttpServletRequest request) {
        UserVo userVo = LoginContext.getLoginContext(request);

        if(userVo != null) {
            sysOrder.setBuyUserId(userVo.getId());
            sysOrder.setBuyUserName(userVo.getUsername());
        }

        ReturnMsg returnMsg = null;

        try {
            returnMsg = orderService.submitOrder(sysOrder);
        }
        catch(SysException ex) {
            returnMsg = ex.getReturnMsg();
            LOG.error("订单保存失败: " + ex.getMessage() + " : " + returnMsg.getResultMessage());
        }
        catch(Exception ex) {
            LOG.error("订单保存失败: " + ex.getMessage(), ex);
            returnMsg = new ReturnMsg();
            returnMsg.setErrorResultMessage(ex.getMessage());
        }

        String uuid = UUID.randomUUID().toString();
        request.getSession().setAttribute(uuid, returnMsg);
        return GsonUtil.toJson(uuid);
    }
}
