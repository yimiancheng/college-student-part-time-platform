package com.dlut.platform.dao;

import com.dlut.platform.domain.SysProductTypes;
import java.util.HashMap;
import java.util.List;

public interface SysProductTypesDao {
    SysProductTypes selectProductTypeById(Integer id);

    List<SysProductTypes> selectProductTypes();

    int insertProductType(SysProductTypes record);

    int updateProductType(SysProductTypes record);

    int deleteByPrimaryKey(List<Integer> ids);

    List<HashMap<Integer, String>> select2ProductTypes();
}