package com.dlut.platform.dao;

import com.dlut.platform.domain.SysProductLike;
import java.util.List;
import java.util.Map;

public interface SysProductLikeDao {
    int addProductLikeSku(SysProductLike record);

    int updateProductLikeSku(SysProductLike record);

    List<SysProductLike> selectProductLikeList(Map<String, Object> params);
}