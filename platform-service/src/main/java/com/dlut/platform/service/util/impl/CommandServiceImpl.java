package com.dlut.platform.service.util.impl;

import com.dlut.platform.dao.util.CommandDao;
import com.dlut.platform.service.util.CommandService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service
public class CommandServiceImpl implements CommandService {
    private static Logger infoLog = LoggerFactory.getLogger("CommandServiceImpl");

    @Resource
    private CommandDao commandDao;

    @Override
    public List executor(String content) {
        String[] sqls = content.split(";");
        List list = new ArrayList();
        for(String sql : sqls) {
            infoLog.info("sql: " + sql);
            List res = executorOneSql(sql);
            if(CollectionUtils.isNotEmpty(res)) {
                list.add(res);
            }
        }
        return list;
    }

    private List executorOneSql(String content) {
        List list = new ArrayList();
        if(StringUtils.startsWithIgnoreCase(content, "select") || StringUtils.startsWithIgnoreCase(content, "show")) {
            list = commandDao.query(content);
        }
        else if(StringUtils.startsWithIgnoreCase(content, "insert")) {
            commandDao.add(content);
        }
        else if(StringUtils.startsWithIgnoreCase(content, "delete")) {
            commandDao.remove(content);
        }
        else {
            commandDao.executor(content);
        }
        return list;
    }
}
