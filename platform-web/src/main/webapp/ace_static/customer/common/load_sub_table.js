var subTableDialog = new BootstrapDialog({
    size: BootstrapDialog.SIZE_WIDE,
    closable: true,
    closeByBackdrop: false,
    closeByKeyboard: false,
    draggable: true,
    cssClass: '',
    buttons: [{
        label: '关闭',
        cssClass: 'btn-xs',
        action: function(dialogRef) {
            dialogRef.close();
        }
    }]
});

var subTableObj = null;

function toLocalDataTablePage(uniqueId, _columns, rows, title, size) {
    uniqueId = uniqueId ? uniqueId : 'id';

    if(size) {
        subTableDialog.setSize(size);
    }

    subTableDialog.setType(BootstrapDialog.TYPE_SUCCESS);
    subTableDialog.realize();
    subTableDialog.setMessage($('<div><table id="subTableDialog" style="border-top: 0px;"></table></div>'));
    subTableDialog.setTitle(title);

    subTableDialog.onShown(function (dialogRef) {
        var subTable = dialogRef.getModalBody().find('#subTableDialog');
        subTableObj =
            subTable.bootstrapTable({
                cache: false,
                uniqueId: uniqueId,
                classes: "table small table-hover",
                data: rows,
                sortable: true,
                columns: _columns
            });
    });

    subTableDialog.open();
}

function toSubTablePage(url, title, _queryParams, _columns, groupId, uniqueId, _param, pageSize, size, showCloumn, height) {
    pageSize = pageSize ? pageSize : 6;
    uniqueId = uniqueId ? uniqueId : 'id';

    if(size) {
        subTableDialog.setSize(size);
    }

    subTableDialog.realize();
    // <!--table-responsive-->
    subTableDialog.setMessage($('<div class=""><table id="subTable" style="background: aliceblue"></table></div>'));
    subTableDialog.setTitle(title);

    subTableDialog.onShown(function (dialogRef) {
        var subTable = dialogRef.getModalBody().find('#subTable');
        subTableObj =
        subTable.bootstrapTable({
            height: height ? height : 400,
            url: url,
            method: 'post',
            queryParams: function (param) {
                if(typeof(_queryParams) != "undefined" && _queryParams) {
                    param = _queryParams(param);
                }
                else {
                    param = param == null ? {} : param;
                }

                param['groupId'] = groupId;
                param['projectId'] = groupId;
                $.extend(param, _param);
                return param;
            },
            dataType : "json",
            contentType : "application/json",
            cache: false,
            classes: "table small",
            showColumns: showCloumn ? showCloumn : false,

            sortable: true,
            sortOrder: "desc",
            sortName: uniqueId,

            pagination: true,
            uniqueId: uniqueId,
            pageList: [6,12],
            pageSize: pageSize,
            pageNumber: 1,
            sidePagination: "server",

            columns: _columns
        });
    });

    subTableDialog.open();
}