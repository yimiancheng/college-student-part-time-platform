package com.dlut.platform.service;

import com.dlut.platform.domain.SysProductLike;
import com.dlut.platform.domain.common.ReturnMsg;
import java.util.List;
import java.util.Map;

/**
 * MyLikeService
 *
 * @date 2019/5/13 16:31
 */
public interface MyLikeService {
    /**
     * 添加收藏
     */
    ReturnMsg addSkuLike(SysProductLike sysProductLike);

    /**
     * 获取收藏列表
     */
    List<SysProductLike> skuLikeList(Map<String,Object> params);

    /**
     * 我的收藏更新
     */
    ReturnMsg updateSkuLike(SysProductLike sysProductLike);
}
