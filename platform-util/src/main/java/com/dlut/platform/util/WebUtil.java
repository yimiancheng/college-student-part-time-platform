package com.dlut.platform.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.servlet.ServletResponse;
import java.io.PrintWriter;

public class WebUtil {
    private static final Logger LOG = LoggerFactory.getLogger(WebUtil.class);

    public static void out(ServletResponse response, String result){
        PrintWriter out = null;

        try {
            response.setCharacterEncoding("UTF-8");
            response.setContentType("application/json; charset=utf-8");
            out = response.getWriter();
            out.println(result);
        }
        catch (Exception ex) {
            LOG.error("out body to page error.", ex);
        }
        finally{
            if(null != out){
                try {
                    out.flush();
                    out.close();
                }
                catch(Exception ex) {
                    // do nothing.
                }
            }
        }
    }
}
