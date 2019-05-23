package com.dlut.platform.dao;

import com.dlut.platform.domain.UserVo;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

public interface UserDao {
    UserVo selectUser(UserVo userVo);

    UserVo selectOrderUserInfoById(@Param("id") Integer id);

    int insertUser(UserVo record);

    int updateUser(UserVo record);

    Integer selectUserListSize(Map<String, Object> params);

    List<UserVo> selectUserList(Map<String, Object> params);

    String selectUserNameById(@Param("id") Integer id);
}