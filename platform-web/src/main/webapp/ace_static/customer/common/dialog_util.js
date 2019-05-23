var loadding = new BootstrapDialog({
    title: '提示',
    message: '正在加载，请稍后...',
    size: BootstrapDialog.SIZE_SMALL,
    closable: false,
    cssClass: "text-primary text-center"
});

var dialog = new BootstrapDialog({
    title: '提示'
});

function showLoadingAjax() {
    loadding.realize();
    loadding.getModalHeader().hide();
    loadding.getModalContent().css('background-color', '#fff');
    loadding.getModalContent().css("width", '200px');
    loadding.open();
}

function closeLoadingAjax() {
    loadding.close();
}

function showSuccessDialog(message) {
    dialog.setMessage(message);
    dialog.setClosable(true);
    dialog.setType(BootstrapDialog.TYPE_INFO);
    dialog.open();

    return dialog;
}

function showErrorDialog(message) {
    dialog.setMessage(message);
    dialog.setClosable(true);
    dialog.setType(BootstrapDialog.TYPE_DANGER);
    dialog.open();
}

function senAjax(url, data, successFun, errorFun, showDialog) {
    $.ajax({
        type: "POST",
        dataType: "json",
        url: url,
        data: data,
        traditional: true,
        beforeSend: function (XMLHttpRequest) {
            if(showDialog === undefined || showDialog) {
                showLoadingAjax();
            }
        },
        complete: function (XMLHttpRequest, textStatus) {
            if(showDialog === undefined || showDialog) {
                closeLoadingAjax();
            }
        },
        success: function (jsonData) {
            if(successFun) {
                successFun(jsonData);
            }
            else {
                showSuccessDialog(JSON.stringify(jsonData));
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if(errorFun) {
                errorFun(XMLHttpRequest, textStatus, errorThrown);
            }
            else {
                showErrorDialog("执行失败");
            }
        }
    });
}

var urlDialog = new BootstrapDialog({
    cssClass: 'login-dialog',
    size: BootstrapDialog.SIZE_NORMAL,
    closable: true,
    draggable: true,
    closeByBackdrop: false,
    closeByKeyboard: false
});

function open_Dialog(url, title, type, fun, size) {
    urlDialog.realize();
    urlDialog.setMessage($('<div></div>').load(url));
    urlDialog.setTitle(title);
    urlDialog.setData("href", url);
    size = size ? size : BootstrapDialog.SIZE_NORMAL;
    urlDialog.setSize(size);

    if(typeof(fun) != "undefined" && fun) {
        var buttons = [{
            label: '提交',
            cssClass: 'btn btn-success',
            action: function(dialog){
                if(fun) {
                    fun(dialog);
                }
            }
        }];
        urlDialog.setButtons(buttons);
    }
    else {
        urlDialog.setButtons([]);
    }

    if(type) {
        urlDialog.setType(type);
    }
    else {
        urlDialog.setType(BootstrapDialog.TYPE_INFO);
    }

    urlDialog.open();

    return urlDialog;
}