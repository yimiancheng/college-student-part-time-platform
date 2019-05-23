package com.dlut.platform.domain;

import com.dlut.platform.domain.enumVo.USER_ENUM;
import java.io.Serializable;

/**
 * UserVo
 *
 * @date 2019/3/8 14:26
 */
public class UserVo implements Serializable {
    private static final long serialVersionUID = -8124025896159793004L;
    private Integer id;
    private String username;
    private String password;
    private String usernick;
    private USER_ENUM userrole;
    private USER_ENUM userstate;
    private String wxid;
    private String phone;
    private String userImg;
    private String userContent;

    private Boolean admin;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setUserrole(USER_ENUM userrole) {
        this.userrole = userrole;
    }

    public void setUserstate(USER_ENUM userstate) {
        this.userstate = userstate;
    }

    public USER_ENUM getUserrole() {
        return userrole;
    }

    public USER_ENUM getUserstate() {
        return userstate;
    }

    public String getUsernick() {
        return usernick;
    }

    public void setUsernick(String usernick) {
        this.usernick = usernick;
    }

    public String getWxid() {
        return wxid;
    }

    public void setWxid(String wxid) {
        this.wxid = wxid;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getUserImg() {
        return userImg;
    }

    public void setUserImg(String userImg) {
        this.userImg = userImg;
    }

    public String getUserContent() {
        return userContent;
    }

    public void setUserContent(String userContent) {
        this.userContent = userContent;
    }

    public Boolean getAdmin() {
        return admin;
    }

    public void setAdmin(Boolean admin) {
        this.admin = admin;
    }
}
