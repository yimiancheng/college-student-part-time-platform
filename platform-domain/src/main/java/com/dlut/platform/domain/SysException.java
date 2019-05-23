package com.dlut.platform.domain;

import com.dlut.platform.domain.common.ReturnMsg;

/**
 * SysException
 *
 * @date 2019/5/14 14:27
 */
public class SysException extends RuntimeException {
    private ReturnMsg returnMsg;

    public SysException(String message, ReturnMsg returnMsg) {
        super(message);
        this.returnMsg = returnMsg;
    }

    public ReturnMsg getReturnMsg() {
        return returnMsg;
    }
}
