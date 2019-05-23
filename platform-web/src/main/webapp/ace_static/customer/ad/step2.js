
var SSP_COLUMNS = [
    {
        checkbox: true
    },
    {
        field: 'mediaName',
        title: '媒体位',
        align: 'left',
        valign: 'middle',
        formatter: function(value, rowData, index) {
            var html = "";

            if(!value) {
                return html;
            }

            if(rowData.isMultiAdPosition && !rowData.isLinkage) {
                // tooltip-info
                html = '<span class="badge badge-purple pointerSpan" data-rel="tooltip"' +
                    ' data-placement="bottom"' +
                    ' title="' + rowData.positionName + '">' + value + '</span>';
            }
            else if(rowData.isMultiAdPosition && rowData.isLinkage) {
                html = '<span class="badge badge-warning pointerSpan tooltip-info" data-rel="tooltip"' +
                    ' data-placement="bottom" title="' + '联动屏，点击我获取详细信息！'
                    + '" onclick="showLinkSspInfo(' + rowData.sspId + ', \'' + value + '\')">' + value + '</span>';
            }
            else {
                html = '<span class="badge badge-success pointerSpan">' + value + '</span>';
            }

            return html;
        }
    },
    {
        field: 'area',
        title: '区域',
        align: 'left',
        valign: 'middle',
    },
    {
        field: 'address',
        title: '详细地址',
        align: 'left',
        valign: 'middle',
    },
    {
        field: 'dpi',
        title: '分辨率',
        align: 'left',
        valign: 'middle',
        formatter: function(value, rowData, index) {
            var dpiAd = rowData.dpiAd;

            if(dpiAd) {
                return dpiAd;
            }
            else {
                return value;
            }
        }
    },
    {
        field: 'scene',
        title: '场景',
        align: 'left',
        valign: 'middle',
    },
    {
        field: 'minSellingPeriod',
        title: '最小售<br/>卖周期',
        align: 'left',
        valign: 'middle',
    },
    {
        field: 'carouselUnit',
        title: '最小播放<br/>单元(次)',
        align: 'right',
        valign: 'middle',
        formatter: function(value, rowData, index) {
            if(!value) {
                return 100;
            }
            else {
                return value;
            }
        }
    },
    {
        field: 'cpfPrice',
        title: 'CPF价格',
        align: 'right',
        valign: 'middle',
        formatter: function(value, rowData, index) {
            if(rowData.salePrice && rowData.adId && !rowData.isLinkage) {
                return rowData.salePrice;
            }
            else {
                var cpfPrice = rowData.cpfPrice;
                cpfPrice = cpfPrice ? cpfPrice : rowData.cpmPrice;

                return cpfPrice;
            }
        }
    },
];

var SSP_LINK_AD_COLUMNS = [
    {
        field: 'positionName',
        title: '位置',
        align: 'left',
        valign: 'middle',
    },
    {
        field: '',
        title: '分辨率',
        align: 'left',
        valign: 'middle',
        formatter: function(value, rowData, index) {
            if(rowData.width && rowData.height) {
                return rowData.width + "*" + rowData.height;
            }
        }
    },
    {
        field: 'description',
        title: '描述',
        align: 'left',
        valign: 'middle',
    },
    {
        field: 'salePrice',
        title: '价格',
        align: 'left',
        valign: 'middle',
    },
];
var DIALOG_ADD_SSP_TO_LIST = null;

function showLinkSspInfo(sspId, mediaName) {
    var data = {sspId: sspId};

    senAjax("/adWeb/plan/selectAdPoisById", data,
        function (jsonData) {
            if (jsonData && jsonData.success) {
                var rows = jsonData.result;

                if(rows) {
                    toLocalDataTablePage("id", SSP_LINK_AD_COLUMNS, rows, "联动屏：" + mediaName, BootstrapDialog.SIZE_NORMAL);
                }
                else {
                    showErrorDialog(mediaName + " 联动媒体位不存在！");
                }
            }
            else {
                showErrorDialog(mediaName + " 获取联动媒体位失败！");
            }
        },
        function (XMLHttpRequest, textStatus, errorThrown) {
            showErrorDialog(mediaName + " 获取联动媒体位失败！");
        }
    );
}

