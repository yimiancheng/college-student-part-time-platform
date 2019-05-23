package com.dlut.platform.dao.util;

import com.dlut.platform.domain.common.BaseEnum;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class EnumHandler<E extends Enum<?> & BaseEnum> extends BaseTypeHandler<BaseEnum> {
    private Class<E> type;

    public EnumHandler(Class<E> type) {
        if(type == null) {
            throw new IllegalArgumentException("Type argument cannot be null");
        }

        this.type = type;
    }

    /**
     * 用于定义设置参数时，该如何把Java类型的参数转换为对应的数据库类型
     */
    @Override
    public void setNonNullParameter(PreparedStatement preparedStatement, int i, BaseEnum baseEnum, JdbcType jdbcType)
        throws SQLException {
        preparedStatement.setString(i, baseEnum.getName());
    }

    /**
     * 用于定义通过字段名称获取字段数据时，如何把数据库类型转换为对应的Java类型
     */
    @Override
    public E getNullableResult(ResultSet resultSet, String s) throws SQLException {
        String val = resultSet.getString(s);

        // 结果值是否是 JDBC NULL，必须先读取该列
        if(resultSet.wasNull()) {
            return null;
        }
        else {
            return getEnumKeyByName(type, val);
        }
    }

    /**
     * 用于定义通过字段索引获取字段数据时，如何把数据库类型转换为对应的Java类型
     */
    @Override
    public E getNullableResult(ResultSet resultSet, int i) throws SQLException {
        String val = resultSet.getString(i);

        // 结果值是否是 JDBC NULL，必须先读取该列
        if(resultSet.wasNull()) {
            return null;
        }
        else {
            return getEnumKeyByName(type, val);
        }
    }

    /**
     * 用定义调用存储过程后，如何把数据库类型转换为对应的Java类型
     */
    @Override
    public E getNullableResult(CallableStatement callableStatement, int i) throws SQLException {
        String val = callableStatement.getString(i);

        // 结果值是否是 JDBC NULL，必须先读取该列
        if(callableStatement.wasNull()) {
            return null;
        }
        else {
            return getEnumKeyByName(type, val);
        }
    }

    public static <E extends Enum<?> & BaseEnum> E getEnumKeyByName(Class<E> enumClass, String name) {
        if(StringUtils.isBlank(name)) {
            return null;
        }

        E[] enums = enumClass.getEnumConstants();

        for(E key : enums) {
            if(key.getName().equals(name)) {
                return key;
            }
        }

        return null;
    }
}
