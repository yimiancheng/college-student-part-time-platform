var strVarScene = '';
strVarScene += '<div class="aui_state_box"><div class="aui_state_box_bg"></div>';
strVarScene += '  <div class="aui_alert_zn aui_outer">';
strVarScene += '    <table class="aui_border" style="border:0px solid #fff;">';
strVarScene += '      <tbody>';
strVarScene += '        <tr>';
strVarScene += '          <td class="aui_c">';
strVarScene += '            <div class="aui_inner">';
strVarScene += '              <table class="aui_dialog">';
strVarScene += '                <tbody>';
strVarScene += '                  <tr>';
strVarScene += '                    <td class="aui_header" colspan="2" style="background-color:#0062c8;"><div class="aui_titleBar">';
strVarScene += '                      <div class="aui_title" style="cursor: move;color: #fff;">选择场景</div>';
strVarScene += '                        <a href="javascript:;" class="aui_close" onclick="scene_Close()">×</a>';
strVarScene += '                      </div>';
strVarScene += '                    </td>';
strVarScene += '                  </tr>';
strVarScene += '                  <tr>';
strVarScene += '                  <tr>';
strVarScene += '                    <td class="aui_icon" style="display: none;">';
strVarScene += '                     <div class="aui_iconBg" style="background: transparent none repeat scroll 0% 0%;"></div></td>';
strVarScene += '                       <td class="aui_main" style="width: auto; height: auto;">';
strVarScene += '                        <div class="aui_content" style="padding: 0px; position:relative">';
strVarScene += '                          <div id="" style="width: 720px; position:relative;">';
strVarScene += '                            <div class="data-result"><em>最多选择 <strong>2000</strong> 项</em></div>';
strVarScene += '                            <div class="data-error" style="display: none;">最多只能选择 3 项</div>';
//strVarScene += '                            <div class="data-search" id="searchRun"><input class="run" name="searcharea"/><div class="searchList run"></div></div>';
strVarScene += '                            <div class="data-tabs">';
strVarScene += '                              <ul>';
strVarScene += '                                <li onclick="removenode_scene(this)" data-selector="tab-all" class="active"><a href="javascript:;"><span>全部</span><em></em></a></li>';
strVarScene += '                              </ul>';
strVarScene += '                            </div>';
strVarScene += '                            <div class="data-container data-container-city">';
strVarScene += '                            </div>';
strVarScene += '                          </div>';
strVarScene += '                        </div>';
strVarScene += '                      </div>';
strVarScene += '                    </td>';
strVarScene += '                  </tr>';
strVarScene += '                  <tr>';
strVarScene += '                    <td class="aui_footer" colspan="2">';
strVarScene += '                      <div class="aui_buttons">';
strVarScene += '                      <button class="aui-btn aui-btn-primary" onclick="save_Scene()"' +
                                        ' style="background:#0062c8!important;color:#fff;" type="button">确定</button>';
strVarScene += '                        <button class="aui-btn aui-btn-light" onclick="scene_Close()" type="button">取消</button>';
strVarScene += '                      </div>';
strVarScene += '                    </td>';
strVarScene += '                  </tr>';
strVarScene += '                </tbody>';
strVarScene += '              </table>';
strVarScene += '            </div></td>';
strVarScene += '        </tr>';
strVarScene += '      </tbody>';
strVarScene += '    </table>';
strVarScene += '  </div>';
strVarScene += '</div>';

// 全局变量
var DATA_TYPE_SCENE = "";
var DATA_SCENE_INPUT = null;

$(document).on('click', '#adScene', function () {
    appendScene(this, 'duoxuan');
});

function appendScene(thiscon, Scenexz) {
    DATA_SCENE_INPUT = thiscon;// thiscon;
    DATA_TYPE_SCENE = Scenexz;
    $('body').append(strVarScene);
    if (DATA_TYPE_SCENE == "danxuan") {
        $('.data-result').find('strong').text('1');
    } else {
        $('.data-result').html('<em>可选择多项</em>');
    }
    if ($(DATA_SCENE_INPUT).data("value") != "") {
        var inputarry = $(DATA_SCENE_INPUT).data("value").split('-');
        var inputarryname = $(DATA_SCENE_INPUT).val().split('-');
        if (inputarry.length > 0) {
            for (var i in inputarry) {
                $('.data-result').append('<span class="save_box aui-titlespan" data-code="' + inputarry[i] + '" data-name="' + inputarryname[i] + '" onclick="removespan_scene(this)">' + inputarryname[i] + '<i>×</i></span>');
            }
        }
    }

    var minwid = document.documentElement.clientWidth;
    $('.aui_outer .aui_header').on("mousedown", function (e) {
        /*$(this)[0].onselectstart = function(e) { return false; }*///防止拖动窗口时，会有文字被选中的现象(事实证明不加上这段效果会更好)
        $(this)[0].oncontextmenu = function (e) { return false; } //防止右击弹出菜单
        var getStartX = e.pageX;
        var getStartY = e.pageY;
        var getPositionX = (minwid / 2) - $(this).offset().left,
            getPositionY = 60;
        $(document).on("mousemove", function (e) {
            var getEndX = e.pageX;
            var getEndY = e.pageY;
            $('.aui_outer').css({
                left: getEndX - getStartX - getPositionX,
                top: getEndY - getStartY + getPositionY
            });

        });
        $(document).on("mouseup", function () {
            $(document).unbind("mousemove");
        })
    });
    selectScene('all', null, '');
    //auto_scene.run();
}

