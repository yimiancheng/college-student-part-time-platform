package com.dlut.platform.util;

import com.dlut.platform.domain.UserVo;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Calendar;

/**
 * LoginContext
 * 存储登录用户信息
 * @date 2019/3/8 14:24
 */
public class LoginContext {
    private static final String SESSION_USER = "user";
    private static final String LOGIN_TIME = "loginTime";

    public static void setLoginContext(UserVo userVo, HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(true);
        session.setAttribute(SESSION_USER, userVo);
        session.setAttribute(LOGIN_TIME, Calendar.getInstance().getTime());

        Cookie cookie = new Cookie(SESSION_USER, userVo.getUsername());
        cookie.setPath("/");
        cookie.setMaxAge(-1);
        response.addCookie(cookie);
    }

    public static UserVo getLoginContext(HttpServletRequest request) {
        Object userVoObj = request.getSession().getAttribute(SESSION_USER);

        if(userVoObj != null) {
           return (UserVo) userVoObj;
        }
        else {
            return null;
        }
    }

    public static Integer getLoginUser(HttpServletRequest request) {
        UserVo userVoObj = getLoginContext(request);

        if(userVoObj != null) {
            return userVoObj.getId();
        }
        else {
            return null;
        }
    }

    public static void remove(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        session.removeAttribute(SESSION_USER);

        Cookie cookie = new Cookie(SESSION_USER, null);
        cookie.setPath("/");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
    }

    public static boolean isLogin(HttpServletRequest request) {
        return request.getSession().getAttribute(SESSION_USER) != null;
    }
}
