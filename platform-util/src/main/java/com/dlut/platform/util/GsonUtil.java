package com.dlut.platform.util;

import com.dlut.platform.domain.common.BaseEnum;
import com.dlut.platform.domain.enumVo.PRODUCT_ENUM;
import com.dlut.platform.domain.enumVo.USER_ENUM;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.lang.reflect.Type;
import java.util.Collection;
import java.util.Enumeration;
import java.util.Iterator;

public class GsonUtil {
    //异常信息日志log对象
    private final static Logger LOG = LoggerFactory.getLogger("GsonUtil");
    private static final Gson gson = new Gson();
    private static final Gson gson_date_time = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
    private static final Gson gson_date = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
    private static final Gson gson_enum =
        new GsonBuilder()
        .registerTypeAdapter(USER_ENUM.class, new GsonEnumTypeAdapter())
            .registerTypeAdapter(PRODUCT_ENUM.class, new GsonEnumTypeAdapter())
        .setDateFormat("yyyy-MM-dd HH:mm:ss").create();
    /**
     * 空的 {@code JSON} 数据 - <code>"{}"</code>。
     */
    private static final String EMPTY_JSON = "{}";
    /**
     * 空的 {@code JSON} 数组(集合)数据 - {@code "[]"}。
     */
    private static final String EMPTY_JSON_ARRAY = "[]";

    public static String toJson(Object target) {
        return toJson(target, gson);
    }

    public static String toEnumJson(Object target) {
        return toJson(target, gson_enum);
    }

    public static String toDateTimeFormatJson(Object target) {
        return toJson(target, gson_date_time);
    }

    public static String toDateFormatJson(Object target) {
        return toJson(target, gson_date);
    }

    public static synchronized String toJson(Object target, Gson gson) {
        if(target == null) {
            return null;
        }
        String result = null;
        try {
            result = gson.toJson(target);
        }
        catch(Exception ex) {
            if(target instanceof Collection<?> || target instanceof Iterator<?> || target instanceof Enumeration<?>
                || target.getClass().isArray()) {
                result = EMPTY_JSON_ARRAY;
            }
        }
        return result;
    }

    public static <T> T fromJson(String json, Class<T> clazz) {
        return fromJson(json, clazz, null);
    }

    public static synchronized <T> T fromJson(String json, Class<T> clazz, String datePattern) {
        if(json == null || json.length() < 1) {
            return null;
        }
        try {
            return gson.fromJson(json, clazz);
        }
        catch(Exception ex) {
            LOG.info("from Json ", ex);
            ex.printStackTrace();
            return null;
        }
    }

    public static Object fromJson(String json, Type type) {
        if(json == null || json.length() < 1) {
            return null;
        }
        try {
            return gson.fromJson(json, type);
        }
        catch(Exception ex) {
            return null;
        }
    }
}
