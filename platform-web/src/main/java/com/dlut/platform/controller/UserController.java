package com.dlut.platform.controller;

import com.dlut.platform.controller.util.ControllerUtil;
import com.dlut.platform.domain.UserVo;
import com.dlut.platform.domain.common.ReturnMsg;
import com.dlut.platform.domain.enumVo.USER_ENUM;
import com.dlut.platform.interceptor.annotation.Permission;
import com.dlut.platform.service.UserService;
import com.dlut.platform.util.GsonUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.annotation.Resource;
import java.util.Map;

/**
 * UserController
 *
 * @date 2019/3/8 15:51
 */
@Controller
@RequestMapping("/user")
@Permission("SYS_MNG")
public class UserController extends ControllerUtil {
    @Resource
    private UserService userService;

    @RequestMapping("")
    public String page() {
        return "userMng";
    }

    @RequestMapping("addUserPage")
    public String addUserPage() {
        return "dialog/addUser";
    }

    @RequestMapping("/selectUserList")
    @ResponseBody
    public String selectUserList(@RequestBody Map<String, Object> params) {
        params = convertTableMap(params, USER_ENUM.class);
        Map<String, Object> resultDate = userService.selectUserList(params);
        return GsonUtil.toEnumJson(resultDate);
    }

    @RequestMapping("/addUser")
    @ResponseBody
    public String addUser(UserVo userVo) {
        ReturnMsg returnMsg = userService.addUser(userVo);
        return GsonUtil.toJson(returnMsg);
    }
}
