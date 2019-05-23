<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${ctx}/static/assets/css/bootstrap.min.css" />
    <script src="${ctx}/static/assets/js/jquery-2.0.3.min.js"></script>
    <script src="${ctx}/static/assets/js/bootstrap.min.js"></script>
    <script src="${ctx}/static/formatJson/formatJson.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            function exe() {
                var content = $('#commandArea').val();
                if (content == null || content == '' || content.length === 0) {
                    return;
                }
                $.ajax({
                    type: 'POST',
                    url: '${ctx}/command/executor',
                    data: {'content': content},
                    dataType: "JSON",
                    success: function (data) {
                        if (data.success == false) {
                            alert(data.resultMessage);
                        } else {
                            var str = JSON.stringify(data.result, null, "\t");
                            if (str == '[]') {
                                $('#result').html("ok");
                            }
                            $('#result').html(formatJson(str));
                            alert("执行成功！");
                        }
                    },
                    error: function (data) {
                        alert(JSON.stringify(data));
                    }
                });
            }


            $('#commandArea').keypress(function (e) {
                if (e.ctrlKey && e.keyCode == 10) {
                    exe();
                }
            });
            $('#act').click(function () {
                var idata = $('#result').html();
                if(idata == null || idata == ''){
                    idata = 0;
                }
                $.ajax({
                    type: 'GET',
                    url: '${ctx}/command/setData',
                    data: {'data': idata},
                    success: function (data) {

                    },
                    error: function (data) {
                        alert(JSON.stringify(data));
                    }
                });
            });



            function getData(){
                var idata = $('#result').html();
                if(idata == null || idata == ''){
                    idata = 0;
                }
                $.ajax({
                    type: 'POST',
                    data: {'data': idata},
                    url: '${ctx}/command/getData',
                    success: function (data) {
                        $('#result').html(JSON.stringify(data));
                        getData();
                    },
                    error: function (data) {
                        alert(data);
                    }
                });
            }
            // getData();
            $('#executor').click(function () {
                exe();
            });
        })
    </script>
</head>
<body>
<div class="container" style="text-align: center">
    <br>
    <textarea id="commandArea" class="form-control"></textarea>
    <br>
    <button id="executor" class="btn btn-warning">执行</button>
    <%--<button id="act" class="btn btn-warning">act</button>--%>
    <br>
    <div id="result" style="text-align: left"></div>
</div>

</body>
</html>