function selectScene(type, con, isremove) {
    var dataarrary = SCENE_DATA.id_name_map;
    //显示场景
    var strVarScene = "";
    if (type == "all") {
        var dataScenexz = SCENE_DATA.panel_content.oneLevel;
        strVarScene += '<div class="view-all" id="">';
        /*strVarScene += '   <p class="data-title">场景</p>';*/
        strVarScene += '   <div class="data-list data-list-provinces">';
        strVarScene += '  <ul class="clearfix">';
        for (var i in dataScenexz) {
            strVarScene += '<li><a href="javascript:;" data-code="' + dataScenexz[i] + '" data-name="' + dataarrary[dataScenexz[i]][0] + '" class="d-item"  onclick="selectScene(\'sub\',this,\'\')">' + dataarrary[dataScenexz[i]][0] + '<label>0</label></a></li>';
        }
        strVarScene += ' </ul>';
        strVarScene += '</div>';
        $('.data-container-city').html(strVarScene);

        $('.data-result span').each(function (index) {
            if ($('a[data-code=' + $(this).data("code") + ']').length > 0) {
                $('a[data-code=' + $(this).data("code") + ']').addClass('d-item-active');
                if ($('a[data-code=' + $(this).data("code") + ']').attr("class").indexOf('data-all') > 0) {
                    $('a[data-code=' + $(this).data("code") + ']').parent('li').nextAll('li').find('a').css({ 'color': '#ccc', 'cursor': 'not-allowed' });
                    $('a[data-code=' + $(this).data("code") + ']').parent('li').nextAll("li").find('a').attr("onclick", "");
                } else {
                    if ($('.data-list-provinces a[data-code=' + $(this).data("code").toString().substring(0, 2) + ']').length > 0) {
                        var numlabel = $('.data-list-provinces a[data-code=' + $(this).data("code").toString().substring(0, 2) + ']').find('label').text();
                        $('.data-list-provinces a[data-code=' + $(this).data("code").toString().substring(0, 2) + ']').find('label').text(parseInt(numlabel) + 1).show();
                    }
                }
            } else {
                var numlabel = $('.data-list-provinces a[data-code=' + $(this).data("code").toString().substring(0, 2) + ']').find('label').text();
                $('.data-list-provinces a[data-code=' + $(this).data("code").toString().substring(0, 2) + ']').find('label').text(parseInt(numlabel) + 1).show();
            }
        });
    }
    //显示下一级
    else {
        // var dataScenexz = SCENE_DATA.panel_content.oneLevel;
        var relations  = SCENE_DATA.relations;

        if (typeof (relations[$(con).data("code")]) != "undefined") {
            //添加标题
            if (isremove != "remove") {
                $('.data-tabs li').each(function () {
                    $(this).removeClass('active');
                });
                $('.data-tabs ul').append('<li data-code=' + $(con).data("code") + ' data-name=' + $(con).data("name") + ' class="active" onclick="removenode_scene(this)"><a href="javascript:;"><span>' + $(con).data("name") + '</span><em></em></a></li>');
            }
            //添加内容
            strVarScene += '<ul class="clearfix">';

            if (DATA_TYPE_SCENE == "danxuan") {
                strVarScene += '<li class="li-disabled" style="width:100%" ><a href="javascript:;" class="d-item data-all"  data-code="' + $(con).data("code") + '"  data-name="' + $(con).data("name") + '">' + $(con).data("name") + '<label>0</label></a></li>';
            } else {
                strVarScene += '<li class="" style="width:100%"><a href="javascript:;" class="d-item data-all"  data-code="' + $(con).data("code") + '"  data-name="' + $(con).data("name") + '"  onclick="selectitem_scene(this)">' + $(con).data("name") + '<label>0</label></a></li>';
            }

            for (var i in relations[$(con).data("code")]) {
                strVarScene += '<li><a href="javascript:;" class="d-item" data-code="' + relations[$(con).data("code")][i] + '"  data-name="' + dataarrary[relations[$(con).data("code")][i]][0] + '" onclick="selectScene(\'sub\',this,\'\')">' + dataarrary[relations[$(con).data("code")][i]][0] + '<label>0</label></a></li>';
            }
            strVarScene += '</ul>';
            $('.data-container-city').html(strVarScene);
        } else {
            if (DATA_TYPE_SCENE == "duoxuan") {
                if (typeof $(con).data('flag') != 'undefined') {
                    if($('.data-result span[data-code="' + $(con).data("code") + '"]').length > 0) {
                        return false;
                    }
                }
                if ($(con).attr("class").indexOf('d-item-active') > 0) {
                    $('.data-result span[data-code="' + $(con).data("code") + '"]').remove();
                    $(con).removeClass('d-item-active');
                    // 省份显示场景数量减一,当为0时不显示
                    if ($('.data-list-provinces a[data-code=' + $(con).data("code").toString().substring(0, 2) + ']').length > 0) {
                        var numlabel = $('.data-list-provinces a[data-code=' + $(con).data("code").toString().substring(0, 2) + ']').find('label').text();
                        if (parseInt(numlabel) == 1) {
                            $('.data-list-provinces a[data-code=' + $(con).data("code").toString().substring(0, 2) + ']').find('label').text(0).hide();
                        } else {
                            $('.data-list-provinces a[data-code=' + $(con).data("code").toString().substring(0, 2) + ']').find('label').text(parseInt(numlabel) - 1);
                        }
                    }
                    return false;
                } else {
                    // 已全选场景，不可再选
                    if ($('.data-list-provinces a[data-code=' + $(con).data("code").toString().substring(0, 2) + ']').hasClass('d-item-active')) {
                        $('.data-error').text('已全选场景,不可再选');
                        $('.data-error').slideDown();
                        setTimeout("$('.data-error').text('最多只能选择 3 项').hide()", 1000);
                        return false;
                    }
                }
                if ($('.data-result span').length > 2000) {
                    $('.data-error').slideDown();
                    setTimeout("$('.data-error').hide()", 1000);
                    return false;
                } else {
                    $('.data-result').append('<span class="save_box aui-titlespan" data-code="' + $(con).data("code") + '" data-name="' + $(con).data("name") + '" onclick="removespan_scene(this)">' + $(con).data("name") + '<i>×</i></span>');
                    $(con).addClass('d-item-active');
                }
            } else {
                //单选
                $('.data-result span').remove();
                // 消除搜索影响
                $('.data-list-hot li').siblings('li').find('a').removeClass('d-item-active');
                $('.data-container-city li').siblings('li').find('a').removeClass('d-item-active');

                $('.data-result').append('<span class="save_box aui-titlespan" data-code="' + $(con).data("code") + '" data-name="' + $(con).data("name") + '" onclick="removespan_scene(this)">' + $(con).data("name") + '<i>×</i></span>');
                $(con).parent('li').siblings('li').find('a').removeClass('d-item-active')
                $(con).addClass('d-item-active');

                $('.data-list-provinces a[data-code=' + $(con).data("code").toString().substring(0, 2) + ']').removeClass('d-item-active');
                $('.data-list-provinces a[data-code=' + $(con).data("code").toString().substring(0, 2) + ']').find('label').text(0).hide();
            }
        }
        $('.data-result span').each(function () {
            $('.data-list-provinces a[data-code=' + $(this).data("code").toString().substring(0, 2) + ']').find('label').text(0).hide();
        });
        $('.data-result span').each(function () {
            if ($('a[data-code=' + $(this).data("code") + ']').length > 0) {
                $('a[data-code=' + $(this).data("code") + ']').addClass('d-item-active');
                if ($('a[data-code=' + $(this).data("code") + ']').attr("class").indexOf('data-all') > 0) {
                    if (DATA_TYPE_SCENE == "duoxuan") {
                        $('a[data-code=' + $(this).data("code") + ']').parent('li').nextAll('li').find('a').css({ 'color': '#ccc', 'cursor': 'not-allowed' });
                        $('a[data-code=' + $(this).data("code") + ']').parent('li').nextAll("li").find('a').attr("onclick", "");
                    }
                } else {
                    if (DATA_TYPE_SCENE == "danxuan") {
                        $('.data-list-provinces a').each(function () {
                            $(this).find('label').text(0).hide();
                        });
                    }
                    if ($('.data-list-provinces a[data-code=' + $(this).data("code").toString().substring(0, 2) + ']').length > 0) {
                        var numlabel = $('.data-list-provinces a[data-code=' + $(this).data("code").toString().substring(0, 2) + ']').find('label').text();
                        $('.data-list-provinces a[data-code=' + $(this).data("code").toString().substring(0, 2) + ']').find('label').text(parseInt(numlabel) + 1).show();
                    }
                }
            } else {
                var numlabel = $('.data-list-provinces a[data-code=' + $(this).data("code").toString().substring(0, 2) + ']').find('label').text();
                $('.data-list-provinces a[data-code=' + $(this).data("code").toString().substring(0, 2) + ']').find('label').text(parseInt(numlabel) + 1).show();
            }
        });
    }
}

