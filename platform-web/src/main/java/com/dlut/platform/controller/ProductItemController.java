package com.dlut.platform.controller;

import com.dlut.platform.service.ProductService;
import com.dlut.platform.util.GsonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import java.util.Map;

/**
 * ProductItemController
 *
 * @date 2019/5/12 18:27
 */
@Controller
@RequestMapping("/item")
public class ProductItemController {
    @Autowired
    private ProductService productService;

    @RequestMapping("")
    public ModelAndView productListPage(Integer id, ModelAndView modelAndView) {
        String viewName = "index";

        if(id != null) {
            Map<String,Object> itemResult = productService.skuItem(id);

            for(Map.Entry<String,Object> entry : itemResult.entrySet()) {
                modelAndView.addObject(entry.getKey(), GsonUtil.toEnumJson(entry.getValue()));
            }

            modelAndView.addObject("id", id);
            viewName = "productItem";
        }

        modelAndView.setViewName(viewName);
        return modelAndView;
    }
}
