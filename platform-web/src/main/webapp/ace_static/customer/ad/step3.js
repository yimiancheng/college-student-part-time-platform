var PREVIEW_DIALOG = null;
var UPLOAD_DIALOG = null;

var SELECT_DIALOG = null;

function init_table_author_materiel_list() {
    $('#authorMaterielList').bootstrapTable({
        url: '/adWeb/plan/selectAuthorMateriel',
        method: 'post',
        cache: false,
        dataType : "json",
        contentType : "application/json",
        locale: "zh-CN",
        classes: 'table small table-hover',
        toolbar: "#toolbar_plan3Two",
        queryParams: getTableIdParam,
        onLoadError: function (status) {
            if(status != 200) {
                showErrorDialog("加载报审资料失败，请重试");
            }
        },
        onLoadSuccess: function (data) {
            $("#authorMaterielList .bs-checkbox").css({
                'vertical-align': 'middle'
            });

            $("#authorMaterielList tr>td, #authorMaterielList tr>th").css({
                'border': '0px',
                'border-bottom': '1px solid #ddd',
            });

            if(data && data.length > 0) {
                $("#toolbar_plan3Two").hide();
            }
        },

        columns: [
            {
                field: 'materielName',
                title: '报审资料',
                align: 'left',
                valign: 'middle',
                formatter: function (value, rowData, index) {
                    var html = null;

                    if(value) {
                        html = '<a style="cursor: pointer;">' + value + '</a>'
                    }

                    return html;
                }
            },
            {
                field: '',
                title: '操作',
                align: 'center',
                valign: 'middle',
                width: 250,
                formatter: function (value, rowData, index) {
                    var html = '<div class="hidden-sm hidden-xs btn-group">';

                    if(rowData.url) {
                        html += '<button class="btn btn-xs btn-info btn-white"' +
                            'onclick="select_materiel(' + index + ', ' + null + ', ' + null + ',\'authorMateriel\')">' +
                            '<i class="ace-icon fa fa-pencil bigger-120"></i>&nbsp;修改报审资料' +
                            '</button>';
                    }

                    return html + '</div>';
                }
            }
        ],
        onClickCell: function(field, value, row, $element) {
            if(field == 'materielName') {
                showImageOrViedo(row.url, row.materielName, "IMAGE");
            }

            return false;
        }
    });
}

// 级联后续加上
function init_table_materiel_list() {
    $('#materielList').bootstrapTable({
        url: '/adWeb/plan/selectMaterielByDpi',
        method: 'post',
        cache: false,
        dataType : "json",
        contentType : "application/json",
        locale: "zh-CN",
        classes: 'table small table-hover',
        queryParams: getTableIdParam,
        onLoadError: function (status) {
            if(status != 200) {
                showErrorDialog("加载广告素材失败，请重试");
            }
        },
        onLoadSuccess: function (data) {
            $("#materielList .bs-checkbox").css({
                'vertical-align': 'middle'
            });

            $("#materielList tr>td, #materielList tr>th").css({
                'border': '0px',
                'border-bottom': '1px solid #ddd',
            });
        },

        striped: false,

        columns: [
            {
                field: 'dpi',
                title: '分辨率',
                align: 'left',
                valign: 'middle',
                formatter: function(value, rowData, index) {
                    if(rowData.isMultiAdPosition) {
                        return rowData.dpiAd;
                    }
                    else {
                        return rowData.dpi;
                    }
                }
            },
            {
                field: 'materielName',
                title: '物料名称',
                align: 'left',
                valign: 'middle',
                formatter: function (value, rowData, index) {
                    var html = null;

                    if(value) {
                        html = '<a style="cursor: pointer;">' + value + '</a>'
                    }

                    return html;
                }
            },
            {
                field: 'materielType',
                title: '物料类型',
                align: 'left',
                valign: 'middle',
                formatter: function (value, rowData, index) {
                    return getMaterielType(value);
                }
            },
            {
                field: '',
                title: '操作',
                align: 'center',
                valign: 'middle',
                width: 200,
                formatter: function (value, rowData, index) {
                    var html = '<div class="hidden-sm hidden-xs btn-group">';
                    // var _row = JSON.stringify(rowData);;

                    if(rowData.url) {
                        html += '<button class="btn btn-xs btn-info btn-white"' +
                            'onclick="select_materiel(' + index + ', \'' + rowData.dpiAd + '\', \'' + rowData.dpi + '\',\'adMateriel\')">' +
                            '<i class="ace-icon fa fa-pencil bigger-120"></i>&nbsp;修改素材' +
                            '</button>';
                    }
                    else {
                        html += '<button class="btn btn-xs btn-success btn-white" ' +
                            'onclick="select_materiel(' + index + ', \'' + rowData.dpiAd + '\', \'' + rowData.dpi + '\',\'adMateriel\')">' +
                            '<i class="ace-icon fa fa-search-plus bigger-120"></i>&nbsp;选择素材' +
                            '</button>';

                        html += '<button class="btn btn-xs btn-info btn-white"' +
                            ' onclick="upload_materiel(\'' + rowData.dpiAd + '\', \'' + rowData.dpi + '\',\'adMateriel\')">' +
                            '<i class="ace-icon fa fa-cloud-upload bigger-120"></i>&nbsp;上传素材' +
                            '</button>';
                    }

                    return html + '</div>';
                }
            }
        ],

        onClickCell: function(field, value, row, $element) {
            //  && row.materielPath
            if(field == 'materielName') {
                showImageOrViedo(row.url, row.materielName, row.materielType);
            }

            return false;
        }
    });
}

