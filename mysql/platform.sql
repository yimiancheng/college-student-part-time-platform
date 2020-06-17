/*
Navicat MySQL Data Transfer

Source Server         : localhost-mysql(root)
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : platform

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2019-05-14 18:03:43
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sys_order
-- ----------------------------
DROP TABLE IF EXISTS `sys_order`;
CREATE TABLE `sys_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `sku_user_id` int(11) DEFAULT NULL COMMENT '卖家用户ID',
  `sku_id` int(11) DEFAULT NULL COMMENT '商品编号',
  `sku_price` double(10,2) NOT NULL COMMENT '商品购买价格',
  `sku_num` int(11) NOT NULL COMMENT '商品购买数量',
  `order_price` double(5,2) NOT NULL COMMENT '订单价格 订单价格',
  `buy_user_id` int(11) DEFAULT NULL COMMENT '购买人用户ID',
  `order_content` text COMMENT '订单备注',
  `create_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期 默认为当前时间',
  `update_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新日期 默认为当前时间',
  PRIMARY KEY (`id`),
  KEY `FK_sys_order_sku_id` (`sku_id`),
  KEY `FK_sys_order_buy_user_id` (`buy_user_id`),
  KEY `FK_sys_order_sku_user_id` (`sku_user_id`),
  CONSTRAINT `FK_sys_order_buy_user_id` FOREIGN KEY (`buy_user_id`) REFERENCES `sys_user` (`Id`),
  CONSTRAINT `FK_sys_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `sys_product` (`id`),
  CONSTRAINT `FK_sys_order_sku_user_id` FOREIGN KEY (`sku_user_id`) REFERENCES `sys_user` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='订单表';

-- ----------------------------
-- Records of sys_order
-- ----------------------------
INSERT INTO `sys_order` VALUES ('2', '1', '5', '100.54', '2', '201.08', '1', '宿舍交易', '2019-05-14 15:00:42', '2019-05-14 15:00:42');
INSERT INTO `sys_order` VALUES ('3', '1', '5', '100.54', '1', '100.54', '1', '宿舍交易', '2019-05-14 15:06:32', '2019-05-14 15:06:32');
INSERT INTO `sys_order` VALUES ('4', '1', '5', '100.54', '1', '100.54', '1', '', '2019-05-14 15:19:20', '2019-05-14 15:19:20');
INSERT INTO `sys_order` VALUES ('5', '1', '5', '100.54', '1', '100.54', '1', '', '2019-05-14 15:20:14', '2019-05-14 15:20:14');
INSERT INTO `sys_order` VALUES ('6', '1', '5', '100.54', '1', '100.54', '1', '', '2019-05-14 15:25:47', '2019-05-14 15:25:47');
INSERT INTO `sys_order` VALUES ('7', '1', '5', '100.54', '1', '100.54', '1', '', '2019-05-14 15:31:19', '2019-05-14 15:31:19');
INSERT INTO `sys_order` VALUES ('8', '1', '5', '100.54', '1', '100.54', '1', '', '2019-05-14 15:34:16', '2019-05-14 15:34:16');
INSERT INTO `sys_order` VALUES ('9', '1', '5', '100.54', '1', '100.54', '1', '', '2019-05-14 15:34:33', '2019-05-14 15:34:33');
INSERT INTO `sys_order` VALUES ('10', '1', '5', '100.54', '1', '100.54', '1', '', '2019-05-14 15:38:29', '2019-05-14 15:38:29');
INSERT INTO `sys_order` VALUES ('11', '1', '5', '100.54', '1', '100.54', '1', '', '2019-05-14 15:38:48', '2019-05-14 15:38:48');
INSERT INTO `sys_order` VALUES ('12', '1', '5', '100.54', '1', '100.54', '1', '', '2019-05-14 15:43:02', '2019-05-14 15:43:02');
INSERT INTO `sys_order` VALUES ('13', '1', '5', '100.54', '1', '100.54', '1', '', '2019-05-14 15:47:17', '2019-05-14 15:47:17');
INSERT INTO `sys_order` VALUES ('14', '1', '5', '100.54', '1', '100.54', '1', '', '2019-05-14 15:49:27', '2019-05-14 15:49:27');
INSERT INTO `sys_order` VALUES ('15', '1', '5', '100.54', '1', '100.54', '1', '', '2019-05-14 15:50:34', '2019-05-14 15:50:34');
INSERT INTO `sys_order` VALUES ('16', '1', '5', '100.54', '1', '100.54', '1', '', '2019-05-14 15:57:28', '2019-05-14 15:57:28');
INSERT INTO `sys_order` VALUES ('17', '1', '5', '100.54', '1', '100.54', '1', '', '2019-05-14 16:04:52', '2019-05-14 16:04:52');
INSERT INTO `sys_order` VALUES ('18', '1', '5', '100.54', '1', '100.54', '1', '', '2019-05-14 16:17:50', '2019-05-14 16:17:50');
INSERT INTO `sys_order` VALUES ('19', '1', '5', '100.54', '1', '100.54', '1', '', '2019-05-14 16:27:23', '2019-05-14 16:27:23');
INSERT INTO `sys_order` VALUES ('20', '1', '5', '100.54', '1', '100.54', '1', '', '2019-05-14 16:34:14', '2019-05-14 16:34:14');
INSERT INTO `sys_order` VALUES ('21', '1', '5', '100.54', '1', '100.54', '1', '', '2019-05-14 16:41:49', '2019-05-14 16:41:49');
INSERT INTO `sys_order` VALUES ('22', '1', '5', '400.54', '1', '400.54', '1', '', '2019-05-14 17:59:58', '2019-05-14 17:59:58');

-- ----------------------------
-- Table structure for sys_order_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_order_log`;
CREATE TABLE `sys_order_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `order_id` int(11) DEFAULT NULL COMMENT '订单号',
  `order_status_old` varchar(255) DEFAULT NULL COMMENT '订单变更前状态',
  `order_status` varchar(4000) DEFAULT NULL COMMENT '订单状态',
  `creator_id` int(11) NOT NULL COMMENT '操作人ID 当前用户ID',
  `creator_name` varchar(4000) DEFAULT NULL COMMENT '操作人姓名',
  `create_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期 默认为当前时间',
  PRIMARY KEY (`id`),
  KEY `IDX_sys_ordlog_creator_idE96A` (`creator_id`),
  KEY `FK_sys_ordlog_order_idB15D` (`order_id`),
  CONSTRAINT `FK_sys_ordlog_creator_idE96A` FOREIGN KEY (`creator_id`) REFERENCES `sys_user` (`Id`),
  CONSTRAINT `FK_sys_ordlog_order_idB15D` FOREIGN KEY (`order_id`) REFERENCES `sys_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='订单状态日志表';

-- ----------------------------
-- Records of sys_order_log
-- ----------------------------
INSERT INTO `sys_order_log` VALUES ('2', '2', null, '订单创建', '1', null, '2019-05-14 15:00:42');
INSERT INTO `sys_order_log` VALUES ('3', '3', null, '订单创建', '1', null, '2019-05-14 15:06:32');
INSERT INTO `sys_order_log` VALUES ('4', '4', null, '订单创建', '1', null, '2019-05-14 15:19:20');
INSERT INTO `sys_order_log` VALUES ('5', '5', null, '订单创建', '1', null, '2019-05-14 15:20:14');
INSERT INTO `sys_order_log` VALUES ('6', '6', null, '订单创建', '1', null, '2019-05-14 15:25:47');
INSERT INTO `sys_order_log` VALUES ('7', '7', null, '订单创建', '1', null, '2019-05-14 15:31:19');
INSERT INTO `sys_order_log` VALUES ('8', '8', null, '订单创建', '1', null, '2019-05-14 15:34:16');
INSERT INTO `sys_order_log` VALUES ('9', '9', null, '订单创建', '1', null, '2019-05-14 15:34:33');
INSERT INTO `sys_order_log` VALUES ('10', '10', null, '订单创建', '1', null, '2019-05-14 15:38:29');
INSERT INTO `sys_order_log` VALUES ('11', '11', null, '订单创建', '1', null, '2019-05-14 15:38:49');
INSERT INTO `sys_order_log` VALUES ('12', '12', null, '订单创建', '1', null, '2019-05-14 15:43:02');
INSERT INTO `sys_order_log` VALUES ('13', '13', null, '订单创建', '1', null, '2019-05-14 15:47:17');
INSERT INTO `sys_order_log` VALUES ('14', '14', null, '订单创建', '1', null, '2019-05-14 15:49:27');
INSERT INTO `sys_order_log` VALUES ('15', '15', null, '订单创建', '1', null, '2019-05-14 15:50:34');
INSERT INTO `sys_order_log` VALUES ('16', '16', null, '订单创建', '1', null, '2019-05-14 15:57:28');
INSERT INTO `sys_order_log` VALUES ('17', '17', null, '订单创建', '1', null, '2019-05-14 16:04:52');
INSERT INTO `sys_order_log` VALUES ('18', '18', null, '订单创建', '1', null, '2019-05-14 16:17:50');
INSERT INTO `sys_order_log` VALUES ('19', '19', null, '订单创建', '1', null, '2019-05-14 16:27:23');
INSERT INTO `sys_order_log` VALUES ('20', '20', null, '订单创建', '1', null, '2019-05-14 16:34:14');
INSERT INTO `sys_order_log` VALUES ('21', '21', null, '订单创建', '1', null, '2019-05-14 16:41:49');
INSERT INTO `sys_order_log` VALUES ('22', '22', null, '订单创建', '1', null, '2019-05-14 17:59:58');

-- ----------------------------
-- Table structure for sys_product
-- ----------------------------
DROP TABLE IF EXISTS `sys_product`;
CREATE TABLE `sys_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `sku_type_id` int(11) DEFAULT NULL COMMENT '商品类型ID',
  `sku_name` varchar(255) NOT NULL COMMENT '商品名称',
  `sku_img` varchar(255) DEFAULT NULL COMMENT '商品图片',
  `trade_position` varchar(255) DEFAULT NULL COMMENT '交易地点 食堂 宿舍',
  `price` double(10,2) NOT NULL COMMENT '价格 当前用户ID',
  `CreatorName` varchar(4000) DEFAULT NULL COMMENT '创建人姓名',
  `sku_attr` int(1) DEFAULT '8' COMMENT '商品成色',
  `sku_status` varchar(255) DEFAULT NULL COMMENT '商品状态 0发布 1下架 2售空',
  `daofou` bit(1) DEFAULT b'0' COMMENT '是否可刀 0不可以 1可以',
  `sku_content` text COMMENT '商品描述',
  `buy_date` datetime DEFAULT NULL COMMENT '售卖开始日期',
  `create_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期 默认为当前时间',
  `update_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新日期',
  PRIMARY KEY (`id`),
  KEY `FK_sys_product_user_id` (`user_id`),
  KEY `FK_sys_prouct_sku_typ_id516D` (`sku_type_id`),
  CONSTRAINT `FK_sys_product_user_id` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`Id`),
  CONSTRAINT `FK_sys_prouct_sku_typ_id516D` FOREIGN KEY (`sku_type_id`) REFERENCES `sys_product_typs` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='商品表';

-- ----------------------------
-- Records of sys_product
-- ----------------------------
INSERT INTO `sys_product` VALUES ('1', '2', '3', '测试商品1', '', '图书馆', '100.00', 'chengshaohua1', '8', '发布', '\0', '', '2019-05-21 22:10:10', '2019-05-12 16:18:23', '2019-05-12 18:23:18');
INSERT INTO `sys_product` VALUES ('3', '1', '3', '华为 HUAWEI P20 Pro 全面屏徕卡三摄游戏手机', 'https://img14.360buyimg.com/n0/jfs/t19510/195/1236218111/148413/135b5703/5ac1eba8N88880b03.jpg', '宿舍', '1000.50', 'admin', '2', '发布', '', '6GB+128GB 亮黑色 全网通移动联通电信4G手机 双卡双待', '2019-05-30 00:00:00', '2019-05-12 16:28:35', '2019-05-12 16:28:35');
INSERT INTO `sys_product` VALUES ('4', '1', '2', '励志成功经典口才心理学书籍大全集8册', 'https://img10.360buyimg.com/n1/jfs/t1/36316/39/707/187107/5cac52b6E0319e170/ebc40bbcf4e1f27b.jpg', '学校都可', '100.00', 'admin', '6', '下架', '', '墨菲定律情商高就是会说话人际交往心理学不会说话你就输了九型人格', '2019-05-10 11:50:00', '2019-05-13 11:12:02', '2019-05-14 17:55:15');
INSERT INTO `sys_product` VALUES ('5', '1', '2', '一看就停不下来的中国史', 'https://img10.360buyimg.com/n1/jfs/t1/3188/6/5712/618881/5ba0b625E6a0d6535/8d695a662e7732a8.jpg', '篮球场', '400.54', 'admin', '1', '发布', '', '◆两位主创均为《南方都市报》原高级记者，以类似新闻深度报道式的写作思路，搭配铿锵有劲儿的语言风格，创作令人大呼过瘾、拍案称快的历史佳作；\n\n◆有理有据，不瞎八卦。虽然是通俗史，但各篇文章史实出处有据可查，全书共引用了116条参考文献，以认真的态度写有个性的文章；\n\n◆热文精选，畅快阅读。从300多篇文章中，筛选52篇成书，并以“读史即是读人心”为主题，梳理全书结构，给读者提供清晰明了的阅读体验；\n\n◆雾满拦江作序推荐，南京大学历史学院教授马俊亚、百万畅销书《大逃港》作者陈秉安、中山大学哲学系教授龚隽联袂推荐。', '2019-05-07 11:50:00', '2019-05-13 11:13:47', '2019-05-14 17:59:52');

-- ----------------------------
-- Table structure for sys_product_like
-- ----------------------------
DROP TABLE IF EXISTS `sys_product_like`;
CREATE TABLE `sys_product_like` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `sku_id` int(11) DEFAULT NULL COMMENT '商品ID',
  `sku_name` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `sku_status` varchar(255) DEFAULT '' COMMENT '收藏记录状态 无效 有效',
  `create_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期 默认为当前时间',
  `update_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新日期 默认为当前时间',
  PRIMARY KEY (`id`),
  KEY `FK_sys_proike_user_id5BEF` (`user_id`),
  CONSTRAINT `FK_sys_proike_user_id5BEF` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='商品收藏';

-- ----------------------------
-- Records of sys_product_like
-- ----------------------------
INSERT INTO `sys_product_like` VALUES ('1', '5', '一看就停不下来的中国史', '1', '收藏', '2019-05-13 17:44:42', '2019-05-13 18:35:34');
INSERT INTO `sys_product_like` VALUES ('2', '5', '一看就停不下来的中国史', '1', '删除', '2019-05-14 17:18:42', '2019-05-14 17:57:41');

-- ----------------------------
-- Table structure for sys_product_typs
-- ----------------------------
DROP TABLE IF EXISTS `sys_product_typs`;
CREATE TABLE `sys_product_typs` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `type_name` varchar(10) NOT NULL COMMENT '名称',
  `creator_user_id` int(11) DEFAULT NULL COMMENT '创建人编号 当前用户ID',
  `order_no` int(11) DEFAULT '0' COMMENT '排序号 order_no越小越靠前',
  `create_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期 默认为当前时间',
  `update_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新日期 默认为当前时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='商品类型表';

-- ----------------------------
-- Records of sys_product_typs
-- ----------------------------
INSERT INTO `sys_product_typs` VALUES ('2', '电脑', null, '10', '2019-05-12 09:21:40', '2019-05-12 10:14:15');
INSERT INTO `sys_product_typs` VALUES ('3', '数码', null, '20', '2019-05-12 09:23:18', '2019-05-12 10:14:26');
INSERT INTO `sys_product_typs` VALUES ('4', '衣鞋伞帽', null, '3', '2019-05-12 09:34:15', '2019-05-12 10:14:35');
INSERT INTO `sys_product_typs` VALUES ('6', '书籍教材', null, '100', '2019-05-12 10:13:46', '2019-05-12 10:16:19');
INSERT INTO `sys_product_typs` VALUES ('7', '体育健身', null, '0', '2019-05-12 10:13:57', '2019-05-12 10:13:57');
INSERT INTO `sys_product_typs` VALUES ('8', '乐器', null, '300', '2019-05-12 10:14:03', '2019-05-12 16:20:46');

-- ----------------------------
-- Table structure for sys_stock
-- ----------------------------
DROP TABLE IF EXISTS `sys_stock`;
CREATE TABLE `sys_stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `sku_id` int(11) DEFAULT NULL COMMENT '商品ID',
  `num` int(11) DEFAULT NULL COMMENT '库存数量 商品发布时设置库存数量',
  `num_stock` int(11) DEFAULT NULL COMMENT '已售商品数量',
  `create_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期 默认为当前时间',
  `update_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新日期 默认为当前时间',
  PRIMARY KEY (`id`),
  KEY `FK_sys_stock_sku_id` (`sku_id`),
  CONSTRAINT `FK_sys_stock_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `sys_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='库存表';

-- ----------------------------
-- Records of sys_stock
-- ----------------------------
INSERT INTO `sys_stock` VALUES ('1', '1', '1', null, '2019-05-12 16:18:23', '2019-05-12 16:18:23');
INSERT INTO `sys_stock` VALUES ('2', '3', '3', null, '2019-05-12 16:28:35', '2019-05-12 16:28:35');
INSERT INTO `sys_stock` VALUES ('3', '4', '1', null, '2019-05-13 11:12:02', '2019-05-13 11:12:02');
INSERT INTO `sys_stock` VALUES ('4', '5', '30', '22', '2019-05-13 11:13:47', '2019-05-14 17:59:58');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Usernick` varchar(255) DEFAULT NULL COMMENT '昵称',
  `UserName` varchar(255) DEFAULT NULL COMMENT '登录账号',
  `PassWord` varchar(255) DEFAULT NULL COMMENT '密码',
  `UserRole` varchar(255) DEFAULT NULL COMMENT '角色',
  `UserState` varchar(255) DEFAULT NULL COMMENT '状态',
  `wxid` varchar(100) DEFAULT NULL COMMENT '微信号',
  `phone` varchar(11) DEFAULT NULL COMMENT '手机号',
  `user_img` varchar(255) DEFAULT NULL COMMENT '用户头像',
  `user_content` text COMMENT '用户签名',
  `updateTime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `createTime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', '管理员', 'admin', '72255c614de9471b379a477ec5062d1e', '系统管理员', '正常', 'wxid', '18688888888', null, '个性签名', '2019-05-12 16:28:25', '2019-05-12 16:28:25');
INSERT INTO `sys_user` VALUES ('2', '华子', '*', '*', '学生', '正常', 'wxid', '18688888888', 'https://www.youzixy.com/Public/images/icon/pleaselogin.png', 'go go', '2019-05-12 16:40:56', '2019-05-12 16:40:56');