function get_ad_select_param(params) {
    params["id"] = lunchId;
    params["mediaName"] = $("#mediaName").val();
    params["poi"] = $("#poi").val();

    var _pname = $(".selectDiv .province").val();

    if(_pname) {
        params["province"] = [_pname];
    }

    var _city = $(".selectDiv .city").val();

    if(_city) {
        params["city"] = [_city];
    }

    params["country"] = $(".selectDiv .country").val();
    params["business"] = $(".selectDiv .business").val();

    params["screenType"] = $("#screenType").select2("val");
    params["dpi"] = $("#dpi").select2("val");
    params["sellingModel"] = $("#sellingModel").select2("val");
    params["minSellingPeriod"] = $("#minSellingPeriod").select2("val");
    params["haveSound"] = $("#haveSound").select2("val");

    // var sspAdType = $("#sspAdType").select2("data");
    var sspAdType = $("#sspAdType").select2("val");

    if(sspAdType && sspAdType == "单广告位") {
        params["isMultiAdPosition"] = false;
        params["isLinkage"] = false;
    }
    else if(sspAdType && sspAdType == "多广告位") {
        params["isMultiAdPosition"] = true;
        params["isLinkage"] = false;
    }
    else if(sspAdType && sspAdType == "联动广告位") {
        params["isLinkage"] = true;
        params["isMultiAdPosition"] = true;
    }
}

function init_table_ad_position() {
    $('#tableAdPoi').bootstrapTable({
        url: '/adWeb/plan/adPoiList',
        method: 'post',
        cache: false,
        dataType : "json",
        contentType : "application/json",
        locale: "zh-CN",
        classes: 'table small table-hover',
        queryParams: function (params) {
            get_ad_select_param(params);
            return params;
        },
        onLoadError: function (status) {
            closeLoadingAjax();

            if(status != 200) {
                showErrorDialog("加载广告位失败，请重试");
            }
        },
        onRefresh: function() {
            closeLoadingAjax();
            showLoadingAjax();
        },
        onLoadSuccess: function (data) {
            closeLoadingAjax();

            $('#tableAdPoi span[data-rel=tooltip]').tooltip();
            // bootstrap-table bs-checkbox
            $("#tableAdPoi .bs-checkbox").css({
                'vertical-align': 'middle'
            });

            $("#tableAdPoi tr>td, #tableAdPoi tr>th").css({
                'border': '0px',
                'border-bottom': '1px solid #ddd',
            });

            var totalVo = data.totalVo || {};
            var adNum = totalVo.adNum || 0;
            $("#adNum_adPoi").text(adNum);

            var sspNum = totalVo.sspNum || 0;
            $("#sspNum_adPoi").text(sspNum);

            var linkSspNum = totalVo.linkSspNum || 0;
            $("#linkSspNum_adPoi").text(linkSspNum);
        },

        striped: false,

        toolbar: '#toolbar_plan2Two',

        pagination: true,
        pageList: [10, 20, 30, 40, 50, 100],
        pageSize: 10,
        pageNumber: 1,
        sidePagination: "server",

        paginationShowPageGo: true,
        showJumpto: true,
        pageGo: function () {
            return '跳转到';
        },

        // rowStyle: "ssp_white",

        columns: SSP_COLUMNS
    });
}