function init_table_select_materiel(subTable) {
    var _isAdMateriel = SELECT_DIALOG.getData("isAdMateriel");;

    subTable.bootstrapTable({
        url: '/adWeb/plan/selectMateriel',
        method: 'post',
        cache: false,
        dataType : "json",
        contentType : "application/json",
        locale: "zh-CN",
        classes: 'table small table-hover',
        queryParams: function (params) {
            params = params ? params : {};
            params.id = getLaunchId();
            params.isAdMateriel = SELECT_DIALOG.getData("isAdMateriel");
            return params;
        },
        onLoadError: function (status) {
            if(status != 200) {
                showErrorDialog("加载资源列表失败，请重试");
            }
        },

        height: 400,
        striped: false,
        search: true,
        trimOnSearch: true,
        searchOnEnterKey: false,
        singleSelect: true,
        clickToSelect: true,

        uniqueId: 'id',

        pagination: true,
        pageList: [5, 10, 20, 30, 40, 50, 100],
        pageSize: 5,
        pageNumber: 1,
        sidePagination: "server",

        paginationShowPageGo: true,
        showJumpto: true,
        pageGo: function () {
            return '跳转到';
        },
        onLoadSuccess: function (data) {
            $("#allMaterielList .bs-checkbox").css({
                'vertical-align': 'middle'
            });

            $("div#img_VIV").css({
                'height': '400px'
            });

            $("#allMaterielList tr>td, #allMaterielList tr>th").css({
                'border': '0px',
                'border-bottom': '1px solid #ddd',
            });

            $(".bootstrap-table .fixed-table-toolbar .search input").css({
                'width': '300px'
            });

            $(".bootstrap-table .fixed-table-toolbar .search").removeClass("pull-right");
            $(".bootstrap-table .fixed-table-toolbar .search").addClass("pull-left");
        },

        columns: [
            {
                checkbox: true
            },
            {
                field: 'materielName',
                title: '名称',
                align: 'left',
                valign: 'middle',
                formatter: function (value, rowData, index) {
                    if(!_isAdMateriel) {
                        return rowData.name;
                    }
                    else {
                        return value;
                    }
                }
            },
            {
                field: 'materielType',
                title: '类型',
                align: 'left',
                valign: 'middle',
                visible: _isAdMateriel,
                formatter: function (value, rowData, index) {
                    return getMaterielType(value);
                }
            },
            {
                field: 'description',
                title: '描述',
                align: 'left',
                valign: 'middle',
                visible: _isAdMateriel,
            },
            {
                field: 'createTime',
                title: '创建时间',
                align: 'left',
                valign: 'middle'
            }
        ],
        onCheck: function (row, $ele) {
            show_img(row, SELECT_DIALOG.getData("isAdMateriel"));
        }
    });
}

function show_img(row, _isAdMateriel) {
    $("#img_VIV").children().hide();

    if(!row || _isAdMateriel == undefined) {
        return;
    }

    var value_type = row.materielType;

    if(!_isAdMateriel || "IMAGE" == value_type) {
        $("#img_VIV #img_content").attr("src", row.url);
        $("#img_VIV #img_content").show();
    }
    else if ("VIDEO" == value_type) {
        // .children('source')
        $("#img_VIV #video_content").attr("src", row.url);
        $("#img_VIV #video_content").show();
    }
    else if ("AUDIO" == value_type) {
        // .children('source')
        $("#img_VIV #audio_content").attr("src", row.url);
        $("#img_VIV #audio_content").show();
    }
}

function getMaterielType(value) {
    if ("IMAGE" == value) {
        return "图片";
    }
    if ("VIDEO" == value) {
        return "视频";
    }
    if ("AUDIO" == value) {
        return "音频";
    }
    if ("OTHER" == value) {
        return "其它";
    }

    return value;
}

