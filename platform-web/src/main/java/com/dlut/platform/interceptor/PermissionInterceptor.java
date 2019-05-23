package com.dlut.platform.interceptor;

import com.dlut.platform.controller.IndexController;
import com.dlut.platform.domain.UserVo;
import com.dlut.platform.domain.enumVo.USER_ENUM;
import com.dlut.platform.interceptor.annotation.Permission;
import com.dlut.platform.util.LoginContext;
import com.dlut.platform.util.WebUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.method.HandlerMethod;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import java.lang.reflect.Method;

public class PermissionInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws
        Exception {
        if(this.hasPermission(request, handler)) {
            return true;
        }
        else {
            WebUtil.out(response, "您没有权限操作此功能,请联系管理员!");
            return false;
        }
    }

    private boolean hasPermission(HttpServletRequest request, Object handler) {
        if(!(handler instanceof HandlerMethod)) {
            return true;
        }

        HandlerMethod handlerMethod = (HandlerMethod) handler;
        Method method = handlerMethod.getMethod();

        // String methodName = method.getName();
        Class classObj = handlerMethod.getBean().getClass();
        RequestMapping requestMapping = method.getAnnotation(RequestMapping.class);

        if(requestMapping == null || StringUtils.equals(IndexController.class.getName(), classObj.getName()))
        {
            return true;
        }

        UserVo userVo = LoginContext.getLoginContext(request);

        if(userVo != null && userVo.getUserrole().equals(USER_ENUM.SYS_MNG)) {
            return true;
        }

        Permission permissionAnnotation = handlerMethod.getMethod().getAnnotation(Permission.class);

        if(permissionAnnotation == null) {
            permissionAnnotation = (Permission) classObj.getAnnotation(Permission.class);
        }

        if(permissionAnnotation == null) {
            return true;
        }
        else if(userVo == null || userVo.getUserrole() == null) {
            return false;
        }

        String permissionFlag = permissionAnnotation != null ? permissionAnnotation.value() : USER_ENUM.STUDENT.toString();
        return permissionFlag.equals(userVo.getUserrole().name());
    }
}
