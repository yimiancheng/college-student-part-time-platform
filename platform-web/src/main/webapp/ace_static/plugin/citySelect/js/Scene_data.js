var SCENE_DATA = {};

jQuery(function($) {
    init_scene_data();
});

function init_scene_data() {
    if(SCENE_LIST.code == 0 && SCENE_LIST.data) {
        // id - name 关系
        var id_name_map = {};
        // 一级列表
        var oneLevel = new Array();
        // 一级 和 二级 关系
        var relations = {};

        // 一级面板内容
        var panel_content = {};

        var oneList = SCENE_LIST.data;

        for (var i in oneList) {
            var one = oneList[i];
            var oneId = one.id.toString();

            id_name_map[oneId] = [one.name];

            var twoLevels = [];
            var twoList = one.viewList;

            if(twoList) {
                for(var j in twoList) {
                    var two = twoList[j];
                    var twoId = two.id.toString();

                    id_name_map[twoId] = [two.name];
                    twoLevels.push(twoId);
                }
            }

            oneLevel.push(oneId);
            relations[oneId] = twoLevels;
        }

        panel_content["oneLevel"] = oneLevel;

        SCENE_DATA["id_name_map"] = id_name_map;
        SCENE_DATA["relations"] = relations;
        SCENE_DATA["panel_content"] = panel_content;
    }
}