function selectitem_scene(con) {
    if (DATA_TYPE_SCENE == "duoxuan") {
        //多选
        if ($('.data-result span').length > 2000) {
            $('.data-error').slideDown();
            setTimeout("$('.data-error').hide()", 1000);
            return false;
        } else {
            $('.data-result span').each(function () {
                if ($(this).data("code").toString().substring(0, $(con).data("code").toString().length) == $(con).data("code").toString()) {
                    $(this).remove();
                }
            })
            $(con).parent('li').siblings('li').find("a").removeClass("d-item-active");

            if ($(con).attr("class").indexOf("d-item-active") == -1) {
                $(con).parent('li').nextAll("li").find('a').css({ 'color': '#ccc', 'cursor': 'not-allowed' })
                $(con).parent('li').nextAll("li").find('a').attr("onclick", "");
            } else {
                $(con).parent('li').nextAll("li").find('a').css({ 'color': '#0077b3', 'a.d-item-active:hover': '#fff', 'cursor': 'pointer' })
                $(con).parent('li').nextAll("li").find('a').attr("onclick", 'selectScene("sub",this,"")');
            }
            if ($(con).attr("class").indexOf('d-item-active') > 0) {
                $('.data-result span[data-code="' + $(con).data("code") + '"]').remove();
                $(con).removeClass('d-item-active');
                return false;
            }
            $('.data-result').append('<span class="save_box aui-titlespan" data-code="' + $(con).data("code") + '" data-name="' + $(con).data("name") + '" onclick="removespan_scene(this)">' + $(con).data("name") + '<i>×</i></span>');
            $(con).addClass('d-item-active');
        }
    } else {
        //单选
        $('.data-result span').remove();
        $('.data-result').append('<span class="save_box aui-titlespan" data-code="' + $(con).data("code") + '" data-name="' + $(con).data("name") + '" onclick="removespan_scene(this)">' + $(con).data("name") + '<i>×</i></span>');
        $(con).parent('li').siblings('li').find('a').removeClass('d-item-active')
        $(con).addClass('d-item-active');
    }
}

