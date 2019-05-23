package com.dlut.platform.service.impl;

import com.dlut.platform.dao.UserDao;
import com.dlut.platform.domain.UserVo;
import com.dlut.platform.domain.common.ReturnMsg;
import com.dlut.platform.domain.enumVo.USER_ENUM;
import com.dlut.platform.service.UserService;
import com.google.common.hash.Hashing;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import javax.annotation.Resource;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Map;

/**
 * UserServiceImpl
 *
 * @date 2019/3/8 14:34
 */
@Service
public class UserServiceImpl implements UserService {
    private static final Logger LOG = LoggerFactory.getLogger(UserServiceImpl.class);

    @Resource
    private UserDao userDao;

    @Override
    public ReturnMsg login(UserVo userVo) {
        ReturnMsg returnMsg = ReturnMsg.success();

        /*if(StringUtils.equals(userVo.getUsername(), "admin") && StringUtils.equals(userVo.getPassword(), "admin")) {
            userVo.setId(-1);
            userVo.setUserrole(USER_ENUM.SYS_MNG);
            returnMsg.setResult(userVo);
            return returnMsg;
        }*/

        userVo.setPassword(md5Password(userVo));
        UserVo userVoDb = userDao.selectUser(userVo);

        if(userVoDb == null) {
            returnMsg.setSuccess(false);
            returnMsg.setResultMessage("用户名和密码不匹配！");
        }
        else if(!USER_ENUM.NORMAL.equals(userVoDb.getUserstate())) {
            returnMsg.setSuccess(false);
            returnMsg.setResultMessage("账号状态异常，请联系管理员！【" + userVoDb.getUserstate().getName() + "】");
        }
        else {
            if(USER_ENUM.SYS_MNG.equals(userVoDb.getUserrole())) {
                userVoDb.setAdmin(true);
            }
            else {
                userVoDb.setAdmin(false);
            }

            returnMsg.setResult(userVoDb);
        }

        return returnMsg;
    }

    private String md5Password(UserVo userVo) {
        return Hashing.md5().hashString(userVo.getPassword() + "_salt_" + userVo.getUsername(),
            Charset.forName("UTF-8")).toString();
    }

    @Override
    public Map<String, Object> selectUserList(Map<String, Object> params) {
        Map resultMap = new HashMap();

        Integer total = userDao.selectUserListSize(params);
        resultMap.put("total", total);

        if(total != null && total > 0) {
            resultMap.put("rows", userDao.selectUserList(params));
        }

        return resultMap;
    }

    @Override
    @Transactional
    public ReturnMsg addUser(UserVo userVo) {
        userVo.setPassword(md5Password(userVo));
        int size = userDao.insertUser(userVo);
        ReturnMsg returnMsg = ReturnMsg.success();

        if(size != 1) {
            returnMsg.setSuccess(false);
            returnMsg.setResultMessage("插入数据库失败！");
        }

        return returnMsg;
    }
}
