package com.dlut.platform.dao;

import com.dlut.platform.domain.SysOrderLog;
import java.util.List;

public interface SysOrderLogDao {
    List<SysOrderLog> selectOrderStatusTimeLine(Integer id);

    List<SysOrderLog> selectLatestOrderStatus(Integer id);

    int addOrderLog(SysOrderLog record);
}