function removenode_scene(lithis) {
    $(lithis).siblings().removeClass('active');
    $(lithis).addClass('active');
    if ($(lithis).nextAll('li').length == 0) {
        return false;
    }
    $(lithis).nextAll('li').remove();
    if ($(lithis).data("selector") == "tab-all") {
        selectScene('all', null, '');
    } else {
        selectScene('sub', lithis, 'remove');
    }
}

function removespan_scene(spanthis) {
    $('a[data-code=' + $(spanthis).data("code") + ']').removeClass('d-item-active');
    if ($('a[data-code=' + $(spanthis).data("code") + ']').length > 0) {
        if ($('a[data-code=' + $(spanthis).data("code") + ']').attr("class").indexOf('data-all') > 0) {
            $('a[data-code=' + $(spanthis).data("code") + ']').parent('li').nextAll('li').find('a').css({ 'color': '#0077b3', 'a.d-item-active:hover': '#fff', 'cursor': 'pointer' });
            $('a[data-code=' + $(spanthis).data("code") + ']').parent('li').nextAll("li").find('a').attr("onclick", 'selectScene("sub",this,"")');
        }
    }
    if ($('.data-list-provinces a[data-code=' + $(spanthis).data("code").toString().substring(0, 2) + ']').length > 0) {
        var numlabel = $('.data-list-provinces a[data-code=' + $(spanthis).data("code").toString().substring(0, 2) + ']').find('label').text();
        if (parseInt(numlabel) == 1) {
            $('.data-list-provinces a[data-code=' + $(spanthis).data("code").toString().substring(0, 2) + ']').find('label').text(0).hide();
        } else {
            $('.data-list-provinces a[data-code=' + $(spanthis).data("code").toString().substring(0, 2) + ']').find('label').text(parseInt(numlabel) - 1);
        }
    }
    $(spanthis).remove();
}

//确定选择
function save_Scene() {
    var val = '';
    var Scenename = '';
    if ($('.save_box').length > 0) {
        $('.save_box').each(function () {
            val += $(this).data("code") + '-';
            Scenename += $(this).data("name") + '-';
        });
    }
    if (val != '') {
        val = val.substring(0, val.lastIndexOf('-'));
    }
    if (Scenename != '') {
        Scenename = Scenename.substring(0, Scenename.lastIndexOf('-'));
    }

    $(DATA_SCENE_INPUT).data("value", val);
    $(DATA_SCENE_INPUT).val(Scenename);
    scene_Close();
}

function scene_Close() {
    $('.aui_state_box').remove();
}