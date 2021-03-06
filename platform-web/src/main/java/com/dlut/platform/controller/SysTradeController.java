package com.dlut.platform.controller;

import com.dlut.platform.interceptor.annotation.Permission;
import com.dlut.platform.service.ProductService;
import com.dlut.platform.util.GsonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import java.util.Map;

/**
 * SysTradeController
 *
 * @date 2019/5/13 18:41
 */
@Controller
@RequestMapping("/trade")
@Permission("STUDENT")
public class SysTradeController {
    @Autowired
    private ProductService productService;

    @RequestMapping("")
    public ModelAndView productListPage(Integer id, ModelAndView modelAndView) {
        String viewName = "index";

        if(id != null) {
            Map<String,Object> itemResult = productService.skuItemTradePage(id);

            for(Map.Entry<String,Object> entry : itemResult.entrySet()) {
                modelAndView.addObject(entry.getKey(), entry.getValue());
            }

            modelAndView.addObject("id", id);
            viewName = "tradePage";
        }

        modelAndView.setViewName(viewName);
        return modelAndView;
    }
}
