package com.dlut.platform.service.impl;

import com.dlut.platform.dao.SysProductDao;
import com.dlut.platform.dao.SysProductLikeDao;
import com.dlut.platform.domain.SysProductLike;
import com.dlut.platform.domain.common.ReturnMsg;
import com.dlut.platform.domain.enumVo.PRODUCT_ENUM;
import com.dlut.platform.service.MyLikeService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * MyLikeServiceImpl
 *
 * @date 2019/5/13 16:33
 */
@Service
public class MyLikeServiceImpl implements MyLikeService {
    @Resource
    private SysProductLikeDao sysProductLikeDao;
    @Resource
    private SysProductDao sysProductDao;

    @Override
    @Transactional
    public ReturnMsg addSkuLike(SysProductLike sysProductLike) {
        ReturnMsg msg = new ReturnMsg();
        Integer skuId = sysProductLike.getSkuId();

        if(skuId == null) {
            msg.setErrorResultMessage("参数不完整!");
        }

        if(StringUtils.isBlank(sysProductLike.getSkuName())) {
            String skuName = sysProductDao.selectProductName(skuId);
            sysProductLike.setSkuName(skuName);
        }

        sysProductLike.setSkuStatus(PRODUCT_ENUM.LIKE_NORMAL);
        sysProductLikeDao.addProductLikeSku(sysProductLike);
        return msg;
    }

    @Override
    public List<SysProductLike> skuLikeList(Map<String, Object> params) {
        return sysProductLikeDao.selectProductLikeList(params);
    }

    @Override
    @Transactional
    public ReturnMsg updateSkuLike(SysProductLike sysProductLike) {
        ReturnMsg returnMsg = new ReturnMsg();
        int rows = sysProductLikeDao.updateProductLikeSku(sysProductLike);

        if(rows != 1) {
            returnMsg.setErrorResultMessage("更新条数不为1");
        }

        return returnMsg;
    }
}
