function init_datetimepicker(domId, linkDomId, minView, startView, format) {
    minView = minView ? minView : 'month';
    startView = startView ? startView : 'month';
    var format = !format ? 'yyyy-mm-dd' : format;

    $('#' + domId).datetimepicker({
        language :  'zh-CN',
        format: format,
        linkField: linkDomId,
        linkFormat: format,
        autoclose: true,
        weekStart: 1,
        minView: minView,
        startView: startView,
        minuteStep: 5
    });

    $('#' + domId).next().click(function() {
        $('#' + domId).datetimepicker('show');
    });
}

function init_switch(id, state) {
    $("#" + id).bootstrapSwitch({
        state: state,
        //size: 'small',
        onColor: 'success',
        offColor: 'danger',
        onText: '是',
        offText: '否'
    });

    // $("#switchId_" + id).bootstrapSwitch('state', state);
}

function init_tagsinput(id) {
    $('#' + id).tagsinput({
        tagClass: 'label label-primary small',
        maxTags: 5,
        trimValue: true
    });

    // $("input").tagsinput('items')
    // $("input").val()
    // $('input').tagsinput('add', 'some tag');
}

function init_chosen_select(dom) {
    dom.chosen({
        allow_single_deselect: true,
        disable_search: false,
        disable_search_threshold: 10
    });
}

function init_chosen(domId, data) {
    set_chosen_data(domId, data);

    $('#' + domId).chosen({
        allow_single_deselect: true,
        disable_search: false,
        disable_search_threshold: 10
    });
}

function set_chosen_data(domId, data) {
    if(!data) {
        return;
    }

    $('#' + domId).empty();
    var length = data.length;
    var chosen_obj = document.getElementById(domId);

    if(chosen_obj == null) {
        return;
    }

    for(var i = 0; i < length; i++) {
        var item = data[i];

        if(!item) {
            continue;
        }

        chosen_obj.add(new Option(item.name, item.id, false, item.select));
    }

    $('#' + domId).trigger('chosen:updated');
}

function init_select2_data(domId, placeholder, optionData) {
    $('#' + domId).select2({
        language: "zh-CN",
        width: "100%",
        allowClear: false,
        multiple: false,
        placeholder: placeholder,
        minimumResultsForSearch: 10,
        data: optionData
    });
}

function init_select2(domId, url, placeholder, firstOption, changeFun) {
    $('#' + domId).select2({
        language: "zh-CN",
        width: "100%",
        allowClear: true,
        multiple: false,
        placeholder: placeholder,
        ajax: {
            url: url,
            dataType: 'json',
            type: 'POST',
            delay : 250,
            data: function (params) {
                params.limit = 6;
                params.page = params.page || 0;
                params.offset = params.page * params.limit;
                return params;
            },
            processResults: function (data, params) {
                var options = data.rows || [];

                if(options && firstOption && params.page == 0) {
                    options.unshift(firstOption);
                }

                var _more = false;

                if(params.offset) {
                    _more = params.offset < data.pageSize - 1;
                }

                return {
                    results: options,
                    pagination: {
                        more: _more
                    }
                };
            },
            cache: true,
            escapeMarkup: function (markup) {
                return markup;
            }
        }
    }).on('change', function(){
        if(changeFun) {
            changeFun($(this).val());
        }
    });

    // .trigger('change')
}

function init_dataTime_range(domId, minId, maxId, range, first_week_day, last_week_day) {
    var $dom = $('#' + domId);

    if($dom == null || $dom.length != 1) {
        return;
    }

    var first_week_day = first_week_day ? first_week_day : moment();
    var last_week_day = last_week_day ? last_week_day : moment().add(6, 'days');

    $('input[name="' + minId + '"]').val(first_week_day.format('YYYY-MM-DD'));
    $('input[name="' + maxId + '"]').val(last_week_day.format('YYYY-MM-DD'));

    $dom.prev().click(function() {
        $dom.click();
    });

    var _ranges = null;

    if(range) {
        _ranges = {
            '今日': [moment().startOf('day'), moment()],
            '昨日': [moment().subtract(1, 'days').startOf('day'), moment().subtract(1, 'days').endOf('day')],
            '本周': [moment().isoWeekday(1).day(1), moment().isoWeekday(1).day(7)],
            '上周': [moment().isoWeekday(1).subtract(1, 'weeks').day(1), moment().isoWeekday(1).subtract(1, 'weeks').day(7)],
            // '下周': [moment().isoWeekday(1).subtract(-1,"week").day(1),
            // moment().isoWeekday(1).subtract(-1,"week").day(7)],
            '最近7日': [moment().subtract(6, 'days'), moment()],
            '上个月':[moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')],
            '最近30日': [moment().subtract('days', 29), moment()]
        }
    }

    $dom.daterangepicker({
            opens : 'right',
            singleDatePicker : false,
            showWeekNumbers: true,
            startDate : first_week_day,
            endDate: last_week_day,
            // minDate: moment(),
            // maxDate : moment().add(1, 'months').endOf("month"),
            autoUpdateInput: true,
            format: 'YYYY-MM-DD',
            buttonClasses : [ 'btn btn-default' ],
            applyClass : 'btn-small btn-primary blue',
            cancelClass : 'btn-small',
            locale : {
                direction : "ltr",
                applyLabel : '确定',
                cancelLabel : '取消',
                fromLabel : '起始时间',
                toLabel : '结束时间',
                format : 'YYYY-MM-DD',
                separator : ' 到 ',
                customRangeLabel : '自定义',
                daysOfWeek : [ '日', '一', '二', '三', '四', '五', '六' ],
                monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月' ],
                firstDay : 1
            },
            ranges : _ranges
        },
        function(start, end, label) {
            $('input[name="' + minId + '"]').val(moment(start).format('YYYY-MM-DD'));
            $('input[name="' + maxId + '"]').val(moment(end).format('YYYY-MM-DD'));
        });
}

function init_ace_spinner($dom, value, min, max) {
    $dom.ace_spinner({
        value:value,
        min:min,
        max:max,
        step:1,
        on_sides: true,
        icon_up:'ace-icon fa fa-plus bigger-110',
        icon_down:'ace-icon fa fa-minus bigger-110',
        btn_up_class:'btn-success',
        btn_down_class:'btn-danger'
    });
}

function init_file_upload(dom, url, _uploadExtraDataFun, _fileuploaded) {
    dom.fileinput({
        language: 'zh',
        uploadAsync: true,
        showUpload:false,
        showRemove :false,
        showPreview :false,
        showCaption:true,
        allowedFileExtensions: [
            'mp4', 'mpg_4', '3gp', 'avi', 'wmv',
            'mp3', 'mid',
            'gif', 'jpg', 'jpeg', 'png', 'bmp'
        ],

        browseClass:"btn btn-primary btn-xs",
        dropZoneEnabled: false,
        enctype: 'multipart/form-data',
        uploadUrl: url,
        maxFileCount: 1,
        uploadExtraData: _uploadExtraDataFun
    })
    .on("fileuploaded", function (event, data, previewId, index) {
        var jsonData = data.response;

        if(_fileuploaded) {
            _fileuploaded(jsonData);
        }
    })
    .on('filepreajax', function(event, previewId, index) {
        // console.log('filepreajax', event, previewId, index)
        return null;
    })
    .on("fileerror", function (event, data, msg) {
        showErrorDialog(" 上传失败！");
    });
}