var SCENE_LIST = {
    "code" : 0,
    "data" : [
        {
            "id" : 10,
            "name" : "科教文化",
            "viewList" : [
                {
                    "id" : 1001,
                    "name" : "幼儿园"
                },
                {
                    "id" : 1002,
                    "name" : "小学"
                },
                {
                    "id" : 1003,
                    "name" : "初中"
                },
                {
                    "id" : 1004,
                    "name" : "高中"
                },
                {
                    "id" : 1005,
                    "name" : "大学"
                },
                {
                    "id" : 1006,
                    "name" : "大专"
                },
                {
                    "id" : 1007,
                    "name" : "中专"
                },
                {
                    "id" : 1008,
                    "name" : "技校"
                },
                {
                    "id" : 1009,
                    "name" : "培训机构"
                },
                {
                    "id" : 1010,
                    "name" : "科研机构"
                },
                {
                    "id" : 1011,
                    "name" : "留学中介机构"
                },
                {
                    "id" : 1012,
                    "name" : "特殊教育学校"
                },
                {
                    "id" : 1013,
                    "name" : "图书馆"
                },
                {
                    "id" : 1014,
                    "name" : "科技馆"
                },
                {
                    "id" : 1015,
                    "name" : "传媒机构"
                },
                {
                    "id" : 1016,
                    "name" : "文艺团体"
                },
                {
                    "id" : 1017,
                    "name" : "展馆"
                },
                {
                    "id" : 1018,
                    "name" : "驾校"
                },
                {
                    "id" : 1019,
                    "name" : "美术馆"
                }
            ]
        },
        {
            "id" : 11,
            "name" : "交通设施",
            "viewList" : [
                {
                    "id" : 1101,
                    "name" : "出租车"
                },
                {
                    "id" : 1102,
                    "name" : "地铁站"
                },
                {
                    "id" : 1103,
                    "name" : "地铁"
                },
                {
                    "id" : 1104,
                    "name" : "公交车"
                },
                {
                    "id" : 1105,
                    "name" : "公交站"
                },
                {
                    "id" : 1106,
                    "name" : "火车站"
                },
                {
                    "id" : 1107,
                    "name" : "机场"
                },
                {
                    "id" : 1108,
                    "name" : "汽车站"
                },
                {
                    "id" : 1109,
                    "name" : "长途车站"
                },
                {
                    "id" : 1110,
                    "name" : "港口"
                },
                {
                    "id" : 1111,
                    "name" : "停车场"
                },
                {
                    "id" : 1112,
                    "name" : "服务区"
                },
                {
                    "id" : 1113,
                    "name" : "收费站"
                }
            ]
        },
        {
            "id" : 12,
            "name" : "休闲娱乐",
            "viewList" : [
                {
                    "id" : 1201,
                    "name" : "KTV"
                },
                {
                    "id" : 1202,
                    "name" : "电影院"
                },
                {
                    "id" : 1203,
                    "name" : "剧院"
                },
                {
                    "id" : 1204,
                    "name" : "歌舞厅"
                },
                {
                    "id" : 1205,
                    "name" : "网吧"
                },
                {
                    "id" : 1206,
                    "name" : "休闲广场"
                },
                {
                    "id" : 1207,
                    "name" : "会所"
                },
                {
                    "id" : 1208,
                    "name" : "游戏场所"
                },
                {
                    "id" : 1209,
                    "name" : "洗浴按摩"
                },
                {
                    "id" : 1210,
                    "name" : "青少年活动中心"
                },
                {
                    "id" : 1211,
                    "name" : "游艇会"
                },
                {
                    "id" : 1212,
                    "name" : "休闲娱乐场所"
                },
                {
                    "id" : 1213,
                    "name" : "WOW"
                },
                {
                    "id" : 1214,
                    "name" : "酒吧"
                }
            ]
        },
        {
            "id" : 13,
            "name" : "餐饮住宿",
            "viewList" : [
                {
                    "id" : 1301,
                    "name" : "蛋糕甜品店"
                },
                {
                    "id" : 1302,
                    "name" : "茶座"
                },
                {
                    "id" : 1303,
                    "name" : "咖啡厅"
                },
                {
                    "id" : 1304,
                    "name" : "酒店"
                },
                {
                    "id" : 1305,
                    "name" : "餐厅"
                },
                {
                    "id" : 1306,
                    "name" : "食堂"
                },
                {
                    "id" : 1307,
                    "name" : "公寓式酒店"
                },
                {
                    "id" : 1308,
                    "name" : "快捷酒店"
                },
                {
                    "id" : 1309,
                    "name" : "星级酒店"
                },
                {
                    "id" : 1310,
                    "name" : "度假式酒店"
                }
            ]
        },
        {
            "id" : 14,
            "name" : "社区楼宇",
            "viewList" : [
                {
                    "id" : 1401,
                    "name" : "创意园"
                },
                {
                    "id" : 1402,
                    "name" : "农林园艺"
                },
                {
                    "id" : 1403,
                    "name" : "工厂"
                },
                {
                    "id" : 1404,
                    "name" : "园区"
                },
                {
                    "id" : 1405,
                    "name" : "公寓"
                },
                {
                    "id" : 1406,
                    "name" : "商住两用"
                },
                {
                    "id" : 1407,
                    "name" : "写字楼"
                },
                {
                    "id" : 1408,
                    "name" : "政府楼宇"
                },
                {
                    "id" : 1409,
                    "name" : "住宅"
                },
                {
                    "id" : 1410,
                    "name" : "宿舍"
                }
            ]
        },
        {
            "id" : 15,
            "name" : "生活服务",
            "viewList" : [
                {
                    "id" : 1501,
                    "name" : "通讯营业厅"
                },
                {
                    "id" : 1502,
                    "name" : "邮局"
                },
                {
                    "id" : 1503,
                    "name" : "殡仪馆"
                },
                {
                    "id" : 1504,
                    "name" : "宠物服务"
                },
                {
                    "id" : 1505,
                    "name" : "公共厕所"
                },
                {
                    "id" : 1506,
                    "name" : "报刊亭"
                },
                {
                    "id" : 1507,
                    "name" : "维修点"
                },
                {
                    "id" : 1508,
                    "name" : "洗衣店"
                },
                {
                    "id" : 1509,
                    "name" : "图文快印"
                },
                {
                    "id" : 1510,
                    "name" : "照相馆"
                },
                {
                    "id" : 1511,
                    "name" : "物流公司"
                },
                {
                    "id" : 1512,
                    "name" : "售票处"
                },
                {
                    "id" : 1513,
                    "name" : "房产中介"
                },
                {
                    "id" : 1514,
                    "name" : "售楼部"
                },
                {
                    "id" : 1515,
                    "name" : "家政服务"
                },
                {
                    "id" : 1516,
                    "name" : "彩票销售点"
                },
                {
                    "id" : 1517,
                    "name" : "建筑单位"
                },
                {
                    "id" : 1518,
                    "name" : "书店"
                },
                {
                    "id" : 1519,
                    "name" : "敬老院"
                },
                {
                    "id" : 1520,
                    "name" : "电信局"
                },
                {
                    "id" : 1521,
                    "name" : "居委会"
                },
                {
                    "id" : 1522,
                    "name" : "法院"
                },
                {
                    "id" : 1523,
                    "name" : "车管所"
                },
                {
                    "id" : 1524,
                    "name" : "派出所"
                },
                {
                    "id" : 1525,
                    "name" : "政府机构"
                },
                {
                    "id" : 1526,
                    "name" : "政府机关单位"
                },
                {
                    "id" : 1527,
                    "name" : "律师事务所"
                }
            ]
        },
        {
            "id" : 16,
            "name" : "金融保险",
            "viewList" : [
                {
                    "id" : 1601,
                    "name" : "银行"
                },
                {
                    "id" : 1602,
                    "name" : "保险公司"
                },
                {
                    "id" : 1603,
                    "name" : "证券公司"
                },
                {
                    "id" : 1604,
                    "name" : "ATM"
                },
                {
                    "id" : 1605,
                    "name" : "信用社"
                },
                {
                    "id" : 1606,
                    "name" : "典当行"
                },
                {
                    "id" : 1607,
                    "name" : "财务公司"
                }
            ]
        },
        {
            "id" : 17,
            "name" : "购物服务",
            "viewList" : [
                {
                    "id" : 1701,
                    "name" : "家电数码"
                },
                {
                    "id" : 1702,
                    "name" : "家居建材"
                },
                {
                    "id" : 1703,
                    "name" : "商铺"
                },
                {
                    "id" : 1704,
                    "name" : "市场"
                },
                {
                    "id" : 1705,
                    "name" : "商业街"
                },
                {
                    "id" : 1706,
                    "name" : "服装店"
                },
                {
                    "id" : 1707,
                    "name" : "收银台"
                },
                {
                    "id" : 1708,
                    "name" : "手机店"
                },
                {
                    "id" : 1709,
                    "name" : "便利店"
                },
                {
                    "id" : 1710,
                    "name" : "超市"
                },
                {
                    "id" : 1711,
                    "name" : "商场"
                }
            ]
        },
        {
            "id" : 18,
            "name" : "美容健身",
            "viewList" : [
                {
                    "id" : 1801,
                    "name" : "医疗美容"
                },
                {
                    "id" : 1802,
                    "name" : "美容美发"
                },
                {
                    "id" : 1803,
                    "name" : "美甲"
                },
                {
                    "id" : 1804,
                    "name" : "美体"
                },
                {
                    "id" : 1805,
                    "name" : "健身房"
                },
                {
                    "id" : 1806,
                    "name" : "体育馆"
                },
                {
                    "id" : 1807,
                    "name" : "极限运动场所"
                }
            ]
        },
        {
            "id" : 19,
            "name" : "旅游景点",
            "viewList" : [
                {
                    "id" : 1901,
                    "name" : "公园"
                },
                {
                    "id" : 1902,
                    "name" : "动物园"
                },
                {
                    "id" : 1903,
                    "name" : "植物园"
                },
                {
                    "id" : 1904,
                    "name" : "游乐园"
                },
                {
                    "id" : 1905,
                    "name" : "博物馆"
                },
                {
                    "id" : 1906,
                    "name" : "水族馆"
                },
                {
                    "id" : 1907,
                    "name" : "海滨浴场"
                },
                {
                    "id" : 1908,
                    "name" : "文物古迹"
                },
                {
                    "id" : 1909,
                    "name" : "教堂"
                },
                {
                    "id" : 1910,
                    "name" : "风景区"
                },
                {
                    "id" : 1911,
                    "name" : "度假村"
                },
                {
                    "id" : 1912,
                    "name" : "农家院"
                }
            ]
        },
        {
            "id" : 20,
            "name" : "医疗卫生",
            "viewList" : [
                {
                    "id" : 2001,
                    "name" : "医院"
                },
                {
                    "id" : 2002,
                    "name" : "诊所"
                },
                {
                    "id" : 2003,
                    "name" : "医疗保健"
                },
                {
                    "id" : 2004,
                    "name" : "药店"
                },
                {
                    "id" : 2005,
                    "name" : "疗养院"
                },
                {
                    "id" : 2006,
                    "name" : "急救中心"
                },
                {
                    "id" : 2007,
                    "name" : "疾控中心"
                },
                {
                    "id" : 2008,
                    "name" : "动物医疗场所"
                }
            ]
        },
        {
            "id" : 21,
            "name" : "汽车服务",
            "viewList" : [
                {
                    "id" : 2101,
                    "name" : "汽车检测场"
                },
                {
                    "id" : 2102,
                    "name" : "4S店"
                },
                {
                    "id" : 2103,
                    "name" : "汽车租赁"
                },
                {
                    "id" : 2104,
                    "name" : "汽车配件"
                },
                {
                    "id" : 2105,
                    "name" : "汽车美容"
                },
                {
                    "id" : 2106,
                    "name" : "汽车维修"
                },
                {
                    "id" : 2107,
                    "name" : "加油站"
                },
                {
                    "id" : 2108,
                    "name" : "加气站"
                }
            ]
        }
    ]
}