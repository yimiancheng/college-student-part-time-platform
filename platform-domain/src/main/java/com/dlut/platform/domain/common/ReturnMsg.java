package com.dlut.platform.domain.common;

import java.io.Serializable;

public final class ReturnMsg implements Serializable {
    private static final long serialVersionUID = 3958191169088495763L;
    private boolean success = true;
    private Object result;
    private String resultMessage;

    public ReturnMsg() {
        this.success = true;
    }

    public ReturnMsg(boolean success, String resultMessage) {
        this.success = success;
        this.resultMessage = resultMessage;
    }

    public static ReturnMsg success() {
        return new ReturnMsg();
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public Object getResult() {
        return result;
    }

    public void setResult(Object result) {
        this.result = result;
    }

    public String getResultMessage() {
        return resultMessage;
    }

    public void setResultMessage(String resultMessage) {
        this.resultMessage = resultMessage;
    }

    public void setErrorResultMessage(String resultMessage) {
        this.success = false;
        this.resultMessage = resultMessage;
    }

    @Override
    public String toString() {
        return "ReturnMsg{" + "success=" + success + ", result='" + result + '\'' + ", resultMessage='" +
            resultMessage + '\'' + '}';
    }
}