function init_table_ad_list() {
    var AD_LIST_COLUMNS = _.cloneDeep(SSP_COLUMNS);
    AD_LIST_COLUMNS.push(
        {
            field: 'playTimes',
            title: '播放频次<br/>(次/天)',
            align: 'right',
            valign: 'middle',
        }
    );
    AD_LIST_COLUMNS.push(
        {
            field: 'estimateCostByAd',
            title: '周期总价(天)',
            align: 'right',
            valign: 'middle',
            /*formatter: function(value, rowData, index) {
                var diffDay = rowData.diffDay || 1;
                return value * diffDay;
            }*/
        }
    );

    $('#tableAdList').bootstrapTable({
        url: '/adWeb/plan/launchAdList',
        method: 'post',
        cache: false,
        dataType : "json",
        contentType : "application/json",
        locale: "zh-CN",
        striped: false,
        classes: 'table small table-hover',
        queryParams: function (params) {
            params["id"] = lunchId;
            return params;
        },
        onLoadError: function (status) {
            if(status != 200) {
                showErrorDialog("加载已选广告位失败，请重试");
            }
        },
        onLoadSuccess: function (data) {
            $('#tableAdList span[data-rel=tooltip]').tooltip();

            var totalVo = data.totalVo || {};

            var diffDay = totalVo.diffDay || 0;
            $("#diffDay_span").text(diffDay);

            var playTimes = totalVo.playTimes || 0;
            $("#playTimes_span").text(playTimes * diffDay);

            var playPrice = totalVo.playPrice || 0;
            $("#playPrice_span").text(playPrice * diffDay);

            $("#tableAdList .bs-checkbox").css({
                'vertical-align': 'middle'
            });

            $("#tableAdList tr>td, #tableAdList tr>th").css({
                'border': '0px',
                'border-bottom': '1px solid #ddd',
            });
        },

        toolbar: '#toolbar_plan2Three',

        pagination: true,
        pageList: [10, 20, 30, 40, 50, 100],
        pageSize: 10,
        pageNumber: 1,
        sidePagination: "server",

        sortable: true,
        idField: "id",
        uniqueId: "id",
        sortOrder: "desc",

        paginationShowPageGo: true,
        showJumpto: true,
        pageGo: function () {
            return '跳转到';
        },

        columns: AD_LIST_COLUMNS
    });
}

function add_ssp_to_ad_list() {
    var selectSsps = $('#tableAdPoi').bootstrapTable('getSelections');

    if(!selectSsps || selectSsps.length < 1) {
        showErrorDialog("请选择广告位！");
        return;
    }
    else {
        var adPois = [];
        var len = selectSsps.length;

        for(var i = 0; i < len; i++) {
            var each = selectSsps[i];

            if(!each) {
                continue;
            }

            var item = {};
            item.sspId = each.sspId;
            item.mediaName = each.mediaName;

            if(!each.isLinkage) {
                item.positionCode = each.positionCode;
                item.positionName = each.positionName;
                item.adId = each.adId;
            }

            item.isLinkage = each.isLinkage;
            item.isMultiAdPosition = each.isMultiAdPosition;

            item.launchPlanId = lunchId;

            item.planRatio = 1;

            adPois.push(item);
        }

        var data = {
            json: JSON.stringify(adPois)
        };

        senAjax("/adWeb/plan/addAdToLaunchPlan", data,
            function (jsonData) {
                if(jsonData && jsonData.success) {
                    $('#tableAdPoi').bootstrapTable("refresh");
                    $('#tableAdList').bootstrapTable("refresh");
                }
                else {
                    showErrorDialog("添加媒体位失败！");
                }
            },
            function (XMLHttpRequest, textStatus, errorThrown) {
                showErrorDialog("添加媒体位失败！");
            }
        );
    }
}

