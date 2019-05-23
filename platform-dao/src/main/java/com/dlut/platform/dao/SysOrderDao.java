package com.dlut.platform.dao;

import com.dlut.platform.domain.SysOrder;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

public interface SysOrderDao {
    int insertOrder(SysOrder order);

    SysOrder selectOrderById(@Param("id") Integer id);

    List<SysOrder> selectOrderList(Map<String, Object> params);

    List<SysOrder> selectBuyOrderList(Map<String, Object> params);
}