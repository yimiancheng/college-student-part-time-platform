<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="./common/base.jsp"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta charset="utf-8" />
    <title>用户管理</title>
    <%@ include file="./common/static/headerLink.jspf"%>
</head>
<body class="no-skin">
<jsp:include page="./common/top.jsp" />
<div class="main-container ace-save-state" id="main-container">
    <jsp:include page="./common/left.jsp" />
    <div class="main-content">
        <div class="main-content-inner">
            <div class="breadcrumbs ace-save-state" id="breadcrumbs">
                <ul class="breadcrumb" id="breadcrumb">
                </ul>
            </div>
            <div class="page-content">
                <div class="page-header">
                    <div id="serch_form">
                        <div class="row">
                            <div class="form-group-sm col-xs-3">
                                <label class="col-xs-4 control-label">用户姓名：</label>

                                <div class="input-group col-xs-8">
                                    <input class="chosen-select form-control" id="username" name="username"
                                           placeholder="用户名称 ..."></input>
                                </div>
                            </div>

                            <div class="form-group-sm col-xs-3">
                                <label class="col-xs-4 control-label">用户角色：</label>

                                <div class="input-group col-xs-7">
                                    <select class="select2 form-control" id="userrole">
                                    </select>
                                </div>
                            </div>

                            <div class="form-group-sm col-xs-3">
                                <label class="col-xs-4 control-label">用户状态：</label>

                                <div class="input-group col-xs-7">
                                    <select class="select2 form-control" id="userstate">
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div id="toolbar" class="btn-group">
                        <button id="btn_query" type="button" class="btn btn-success">
                            <span class="glyphicon glyphicon-search" aria-hidden="true"></span>&nbsp;&nbsp;查询
                        </button>
                        <button id="btn_reset" type="button" class="btn btn-info">
                            <span class="glyphicon glyphicon-repeat" aria-hidden="true"></span>&nbsp;&nbsp;重置
                        </button>
                        <button id="btn_add" type="button" class="btn btn-primary">
                            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>&nbsp;&nbsp;新增
                        </button>
                    </div>

                    <table id="table" style="background: aliceblue"></table>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="./common/footer.jsp" />
</div>
<!-- /.main-container -->
<%@ include file="./common/static/aceJs.jspf"%>

