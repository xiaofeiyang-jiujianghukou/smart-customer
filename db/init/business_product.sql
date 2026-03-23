/*
 Navicat Premium Dump SQL

 Source Server         : mysql-server
 Source Server Type    : MySQL
 Source Server Version : 90300 (9.3.0)
 Source Host           : 127.0.0.1:3306
 Source Schema         : business_product

 Target Server Type    : MySQL
 Target Server Version : 90300 (9.3.0)
 File Encoding         : 65001

 Date: 23/03/2026 20:54:57
*/
CREATE DATABASE IF NOT EXISTS business_product DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_general_ci;
USE business_product;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_coupon
-- ----------------------------
DROP TABLE IF EXISTS `t_coupon`;
CREATE TABLE `t_coupon` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '券标题',
  `type` tinyint NOT NULL COMMENT '券类型: 0->全场赠券; 1->会员赠券; 2->购物赠券; 3->注册赠券',
  `min_point` decimal(12,2) NOT NULL COMMENT '使用门槛(满多少可用)',
  `amount` decimal(12,2) NOT NULL COMMENT '抵扣金额',
  `start_time` datetime NOT NULL COMMENT '有效期开始时间',
  `end_time` datetime NOT NULL COMMENT '有效期结束时间',
  `publish_count` int DEFAULT NULL COMMENT '发行数量',
  `use_count` int DEFAULT '0' COMMENT '已使用数量',
  `status` tinyint DEFAULT '1' COMMENT '1:可用, 0:失效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='优惠券规则表';

-- ----------------------------
-- Records of t_coupon
-- ----------------------------
BEGIN;
INSERT INTO `t_coupon` (`id`, `title`, `type`, `min_point`, `amount`, `start_time`, `end_time`, `publish_count`, `use_count`, `status`) VALUES (101, '数码品类满5000减500', 0, 5000.00, 500.00, '2026-01-01 00:00:00', '2026-12-31 23:59:59', NULL, 0, 1);
INSERT INTO `t_coupon` (`id`, `title`, `type`, `min_point`, `amount`, `start_time`, `end_time`, `publish_count`, `use_count`, `status`) VALUES (102, '全场通用红包', 3, 0.00, 50.00, '2026-01-01 00:00:00', '2026-12-31 23:59:59', NULL, 0, 1);
COMMIT;

-- ----------------------------
-- Table structure for t_coupon_history
-- ----------------------------
DROP TABLE IF EXISTS `t_coupon_history`;
CREATE TABLE `t_coupon_history` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `coupon_id` bigint NOT NULL COMMENT '关联 t_coupon.id',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `use_status` tinyint DEFAULT '0' COMMENT '使用状态：0->未使用；1->已使用；2->已过期',
  `order_id` bigint DEFAULT NULL COMMENT '关联使用的订单ID',
  `use_time` datetime DEFAULT NULL COMMENT '使用时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1003 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户领券记录表';

-- ----------------------------
-- Records of t_coupon_history
-- ----------------------------
BEGIN;
INSERT INTO `t_coupon_history` (`id`, `coupon_id`, `user_id`, `use_status`, `order_id`, `use_time`, `create_time`) VALUES (1001, 101, 888, 1, NULL, NULL, '2026-03-21 13:58:12');
INSERT INTO `t_coupon_history` (`id`, `coupon_id`, `user_id`, `use_status`, `order_id`, `use_time`, `create_time`) VALUES (1002, 102, 888, 1, NULL, NULL, '2026-03-21 13:58:12');
COMMIT;

-- ----------------------------
-- Table structure for t_product
-- ----------------------------
DROP TABLE IF EXISTS `t_product`;
CREATE TABLE `t_product` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商品名称',
  `pic` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '主图URL',
  `price` decimal(12,2) NOT NULL COMMENT '当前售价',
  `stock` int NOT NULL DEFAULT '0' COMMENT '库存数量',
  `category_id` bigint DEFAULT NULL COMMENT '类目ID',
  `detail_html` text COLLATE utf8mb4_general_ci COMMENT '商品详情',
  `status` tinyint DEFAULT '1' COMMENT '1:上架, 0:下架',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='商品基础表';

-- ----------------------------
-- Records of t_product
-- ----------------------------
BEGIN;
INSERT INTO `t_product` (`id`, `name`, `pic`, `price`, `stock`, `category_id`, `detail_html`, `status`, `create_time`) VALUES (1, 'iPhone 15 Pro', NULL, 7999.00, 100, NULL, NULL, 1, '2026-03-21 13:58:12');
INSERT INTO `t_product` (`id`, `name`, `pic`, `price`, `stock`, `category_id`, `detail_html`, `status`, `create_time`) VALUES (2, 'AirPods Pro 2', NULL, 1899.00, 50, NULL, NULL, 1, '2026-03-21 13:58:12');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