function showImageOrViedo(url, materielName, materielType) {
    getPreViewDialog();

    var materielPath = url;

    if(materielPath) {
        PREVIEW_DIALOG.realize();
        var url = materielPath;
        PREVIEW_DIALOG.setTitle('预览-' + materielName);
        var contet = "";

        if('IMAGE' == materielType) {
            contet = '<img src="' + url +'" class="img-responsive center-block" style="width:400px;">';
        }
        else if('VIDEO' == materielType) {
            contet = '<video src="' + url +
                '" controls="controls" class="img-responsive center-block" style="width:400px;">您的浏览器不支持 video 标签。 </video>';
        }
        else if('AUDIO' == materielType) {
            contet = '<audio controls="controls" autoplay ><source src="' + url + '">您的浏览器不支持 audio 标签。</audio>';
        }

        PREVIEW_DIALOG.setMessage(contet);
        PREVIEW_DIALOG.open();
    }
}

function getPreViewDialog() {
    if(PREVIEW_DIALOG == null) {
        PREVIEW_DIALOG = new BootstrapDialog({
            // size: BootstrapDialog.SIZE_WIDE,
            closable: true,
            closeByBackdrop: true,
            closeByKeyboard: true,
            cssClass: "text-center dialog_move"
        });
    }

    return PREVIEW_DIALOG;
}

function upload_materiel(dpiAd, dpi, type) {
    var isAdMateriel = type == 'adMateriel';
    var title = isAdMateriel ? "上传素材" : "上传报审资料";

    get_dialog_upload_materiel(title, isAdMateriel);

    UPLOAD_DIALOG.setData("dpiAd", dpiAd);
    UPLOAD_DIALOG.setData("dpi", dpi);
    UPLOAD_DIALOG.setTitle(title);
    UPLOAD_DIALOG.open();
}

function uploadExtraDataFun(param) {
    return {
        file : UPLOAD_DIALOG.getModalBody().find('#file').val(),
        materielType : UPLOAD_DIALOG.getModalBody().find('#materielType').val(),
        materielName : UPLOAD_DIALOG.getModalBody().find('#materielName').val(),
        isAdMateriel : UPLOAD_DIALOG.getData("isAdMateriel"),
        description : UPLOAD_DIALOG.getModalBody().find('#materielcontent').val(),
        dpiAd : UPLOAD_DIALOG.getData("dpiAd"),
        dpi : UPLOAD_DIALOG.getData("dpi"),
        launchId: getLaunchId()
    }
}

function select_materiel(index, dpiAd, dpi, type) {
    var isAdMateriel = type == 'adMateriel';
    var title = isAdMateriel ? "修改素材" : "修改报审资料";

    var rowData = null;

    if(index != null && index >= 0) {
        if(isAdMateriel) {
            rowData = $('#materielList').bootstrapTable("getData")[index];
        }
        else {
            rowData = $('#authorMaterielList').bootstrapTable("getData")[index];
        }
    }

    get_dialog_select_materiel(title, isAdMateriel, rowData);

    SELECT_DIALOG.setData("dpiAd", dpiAd);
    SELECT_DIALOG.setData("dpi", dpi);
    SELECT_DIALOG.setTitle(title);
    SELECT_DIALOG.open();
}

function get_dialog_select_materiel(title, isAdMateriel, rowData) {
    if(!SELECT_DIALOG) {
        var message = $('#content_select_materiel').html().trim();
        message = message.replace(/[\n\r]/g, '');

        SELECT_DIALOG = new BootstrapDialog({
            title: title,
            // $('<div></div>').load('/adWeb/test')
            message: message,
            size: BootstrapDialog.SIZE_WIDE,
            closable: false,
            draggable: true,
            cssClass: "text-primary text-left dialog_move",
            onshown: function(dialogRef) {
                var subTable = dialogRef.getModalBody().find('#allMaterielList');
                show_img(SELECT_DIALOG.getData("rowData"), SELECT_DIALOG.getData("isAdMateriel"));

                if(subTable) {
                    init_table_select_materiel(subTable);
                }
                else {
                    dialogRef.close();
                    showErrorDialog("请重新打开！");
                }
            },
            buttons:[
                {
                    label: '取消',
                    cssClass: 'btn-xs',
                    action: function(dialog){
                        dialog.close();
                    }
                },
                {
                    label: '上传',
                    cssClass: 'btn-xs btn-success',
                    action: function(dialog){
                        dialog.close();
                        var isAdMateriel = SELECT_DIALOG.getData("isAdMateriel");
                        var type = isAdMateriel ? 'adMateriel' : 'authorMateriel';
                        upload_materiel(SELECT_DIALOG.getData("dpiAd"), SELECT_DIALOG.getData("dpi"), type);
                    }
                },
                {
                    label: '确认',
                    cssClass: 'btn-primary btn-xs',
                    action: function(dialogRef){
                        var subTable = dialogRef.getModalBody().find('#allMaterielList');
                        var materielId = subTable.bootstrapTable("getSelections");

                        if(materielId && materielId.length != 1) {
                            showErrorDialog("请选择资源！");
                            return;
                        }

                        dialogRef.close();

                        var dpiAd = dialogRef.getData("dpiAd");
                        var dpi = dialogRef.getData("dpi");
                        var launchId = getLaunchId();
                        var _materielId = materielId[0].id;

                        var isAdMateriel = dialogRef.getData("isAdMateriel");

                        var data = {
                            adDpi: dpiAd,
                            dpi: dpi,
                            launchId: launchId,
                            materielId: _materielId,
                            isAdMateriel: isAdMateriel,
                            materielName: materielId[0].materielName
                        };

                        senAjax("/adWeb/plan/setMaterielId", data,
                            function (jsonData) {
                                if(jsonData && jsonData.success) {
                                    showSuccessDialog("执行成功！");

                                    if(!isAdMateriel) {
                                        $('#authorMaterielList').bootstrapTable("refresh");
                                    }
                                    else {
                                        $('#materielList').bootstrapTable("refresh");
                                    }
                                }
                                else {
                                    showErrorDialog("执行失败！");
                                }
                            },
                            function (XMLHttpRequest, textStatus, errorThrown) {
                                showErrorDialog("执行失败！");
                            }
                        );
                    }
                }
            ]
        });
    }

    if(SELECT_DIALOG) {
        SELECT_DIALOG.setData("isAdMateriel", isAdMateriel);
        SELECT_DIALOG.setData("rowData", rowData);
    }
}

