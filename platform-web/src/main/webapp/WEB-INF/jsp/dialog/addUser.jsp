<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta charset="utf-8" />
    <title>新增用户</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

    <script>
        jQuery(function($) {
            init_select2_data("userrole_dialog", "请选择用户角色", USER_ROLE_DATA.slice(1));
            init_select2_data("userstate_dialog", "请选择用户状态", USER_STATE_DATA.slice(1));
        });
        
    </script>
</head>
<body class="container-fluid">
    <div role="form" id="edit_bug" class="form-horizontal">
        <div class="form-group">
            <label class="col-xs-3 control-label">账号名：</label>

            <div class="input-group col-xs-8">
                <input id="username" type="text" class="form-control" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">姓名：</label>

            <div class="input-group col-xs-8">
                <input id="usernick" type="text" class="form-control" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">密码：</label>

            <div class="input-group col-xs-8">
                <input id="password" type="text" class="form-control" readonly />
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">用户角色：</label>

            <div class="input-group col-xs-8">
                <select class="select2 form-control" id="userrole_dialog">
                </select>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">用户状态：</label>

            <div class="input-group col-xs-8">
                <select class="select2 form-control" id="userstate_dialog">
                </select>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">手机号：</label>

            <div class="input-group col-xs-8">
                <input id="phone" type="text" class="form-control" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">微信号：</label>

            <div class="input-group col-xs-8">
                <input id="wxid" type="text" class="form-control" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">用户头像：</label>

            <div class="input-group col-xs-8">
                <input id="userImg" type="text" class="form-control" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">用户签名：</label>

            <div class="input-group col-xs-8">
                <input id="userContent" type="text" class="form-control" />
            </div>
        </div>
    </div>
</body>
</html>