<script>
    var USER_STATE_DATA = [
        {text: "全部", id: "0"},
        {text: "正常", id: "NORMAL"},
        {text: "禁止登录", id: "FORBIDDEN_LOGIN"}
    ];

    var USER_ROLE_DATA = [
        {text: "全部", id: "0"},
        /*{text: "老师", id: "TEACHER"},*/
        {text: "学生", id: "STUDENT"},
        {text: "系统管理员", id: "SYS_MNG"}
    ];

    jQuery(function($) {
        init_select2_data("userrole", "请选择用户角色", USER_ROLE_DATA);
        init_select2_data("userstate", "请选择用户状态", USER_STATE_DATA);

        initTable();

        $("#btn_query").click(function () {
            $("#table").bootstrapTable('removeAll');
            $('#table').bootstrapTable("refresh");
        });

        $("#btn_reset").click(function () {
            $('#userstate').select2("val", ["0"]);
            $('#userrole').select2("val", ["0"]);
            $('#username').val("");
        });

        $("#btn_add").click(function () {
            addUser();
        });
    });

    var ADD_DIALOG_USER = null;

    function addUser() {
        ADD_DIALOG_USER = open_Dialog("/user/addUserPage?t=" + new Date().getTime(), "新增用户",
            BootstrapDialog.TYPE_PRIMARY, addUserAjax, BootstrapDialog.SIZE_NORMAL);

        ADD_DIALOG_USER.onShown(function (dialogRef) {
            dialogRef.getModalBody().find('#userName').val("");
            dialogRef.getModalBody().find('#usernick').val("");
            dialogRef.getModalBody().find('#password').val("1");

            dialogRef.getModalBody().find('#phone').val("");
            dialogRef.getModalBody().find('#wxid').val("");
            dialogRef.getModalBody().find('#userImg').val("");
            dialogRef.getModalBody().find('#userContent').val("");
        });
    }
    
    function addUserAjax(dialogRef) {
        var data = {};
        data["username"] = dialogRef.getModalBody().find('#username').val();
        data["usernick"] = dialogRef.getModalBody().find('#usernick').val();

        if(data["username"].length < 1 || data["usernick"].length < 1) {
            showErrorDialog("用户信息不完整！");
            return;
        }

        data["phone"] = dialogRef.getModalBody().find('#phone').val();
        data["wxid"] = dialogRef.getModalBody().find('#wxid').val();
        data["userImg"] = dialogRef.getModalBody().find('#userImg').val();
        data["userContent"] = dialogRef.getModalBody().find('#userContent').val();

        data["password"] = dialogRef.getModalBody().find('#password').val();
        data["userrole"] = $('#userrole_dialog').select2("val");
        data["userstate"] = $('#userstate_dialog').select2("val");

        senAjax("${cxt}/user/addUser", data,
            function (jsonData) {
                if(jsonData && jsonData.success) {
                    $('#table').bootstrapTable("refresh");
                    dialogRef.close();
                }
                else {
                    showErrorDialog(data["userName"] + " 添加失败！<br>" + jsonData.resultMessage);
                }
            },
            function (XMLHttpRequest, textStatus, errorThrown) {
                showErrorDialog(data["userName"] + " 添加失败！");
            }
        );
    }
    
    function initTable() {
        $('#table').bootstrapTable({
            url: '${ctx}/user/selectUserList',
            method: 'post',
            cache: false,
            dataType : "json",
            contentType : "application/json",
            classes: "table",

            queryParams: function (param) {
                param = param == null ? {} : param;

                param["username"] = $('#username').val();
                param["userrole"] = "enum_" + $('#userrole').select2("data")[0].text;
                param["userstate"] = "enum_" + $('#userstate').select2("data")[0].text;

                return param;
            },
            onLoadError: function (status) {
                if(status != 200) {
                    showErrorDialog("数据加载失败，请重试");
                }
            },

            pagination: true,
            pageList: [10,20,30],
            pageSize: 10,
            pageNumber: 1,
            sidePagination: "server",

            search: false,
            striped: true,
            locale: "zh-CN",
            toolbar: '#toolbar',
            showRefresh: false,
            showColumns: true,
            showToggle: false,

            minimumCountColumns: 2,
            clickToSelect: false,

            sortable: true,
            uniqueId: "id",
            sortOrder: "desc",

            paginationShowPageGo: true,
            showJumpto: true,
            pageGo: function () {
                return '跳转到';
            },

            columns: [
                {
                    field: 'id',
                    title: 'ID',
                    visible: false
                },
                {
                    field: 'username',
                    valign: 'middle',
                    title: '账号'
                },
                {
                    field: 'usernick',
                    valign: 'middle',
                    title: '姓名'
                },
                {
                    field: 'userrole',
                    valign: 'middle',
                    title: '角色'
                },
                {
                    field: 'userstate',
                    valign: 'middle',
                    title: '状态'
                },
                {
                    field: 'phone',
                    valign: 'middle',
                    title: '手机号'
                },
                {
                    field: 'wxid',
                    valign: 'middle',
                    title: '微信'
                },
                {
                    field: 'userImg',
                    valign: 'middle',
                    title: '用户头像',
                    visible: false
                },
                {
                    field: 'userContent',
                    valign: 'middle',
                    title: '个性签名',
                    visible: false
                },
                {
                    field: '',
                    title: '操作',
                    align: 'center',
                    valign: 'middle',
                    width: '200px',
                    formatter: function(value, rowData, index) {
                        var btnText = rowData.userstate == '正常' ? '禁用' : '启用';

                        var html =  '<div class="btn-group btn-group-sm">' +
                            '<button type="button" class="btn btn-success" onclick="toLogProjectPage(' +
                            rowData.id  + ')">' + btnText + '</button>';

                        html +=  '<button type="button" class="btn btn-info" onclick="toUploadLogPage(\'' +
                            rowData.groupId + '\')">重置密码</button>';

                        return html + '</div>';
                    }
                }
            ]
        });
    }
</script>
</body>
</html>
