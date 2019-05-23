package com.dlut.platform.controller;

import com.dlut.platform.domain.UserVo;
import com.dlut.platform.domain.common.ReturnMsg;
import com.dlut.platform.service.ProductService;
import com.dlut.platform.service.UserService;
import com.dlut.platform.util.GsonUtil;
import com.dlut.platform.util.LoginContext;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * IndexController
 *
 * @date 2019/3/8 11:00
 */
@Controller
public class IndexController {
    @Resource
    private UserService userService;
    @Autowired
    private ProductService productService;

    @RequestMapping({"/", "/index"})
    public ModelAndView page(ModelAndView modelAndView, Integer skuTypeId) {
        modelAndView.setViewName("index");
        modelAndView.addObject("skus", productService.selectSkus(skuTypeId));
        modelAndView.addObject("navs", productService.select2ProductTypes());
        modelAndView.addObject("skuTypeId", skuTypeId == null ? 0 : skuTypeId);
        return modelAndView;
    }

    @RequestMapping("/backend")
    public String pageBackend() {
        return "redirect:/product";
    }

    @RequestMapping("/login")
    public String loginPage() {
        return "login";
    }

    @RequestMapping("/loginAction")
    @ResponseBody
    public String login(UserVo userVo, HttpServletRequest request, HttpServletResponse response) {
        ReturnMsg returnMsg = userService.login(userVo);

        if(returnMsg.isSuccess()) {
            LoginContext.setLoginContext((UserVo) returnMsg.getResult(), request, response);
        }

        String returnUrl = request.getParameter("returnUrl");
        returnMsg.setResultMessage(StringUtils.isBlank(returnUrl) ? "/" : returnUrl);
        return GsonUtil.toJson(returnMsg);
    }

    @RequestMapping("/logoutAction")
    @ResponseBody
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        LoginContext.remove(request, response);
        return GsonUtil.toJson(ReturnMsg.success());
    }
}