function get_dialog_upload_materiel(title, isAdMateriel) {
    if(!UPLOAD_DIALOG) {
        var message = $('#content_materiel').html().trim();
        message = message.replace(/[\n\r]/g, '');

        UPLOAD_DIALOG = new BootstrapDialog({
            title: title,
            message: message,
            size: BootstrapDialog.SIZE_NORMAL,
            closable: false,
            draggable: true,
            cssClass: "text-primary text-left dialog_move",
            onshown: function(dialogRef) {
                $("#" + dialogRef.getId() + " .modal-body .chosen-select").each(function() {
                    init_chosen_select($(this));
                });

                init_file_upload($(".modal-body #file"), "/adWeb/plan/upload", uploadExtraDataFun, function (jsonData) {
                    if(jsonData.success) {
                        var _isAdMateriel = UPLOAD_DIALOG.getData("isAdMateriel");

                        if(!_isAdMateriel) {
                            $('#authorMaterielList').bootstrapTable("refresh");
                        }
                        else {
                            $('#materielList').bootstrapTable("refresh");
                        }
                    }
                    else {
                        var error = jsonData.error ? jsonData.error : "";
                        showErrorDialog(jsonData.fileName + " 上传失败！ " + error);
                    }
                });

                var _isAdMateriel = dialogRef.getData("isAdMateriel");
                _isAdMateriel = _isAdMateriel == undefined ? isAdMateriel : _isAdMateriel;
                UPLOAD_DIALOG.setData("isAdMateriel", _isAdMateriel);

                if(!_isAdMateriel) {
                    UPLOAD_DIALOG.getModalBody().find('#materielName_span').text("报审资料名称：");
                    UPLOAD_DIALOG.getModalBody().find('#file_span').text("报审资料:");
                    UPLOAD_DIALOG.getModalBody().find('#table_div').hide();
                }
                else {
                    UPLOAD_DIALOG.getModalBody().find('#materielName_span').text("素材名称：");
                    UPLOAD_DIALOG.getModalBody().find('#file_span').text("素材文件:");
                    UPLOAD_DIALOG.getModalBody().find('#table_div').show();
                }
            },
            buttons:[
                {
                    label: '取消',
                    cssClass: 'btn-xs',
                    action: function(dialog){
                        dialog.close();

                        var _isAdMateriel = UPLOAD_DIALOG.getData("isAdMateriel");

                        if(!_isAdMateriel) {
                            $('#authorMaterielList').bootstrapTable("refresh");
                        }
                        else {
                            $('#materielList').bootstrapTable("refresh");
                        }
                    }
                },
                {
                    label: '上传',
                    cssClass: 'btn-primary btn-xs',
                    action: function(dialog){
                        // dialog.close();
                        var file = UPLOAD_DIALOG.getModalBody().find('#file').val();
                        var materielType = UPLOAD_DIALOG.getModalBody().find('#materielType').val();
                        var materielName = UPLOAD_DIALOG.getModalBody().find('#materielName').val();

                        if(file && materielType && materielName) {
                            $(".modal-body #file").fileinput("upload");
                        }
                        else {
                            showErrorDialog("填写信息不完整！");
                        }
                    }
                }
            ]
        });
    }
    else {
        UPLOAD_DIALOG.setData("isAdMateriel", isAdMateriel);
    }
}