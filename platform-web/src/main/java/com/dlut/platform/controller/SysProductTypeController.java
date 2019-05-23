package com.dlut.platform.controller;

import com.dlut.platform.domain.SysProductTypes;
import com.dlut.platform.domain.common.ReturnMsg;
import com.dlut.platform.service.ProductService;
import com.dlut.platform.util.GsonUtil;
import com.dlut.platform.util.LoginContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * SysProductController
 *
 * @date 2019/5/11 16:04
 */
@Controller
@RequestMapping("/productType")
public class SysProductTypeController {
    @Autowired
    private ProductService productService;

    @RequestMapping("/page")
    public String page() {
        return "product/productType";
    }

    @RequestMapping("/selectProductTypes")
    @ResponseBody
    public String selectProductTypes() {
        List<SysProductTypes> productTypes = productService.selectProductTypes();
        return GsonUtil.toDateTimeFormatJson(productTypes);
    }

    @RequestMapping("/select2ProductTypes")
    @ResponseBody
    public String select2ProductTypes() {
        Map<String, Object> result = productService.select2ProductTypes();
        return GsonUtil.toJson(result);
    }

    @RequestMapping("/addProductType")
    @ResponseBody
    public String addProductType(SysProductTypes sysProductTypes, HttpServletRequest request) {
        sysProductTypes.setCreatorUserId(LoginContext.getLoginUser(request));
        ReturnMsg returnMsg = productService.addProductType(sysProductTypes);
        return GsonUtil.toJson(returnMsg);
    }

    @RequestMapping("/updateProductType")
    @ResponseBody
    public String updateProductType(SysProductTypes sysProductTypes) {
        ReturnMsg returnMsg = productService.updateProductType(sysProductTypes);
        return GsonUtil.toJson(returnMsg);
    }

    @RequestMapping("/delProductType")
    @ResponseBody
    public String delProductType(@RequestParam("id") List<Integer> idList) {
        ReturnMsg returnMsg = productService.delProductType(idList);
        return GsonUtil.toJson(returnMsg);
    }
}
