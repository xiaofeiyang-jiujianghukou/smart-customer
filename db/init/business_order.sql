/*
 Navicat Premium Dump SQL

 Source Server         : mysql-server
 Source Server Type    : MySQL
 Source Server Version : 90300 (9.3.0)
 Source Host           : 127.0.0.1:3306
 Source Schema         : business_order

 Target Server Type    : MySQL
 Target Server Version : 90300 (9.3.0)
 File Encoding         : 65001

 Date: 23/03/2026 20:54:25
*/
CREATE DATABASE IF NOT EXISTS business_order DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_general_ci;
USE business_order;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_order
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单编号',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `total_amount` decimal(12,2) NOT NULL COMMENT '商品总原价',
  `coupon_total_amount` decimal(12,2) DEFAULT '0.00' COMMENT '所有优惠券抵扣总额',
  `pay_amount` decimal(12,2) NOT NULL COMMENT '最终实付金额',
  `status` tinyint DEFAULT '0' COMMENT '0:待支付...',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_sn` (`order_sn`)
) ENGINE=InnoDB AUTO_INCREMENT=5002 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='订单主表';

-- ----------------------------
-- Records of t_order
-- ----------------------------
BEGIN;
INSERT INTO `t_order` (`id`, `order_sn`, `user_id`, `total_amount`, `coupon_total_amount`, `pay_amount`, `status`, `create_time`) VALUES (5001, 'SN20260321888', 888, 9898.00, 550.00, 9348.00, 0, '2026-03-21 13:58:28');
COMMIT;

-- ----------------------------
-- Table structure for t_order_coupon
-- ----------------------------
DROP TABLE IF EXISTS `t_order_coupon`;
CREATE TABLE `t_order_coupon` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint NOT NULL COMMENT '关联 t_order.id',
  `coupon_id` bigint NOT NULL COMMENT '优惠券ID',
  `coupon_type` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '优惠券类型: FULL_REDUCTION, RED_PACKET, etc.',
  `discount_amount` decimal(12,2) NOT NULL COMMENT '该张券抵扣的具体金额',
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='订单优惠券关联表(多对多中间表)';

-- ----------------------------
-- Records of t_order_coupon
-- ----------------------------
BEGIN;
INSERT INTO `t_order_coupon` (`id`, `order_id`, `coupon_id`, `coupon_type`, `discount_amount`) VALUES (1, 5001, 101, 'CATEGORY_REDUCTION', 500.00);
INSERT INTO `t_order_coupon` (`id`, `order_id`, `coupon_id`, `coupon_type`, `discount_amount`) VALUES (2, 5001, 102, 'RED_PACKET', 50.00);
COMMIT;

-- ----------------------------
-- Table structure for t_order_item
-- ----------------------------
DROP TABLE IF EXISTS `t_order_item`;
CREATE TABLE `t_order_item` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint NOT NULL COMMENT '关联 t_order.id',
  `product_id` bigint NOT NULL COMMENT '商品ID',
  `product_name` varchar(128) COLLATE utf8mb4_general_ci NOT NULL COMMENT '下单时商品名快照',
  `price` decimal(12,2) NOT NULL COMMENT '下单时单价',
  `quantity` int NOT NULL COMMENT '购买数量',
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='订单商品详情(多对多中间表)';

-- ----------------------------
-- Records of t_order_item
-- ----------------------------
BEGIN;
INSERT INTO `t_order_item` (`id`, `order_id`, `product_id`, `product_name`, `price`, `quantity`) VALUES (1, 5001, 1, 'iPhone 15 Pro', 7999.00, 1);
INSERT INTO `t_order_item` (`id`, `order_id`, `product_id`, `product_name`, `price`, `quantity`) VALUES (2, 5001, 2, 'AirPods Pro 2', 1899.00, 1);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
