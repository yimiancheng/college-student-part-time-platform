package com.dlut.platform.controller;

import com.dlut.platform.domain.SysProductLike;
import com.dlut.platform.domain.UserVo;
import com.dlut.platform.domain.common.ReturnMsg;
import com.dlut.platform.domain.enumVo.PRODUCT_ENUM;
import com.dlut.platform.interceptor.annotation.Permission;
import com.dlut.platform.service.MyLikeService;
import com.dlut.platform.util.GsonUtil;
import com.dlut.platform.util.LoginContext;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * SysMyController
 *
 * @date 2019/5/13 16:25
 */
@Controller
@RequestMapping("/my")
@Permission("STUDENT")
public class SysMyController {
    @Autowired
    private MyLikeService myLikeService;

    @RequestMapping({"/", "/page"})
    public String pageBackend() {
        return "my/myLikeList";
    }

    @RequestMapping("/addSkuLike")
    @ResponseBody
    public String addSkuLike(SysProductLike sysProductLike, HttpServletRequest request) {
        UserVo userVo = LoginContext.getLoginContext(request);

        if(userVo != null) {
            sysProductLike.setUserId(userVo.getId());
        }

        ReturnMsg returnMsg = myLikeService.addSkuLike(sysProductLike);
        return GsonUtil.toJson(returnMsg);
    }

    @RequestMapping("/skuLikeList")
    @ResponseBody
    public String skuLikeList(HttpServletRequest request) {
        UserVo userVo = LoginContext.getLoginContext(request);

        if(userVo == null) {
            return "[]";
        }

        Integer selectUserId = userVo.getAdmin() != null && userVo.getAdmin() ? null : userVo.getId();
        Map<String,Object> params = new HashMap<>();
        params.put("selectUserId", selectUserId);

        if(selectUserId != null) {
            params.put("skuStatus", PRODUCT_ENUM.LIKE_NORMAL);
        }

        List<SysProductLike> returnMsg = myLikeService.skuLikeList(params);
        return GsonUtil.toEnumJson(returnMsg);
    }

    @RequestMapping("/updateSkuLike")
    @ResponseBody
    public String updateSkuLike(SysProductLike sysProductLike, HttpServletRequest request, String ststus) {
        if(StringUtils.isNotBlank(ststus)) {
            sysProductLike.setSkuStatus(ststus.equals(PRODUCT_ENUM.LIKE_DEL.getName()) ? PRODUCT_ENUM.LIKE_DEL :
            PRODUCT_ENUM.LIKE_NORMAL);
        }

        ReturnMsg returnMsg = myLikeService.updateSkuLike(sysProductLike);
        return GsonUtil.toJson(returnMsg);
    }
}
