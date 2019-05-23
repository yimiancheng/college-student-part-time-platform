package com.dlut.platform.controller;

import com.dlut.platform.domain.SysProduct;
import com.dlut.platform.domain.SysProductTypes;
import com.dlut.platform.domain.UserVo;
import com.dlut.platform.domain.common.ReturnMsg;
import com.dlut.platform.domain.enumVo.PRODUCT_ENUM;
import com.dlut.platform.interceptor.annotation.Permission;
import com.dlut.platform.service.ProductService;
import com.dlut.platform.util.GsonUtil;
import com.dlut.platform.util.LoginContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.MalformedParameterizedTypeException;
import java.util.HashMap;
import java.util.Map;

/**
 * SysProductController
 *
 * @date 2019/5/11 16:04
 */
@Controller
@RequestMapping("/product")
@Permission("STUDENT")
public class SysProductController {
    @Autowired
    private ProductService productService;

    @RequestMapping("/page")
    public String page() {
        return "product/addProduct";
    }

    @RequestMapping("/saveProduct")
    @ResponseBody
    public String saveProduct(SysProduct sysProduct, HttpServletRequest request) {
        UserVo userVo = LoginContext.getLoginContext(request);

        if(userVo != null) {
            sysProduct.setUserId(userVo.getId());
            sysProduct.setCreatorname(userVo.getUsername());
        }

        ReturnMsg returnMsg = productService.saveProduct(sysProduct);
        return GsonUtil.toJson(returnMsg);
    }

    @RequestMapping("")
    public String productListPage() {
        return "product/productList";
    }

    @RequestMapping("/productList")
    @ResponseBody
    public String productList(HttpServletRequest request) {
        UserVo userVo = LoginContext.getLoginContext(request);

        if(userVo == null) {
            return "[]";
        }

        Integer selectUserId = userVo.getAdmin() != null && userVo.getAdmin() ? null : userVo.getId();
        Map<String,Object> params = new HashMap<>();
        params.put("selectUserId", selectUserId);
        Object returnMsg = productService.productList(params);
        return GsonUtil.toEnumJson(returnMsg);
    }

    @RequestMapping("/updateProduct")
    @ResponseBody
    public String updateProduct(SysProduct sysProduct, @RequestParam(name = "skuStatusBoolean", required = false) Boolean skuStatusBoolean) {
        if(skuStatusBoolean != null) {
            sysProduct.setSkuStatus(skuStatusBoolean ? PRODUCT_ENUM.PUBLISH : PRODUCT_ENUM.OFF);
        }

        ReturnMsg returnMsg = productService.updateProduct(sysProduct);
        return GsonUtil.toJson(returnMsg);
    }
}
