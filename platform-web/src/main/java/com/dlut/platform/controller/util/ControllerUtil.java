package com.dlut.platform.controller.util;

import com.dlut.platform.dao.util.EnumHandler;
import com.dlut.platform.domain.common.BaseEnum;
import org.apache.commons.lang.StringUtils;
import java.util.HashMap;
import java.util.Map;

public class ControllerUtil {
    public Map<String, Object> convertTableMap(Map<String, Object> params) {
        if(params == null) {
            return new HashMap<>();
        }

        Object id = params.get("id");

        if(id != null && id instanceof Double) {
            params.put("id", (int) Math.floor((Double) id));
        }
        else if(id != null && id instanceof String) {
            params.put("id", Integer.parseInt(id.toString()));
        }

        Object offset = params.get("offset");

        if(offset != null && offset instanceof Double) {
            params.put("offset", (int) Math.floor((Double) offset));
        }
        else if(offset != null && offset instanceof String) {
            params.put("offset", Integer.parseInt(offset.toString()));
        }

        Object limit = params.get("limit");

        if(limit != null && limit instanceof Double) {
            params.put("limit", (int) Math.floor((Double) limit));
        }
        else if(limit != null && limit instanceof String) {
            params.put("limit", Integer.parseInt(limit.toString()));
        }

        Object sort = params.get("sort");

        if(sort != null && sort instanceof String) {
            params.put("sort", sort.toString());
        }

        Object search = params.get("search");

        if(search != null && search instanceof String) {
            if(StringUtils.isBlank(search.toString()) || search.toString().endsWith("...")) {
                params.remove("search");
            }
            else {
                params.put("search", search.toString().trim());
            }
        }

        return params;
    }

    public Map<String, Object> convertTableMap(Map<String, Object> params, Class enumClass) {
        params = convertTableMap(params);

        for(Map.Entry<String, Object> entry : params.entrySet()) {
            if(entry.getValue() instanceof String) {
                String name = entry.getValue().toString();

                if(name.startsWith(ENUM_FLAG)) {
                    Object enumObj = EnumHandler.getEnumKeyByName(enumClass, name.substring(ENUM_FLAG_LENGTH));
                    params.put(entry.getKey(), enumObj);
                }
            }
        }

        return params;
    }

    public <E extends Enum<?> & BaseEnum> E convertToEnum(String name, Class<E> enumClass) {
        if(name == null) {
            return null;
        }

        return EnumHandler.getEnumKeyByName(enumClass, name);
    }

    private static final String ENUM_FLAG = "enum_";
    private static final int ENUM_FLAG_LENGTH = ENUM_FLAG.length();
}