function getAddSspDialog() {
    if(!DIALOG_ADD_SSP_TO_LIST) {
        DIALOG_ADD_SSP_TO_LIST = new BootstrapDialog({
            title: '设置播放次数',
            message: (
                '<div class="row form-horizontal">' +
                    '<div class="form-group">' +
                        '<label class="col-sm-3 control-label no-padding-right">增加/减少-播放倍数: </label>' +
                        '<div class="col-sm-6">' +
                            '<input type="text" name="ratio" class="form-control">' +
                        '</div>' +
                        '<div class="help-block col-xs-12 col-sm-reset inline smaller red col-sm-offset-3"' +
                            ' style="font-size:12px;">' +
                            '播放次数 = 播放次数最小单元 * 单元' +
                        '</div>' +
                    '</div>' +
                '</div>'
            ),
            size: BootstrapDialog.SIZE_NORMAL,
            type: BootstrapDialog.TYPE_INFO,
            closable: true,
            draggable: true,
            cssClass: "dialog_move dialog_title",
            btnCancelLabel: '取消',
            onshown: function(dialogRef) {
                var ratio = dialogRef.getModalBody().find('input[name="ratio"]');

                if(ratio && ratio.length == 1) {
                    init_ace_spinner(ratio, 1, 1, 100);
                }

                dialogRef.getModalHeader().css('background-color', '#0062c8');
                dialogRef.getModalHeader().css('color', '#fff');
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
                    label: '减少次数',
                    cssClass: 'btn-warning btn-xs',
                    action: function(dialog){
                        var ratio = dialog.getModalBody().find('input[name="ratio"]').val();

                        if(ratio) {
                            dialog.close();
                            update_ad_play_time(-ratio);
                        }
                    }
                },
                {
                    label: '增加次数',
                    cssClass: 'btn-primary btn-xs',
                    action: function(dialog){
                        var ratio = dialog.getModalBody().find('input[name="ratio"]').val();

                        if(ratio) {
                            dialog.close();
                            update_ad_play_time(ratio);
                        }
                    }
                },
            ]
        });
    }

    return DIALOG_ADD_SSP_TO_LIST;
}

function update_ad_play_time(ratio) {
    var data = {
        ratio: ratio,
        adPoisJson: JSON.stringify(DIALOG_ADD_SSP_TO_LIST.getData("adPois"))
    };

    senAjax("/adWeb/plan/updateAdPlayTime", data,
        function (jsonData) {
            if(jsonData && jsonData.success) {
                $('#tableAdList').bootstrapTable("refresh");
            }
            else {
                showErrorDialog("设置播放次数 " + ratio + " 失败！");
            }
        },
        function (XMLHttpRequest, textStatus, errorThrown) {
            showErrorDialog("设置播放次数 " + ratio + " 失败！");
        }
    );
}

function delete_ad_from_ad_list() {
    var selectAds = $('#tableAdList').bootstrapTable('getSelections');

    if(!selectAds || selectAds.length < 1) {
        showErrorDialog("请选择媒体位！");
        return;
    }

    var adPois = [];
    var len = selectAds.length;

    for(var i = 0; i < len; i++) {
        var each = selectAds[i];

        var item = {};
        item.launchPlanId = lunchId;
        item.sspId = each.sspId;
        item.mediaName = each.mediaName;

        if(!each.isLinkage) {
            item.positionCode = each.positionCode;
            item.adId = each.adId;
        }

        item.isLinkage = each.isLinkage;
        item.isMultiAdPosition = each.isMultiAdPosition;

        adPois.push(item);
    }

    var data = {
        json: JSON.stringify(adPois)
    };

    senAjax("/adWeb/plan/delAdToLaunchPlan", data,
        function (jsonData) {
            if(jsonData && jsonData.success) {
                $('#tableAdPoi').bootstrapTable("refresh");
                $('#tableAdList').bootstrapTable("refresh");
            }
            else {
                showErrorDialog("删除媒体位失败！");
            }
        },
        function (XMLHttpRequest, textStatus, errorThrown) {
            showErrorDialog("删除媒体位失败！");
        }
    );
}

function set_ad_play_time() {
    var selectAds = $('#tableAdList').bootstrapTable('getSelections');

    if(!selectAds || selectAds.length < 1) {
        showErrorDialog("请选择媒体位！");
        return;
    }

    var adPois = [];
    var len = selectAds.length;

    for(var i = 0; i < len; i++) {
        var each = selectAds[i];

        var item = {};
        item.launchPlanId = lunchId;
        item.sspId = each.sspId;

        if(!each.isLinkage) {
            item.launchPlanAdId = each.launchPlanAdId;
            item.positionCode = each.positionCode;
            item.adId = each.adId;
        }

        item.isLinkage = each.isLinkage;
        item.isMultiAdPosition = each.isMultiAdPosition;

        adPois.push(item);
    }

    var dialog = getAddSspDialog();
    dialog.setData("adPois", adPois);
    dialog.open();
}