package com.dlut.platform.service;

import com.dlut.platform.domain.UserVo;
import com.dlut.platform.domain.common.ReturnMsg;
import java.util.Map;

public interface UserService {
    /**
     * 用户登录
     */
    ReturnMsg login(UserVo userVo);

    Map<String,Object> selectUserList(Map<String,Object> params);

    ReturnMsg addUser(UserVo userVo);
}
