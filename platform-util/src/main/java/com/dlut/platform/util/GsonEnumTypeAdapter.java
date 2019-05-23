package com.dlut.platform.util;

import com.dlut.platform.domain.common.BaseEnum;
import com.google.gson.JsonElement;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;
import java.lang.reflect.Type;

public class GsonEnumTypeAdapter<E extends Enum<?> & BaseEnum> implements JsonSerializer<BaseEnum>{
    @Override
    public JsonElement serialize(BaseEnum baseEnum, Type type, JsonSerializationContext jsonSerializationContext) {
        if(baseEnum != null) {
            String val = baseEnum.getName();
            return new JsonPrimitive(val);
        }

        return null;
    }
}
