package com.dlut.platform.controller.util;

import com.dlut.platform.domain.common.ReturnMsg;
import com.dlut.platform.service.util.CommandService;
import com.dlut.platform.util.GsonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.List;

@Controller
@RequestMapping("/command")
public class CommandController {
    @Autowired
    private CommandService commandService;

    @RequestMapping("/page")
    public String page() {
        return "util/command";
    }

    @RequestMapping("/executor")
    @ResponseBody
    public String executor(String content){
        ReturnMsg rm = ReturnMsg.success();
        try {
            List list = commandService.executor(content);
            rm.setSuccess(true);
            rm.setResult(list);
        }
        catch (Exception e) {
            e.printStackTrace();
            rm.setSuccess(false);
            rm.setResultMessage(e.getMessage());
        }

        return GsonUtil.toDateTimeFormatJson(rm);
    }
}
