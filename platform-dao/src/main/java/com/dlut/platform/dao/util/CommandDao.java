package com.dlut.platform.dao.util;

import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface CommandDao {
    void executor(@Param("content") String content);

    List query(@Param("content") String content);

    void add(@Param("content") String content);

    void remove(@Param("content") String content);
}