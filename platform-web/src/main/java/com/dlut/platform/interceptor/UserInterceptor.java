package com.dlut.platform.interceptor;

import com.dlut.platform.util.LoginContext;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserInterceptor implements HandlerInterceptor {
    private static Logger LOG = LoggerFactory.getLogger("infoLog");
    @Value("${login.address}")
    private String loginUrl;

    @Override
    public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
        throws Exception {
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o,
        ModelAndView modelAndView) {
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws
        Exception {
        String uri = request.getRequestURI();

        // 放行登录及静态文件
        if(uri.endsWith("/loginAction") || uri.startsWith("/ace_static") || uri.endsWith("/logoutAction")
            || uri.startsWith("/item") || (uri.startsWith("/index") || uri.equals("/")))
        {
            LOG.info("不需要登录的url: " + uri);
            return true;
        }

        // 未登录转发到登录页面
        if(!LoginContext.isLogin(request)) {
            if(uri.endsWith(loginUrl)) {
                return true;
            }
            else {
                String queryString = request.getQueryString();
                String returnUrl = request.getParameter("returnUrl");
                returnUrl = StringUtils.isBlank(returnUrl) ?
                    (request.getRequestURL() + (StringUtils.isBlank(queryString) ? "" : ("?" + queryString))) :
                    returnUrl;
                LOG.info("returnUrl = " + returnUrl);
                response.sendRedirect(request.getContextPath() + loginUrl + "?returnUrl=" + returnUrl);
                return false;
            }
        }

        // 已登录如果访问登录页面，转发到控制台页面
        if(uri.endsWith(loginUrl)) {
            request.getRequestDispatcher(request.getContextPath()).forward(request, response);
            return false;
        }

        return true;
    }
}
