/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80045 (8.0.45)
 Source Host           : localhost:3306
 Source Schema         : community_waste_db

 Target Server Type    : MySQL
 Target Server Version : 80045 (8.0.45)
 File Encoding         : 65001

 Date: 03/06/2026 10:23:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for activities_activity
-- ----------------------------
DROP TABLE IF EXISTS `activities_activity`;
CREATE TABLE `activities_activity`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` datetime(6) NOT NULL,
  `end_date` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `reward_points` int NOT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of activities_activity
-- ----------------------------
INSERT INTO `activities_activity` VALUES (1, '地球日', '社区广场举办环保知识讲座和互动游戏，参与即可获得积分奖励', '2026-03-08 20:24:20.237289', '2026-03-15 20:24:20.237289', 0, '2026-05-19 08:29:24.878179', 50, '世界地球日宣传活动');
INSERT INTO `activities_activity` VALUES (2, '分类比赛', '居民分组进行垃圾分类速度和准确率比拼，优胜者获得丰厚奖品', '2026-03-23 20:24:20.237289', '2026-03-30 20:24:20.237289', 0, '2026-05-19 08:29:24.881132', 100, '垃圾分类达人赛');
INSERT INTO `activities_activity` VALUES (3, '绿色家庭', '评选社区内践行环保理念的优秀家庭，颁发荣誉证书和奖品', '2026-04-12 20:24:20.237289', '2026-05-03 20:24:20.237289', 1, '2026-05-19 08:29:24.884053', 200, '绿色家庭评选活动');
INSERT INTO `activities_activity` VALUES (4, '公益活动', '收集家中闲置衣物进行统一回收处理，按重量获得积分', '2026-05-07 20:24:20.237289', '2026-05-21 20:24:20.237289', 1, '2026-05-19 08:29:24.887026', 80, '旧衣回收公益行');
INSERT INTO `activities_activity` VALUES (5, '手工制作', '用废旧物品制作实用工艺品，培养环保意识', '2026-05-27 20:24:20.237289', '2026-05-28 20:24:20.237289', 1, '2026-05-19 08:29:24.889460', 60, '环保手工DIY workshop');
INSERT INTO `activities_activity` VALUES (6, '志愿服务', '组织志愿者对社区公共区域进行深度清洁', '2026-06-06 20:24:20.237289', '2026-06-07 20:24:20.237289', 1, '2026-05-19 08:29:24.891631', 40, '社区清洁志愿行动');
INSERT INTO `activities_activity` VALUES (7, '绘画比赛', '面向社区儿童的环保主题绘画征集活动', '2026-06-21 20:24:20.237289', '2026-07-11 20:24:20.237289', 1, '2026-05-19 08:29:24.893928', 100, '儿童环保绘画比赛');
INSERT INTO `activities_activity` VALUES (8, '培训课程', '学习如何将厨余垃圾转化为有机肥料', '2026-07-16 20:24:20.237289', '2026-07-17 20:24:20.237289', 1, '2026-05-19 08:29:24.896146', 30, '厨余堆肥体验课');
INSERT INTO `activities_activity` VALUES (9, NULL, '庆祝世界环境日，提高居民环保意识。活动地点：社区广场', '2026-05-29 16:36:13.879916', '2026-05-30 16:36:13.879942', 1, '2026-05-19 08:36:13.884941', 200, '世界环境日宣传活动');
INSERT INTO `activities_activity` VALUES (10, NULL, '测试你的垃圾分类知识，赢取丰厚奖品。活动地点：社区活动中心', '2026-06-03 16:36:13.879944', '2026-06-04 16:36:13.879946', 1, '2026-05-19 08:36:13.889923', 500, '垃圾分类知识竞赛');
INSERT INTO `activities_activity` VALUES (11, NULL, '家长和孩子一起制作环保手工艺品。活动地点：社区儿童活动室', '2026-06-08 16:36:13.879947', '2026-06-09 16:36:13.879948', 1, '2026-05-19 08:36:13.893329', 300, '亲子环保手工坊');
INSERT INTO `activities_activity` VALUES (12, NULL, '一起清理社区卫生死角，共建美好家园。活动地点：整个社区', '2026-05-24 16:36:13.879950', '2026-05-24 16:36:13.879951', 1, '2026-05-19 08:36:13.897049', 150, '社区清洁日活动');

-- ----------------------------
-- Table structure for activities_activityparticipant
-- ----------------------------
DROP TABLE IF EXISTS `activities_activityparticipant`;
CREATE TABLE `activities_activityparticipant`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `points_earned` int NOT NULL,
  `is_completed` tinyint(1) NOT NULL,
  `joined_at` datetime(6) NOT NULL,
  `activity_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `activities_activityp_activity_id_80051bf7_fk_activitie`(`activity_id` ASC) USING BTREE,
  INDEX `activities_activityparticipant_user_id_3e428f74_fk_users_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `activities_activityp_activity_id_80051bf7_fk_activitie` FOREIGN KEY (`activity_id`) REFERENCES `activities_activity` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `activities_activityparticipant_user_id_3e428f74_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of activities_activityparticipant
-- ----------------------------
INSERT INTO `activities_activityparticipant` VALUES (1, 23, 1, '2026-05-19 08:29:25.539811', 1, 1);
INSERT INTO `activities_activityparticipant` VALUES (2, 16, 1, '2026-05-19 08:29:25.542852', 1, 5);
INSERT INTO `activities_activityparticipant` VALUES (4, 32, 1, '2026-05-19 08:29:25.546466', 1, 3);
INSERT INTO `activities_activityparticipant` VALUES (5, 29, 1, '2026-05-19 08:29:25.549064', 1, 4);
INSERT INTO `activities_activityparticipant` VALUES (6, 43, 1, '2026-05-19 08:29:25.551365', 2, 1);
INSERT INTO `activities_activityparticipant` VALUES (8, 38, 1, '2026-05-19 08:29:25.554995', 2, 3);
INSERT INTO `activities_activityparticipant` VALUES (9, 38, 1, '2026-05-19 08:29:25.557281', 2, 4);
INSERT INTO `activities_activityparticipant` VALUES (10, 38, 1, '2026-05-19 08:29:25.559016', 2, 5);
INSERT INTO `activities_activityparticipant` VALUES (11, 0, 0, '2026-05-19 08:29:25.560810', 3, 3);
INSERT INTO `activities_activityparticipant` VALUES (12, 0, 0, '2026-05-19 08:29:25.562790', 3, 5);
INSERT INTO `activities_activityparticipant` VALUES (13, 0, 0, '2026-05-19 08:29:25.564965', 3, 1);
INSERT INTO `activities_activityparticipant` VALUES (14, 0, 0, '2026-05-19 08:29:25.566686', 3, 4);
INSERT INTO `activities_activityparticipant` VALUES (16, 0, 0, '2026-05-19 08:29:25.570630', 4, 1);
INSERT INTO `activities_activityparticipant` VALUES (17, 0, 0, '2026-05-19 08:29:25.572634', 4, 4);
INSERT INTO `activities_activityparticipant` VALUES (18, 0, 0, '2026-05-19 08:29:25.574363', 4, 3);
INSERT INTO `activities_activityparticipant` VALUES (20, 0, 0, '2026-05-19 08:29:25.577351', 4, 5);
INSERT INTO `activities_activityparticipant` VALUES (21, 0, 0, '2026-05-19 08:29:25.579715', 5, 5);
INSERT INTO `activities_activityparticipant` VALUES (22, 0, 0, '2026-05-19 08:29:25.581630', 5, 4);
INSERT INTO `activities_activityparticipant` VALUES (23, 0, 0, '2026-05-19 08:29:25.583357', 5, 1);
INSERT INTO `activities_activityparticipant` VALUES (24, 0, 0, '2026-05-19 08:29:25.585239', 5, 3);

-- ----------------------------
-- Table structure for activities_notification
-- ----------------------------
DROP TABLE IF EXISTS `activities_notification`;
CREATE TABLE `activities_notification`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  `notification_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `activities_notification_user_id_291c1ed9_fk_users_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `activities_notification_user_id_291c1ed9_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of activities_notification
-- ----------------------------
INSERT INTO `activities_notification` VALUES (4, '月度环保之星评选结果', '恭喜您被评为本月环保之星，额外获得200积分奖励！', 1, '', '2026-05-19 08:29:25.961055', 3, 'system');
INSERT INTO `activities_notification` VALUES (5, '节日祝福', '值此佳节之际，祝您和家人身体健康，万事如意！', 0, '', '2026-05-19 08:29:25.963281', 3, 'system');
INSERT INTO `activities_notification` VALUES (6, '订单状态更新', '您兑换的商品已准备就绪，请前往物业处领取。', 1, '', '2026-05-19 08:29:25.965428', 3, 'order');
INSERT INTO `activities_notification` VALUES (7, '您的积分到账通知', '您最近的垃圾分类投放获得了新的积分奖励，快去查看吧！', 1, '', '2026-05-19 08:29:25.967188', 3, 'system');
INSERT INTO `activities_notification` VALUES (8, '积分商城新品上架', '积分商城新增了多款环保商品，快来选购吧！', 1, '', '2026-05-19 08:29:25.969881', 3, 'product');
INSERT INTO `activities_notification` VALUES (9, '系统公告：垃圾分类新规上线', '亲爱的居民，新的垃圾分类管理规定将于下周起正式实施，请大家认真学习。', 1, '', '2026-05-19 08:29:25.972126', 4, 'system');
INSERT INTO `activities_notification` VALUES (10, '活动提醒：本周末环保活动', '本周末将在社区广场举办环保主题活动，欢迎参加！', 1, '', '2026-05-19 08:29:25.974065', 4, 'activity');
INSERT INTO `activities_notification` VALUES (11, '积分商城新品上架', '积分商城新增了多款环保商品，快来选购吧！', 0, '', '2026-05-19 08:29:25.976067', 4, 'product');
INSERT INTO `activities_notification` VALUES (12, '月度环保之星评选结果', '恭喜您被评为本月环保之星，额外获得200积分奖励！', 1, '', '2026-05-19 08:29:25.977984', 4, 'system');
INSERT INTO `activities_notification` VALUES (13, '订单状态更新', '您兑换的商品已准备就绪，请前往物业处领取。', 0, '', '2026-05-19 08:29:25.980085', 4, 'order');
INSERT INTO `activities_notification` VALUES (14, '订单状态更新', '您兑换的商品已准备就绪，请前往物业处领取。', 1, '', '2026-05-19 08:29:25.981980', 5, 'order');
INSERT INTO `activities_notification` VALUES (15, '节日祝福', '值此佳节之际，祝您和家人身体健康，万事如意！', 1, '', '2026-05-19 08:29:25.983818', 5, 'system');
INSERT INTO `activities_notification` VALUES (16, '系统公告：垃圾分类新规上线', '亲爱的居民，新的垃圾分类管理规定将于下周起正式实施，请大家认真学习。', 1, '', '2026-05-19 08:29:25.987249', 5, 'system');
INSERT INTO `activities_notification` VALUES (17, '月度环保之星评选结果', '恭喜您被评为本月环保之星，额外获得200积分奖励！', 1, '', '2026-05-19 08:29:25.989328', 5, 'system');
INSERT INTO `activities_notification` VALUES (18, '账户安全提示', '检测到您的账号在新设备登录，如非本人操作请及时修改密码。', 0, '', '2026-05-19 08:29:25.991224', 5, 'system');
INSERT INTO `activities_notification` VALUES (19, '投放异常提醒', '检测到您近期的投放合格率有所下降，请注意分类准确性。', 0, '', '2026-05-19 08:29:25.993004', 5, 'system');
INSERT INTO `activities_notification` VALUES (20, '投放点维护通知', '部分投放点将于明日进行例行维护，届时暂停使用。', 1, '', '2026-05-19 08:29:25.994654', 5, 'system');
INSERT INTO `activities_notification` VALUES (21, '积分商城新品上架', '积分商城新增了多款环保商品，快来选购吧！', 1, '', '2026-05-19 08:29:25.996223', 5, 'product');

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id` ASC, `permission_id` ASC) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id` ASC, `codename` ASC) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 93 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add content type', 4, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (14, 'Can change content type', 4, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (15, 'Can delete content type', 4, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (16, 'Can view content type', 4, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (17, 'Can add session', 5, 'add_session');
INSERT INTO `auth_permission` VALUES (18, 'Can change session', 5, 'change_session');
INSERT INTO `auth_permission` VALUES (19, 'Can delete session', 5, 'delete_session');
INSERT INTO `auth_permission` VALUES (20, 'Can view session', 5, 'view_session');
INSERT INTO `auth_permission` VALUES (21, 'Can add user', 6, 'add_user');
INSERT INTO `auth_permission` VALUES (22, 'Can change user', 6, 'change_user');
INSERT INTO `auth_permission` VALUES (23, 'Can delete user', 6, 'delete_user');
INSERT INTO `auth_permission` VALUES (24, 'Can view user', 6, 'view_user');
INSERT INTO `auth_permission` VALUES (25, 'Can add house', 7, 'add_house');
INSERT INTO `auth_permission` VALUES (26, 'Can change house', 7, 'change_house');
INSERT INTO `auth_permission` VALUES (27, 'Can delete house', 7, 'delete_house');
INSERT INTO `auth_permission` VALUES (28, 'Can view house', 7, 'view_house');
INSERT INTO `auth_permission` VALUES (29, 'Can add waste point', 8, 'add_wastepoint');
INSERT INTO `auth_permission` VALUES (30, 'Can change waste point', 8, 'change_wastepoint');
INSERT INTO `auth_permission` VALUES (31, 'Can delete waste point', 8, 'delete_wastepoint');
INSERT INTO `auth_permission` VALUES (32, 'Can view waste point', 8, 'view_wastepoint');
INSERT INTO `auth_permission` VALUES (33, 'Can add sensor', 9, 'add_sensor');
INSERT INTO `auth_permission` VALUES (34, 'Can change sensor', 9, 'change_sensor');
INSERT INTO `auth_permission` VALUES (35, 'Can delete sensor', 9, 'delete_sensor');
INSERT INTO `auth_permission` VALUES (36, 'Can view sensor', 9, 'view_sensor');
INSERT INTO `auth_permission` VALUES (37, 'Can add waste category', 10, 'add_wastecategory');
INSERT INTO `auth_permission` VALUES (38, 'Can change waste category', 10, 'change_wastecategory');
INSERT INTO `auth_permission` VALUES (39, 'Can delete waste category', 10, 'delete_wastecategory');
INSERT INTO `auth_permission` VALUES (40, 'Can view waste category', 10, 'view_wastecategory');
INSERT INTO `auth_permission` VALUES (41, 'Can add waste record', 11, 'add_wasterecord');
INSERT INTO `auth_permission` VALUES (42, 'Can change waste record', 11, 'change_wasterecord');
INSERT INTO `auth_permission` VALUES (43, 'Can delete waste record', 11, 'delete_wasterecord');
INSERT INTO `auth_permission` VALUES (44, 'Can view waste record', 11, 'view_wasterecord');
INSERT INTO `auth_permission` VALUES (45, 'Can add point transaction', 12, 'add_pointtransaction');
INSERT INTO `auth_permission` VALUES (46, 'Can change point transaction', 12, 'change_pointtransaction');
INSERT INTO `auth_permission` VALUES (47, 'Can delete point transaction', 12, 'delete_pointtransaction');
INSERT INTO `auth_permission` VALUES (48, 'Can view point transaction', 12, 'view_pointtransaction');
INSERT INTO `auth_permission` VALUES (49, 'Can add product', 13, 'add_product');
INSERT INTO `auth_permission` VALUES (50, 'Can change product', 13, 'change_product');
INSERT INTO `auth_permission` VALUES (51, 'Can delete product', 13, 'delete_product');
INSERT INTO `auth_permission` VALUES (52, 'Can view product', 13, 'view_product');
INSERT INTO `auth_permission` VALUES (53, 'Can add order', 14, 'add_order');
INSERT INTO `auth_permission` VALUES (54, 'Can change order', 14, 'change_order');
INSERT INTO `auth_permission` VALUES (55, 'Can delete order', 14, 'delete_order');
INSERT INTO `auth_permission` VALUES (56, 'Can view order', 14, 'view_order');
INSERT INTO `auth_permission` VALUES (57, 'Can add faq', 15, 'add_faq');
INSERT INTO `auth_permission` VALUES (58, 'Can change faq', 15, 'change_faq');
INSERT INTO `auth_permission` VALUES (59, 'Can delete faq', 15, 'delete_faq');
INSERT INTO `auth_permission` VALUES (60, 'Can view faq', 15, 'view_faq');
INSERT INTO `auth_permission` VALUES (61, 'Can add guide category', 16, 'add_guidecategory');
INSERT INTO `auth_permission` VALUES (62, 'Can change guide category', 16, 'change_guidecategory');
INSERT INTO `auth_permission` VALUES (63, 'Can delete guide category', 16, 'delete_guidecategory');
INSERT INTO `auth_permission` VALUES (64, 'Can view guide category', 16, 'view_guidecategory');
INSERT INTO `auth_permission` VALUES (65, 'Can add guide item', 17, 'add_guideitem');
INSERT INTO `auth_permission` VALUES (66, 'Can change guide item', 17, 'change_guideitem');
INSERT INTO `auth_permission` VALUES (67, 'Can delete guide item', 17, 'delete_guideitem');
INSERT INTO `auth_permission` VALUES (68, 'Can view guide item', 17, 'view_guideitem');
INSERT INTO `auth_permission` VALUES (69, 'Can add activity', 18, 'add_activity');
INSERT INTO `auth_permission` VALUES (70, 'Can change activity', 18, 'change_activity');
INSERT INTO `auth_permission` VALUES (71, 'Can delete activity', 18, 'delete_activity');
INSERT INTO `auth_permission` VALUES (72, 'Can view activity', 18, 'view_activity');
INSERT INTO `auth_permission` VALUES (73, 'Can add activity participant', 19, 'add_activityparticipant');
INSERT INTO `auth_permission` VALUES (74, 'Can change activity participant', 19, 'change_activityparticipant');
INSERT INTO `auth_permission` VALUES (75, 'Can delete activity participant', 19, 'delete_activityparticipant');
INSERT INTO `auth_permission` VALUES (76, 'Can view activity participant', 19, 'view_activityparticipant');
INSERT INTO `auth_permission` VALUES (77, 'Can add notification', 20, 'add_notification');
INSERT INTO `auth_permission` VALUES (78, 'Can change notification', 20, 'change_notification');
INSERT INTO `auth_permission` VALUES (79, 'Can delete notification', 20, 'delete_notification');
INSERT INTO `auth_permission` VALUES (80, 'Can view notification', 20, 'view_notification');
INSERT INTO `auth_permission` VALUES (81, 'Can add feedback', 21, 'add_feedback');
INSERT INTO `auth_permission` VALUES (82, 'Can change feedback', 21, 'change_feedback');
INSERT INTO `auth_permission` VALUES (83, 'Can delete feedback', 21, 'delete_feedback');
INSERT INTO `auth_permission` VALUES (84, 'Can view feedback', 21, 'view_feedback');
INSERT INTO `auth_permission` VALUES (85, 'Can add point evaluation', 22, 'add_pointevaluation');
INSERT INTO `auth_permission` VALUES (86, 'Can change point evaluation', 22, 'change_pointevaluation');
INSERT INTO `auth_permission` VALUES (87, 'Can delete point evaluation', 22, 'delete_pointevaluation');
INSERT INTO `auth_permission` VALUES (88, 'Can view point evaluation', 22, 'view_pointevaluation');
INSERT INTO `auth_permission` VALUES (89, 'Can add violation report', 23, 'add_violationreport');
INSERT INTO `auth_permission` VALUES (90, 'Can change violation report', 23, 'change_violationreport');
INSERT INTO `auth_permission` VALUES (91, 'Can delete violation report', 23, 'delete_violationreport');
INSERT INTO `auth_permission` VALUES (92, 'Can view violation report', 23, 'view_violationreport');

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NULL DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id` ASC) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_users_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_chk_1` CHECK (`action_flag` >= 0)
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES (1, '2026-05-20 00:48:57.118686', '3', '2号楼投放点', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 8, 1);

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label` ASC, `model` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (18, 'activities', 'activity');
INSERT INTO `django_content_type` VALUES (19, 'activities', 'activityparticipant');
INSERT INTO `django_content_type` VALUES (20, 'activities', 'notification');
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (21, 'feedback', 'feedback');
INSERT INTO `django_content_type` VALUES (22, 'feedback', 'pointevaluation');
INSERT INTO `django_content_type` VALUES (23, 'feedback', 'violationreport');
INSERT INTO `django_content_type` VALUES (15, 'guides', 'faq');
INSERT INTO `django_content_type` VALUES (16, 'guides', 'guidecategory');
INSERT INTO `django_content_type` VALUES (17, 'guides', 'guideitem');
INSERT INTO `django_content_type` VALUES (9, 'points', 'sensor');
INSERT INTO `django_content_type` VALUES (8, 'points', 'wastepoint');
INSERT INTO `django_content_type` VALUES (14, 'products', 'order');
INSERT INTO `django_content_type` VALUES (13, 'products', 'product');
INSERT INTO `django_content_type` VALUES (5, 'sessions', 'session');
INSERT INTO `django_content_type` VALUES (7, 'users', 'house');
INSERT INTO `django_content_type` VALUES (6, 'users', 'user');
INSERT INTO `django_content_type` VALUES (12, 'waste_records', 'pointtransaction');
INSERT INTO `django_content_type` VALUES (10, 'waste_records', 'wastecategory');
INSERT INTO `django_content_type` VALUES (11, 'waste_records', 'wasterecord');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2026-05-19 08:10:25.299145');
INSERT INTO `django_migrations` VALUES (2, 'contenttypes', '0002_remove_content_type_name', '2026-05-19 08:10:25.402535');
INSERT INTO `django_migrations` VALUES (3, 'auth', '0001_initial', '2026-05-19 08:10:25.660924');
INSERT INTO `django_migrations` VALUES (4, 'auth', '0002_alter_permission_name_max_length', '2026-05-19 08:10:25.725224');
INSERT INTO `django_migrations` VALUES (5, 'auth', '0003_alter_user_email_max_length', '2026-05-19 08:10:25.731334');
INSERT INTO `django_migrations` VALUES (6, 'auth', '0004_alter_user_username_opts', '2026-05-19 08:10:25.737994');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0005_alter_user_last_login_null', '2026-05-19 08:10:25.744004');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0006_require_contenttypes_0002', '2026-05-19 08:10:25.747300');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0007_alter_validators_add_error_messages', '2026-05-19 08:10:25.753512');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0008_alter_user_username_max_length', '2026-05-19 08:10:25.760347');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0009_alter_user_last_name_max_length', '2026-05-19 08:10:25.767449');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0010_alter_group_name_max_length', '2026-05-19 08:10:25.781741');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0011_update_proxy_permissions', '2026-05-19 08:10:25.788324');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0012_alter_user_first_name_max_length', '2026-05-19 08:10:25.796378');
INSERT INTO `django_migrations` VALUES (15, 'users', '0001_initial', '2026-05-19 08:10:26.168519');
INSERT INTO `django_migrations` VALUES (16, 'activities', '0001_initial', '2026-05-19 08:10:26.219950');
INSERT INTO `django_migrations` VALUES (17, 'activities', '0002_initial', '2026-05-19 08:10:26.419568');
INSERT INTO `django_migrations` VALUES (18, 'activities', '0003_activity_reward_points_activity_title_and_more', '2026-05-19 08:10:26.642987');
INSERT INTO `django_migrations` VALUES (19, 'admin', '0001_initial', '2026-05-19 08:10:26.782081');
INSERT INTO `django_migrations` VALUES (20, 'admin', '0002_logentry_remove_auto_add', '2026-05-19 08:10:26.792848');
INSERT INTO `django_migrations` VALUES (21, 'admin', '0003_logentry_add_action_flag_choices', '2026-05-19 08:10:26.802405');
INSERT INTO `django_migrations` VALUES (22, 'points', '0001_initial', '2026-05-19 08:10:26.890992');
INSERT INTO `django_migrations` VALUES (23, 'feedback', '0001_initial', '2026-05-19 08:10:26.940431');
INSERT INTO `django_migrations` VALUES (24, 'feedback', '0002_initial', '2026-05-19 08:10:27.270649');
INSERT INTO `django_migrations` VALUES (25, 'feedback', '0003_violationreport_reporter_alter_violationreport_user', '2026-05-19 08:10:27.486247');
INSERT INTO `django_migrations` VALUES (26, 'guides', '0001_initial', '2026-05-19 08:10:27.590155');
INSERT INTO `django_migrations` VALUES (27, 'points', '0002_remove_wastepoint_current_level_and_more', '2026-05-19 08:10:27.842057');
INSERT INTO `django_migrations` VALUES (28, 'products', '0001_initial', '2026-05-19 08:10:27.929827');
INSERT INTO `django_migrations` VALUES (29, 'products', '0002_initial', '2026-05-19 08:10:28.002515');
INSERT INTO `django_migrations` VALUES (30, 'products', '0003_product_points_required_alter_product_price_and_more', '2026-05-19 08:10:28.054452');
INSERT INTO `django_migrations` VALUES (31, 'sessions', '0001_initial', '2026-05-19 08:10:28.088706');
INSERT INTO `django_migrations` VALUES (32, 'waste_records', '0001_initial', '2026-05-19 08:10:28.427309');
INSERT INTO `django_migrations` VALUES (33, 'waste_records', '0002_remove_pointtransaction_amount_and_more', '2026-05-19 08:10:28.673060');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('5ui7lsy54u78wqagbrmdjqdg2ur5ozqe', '.eJyVVtty4ygQ_ZWUnuNYIIFQHvd9v2A95eLS2Exk4RFSUlNT-fcFSZOxBIozDwkC2t2nb4f-lR350J-Pg4PuaFT2nKHs8fZMcPkCbbhQ33l7sk_Stn1nxFMQeZpv3dO_VkHzzyy7UHDm7ux_TTWpOC6BgaiVLHleSkU1UtQfCUxoLigXBZKkprhmQnGea8qZKL00rUAHpRdoB-d1_ffrkLX8Aofs-eGQHQ5DRTDzC8VFFXaCo7CUOT1kj17CeMyTrOYPmu8CrunmEmC7cPepzpUWaHZhc6Nn6JrpKhy5ffi_n27AqHCD8hy_Pz6sjXjt2i9ElsIvpYYAnOZUb5m0WhsJOzGYRpn2lLR-tn6NzBfv38LB8Q3M6dyHw3wpgBL4SMWKcSkgLNhH1EdGViId2A7kT9nA3dgu1Y76gnYcqf3ttraNgm5nr9CCWjn9xl0PR2_adsrtx53kPZxs9zMKAknmoCZhISMYJkQewGhCtsAoKwdfiv19HNMmQkETKKoa9J8Ql8DLgImiYguFtKb9FMHVC_R9x1vHZW9sG8GooopAS4HybrSqXNRf6bgLv_q_7sXnkDf93fpIGNmIQmN9ro1dR2L0fU7C-B05Xyd8KzUOuacIjamglG2ZvdjW9Hbd_LNVB62zUf-jPAo3XkJid8uCkHJcKgnpOLuzvV49L-wk7-6H-be6UqItR0_WKrd2s7NqkN7R-SPyNMV0THAcbBXbfbUAv8NbVn1xx-yKYnorlgIpeqOqmJiHs7HpsBpbX0ZNN0VX8sY_b_yLNXyje4tIPE2tvAyt-mp6A24_f0YkhlIkRgqJRxfyL5JY4u1K2L76TBhprjzuIJRisTpHPFRtBWP_KsbuvGcCmmYbRmt74987nqIvFNNXuRRI0ZePU8hxXbMp4zXeyNGccXsJTO_-alpYWtmi7zPv_UvS7zo7tOsnTQOoMFrtPz7WzqfoiwlZ_uGKeVeC3pxfXO9rOeLOD5sjncErb4ZkAnCewqBV8JzVs_GRwCnmm3X4xrs2HmQ-MLwa24zWO8_jXVSEGEVFQJaBSpHq7Rzj0RX5lDMSBWoqAmHty_12v9Hy6aS0HGlWfp8Go3zdj8vWEIOLFJMtzSMW-o-I7YezA54YIG_tmx4uke1kT0HBppyHIaAmEHJes3qz9n8M4BKP9mxc8x-RWRKlmS4F8Pu37P1_Hnj02g:1wPVDY:2lk3wbhl0-Mm1F0sCnZJ1FAhRcTd8wF5Zdxdjc7ccCo', '2026-06-03 00:55:24.047988');
INSERT INTO `django_session` VALUES ('eo6b1345d6g8b1op5blt28349fa0vbso', '.eJyVVtty4ygQ_ZWUnuNYIIFQHvd9v2A95eLS2Exk4RFSUlNT-fcFSZOxBIozDwkC2t2nb4f-lR350J-Pg4PuaFT2nKHs8fZMcPkCbbhQ33l7sk_Stn1nxFMQeZpv3dO_VkHzzyy7UHDm7ux_TTWpOC6BgaiVLHleSkU1UtQfCUxoLigXBZKkprhmQnGea8qZKL00rUAHpRdoB-d1_ffrkLX8Aofs-eGQHQ5DRTDzC8VFFXaCo7CUOT1kj17CeMyTrOYPmu8CrunmEmC7cPepzpUWaHZhc6Nn6JrpKhy5ffi_n27AqHCD8hy_Pz6sjXjt2i9ElsIvpYYAnOZUb5m0WhsJOzGYRpn2lLR-tn6NzBfv38LB8Q3M6dyHw3wpgBL4SMWKcSkgLNhH1EdGViId2A7kT9nA3dgu1Y76gnYcqf3ttraNgm5nr9CCWjn9xl0PR2_adsrtx53kPZxs9zMKAknmoCZhISMYJkQewGhCtsAoKwdfiv19HNMmQkETKKoa9J8Ql8DLgImiYguFtKb9FMHVC_R9x1vHZW9sG8GooopAS4HybrSqXNRf6bgLv_q_7sXnkDf93fpIGNmIQmN9ro1dR2L0fU7C-B05Xyd8KzUOuacIjamglG2ZvdjW9Hbd_LNVB62zUf-jPAo3XkJid8uCkHJcKgnpOLuzvV49L-wk7-6H-be6UqItR0_WKrd2s7NqkN7R-SPyNMV0THAcbBXbfbUAv8NbVn1xx-yKYnorlgIpeqOqmJiHs7HpsBpbX0ZNN0VX8sY_b_yLNXyje4tIPE2tvAyt-mp6A24_f0YkhlIkRgqJRxfyL5JY4u1K2L76TBhprjzuIJRisTpHPFRtBWP_KsbuvGcCmmYbRmt74987nqIvFNNXuRRI0ZePU8hxXbMp4zXeyNGccXsJTO_-alpYWtmi7zPv_UvS7zo7tOsnTQOoMFrtPz7WzqfoiwlZ_uGKeVeC3pxfXO9rOeLOD5sjncErb4ZkAnCewqBV8JzVs_GRwCnmm3X4xrs2HmQ-MLwa24zWO8_jXVSEGEVFQJaBSpHq7Rzj0RX5lDMSBWoqAmHty_12v9Hy6aS0HGlWfp8Go3zdj8vWEIOLFJMtzSMW-o-I7YezA54YIG_tmx4uke1kT0HBppyHIaAmEHJes3qz9n8M4BKP9mxc8x-RWRKlmS4F8Pu37P1_Hnj02g:1wUaRH:pi5huygeXGEkEzSC9tZ4TrPWbuLz_D_HgdpsKd8jvoc', '2026-06-17 01:30:35.777712');
INSERT INTO `django_session` VALUES ('tzldlwczy73l3gwi7vta43qnlznjwzf5', '.eJyVVtty4ygQ_ZWUnuNYIIFQHvd9v2A95eLS2Exk4RFSUlNT-fcFSZOxBIozDwkC2t2nb4f-lR350J-Pg4PuaFT2nKHs8fZMcPkCbbhQ33l7sk_Stn1nxFMQeZpv3dO_VkHzzyy7UHDm7ux_TTWpOC6BgaiVLHleSkU1UtQfCUxoLigXBZKkprhmQnGea8qZKL00rUAHpRdoB-d1_ffrkLX8Aofs-eGQHQ5DRTDzC8VFFXaCo7CUOT1kj17CeMyTrOYPmu8CrunmEmC7cPepzpUWaHZhc6Nn6JrpKhy5ffi_n27AqHCD8hy_Pz6sjXjt2i9ElsIvpYYAnOZUb5m0WhsJOzGYRpn2lLR-tn6NzBfv38LB8Q3M6dyHw3wpgBL4SMWKcSkgLNhH1EdGViId2A7kT9nA3dgu1Y76gnYcqf3ttraNgm5nr9CCWjn9xl0PR2_adsrtx53kPZxs9zMKAknmoCZhISMYJkQewGhCtsAoKwdfiv19HNMmQkETKKoa9J8Ql8DLgImiYguFtKb9FMHVC_R9x1vHZW9sG8GooopAS4HybrSqXNRf6bgLv_q_7sXnkDf93fpIGNmIQmN9ro1dR2L0fU7C-B05Xyd8KzUOuacIjamglG2ZvdjW9Hbd_LNVB62zUf-jPAo3XkJid8uCkHJcKgnpOLuzvV49L-wk7-6H-be6UqItR0_WKrd2s7NqkN7R-SPyNMV0THAcbBXbfbUAv8NbVn1xx-yKYnorlgIpeqOqmJiHs7HpsBpbX0ZNN0VX8sY_b_yLNXyje4tIPE2tvAyt-mp6A24_f0YkhlIkRgqJRxfyL5JY4u1K2L76TBhprjzuIJRisTpHPFRtBWP_KsbuvGcCmmYbRmt74987nqIvFNNXuRRI0ZePU8hxXbMp4zXeyNGccXsJTO_-alpYWtmi7zPv_UvS7zo7tOsnTQOoMFrtPz7WzqfoiwlZ_uGKeVeC3pxfXO9rOeLOD5sjncErb4ZkAnCewqBV8JzVs_GRwCnmm3X4xrs2HmQ-MLwa24zWO8_jXVSEGEVFQJaBSpHq7Rzj0RX5lDMSBWoqAmHty_12v9Hy6aS0HGlWfp8Go3zdj8vWEIOLFJMtzSMW-o-I7YezA54YIG_tmx4uke1kT0HBppyHIaAmEHJes3qz9n8M4BKP9mxc8x-RWRKlmS4F8Pu37P1_Hnj02g:1wPFyH:WOLbhR8FlgADWejbPRHYJyEauNWZm8xlCGEUoHKANIM', '2026-06-02 08:38:37.117704');

-- ----------------------------
-- Table structure for feedback_feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback_feedback`;
CREATE TABLE `feedback_feedback`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `feedback_feedback_user_id_f7dd5014_fk_users_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `feedback_feedback_user_id_f7dd5014_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 81 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of feedback_feedback
-- ----------------------------
INSERT INTO `feedback_feedback` VALUES (1, 'APP功能建议', '希望能增加投放记录导出功能和月度统计图表。\n\n（这是自动生成的测试反馈数据）', '', 'processed', '2026-05-19 08:29:25.590021', '2026-05-19 08:29:25.590047', 5);
INSERT INTO `feedback_feedback` VALUES (2, '投放点卫生问题反馈', '最近发现某投放点周围有异味和蚊虫问题，需要关注。\n\n（这是自动生成的测试反馈数据）', '', 'pending', '2026-05-19 08:29:25.592176', '2026-05-19 08:29:25.592192', 1);
INSERT INTO `feedback_feedback` VALUES (3, '投放点卫生问题反馈', '最近发现某投放点周围有异味和蚊虫问题，需要关注。\n\n（这是自动生成的测试反馈数据）', '', 'processed', '2026-05-19 08:29:25.594934', '2026-05-19 08:29:25.594952', 3);
INSERT INTO `feedback_feedback` VALUES (4, '建议增加夜间投放时间', '希望投放点的开放时间能延长到晚上10点以后，方便上班族使用。\n\n（这是自动生成的测试反馈数据）', '', 'pending', '2026-05-19 08:29:25.596783', '2026-05-19 08:29:25.596802', 5);
INSERT INTO `feedback_feedback` VALUES (6, '建议开展更多线下活动', '希望能多举办一些亲子参与的环保教育活动。\n\n（这是自动生成的测试反馈数据）', '', 'processed', '2026-05-19 08:29:25.600031', '2026-05-19 08:29:25.600048', 4);
INSERT INTO `feedback_feedback` VALUES (7, '建议增加夜间投放时间', '希望投放点的开放时间能延长到晚上10点以后，方便上班族使用。\n\n（这是自动生成的测试反馈数据）', '', 'closed', '2026-05-19 08:29:25.602216', '2026-05-19 08:29:25.602236', 3);
INSERT INTO `feedback_feedback` VALUES (8, '投放点容量不足', '3号楼的投放点经常满溢，建议增加清理频次或更换更大容量的设备。\n\n（这是自动生成的测试反馈数据）', '', 'pending', '2026-05-19 08:29:25.604301', '2026-05-19 08:29:25.604320', 4);
INSERT INTO `feedback_feedback` VALUES (9, '申请增设有害垃圾专用箱', '我们这栋楼的有害垃圾产生量较大，希望能设专用的收集箱。\n\n（这是自动生成的测试反馈数据）', '', 'pending', '2026-05-19 08:29:25.606035', '2026-05-19 08:29:25.606051', 1);
INSERT INTO `feedback_feedback` VALUES (10, '申请增设有害垃圾专用箱', '我们这栋楼的有害垃圾产生量较大，希望能设专用的收集箱。\n\n（这是自动生成的测试反馈数据）', '', 'processed', '2026-05-19 08:29:25.607749', '2026-05-19 08:29:25.607766', 3);
INSERT INTO `feedback_feedback` VALUES (11, '投放点卫生问题反馈', '最近发现某投放点周围有异味和蚊虫问题，需要关注。\n\n（这是自动生成的测试反馈数据）', '', 'pending', '2026-05-19 08:29:25.609432', '2026-05-19 08:29:25.609447', 5);
INSERT INTO `feedback_feedback` VALUES (12, '建议开展更多线下活动', '希望能多举办一些亲子参与的环保教育活动。\n\n（这是自动生成的测试反馈数据）', '', 'pending', '2026-05-19 08:29:25.611485', '2026-05-19 08:29:25.611504', 5);
INSERT INTO `feedback_feedback` VALUES (15, '感谢系统的便利性', '使用这个系统已经半年了，感觉越来越方便了，感谢开发团队！\n\n（这是自动生成的测试反馈数据）', '', 'pending', '2026-05-19 08:29:25.616493', '2026-05-19 08:29:25.616513', 3);
INSERT INTO `feedback_feedback` VALUES (16, '分类标识不够清晰', '部分投放点的分类标识褪色了，建议定期更换。\n\n（这是自动生成的测试反馈数据）', '', 'pending', '2026-05-19 08:29:25.618666', '2026-05-19 08:29:25.618686', 1);
INSERT INTO `feedback_feedback` VALUES (17, '投放点容量不足', '3号楼的投放点经常满溢，建议增加清理频次或更换更大容量的设备。\n\n（这是自动生成的测试反馈数据）', '', 'pending', '2026-05-19 08:29:25.620630', '2026-05-19 08:29:25.620650', 5);
INSERT INTO `feedback_feedback` VALUES (18, '申请增设有害垃圾专用箱', '我们这栋楼的有害垃圾产生量较大，希望能设专用的收集箱。\n\n（这是自动生成的测试反馈数据）', '', 'processed', '2026-05-19 08:29:25.622527', '2026-05-19 08:29:25.622546', 3);
INSERT INTO `feedback_feedback` VALUES (19, '投放点卫生问题反馈', '最近发现某投放点周围有异味和蚊虫问题，需要关注。\n\n（这是自动生成的测试反馈数据）', '', 'processed', '2026-05-19 08:29:25.624377', '2026-05-19 08:29:25.624397', 4);
INSERT INTO `feedback_feedback` VALUES (21, '投放点容量不足', '3号楼的投放点经常满溢，建议增加清理频次或更换更大容量的设备。\n\n（这是自动生成的测试反馈数据）', '', 'pending', '2026-05-19 08:29:25.628376', '2026-05-19 08:29:25.628397', 5);
INSERT INTO `feedback_feedback` VALUES (22, '投放点卫生问题反馈', '最近发现某投放点周围有异味和蚊虫问题，需要关注。\n\n（这是自动生成的测试反馈数据）', '', 'processed', '2026-05-19 08:29:25.630403', '2026-05-19 08:29:25.630421', 4);
INSERT INTO `feedback_feedback` VALUES (23, '表扬保洁人员工作认真', '想特别表扬负责东门投放点的王师傅，工作非常认真负责！\n\n（这是自动生成的测试反馈数据）', '', 'pending', '2026-05-19 08:29:25.632388', '2026-05-19 08:29:25.632404', 4);
INSERT INTO `feedback_feedback` VALUES (24, '积分兑换商品太少', '积分商城的商品种类偏少，希望能增加更多选择。\n\n（这是自动生成的测试反馈数据）', '', 'pending', '2026-05-19 08:29:25.634068', '2026-05-19 08:29:25.634083', 1);
INSERT INTO `feedback_feedback` VALUES (25, '积分兑换商品太少', '积分商城的商品种类偏少，希望能增加更多选择。\n\n（这是自动生成的测试反馈数据）', '', 'closed', '2026-05-19 08:29:25.636338', '2026-05-19 08:29:25.636359', 5);
INSERT INTO `feedback_feedback` VALUES (26, '建议开展更多线下活动', '希望能多举办一些亲子参与的环保教育活动。\n\n（这是自动生成的测试反馈数据）', '', 'closed', '2026-05-19 08:29:25.638310', '2026-05-19 08:29:25.638329', 3);
INSERT INTO `feedback_feedback` VALUES (27, '积分兑换商品太少', '积分商城的商品种类偏少，希望能增加更多选择。\n\n（这是自动生成的测试反馈数据）', '', 'pending', '2026-05-19 08:29:25.640097', '2026-05-19 08:29:25.640112', 1);
INSERT INTO `feedback_feedback` VALUES (28, '分类标识不够清晰', '部分投放点的分类标识褪色了，建议定期更换。\n\n（这是自动生成的测试反馈数据）', '', 'closed', '2026-05-19 08:29:25.641909', '2026-05-19 08:29:25.641924', 5);
INSERT INTO `feedback_feedback` VALUES (29, '建议开展更多线下活动', '希望能多举办一些亲子参与的环保教育活动。\n\n（这是自动生成的测试反馈数据）', '', 'pending', '2026-05-19 08:29:25.643878', '2026-05-19 08:29:25.643896', 1);
INSERT INTO `feedback_feedback` VALUES (30, '感谢系统的便利性', '使用这个系统已经半年了，感觉越来越方便了，感谢开发团队！\n\n（这是自动生成的测试反馈数据）', '', 'pending', '2026-05-19 08:29:25.645785', '2026-05-19 08:29:25.645801', 4);
INSERT INTO `feedback_feedback` VALUES (31, '建议增加夜间投放时间', '希望投放点的开放时间能延长到晚上10点以后，方便上班族使用。\n\n（这是自动生成的测试反馈数据）', '', 'pending', '2026-05-19 08:29:25.647463', '2026-05-19 08:29:25.647478', 1);
INSERT INTO `feedback_feedback` VALUES (33, '积分兑换商品太少', '积分商城的商品种类偏少，希望能增加更多选择。\n\n（这是自动生成的测试反馈数据）', '', 'closed', '2026-05-19 08:29:25.650625', '2026-05-19 08:29:25.650642', 4);
INSERT INTO `feedback_feedback` VALUES (34, '积分兑换商品太少', '积分商城的商品种类偏少，希望能增加更多选择。\n\n（这是自动生成的测试反馈数据）', '', 'processed', '2026-05-19 08:29:25.653111', '2026-05-19 08:29:25.653130', 4);
INSERT INTO `feedback_feedback` VALUES (35, '感谢系统的便利性', '使用这个系统已经半年了，感觉越来越方便了，感谢开发团队！\n\n（这是自动生成的测试反馈数据）', '', 'closed', '2026-05-19 08:29:25.655138', '2026-05-19 08:29:25.655154', 5);
INSERT INTO `feedback_feedback` VALUES (37, '建议开展更多线下活动', '希望能多举办一些亲子参与的环保教育活动。\n\n（这是自动生成的测试反馈数据）', '', 'pending', '2026-05-19 08:29:25.658928', '2026-05-19 08:29:25.658949', 3);
INSERT INTO `feedback_feedback` VALUES (38, '感谢系统的便利性', '使用这个系统已经半年了，感觉越来越方便了，感谢开发团队！\n\n（这是自动生成的测试反馈数据）', '', 'processed', '2026-05-19 08:29:25.661018', '2026-05-19 08:29:25.661045', 3);
INSERT INTO `feedback_feedback` VALUES (39, '投放点容量不足', '3号楼的投放点经常满溢，建议增加清理频次或更换更大容量的设备。\n\n（这是自动生成的测试反馈数据）', '', 'pending', '2026-05-19 08:29:25.662831', '2026-05-19 08:29:25.662846', 3);
INSERT INTO `feedback_feedback` VALUES (40, '建议开展更多线下活动', '希望能多举办一些亲子参与的环保教育活动。\n\n（这是自动生成的测试反馈数据）', '', 'closed', '2026-05-19 08:29:25.664547', '2026-05-19 08:29:25.664562', 3);
INSERT INTO `feedback_feedback` VALUES (41, '感谢系统的便利性', '使用这个系统已经半年了，感觉越来越方便了，感谢开发团队！\n\n（这是自动生成的测试反馈数据）', '', 'processed', '2026-05-19 08:29:25.666319', '2026-05-19 08:29:25.666334', 3);
INSERT INTO `feedback_feedback` VALUES (42, '分类标识不够清晰', '部分投放点的分类标识褪色了，建议定期更换。\n\n（这是自动生成的测试反馈数据）', '', 'processed', '2026-05-19 08:29:25.668606', '2026-05-19 08:29:25.668643', 4);
INSERT INTO `feedback_feedback` VALUES (43, '投放点卫生问题反馈', '最近发现某投放点周围有异味和蚊虫问题，需要关注。\n\n（这是自动生成的测试反馈数据）', '', 'processed', '2026-05-19 08:29:25.671395', '2026-05-19 08:29:25.671414', 5);
INSERT INTO `feedback_feedback` VALUES (44, 'APP功能建议', '希望能增加投放记录导出功能和月度统计图表。\n\n（这是自动生成的测试反馈数据）', '', 'pending', '2026-05-19 08:29:25.673634', '2026-05-19 08:29:25.673672', 1);
INSERT INTO `feedback_feedback` VALUES (46, '积分兑换商品太少', '积分商城的商品种类偏少，希望能增加更多选择。\n\n（这是自动生成的测试反馈数据）', '', 'closed', '2026-05-19 08:29:25.677697', '2026-05-19 08:29:25.677717', 5);
INSERT INTO `feedback_feedback` VALUES (47, '表扬保洁人员工作认真', '想特别表扬负责东门投放点的王师傅，工作非常认真负责！\n\n（这是自动生成的测试反馈数据）', '', 'processed', '2026-05-19 08:29:25.679786', '2026-05-19 08:29:25.679807', 5);
INSERT INTO `feedback_feedback` VALUES (49, '投放点容量不足', '3号楼的投放点经常满溢，建议增加清理频次或更换更大容量的设备。\n\n（这是自动生成的测试反馈数据）', '', 'processed', '2026-05-19 08:29:25.683559', '2026-05-19 08:29:25.683579', 5);
INSERT INTO `feedback_feedback` VALUES (50, '表扬保洁人员工作认真', '想特别表扬负责东门投放点的王师傅，工作非常认真负责！\n\n（这是自动生成的测试反馈数据）', '', 'pending', '2026-05-19 08:29:25.685743', '2026-05-19 08:29:25.685762', 5);
INSERT INTO `feedback_feedback` VALUES (52, '建议开展更多线下活动', '希望能多举办一些亲子参与的环保教育活动。\n\n（这是自动生成的测试反馈数据）', '', 'closed', '2026-05-19 08:29:25.689689', '2026-05-19 08:29:25.689713', 3);
INSERT INTO `feedback_feedback` VALUES (53, '投放点容量不足', '3号楼的投放点经常满溢，建议增加清理频次或更换更大容量的设备。\n\n（这是自动生成的测试反馈数据）', '', 'closed', '2026-05-19 08:29:25.691777', '2026-05-19 08:29:25.691796', 3);
INSERT INTO `feedback_feedback` VALUES (54, '建议增加夜间投放时间', '希望投放点的开放时间能延长到晚上10点以后，方便上班族使用。\n\n（这是自动生成的测试反馈数据）', '', 'pending', '2026-05-19 08:29:25.693586', '2026-05-19 08:29:25.693601', 5);
INSERT INTO `feedback_feedback` VALUES (55, '投放点容量不足', '3号楼的投放点经常满溢，建议增加清理频次或更换更大容量的设备。\n\n（这是自动生成的测试反馈数据）', '', 'pending', '2026-05-19 08:29:25.695558', '2026-05-19 08:29:25.695576', 3);
INSERT INTO `feedback_feedback` VALUES (56, '投放点容量不足', '3号楼的投放点经常满溢，建议增加清理频次或更换更大容量的设备。\n\n（这是自动生成的测试反馈数据）', '', 'processed', '2026-05-19 08:29:25.697622', '2026-05-19 08:29:25.697640', 4);
INSERT INTO `feedback_feedback` VALUES (57, '分类标识不够清晰', '部分投放点的分类标识褪色了，建议定期更换。\n\n（这是自动生成的测试反馈数据）', '', 'pending', '2026-05-19 08:29:25.699358', '2026-05-19 08:29:25.699376', 5);
INSERT INTO `feedback_feedback` VALUES (58, '建议增加夜间投放时间', '希望投放点的开放时间能延长到晚上10点以后，方便上班族使用。\n\n（这是自动生成的测试反馈数据）', '', 'pending', '2026-05-19 08:29:25.701299', '2026-05-19 08:29:25.701317', 3);
INSERT INTO `feedback_feedback` VALUES (59, '申请增设有害垃圾专用箱', '我们这栋楼的有害垃圾产生量较大，希望能设专用的收集箱。\n\n（这是自动生成的测试反馈数据）', '', 'processed', '2026-05-19 08:29:25.703432', '2026-05-19 08:29:25.703452', 4);
INSERT INTO `feedback_feedback` VALUES (60, '建议开展更多线下活动', '希望能多举办一些亲子参与的环保教育活动。\n\n（这是自动生成的测试反馈数据）', '', 'pending', '2026-05-19 08:29:25.705972', '2026-05-19 08:29:25.705991', 3);
INSERT INTO `feedback_feedback` VALUES (61, '[表扬] 工作人员服务态度很好', '工作人员服务态度很好', NULL, 'pending', '2026-05-19 08:38:59.683836', '2026-05-19 08:38:59.683858', 11);
INSERT INTO `feedback_feedback` VALUES (62, '[建议] 建议开展更多环保教育活动', '建议开展更多环保教育活动', NULL, 'closed', '2026-05-19 08:38:59.686594', '2026-05-19 08:38:59.686618', 12);
INSERT INTO `feedback_feedback` VALUES (63, '[表扬] 工作人员服务态度很好', '工作人员服务态度很好', NULL, 'pending', '2026-05-19 08:38:59.689503', '2026-05-19 08:38:59.689527', 13);
INSERT INTO `feedback_feedback` VALUES (64, '[建议] 希望增加更多种类的回收', '希望增加更多种类的回收', NULL, 'processed', '2026-05-19 08:38:59.691913', '2026-05-19 08:38:59.691935', 9);
INSERT INTO `feedback_feedback` VALUES (65, '[建议] 建议开展更多环保教育活动', '建议开展更多环保教育活动', NULL, 'closed', '2026-05-19 08:38:59.693997', '2026-05-19 08:38:59.694018', 6);
INSERT INTO `feedback_feedback` VALUES (66, '[建议] 建议开展更多环保教育活动', '建议开展更多环保教育活动', NULL, 'closed', '2026-05-19 08:38:59.696746', '2026-05-19 08:38:59.696768', 7);
INSERT INTO `feedback_feedback` VALUES (67, '[建议] 希望增加更多种类的回收', '希望增加更多种类的回收', NULL, 'closed', '2026-05-19 08:38:59.699163', '2026-05-19 08:38:59.699188', 5);
INSERT INTO `feedback_feedback` VALUES (68, '[投诉] 投放点标识不够清晰', '投放点标识不够清晰', NULL, 'processed', '2026-05-19 08:38:59.702570', '2026-05-19 08:38:59.702596', 3);
INSERT INTO `feedback_feedback` VALUES (69, '[投诉] 投放点标识不够清晰', '投放点标识不够清晰', NULL, 'pending', '2026-05-19 08:38:59.705054', '2026-05-19 08:38:59.705075', 10);
INSERT INTO `feedback_feedback` VALUES (70, '[投诉] 投放点标识不够清晰', '投放点标识不够清晰', NULL, 'pending', '2026-05-19 08:38:59.707154', '2026-05-19 08:38:59.707176', 11);
INSERT INTO `feedback_feedback` VALUES (71, '[投诉] 投放点标识不够清晰', '投放点标识不够清晰', NULL, 'pending', '2026-05-19 08:38:59.709318', '2026-05-19 08:38:59.709340', 7);
INSERT INTO `feedback_feedback` VALUES (72, '[建议] 希望增加更多种类的回收', '希望增加更多种类的回收', NULL, 'pending', '2026-05-19 08:38:59.711838', '2026-05-19 08:38:59.711864', 1);
INSERT INTO `feedback_feedback` VALUES (73, '[表扬] 工作人员服务态度很好', '工作人员服务态度很好', NULL, 'closed', '2026-05-19 08:38:59.714491', '2026-05-19 08:38:59.714524', 11);
INSERT INTO `feedback_feedback` VALUES (74, '[建议] 建议开展更多环保教育活动', '建议开展更多环保教育活动', NULL, 'pending', '2026-05-19 08:38:59.717162', '2026-05-19 08:38:59.717185', 4);
INSERT INTO `feedback_feedback` VALUES (75, '[投诉] 投放点标识不够清晰', '投放点标识不够清晰', NULL, 'closed', '2026-05-19 08:38:59.719395', '2026-05-19 08:38:59.719421', 14);
INSERT INTO `feedback_feedback` VALUES (76, '[表扬] 工作人员服务态度很好', '工作人员服务态度很好', NULL, 'closed', '2026-05-19 08:38:59.721855', '2026-05-19 08:38:59.721880', 1);
INSERT INTO `feedback_feedback` VALUES (77, '[表扬] 工作人员服务态度很好', '工作人员服务态度很好', NULL, 'closed', '2026-05-19 08:38:59.724036', '2026-05-19 08:38:59.724057', 15);
INSERT INTO `feedback_feedback` VALUES (78, '[建议] 建议增加夜间投放时间', '建议增加夜间投放时间', NULL, 'pending', '2026-05-19 08:38:59.726242', '2026-05-19 08:38:59.726264', 7);
INSERT INTO `feedback_feedback` VALUES (79, '[建议] 希望增加更多种类的回收', '希望增加更多种类的回收', NULL, 'pending', '2026-05-19 08:38:59.729250', '2026-05-19 08:38:59.729296', 3);
INSERT INTO `feedback_feedback` VALUES (80, '[建议] 希望增加更多种类的回收', '希望增加更多种类的回收', NULL, 'processed', '2026-05-19 08:38:59.732119', '2026-05-19 08:38:59.732140', 8);

-- ----------------------------
-- Table structure for feedback_pointevaluation
-- ----------------------------
DROP TABLE IF EXISTS `feedback_pointevaluation`;
CREATE TABLE `feedback_pointevaluation`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cleanliness` int NOT NULL,
  `equipment_status` int NOT NULL,
  `comment` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `image_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  `waste_point_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `feedback_pointevaluation_user_id_0553d44d_fk_users_user_id`(`user_id` ASC) USING BTREE,
  INDEX `feedback_pointevalua_waste_point_id_f3d7df05_fk_points_wa`(`waste_point_id` ASC) USING BTREE,
  CONSTRAINT `feedback_pointevalua_waste_point_id_f3d7df05_fk_points_wa` FOREIGN KEY (`waste_point_id`) REFERENCES `points_wastepoint` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `feedback_pointevaluation_user_id_0553d44d_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 82 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of feedback_pointevaluation
-- ----------------------------
INSERT INTO `feedback_pointevaluation` VALUES (1, 4, 3, '设施完好', '', '2026-05-19 08:29:25.708671', 3, 1);
INSERT INTO `feedback_pointevaluation` VALUES (3, 1, 1, '设备有点旧', '', '2026-05-19 08:29:25.713024', 3, 1);
INSERT INTO `feedback_pointevaluation` VALUES (4, 3, 5, '需要改进卫生', '', '2026-05-19 08:29:25.715605', 1, 1);
INSERT INTO `feedback_pointevaluation` VALUES (5, 3, 4, '位置方便', '', '2026-05-19 08:29:25.717397', 1, 1);
INSERT INTO `feedback_pointevaluation` VALUES (6, 3, 4, '需要改进卫生', '', '2026-05-19 08:29:25.719679', 5, 1);
INSERT INTO `feedback_pointevaluation` VALUES (7, 2, 3, '设备有点旧', '', '2026-05-19 08:29:25.721859', 3, 1);
INSERT INTO `feedback_pointevaluation` VALUES (8, 1, 3, '需要改进卫生', '', '2026-05-19 08:29:25.723959', 4, 2);
INSERT INTO `feedback_pointevaluation` VALUES (10, 4, 4, '总体不错', '', '2026-05-19 08:29:25.727441', 1, 2);
INSERT INTO `feedback_pointevaluation` VALUES (11, 4, 3, '位置方便', '', '2026-05-19 08:29:25.729669', 4, 2);
INSERT INTO `feedback_pointevaluation` VALUES (12, 1, 5, '环境整洁', '', '2026-05-19 08:29:25.731890', 5, 2);
INSERT INTO `feedback_pointevaluation` VALUES (13, 4, 4, '位置方便', '', '2026-05-19 08:29:25.733802', 4, 2);
INSERT INTO `feedback_pointevaluation` VALUES (14, 5, 3, '位置方便', '', '2026-05-19 08:29:25.736281', 3, 2);
INSERT INTO `feedback_pointevaluation` VALUES (15, 3, 4, '', '', '2026-05-19 08:29:25.738190', 5, 2);
INSERT INTO `feedback_pointevaluation` VALUES (17, 5, 4, '环境整洁', '', '2026-05-19 08:29:25.741895', 1, 2);
INSERT INTO `feedback_pointevaluation` VALUES (18, 3, 3, '需要改进卫生', '', '2026-05-19 08:29:25.743929', 3, 3);
INSERT INTO `feedback_pointevaluation` VALUES (19, 3, 3, '', '', '2026-05-19 08:29:25.745706', 3, 3);
INSERT INTO `feedback_pointevaluation` VALUES (20, 2, 2, '环境整洁', '', '2026-05-19 08:29:25.747548', 4, 3);
INSERT INTO `feedback_pointevaluation` VALUES (21, 5, 4, '服务态度好', '', '2026-05-19 08:29:25.749385', 3, 3);
INSERT INTO `feedback_pointevaluation` VALUES (23, 3, 2, '设备有点旧', '', '2026-05-19 08:29:25.753558', 5, 3);
INSERT INTO `feedback_pointevaluation` VALUES (26, 3, 5, '需要改进卫生', '', '2026-05-19 08:29:25.759315', 4, 3);
INSERT INTO `feedback_pointevaluation` VALUES (27, 5, 4, '设施完好', '', '2026-05-19 08:29:25.761288', 1, 3);
INSERT INTO `feedback_pointevaluation` VALUES (28, 1, 5, '服务态度好', '', '2026-05-19 08:29:25.763133', 1, 3);
INSERT INTO `feedback_pointevaluation` VALUES (29, 4, 5, '设备有点旧', '', '2026-05-19 08:29:25.764965', 1, 3);
INSERT INTO `feedback_pointevaluation` VALUES (30, 3, 2, '需要改进卫生', '', '2026-05-19 08:29:25.767248', 5, 4);
INSERT INTO `feedback_pointevaluation` VALUES (31, 4, 5, '需要改进卫生', '', '2026-05-19 08:29:25.769602', 5, 4);
INSERT INTO `feedback_pointevaluation` VALUES (32, 5, 1, '需要改进卫生', '', '2026-05-19 08:29:25.771668', 5, 4);
INSERT INTO `feedback_pointevaluation` VALUES (33, 3, 4, '设备有点旧', '', '2026-05-19 08:29:25.773596', 4, 4);
INSERT INTO `feedback_pointevaluation` VALUES (34, 3, 4, '设施完好', '', '2026-05-19 08:29:25.775479', 5, 4);
INSERT INTO `feedback_pointevaluation` VALUES (35, 5, 5, '环境整洁', '', '2026-05-19 08:29:25.777385', 1, 4);
INSERT INTO `feedback_pointevaluation` VALUES (37, 5, 3, '总体不错', '', '2026-05-19 08:29:25.780821', 3, 4);
INSERT INTO `feedback_pointevaluation` VALUES (38, 4, 4, '环境整洁', '', '2026-05-19 08:29:25.783302', 4, 4);
INSERT INTO `feedback_pointevaluation` VALUES (39, 5, 4, '', '', '2026-05-19 08:29:25.785286', 5, 4);
INSERT INTO `feedback_pointevaluation` VALUES (40, 3, 5, '需要改进卫生', '', '2026-05-19 08:29:25.787319', 4, 4);
INSERT INTO `feedback_pointevaluation` VALUES (41, 1, 3, '', '', '2026-05-19 08:29:25.789168', 3, 5);
INSERT INTO `feedback_pointevaluation` VALUES (43, 3, 3, '服务态度好', '', '2026-05-19 08:29:25.792793', 3, 5);
INSERT INTO `feedback_pointevaluation` VALUES (44, 5, 5, '位置方便', '', '2026-05-19 08:29:25.794906', 5, 5);
INSERT INTO `feedback_pointevaluation` VALUES (45, 1, 5, '', '', '2026-05-19 08:29:25.796733', 3, 5);
INSERT INTO `feedback_pointevaluation` VALUES (46, 2, 4, '设备有点旧', '', '2026-05-19 08:29:25.799042', 3, 6);
INSERT INTO `feedback_pointevaluation` VALUES (48, 1, 3, '环境整洁', '', '2026-05-19 08:29:25.802912', 4, 6);
INSERT INTO `feedback_pointevaluation` VALUES (50, 4, 4, '总体不错', '', '2026-05-19 08:29:25.806513', 4, 6);
INSERT INTO `feedback_pointevaluation` VALUES (51, 4, 3, '需要改进卫生', '', '2026-05-19 08:29:25.808420', 4, 6);
INSERT INTO `feedback_pointevaluation` VALUES (52, 4, 4, '位置方便', '', '2026-05-19 08:29:25.810196', 3, 6);
INSERT INTO `feedback_pointevaluation` VALUES (53, 1, 2, '设施完好', '', '2026-05-19 08:29:25.812070', 4, 6);
INSERT INTO `feedback_pointevaluation` VALUES (54, 4, 3, '设施完好', '', '2026-05-19 08:29:25.814426', 4, 6);
INSERT INTO `feedback_pointevaluation` VALUES (55, 1, 3, '需要改进卫生', '', '2026-05-19 08:29:25.816167', 3, 6);
INSERT INTO `feedback_pointevaluation` VALUES (56, 5, 3, '', '', '2026-05-19 08:29:25.818268', 1, 6);
INSERT INTO `feedback_pointevaluation` VALUES (57, 5, 3, '设备有点旧', '', '2026-05-19 08:29:25.820086', 5, 7);
INSERT INTO `feedback_pointevaluation` VALUES (58, 3, 4, '总体不错', '', '2026-05-19 08:29:25.821784', 1, 7);
INSERT INTO `feedback_pointevaluation` VALUES (59, 3, 5, '总体不错', '', '2026-05-19 08:29:25.823576', 5, 7);
INSERT INTO `feedback_pointevaluation` VALUES (60, 3, 5, '', '', '2026-05-19 08:29:25.825287', 5, 7);
INSERT INTO `feedback_pointevaluation` VALUES (61, 4, 3, '设备有点旧', '', '2026-05-19 08:29:25.826903', 5, 7);
INSERT INTO `feedback_pointevaluation` VALUES (62, 5, 4, '设备有点旧', '', '2026-05-19 08:29:25.828958', 1, 7);
INSERT INTO `feedback_pointevaluation` VALUES (63, 5, 4, '服务态度好', '', '2026-05-19 08:29:25.830901', 1, 8);
INSERT INTO `feedback_pointevaluation` VALUES (65, 5, 5, '环境整洁', '', '2026-05-19 08:29:25.834137', 4, 8);
INSERT INTO `feedback_pointevaluation` VALUES (66, 3, 3, '', '', '2026-05-19 08:29:25.836741', 4, 8);
INSERT INTO `feedback_pointevaluation` VALUES (68, 3, 3, '', '', '2026-05-19 08:29:25.840465', 4, 8);
INSERT INTO `feedback_pointevaluation` VALUES (69, 5, 1, '环境整洁', '', '2026-05-19 08:29:25.842482', 3, 9);
INSERT INTO `feedback_pointevaluation` VALUES (70, 4, 5, '位置方便', '', '2026-05-19 08:29:25.844798', 4, 9);
INSERT INTO `feedback_pointevaluation` VALUES (72, 3, 3, '总体不错', '', '2026-05-19 08:29:25.848477', 4, 9);
INSERT INTO `feedback_pointevaluation` VALUES (73, 4, 4, '设施完好', '', '2026-05-19 08:29:25.850507', 5, 9);
INSERT INTO `feedback_pointevaluation` VALUES (75, 1, 5, '设备有点旧', '', '2026-05-19 08:29:25.854760', 4, 10);
INSERT INTO `feedback_pointevaluation` VALUES (76, 5, 5, '', '', '2026-05-19 08:29:25.856891', 1, 10);
INSERT INTO `feedback_pointevaluation` VALUES (77, 3, 5, '总体不错', '', '2026-05-19 08:29:25.858673', 1, 10);
INSERT INTO `feedback_pointevaluation` VALUES (78, 3, 3, '总体不错', '', '2026-05-19 08:29:25.860719', 5, 10);
INSERT INTO `feedback_pointevaluation` VALUES (79, 3, 5, '环境整洁', '', '2026-05-19 08:29:25.862511', 4, 10);
INSERT INTO `feedback_pointevaluation` VALUES (81, 5, 3, '服务态度好', '', '2026-05-19 08:29:25.865829', 1, 10);

-- ----------------------------
-- Table structure for feedback_violationreport
-- ----------------------------
DROP TABLE IF EXISTS `feedback_violationreport`;
CREATE TABLE `feedback_violationreport`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` bigint NULL DEFAULT NULL,
  `waste_point_id` bigint NOT NULL,
  `reporter_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `feedback_violationre_waste_point_id_ebb27308_fk_points_wa`(`waste_point_id` ASC) USING BTREE,
  INDEX `feedback_violationreport_reporter_id_78f29e7d_fk_users_user_id`(`reporter_id` ASC) USING BTREE,
  INDEX `feedback_violationreport_user_id_f9fd70f9_fk_users_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `feedback_violationre_waste_point_id_ebb27308_fk_points_wa` FOREIGN KEY (`waste_point_id`) REFERENCES `points_wastepoint` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `feedback_violationreport_reporter_id_78f29e7d_fk_users_user_id` FOREIGN KEY (`reporter_id`) REFERENCES `users_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `feedback_violationreport_user_id_f9fd70f9_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of feedback_violationreport
-- ----------------------------
INSERT INTO `feedback_violationreport` VALUES (1, '有人未按规定时间在非投放时段倾倒垃圾。', '', 'pending', '2026-05-19 08:29:25.869537', '2026-05-19 08:29:25.869560', 4, 5, 1);
INSERT INTO `feedback_violationreport` VALUES (4, '有人未按规定时间在非投放时段倾倒垃圾。', '', 'confirmed', '2026-05-19 08:29:25.876857', '2026-05-19 08:29:25.876876', 3, 10, 5);
INSERT INTO `feedback_violationreport` VALUES (6, '发现宠物粪便被错误地投入厨余垃圾桶。', '', 'confirmed', '2026-05-19 08:29:25.880319', '2026-05-19 08:29:25.880335', 5, 7, 1);
INSERT INTO `feedback_violationreport` VALUES (7, '发现有人故意破坏投放点设施设备。', '', 'confirmed', '2026-05-19 08:29:25.882467', '2026-05-19 08:29:25.882486', 1, 8, 4);
INSERT INTO `feedback_violationreport` VALUES (8, '有人将大件家具随意丢弃在投放点旁边。', '', 'pending', '2026-05-19 08:29:25.884683', '2026-05-19 08:29:25.884702', 3, 10, 4);
INSERT INTO `feedback_violationreport` VALUES (11, '有人未按规定时间在非投放时段倾倒垃圾。', '', 'rejected', '2026-05-19 08:29:25.890393', '2026-05-19 08:29:25.890418', 3, 9, 1);
INSERT INTO `feedback_violationreport` VALUES (13, '发现有人将危险废弃物（油漆桶）投入普通垃圾桶。', '', 'confirmed', '2026-05-19 08:29:25.894320', '2026-05-19 08:29:25.894342', 4, 5, 5);
INSERT INTO `feedback_violationreport` VALUES (15, '发现有人将危险废弃物（油漆桶）投入普通垃圾桶。', '', 'pending', '2026-05-19 08:29:25.898227', '2026-05-19 08:29:25.898248', 5, 5, 3);
INSERT INTO `feedback_violationreport` VALUES (16, '发现宠物粪便被错误地投入厨余垃圾桶。', '', 'confirmed', '2026-05-19 08:29:25.900190', '2026-05-19 08:29:25.900210', 3, 2, 4);
INSERT INTO `feedback_violationreport` VALUES (21, '投放点周边存在乱扔垃圾的不文明行为。', '', 'confirmed', '2026-05-19 08:29:25.910495', '2026-05-19 08:29:25.910519', 4, 10, 3);
INSERT INTO `feedback_violationreport` VALUES (22, '有人在投放点附近焚烧垃圾，存在安全隐患。', '', 'rejected', '2026-05-19 08:29:25.912817', '2026-05-19 08:29:25.912840', 3, 8, 5);
INSERT INTO `feedback_violationreport` VALUES (23, '投放点周边存在乱扔垃圾的不文明行为。', '', 'rejected', '2026-05-19 08:29:25.914938', '2026-05-19 08:29:25.914960', 3, 1, 5);
INSERT INTO `feedback_violationreport` VALUES (26, '有人将大件家具随意丢弃在投放点旁边。', '', 'confirmed', '2026-05-19 08:29:25.921843', '2026-05-19 08:29:25.921866', 5, 7, 1);
INSERT INTO `feedback_violationreport` VALUES (27, '有人将大件家具随意丢弃在投放点旁边。', '', 'rejected', '2026-05-19 08:29:25.924124', '2026-05-19 08:29:25.924145', 1, 4, 3);
INSERT INTO `feedback_violationreport` VALUES (28, '投放点周边存在乱扔垃圾的不文明行为。', '', 'rejected', '2026-05-19 08:29:25.926379', '2026-05-19 08:29:25.926401', 3, 9, 1);
INSERT INTO `feedback_violationreport` VALUES (29, '发现有人将建筑垃圾混入生活垃圾投放。', '', 'pending', '2026-05-19 08:29:25.928635', '2026-05-19 08:29:25.928655', 5, 7, 4);
INSERT INTO `feedback_violationreport` VALUES (31, '发现宠物粪便被错误地投入厨余垃圾桶。', '', 'pending', '2026-05-19 08:29:25.932474', '2026-05-19 08:29:25.932499', 1, 8, 4);
INSERT INTO `feedback_violationreport` VALUES (32, '发现宠物粪便被错误地投入厨余垃圾桶。', '', 'confirmed', '2026-05-19 08:29:25.935268', '2026-05-19 08:29:25.935292', 4, 7, 3);
INSERT INTO `feedback_violationreport` VALUES (33, '有人长期占用投放点空间堆放私人物品。', '', 'pending', '2026-05-19 08:29:25.937763', '2026-05-19 08:29:25.937783', 5, 4, 3);
INSERT INTO `feedback_violationreport` VALUES (34, '发现有人故意破坏投放点设施设备。', '', 'confirmed', '2026-05-19 08:29:25.939807', '2026-05-19 08:29:25.939826', 3, 10, 4);
INSERT INTO `feedback_violationreport` VALUES (38, '有人将大件家具随意丢弃在投放点旁边。', '', 'rejected', '2026-05-19 08:29:25.947518', '2026-05-19 08:29:25.947538', 5, 1, 1);
INSERT INTO `feedback_violationreport` VALUES (39, '有人长期占用投放点空间堆放私人物品。', '', 'rejected', '2026-05-19 08:29:25.949646', '2026-05-19 08:29:25.949667', 3, 10, 5);

-- ----------------------------
-- Table structure for guides_faq
-- ----------------------------
DROP TABLE IF EXISTS `guides_faq`;
CREATE TABLE `guides_faq`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `question` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `answer` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of guides_faq
-- ----------------------------
INSERT INTO `guides_faq` VALUES (1, '什么是垃圾分类？', '垃圾分类是指按照一定规定或标准将垃圾分类储存、分类投放和分类搬运，从而转变成公共资源的一系列活动的总称。', '基础概念', '2026-05-19 08:29:24.938454');
INSERT INTO `guides_faq` VALUES (2, '为什么要进行垃圾分类？', '垃圾分类可以减少环境污染、节约土地资源、再生资源利用，是实现可持续发展的重要举措。', '基础概念', '2026-05-19 08:29:24.941895');
INSERT INTO `guides_faq` VALUES (3, '四种垃圾分别用什么颜色的桶？', '可回收物-蓝色，厨余垃圾-绿色，有害垃圾-红色，其他垃圾-灰色或黑色。', '分类知识', '2026-05-19 08:29:24.943913');
INSERT INTO `guides_faq` VALUES (4, '外卖餐盒属于什么垃圾？', '干净的外卖餐盒属于可回收物；沾有大量油污的建议作为其他垃圾处理。', '分类知识', '2026-05-19 08:29:24.946092');
INSERT INTO `guides_faq` VALUES (5, '用过的纸巾可以回收吗？', '不可以。用过的纸巾已被污染且水溶性差，属于其他垃圾。', '分类知识', '2026-05-19 08:29:24.947991');
INSERT INTO `guides_faq` VALUES (6, '过期药品应该怎么扔？', '过期药品属于有害垃圾，应连同包装一起投入红色的有害垃圾桶。', '有害垃圾', '2026-05-19 08:29:24.949735');
INSERT INTO `guides_faq` VALUES (7, '电池都是有害垃圾吗？', '目前市面上的普通干电池（碱性电池）已实现无汞化，可作为其他垃圾投放；但充电电池、纽扣电池仍属有害垃圾。', '有害垃圾', '2026-05-19 08:29:24.951788');
INSERT INTO `guides_faq` VALUES (8, '宠物粪便算什么垃圾？', '宠物粪便不属于生活垃圾范畴，应冲入马桶或在绿化带掩埋，不应投入任何垃圾桶。', '其他垃圾', '2026-05-19 08:29:24.953525');
INSERT INTO `guides_faq` VALUES (9, '大件家具如何处理？', '大件家具不应投入普通垃圾桶，请联系物业预约上门回收或送往指定的大件垃圾处理点。', '其他垃圾', '2026-05-19 08:29:24.955174');
INSERT INTO `guides_faq` VALUES (10, '积分如何获取？', '通过正确分类投放垃圾可获得积分，不同类型的垃圾分值不同。还可通过参与活动、连续签到等方式获取积分。', '积分规则', '2026-05-19 08:29:24.957606');
INSERT INTO `guides_faq` VALUES (11, '积分可以用来做什么？', '积分可在积分商城兑换各种环保商品和服务，也可用于参与抽奖活动。', '积分规则', '2026-05-19 08:29:24.960191');
INSERT INTO `guides_faq` VALUES (12, '投放时间是什么时候？', '各投放点的开放时间可能不同，一般为早上6:00至晚上22:00，具体请查看投放点详情。', '投放须知', '2026-05-19 08:29:24.962636');
INSERT INTO `guides_faq` VALUES (13, '分类错了怎么办？', '如果发现分类错误，请及时联系现场工作人员协助处理，或自行重新分类后再次投放。', '投放须知', '2026-05-19 08:29:24.965385');
INSERT INTO `guides_faq` VALUES (14, '如何查看我的投放记录？', '登录系统后在\"个人中心\"或\"投放记录\"页面可以查看历史投放记录和获得的积分详情。', '使用帮助', '2026-05-19 08:29:24.967929');
INSERT INTO `guides_faq` VALUES (15, '忘记密码怎么办？', '可以通过注册手机号或邮箱找回密码，也可以联系物业管理员重置密码。', '使用帮助', '2026-05-19 08:29:24.970905');

-- ----------------------------
-- Table structure for guides_guidecategory
-- ----------------------------
DROP TABLE IF EXISTS `guides_guidecategory`;
CREATE TABLE `guides_guidecategory`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of guides_guidecategory
-- ----------------------------
INSERT INTO `guides_guidecategory` VALUES (1, '可回收物指南', '', '2026-05-19 08:29:24.898662');
INSERT INTO `guides_guidecategory` VALUES (2, '厨余垃圾指南', '', '2026-05-19 08:29:24.902160');
INSERT INTO `guides_guidecategory` VALUES (3, '有害垃圾指南', '', '2026-05-19 08:29:24.904014');
INSERT INTO `guides_guidecategory` VALUES (4, '其他垃圾指南', '', '2026-05-19 08:29:24.905795');
INSERT INTO `guides_guidecategory` VALUES (5, '分类技巧', '', '2026-05-19 08:29:24.907452');

-- ----------------------------
-- Table structure for guides_guideitem
-- ----------------------------
DROP TABLE IF EXISTS `guides_guideitem`;
CREATE TABLE `guides_guideitem`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `video_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `category_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `guides_guideitem_category_id_6afd3578_fk_guides_guidecategory_id`(`category_id` ASC) USING BTREE,
  CONSTRAINT `guides_guideitem_category_id_6afd3578_fk_guides_guidecategory_id` FOREIGN KEY (`category_id`) REFERENCES `guides_guidecategory` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of guides_guideitem
-- ----------------------------
INSERT INTO `guides_guideitem` VALUES (1, '纸张类如何正确回收', '报纸、杂志、书本、打印纸等应保持干燥平整，折叠后投入蓝色可回收物容器。避免混入油污或湿水的纸张。', '', '', 1, '2026-05-19 08:29:24.909918', '2026-05-19 08:29:24.909948', 1);
INSERT INTO `guides_guideitem` VALUES (2, '塑料瓶回收前要做什么', '塑料瓶回收前请倒空内容物，简单冲洗干净，压扁后投放。瓶盖和瓶身如材质相同可一起投放。', '', '', 1, '2026-05-19 08:29:24.912310', '2026-05-19 08:29:24.912329', 1);
INSERT INTO `guides_guideitem` VALUES (3, '玻璃制品回收注意事项', '玻璃制品应小心轻放，避免破碎。碎玻璃应用厚纸包裹并标注\"内有碎玻璃\"后再投放。镜子不属于可回收物。', '', '', 1, '2026-05-19 08:29:24.914441', '2026-05-19 08:29:24.914459', 1);
INSERT INTO `guides_guideitem` VALUES (4, '金属罐头的处理方法', '易拉罐、奶粉罐等金属容器需倒空清洗，尽量压扁以节省空间。注意尖锐边缘安全。', '', '', 1, '2026-05-19 08:29:24.916399', '2026-05-19 08:29:24.916417', 1);
INSERT INTO `guides_guideitem` VALUES (5, '厨余垃圾投放要点', '厨余垃圾应沥干水分后投放，去除包装袋。大块骨头、硬壳类物品属于其他垃圾。', '', '', 1, '2026-05-19 08:29:24.918711', '2026-05-19 08:29:24.918732', 2);
INSERT INTO `guides_guideitem` VALUES (6, '常见厨余垃圾清单', '剩饭剩菜、瓜皮果核、蛋壳、茶叶渣、枯枝落叶、宠物饲料等都属于厨余垃圾。', '', '', 1, '2026-05-19 08:29:24.921059', '2026-05-19 08:29:24.921077', 2);
INSERT INTO `guides_guideitem` VALUES (7, '厨余垃圾的处理意义', '厨余垃圾经过专业处理后可转化为有机肥料和生物燃气，实现资源循环利用。', '', '', 1, '2026-05-19 08:29:24.922808', '2026-05-19 08:29:24.922825', 2);
INSERT INTO `guides_guideitem` VALUES (8, '废电池的正确处置', '各类电池（干电池、充电电池、纽扣电池）都属于有害垃圾，请投入红色有害垃圾桶。不要随意丢弃。', '', '', 1, '2026-05-19 08:29:24.924647', '2026-05-19 08:29:24.924676', 3);
INSERT INTO `guides_guideitem` VALUES (9, '过期药品如何处理', '过期药品及其包装应整体投入有害垃圾桶。不要将药品冲入下水道。', '', '', 1, '2026-05-19 08:29:24.926813', '2026-05-19 08:29:24.926833', 3);
INSERT INTO `guides_guideitem` VALUES (10, '灯管和温度计的处理', '荧光灯管、节能灯、水银温度计含汞，属于有害垃圾。破损时需小心处理防止汞泄漏。', '', '', 1, '2026-05-19 08:29:24.928648', '2026-05-19 08:29:24.928664', 3);
INSERT INTO `guides_guideitem` VALUES (11, '其他垃圾包含哪些', '受污染纸张、烟蒂、陶瓷碎片、一次性餐具、卫生巾、尿不湿等都属于其他垃圾。', '', '', 1, '2026-05-19 08:29:24.930329', '2026-05-19 08:29:24.930346', 4);
INSERT INTO `guides_guideitem` VALUES (12, '大件垃圾怎么处理', '家具、家电等大件垃圾不应投入普通垃圾桶，请联系物业或专业回收公司上门处理。', '', '', 1, '2026-05-19 08:29:24.932067', '2026-05-19 08:29:24.932083', 4);
INSERT INTO `guides_guideitem` VALUES (13, '快速分类口诀', '能卖钱的可回收，易腐烂的是厨余，有毒有害单独放，其余全部其他类。', '', '', 1, '2026-05-19 08:29:24.933706', '2026-05-19 08:29:24.933726', 5);
INSERT INTO `guides_guideitem` VALUES (14, '不确定时怎么办', '遇到不确定的垃圾，可以查阅官方分类指南或使用手机扫码查询功能。', '', '', 1, '2026-05-19 08:29:24.935909', '2026-05-19 08:29:24.935927', 5);

-- ----------------------------
-- Table structure for points_sensor
-- ----------------------------
DROP TABLE IF EXISTS `points_sensor`;
CREATE TABLE `points_sensor`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sensor_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sensor_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `last_reading` datetime(6) NULL DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `waste_point_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `points_sensor_waste_point_id_9270af0d_fk_points_wastepoint_id`(`waste_point_id` ASC) USING BTREE,
  CONSTRAINT `points_sensor_waste_point_id_9270af0d_fk_points_wastepoint_id` FOREIGN KEY (`waste_point_id`) REFERENCES `points_wastepoint` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of points_sensor
-- ----------------------------
INSERT INTO `points_sensor` VALUES (1, '湿度传感器', 'SNS-1-001', 1, '2026-04-07 19:07:20.206198', '2026-05-19 08:29:24.796870', 1);
INSERT INTO `points_sensor` VALUES (2, '摄像头', 'SNS-1-002', 1, '2026-04-07 19:02:20.207646', '2026-05-19 08:29:24.799023', 1);
INSERT INTO `points_sensor` VALUES (3, '湿度传感器', 'SNS-1-003', 1, '2026-04-07 19:25:20.208492', '2026-05-19 08:29:24.801164', 1);
INSERT INTO `points_sensor` VALUES (4, '湿度传感器', 'SNS-2-001', 1, '2026-04-07 19:29:20.210536', '2026-05-19 08:29:24.803732', 2);
INSERT INTO `points_sensor` VALUES (5, '摄像头', 'SNS-2-002', 1, '2026-04-07 19:00:20.211468', '2026-05-19 08:29:24.805931', 2);
INSERT INTO `points_sensor` VALUES (6, '摄像头', 'SNS-2-003', 1, '2026-04-07 19:17:20.212167', '2026-05-19 08:29:24.808090', 2);
INSERT INTO `points_sensor` VALUES (7, '湿度传感器', 'SNS-3-001', 1, '2026-04-07 19:01:20.213675', '2026-05-19 08:29:24.810178', 3);
INSERT INTO `points_sensor` VALUES (8, '温度传感器', 'SNS-4-001', 1, '2026-04-07 19:32:20.215009', '2026-05-19 08:29:24.812104', 4);
INSERT INTO `points_sensor` VALUES (9, '满溢传感器', 'SNS-5-001', 1, '2026-04-07 18:28:20.216409', '2026-05-19 08:29:24.814282', 5);
INSERT INTO `points_sensor` VALUES (10, '满溢传感器', 'SNS-6-001', 1, '2026-04-07 19:15:20.218228', '2026-05-19 08:29:24.816532', 6);
INSERT INTO `points_sensor` VALUES (11, '重量传感器', 'SNS-6-002', 1, '2026-04-07 18:36:20.219136', '2026-05-19 08:29:24.819158', 6);
INSERT INTO `points_sensor` VALUES (12, '满溢传感器', 'SNS-6-003', 1, '2026-04-07 19:44:20.219767', '2026-05-19 08:29:24.821837', 6);
INSERT INTO `points_sensor` VALUES (13, '湿度传感器', 'SNS-7-001', 1, '2026-04-07 18:32:20.221708', '2026-05-19 08:29:24.824096', 7);
INSERT INTO `points_sensor` VALUES (14, '温度传感器', 'SNS-7-002', 1, '2026-04-07 19:30:20.222612', '2026-05-19 08:29:24.826076', 7);
INSERT INTO `points_sensor` VALUES (15, '温度传感器', 'SNS-7-003', 1, '2026-04-07 20:02:20.223394', '2026-05-19 08:29:24.827995', 7);
INSERT INTO `points_sensor` VALUES (16, '满溢传感器', 'SNS-8-001', 1, '2026-04-07 18:37:20.225114', '2026-05-19 08:29:24.829884', 8);
INSERT INTO `points_sensor` VALUES (17, '摄像头', 'SNS-8-002', 1, '2026-04-07 19:04:20.225779', '2026-05-19 08:29:24.832291', 8);
INSERT INTO `points_sensor` VALUES (18, '湿度传感器', 'SNS-9-001', 1, '2026-04-07 18:31:20.227262', '2026-05-19 08:29:24.834828', 9);
INSERT INTO `points_sensor` VALUES (19, '满溢传感器', 'SNS-9-002', 1, '2026-04-07 19:52:20.227820', '2026-05-19 08:29:24.836879', 9);
INSERT INTO `points_sensor` VALUES (20, '满溢传感器', 'SNS-9-003', 1, '2026-04-07 18:33:20.228398', '2026-05-19 08:29:24.839289', 9);
INSERT INTO `points_sensor` VALUES (21, '重量传感器', 'SNS-10-001', 1, '2026-04-07 18:43:20.230231', '2026-05-19 08:29:24.841263', 10);
INSERT INTO `points_sensor` VALUES (22, '湿度传感器', 'SNS-10-002', 1, '2026-04-07 19:24:20.230798', '2026-05-19 08:29:24.843210', 10);

-- ----------------------------
-- Table structure for points_wastepoint
-- ----------------------------
DROP TABLE IF EXISTS `points_wastepoint`;
CREATE TABLE `points_wastepoint`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `latitude` double NULL DEFAULT NULL,
  `longitude` double NULL DEFAULT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `capacity` int NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `open_time` time(6) NULL DEFAULT NULL,
  `close_time` time(6) NULL DEFAULT NULL,
  `last_cleaned` datetime(6) NULL DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `accepted_categories` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `current_fill` double NOT NULL,
  `fill_level` int NOT NULL,
  `next_cleanup` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of points_wastepoint
-- ----------------------------
INSERT INTO `points_wastepoint` VALUES (1, '小区东门投放点', '小区东门入口处', 39.90968603541304, 116.4263346898238, '智能回收站', 200, 'normal', '06:00:00.192101', '22:00:00.192124', '2026-03-31 20:24:20.192125', '2026-05-19 08:29:24.772322', '2026-05-19 23:34:21.871750', '可回收物,厨余垃圾,有害垃圾,其他垃圾', 61.1, 30, '2026-04-08 20:24:20.192136');
INSERT INTO `points_wastepoint` VALUES (2, '1号楼投放点', '1号楼楼下北侧', 39.89701477202256, 116.39591457986225, '标准分类桶', 100, 'normal', '06:00:00.209234', '22:00:00.209238', '2026-04-06 20:24:20.209239', '2026-05-19 08:29:24.774827', '2026-05-19 08:29:24.774837', '可回收物,厨余垃圾,有害垃圾,其他垃圾', 65, 65, '2026-04-10 20:24:20.209251');
INSERT INTO `points_wastepoint` VALUES (3, '2号楼投放点', '2号楼楼下南侧', 39.91732922305767, 116.39063028364927, '标准分类桶', 100, 'warning', '06:00:00.212737', '22:00:00.212740', '2026-03-31 20:24:20.212741', '2026-05-19 08:29:24.777504', '2026-05-20 00:48:57.112480', '可回收物,厨余垃圾,有害垃圾,其他垃圾', 188, 88, '2026-04-11 20:24:20.212752');
INSERT INTO `points_wastepoint` VALUES (4, '3号楼投放点', '3号楼楼下东侧', 39.91452249755131, 116.41992214713477, '智能回收站', 150, 'normal', '06:00:00.214221', '22:00:00.214226', '2026-04-02 20:24:20.214226', '2026-05-19 08:29:24.779777', '2026-05-19 08:29:24.779787', '可回收物,厨余垃圾,有害垃圾,其他垃圾', 63, 42, '2026-04-11 20:24:20.214237');
INSERT INTO `points_wastepoint` VALUES (5, '4号楼投放点', '4号楼楼下西侧', 39.89410213554788, 116.40956394437544, '标准分类桶', 100, 'warning', '06:00:00.215535', '22:00:00.215538', '2026-03-31 20:24:20.215539', '2026-05-19 08:29:24.781928', '2026-05-19 08:29:24.781938', '可回收物,厨余垃圾,有害垃圾,其他垃圾', 55, 55, '2026-04-12 20:24:20.215548');
INSERT INTO `points_wastepoint` VALUES (6, '中心花园投放点', '社区中心花园旁', 39.89887904511537, 116.42165201044328, '大型分类站', 300, 'normal', '06:00:00.217155', '22:00:00.217159', '2026-04-01 20:24:20.217160', '2026-05-19 08:29:24.784453', '2026-05-19 08:29:24.784464', '可回收物,厨余垃圾,有害垃圾,其他垃圾', 84, 28, '2026-04-11 20:24:20.217172');
INSERT INTO `points_wastepoint` VALUES (7, '西门投放点', '小区西门出口处', 39.91960523304725, 116.42697581948318, '标准分类桶', 80, 'normal', '06:00:00.220692', '22:00:00.220696', '2026-04-03 20:24:20.220697', '2026-05-19 08:29:24.787349', '2026-05-19 08:29:24.787367', '可回收物,厨余垃圾,有害垃圾,其他垃圾', 57.6, 72, '2026-04-10 20:24:20.220709');
INSERT INTO `points_wastepoint` VALUES (8, '北门投放点', '小区北门停车场旁', 39.91814693523199, 116.40553183089081, '智能回收站', 180, 'normal', '06:00:00.224121', '22:00:00.224126', '2026-04-04 20:24:20.224127', '2026-05-19 08:29:24.789848', '2026-05-19 08:29:24.789859', '可回收物,厨余垃圾,有害垃圾,其他垃圾', 81, 45, '2026-04-09 20:24:20.224140');
INSERT INTO `points_wastepoint` VALUES (9, '幼儿园投放点', '社区幼儿园门口', 39.899631960331966, 116.3765143386701, '小型分类点', 60, 'normal', '06:00:00.226363', '22:00:00.226367', '2026-04-01 20:24:20.226368', '2026-05-19 08:29:24.792011', '2026-05-19 08:29:24.792022', '可回收物,厨余垃圾,有害垃圾,其他垃圾', 21, 35, '2026-04-09 20:24:20.226382');
INSERT INTO `points_wastepoint` VALUES (10, '物业楼投放点', '物业管理处旁边', 39.885645548022524, 116.38611812846871, '综合分类站', 250, 'normal', '06:00:00.229148', '22:00:00.229153', '2026-04-07 20:24:20.229154', '2026-05-19 08:29:24.794286', '2026-05-19 08:29:24.794296', '可回收物,厨余垃圾,有害垃圾,其他垃圾', 50, 20, '2026-04-08 20:24:20.229164');

-- ----------------------------
-- Table structure for products_order
-- ----------------------------
DROP TABLE IF EXISTS `products_order`;
CREATE TABLE `products_order`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int NOT NULL,
  `total_points` int NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `product_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `products_order_product_id_a3214026_fk_products_product_id`(`product_id` ASC) USING BTREE,
  INDEX `products_order_user_id_dfb540d8_fk_users_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `products_order_product_id_a3214026_fk_products_product_id` FOREIGN KEY (`product_id`) REFERENCES `products_product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `products_order_user_id_dfb540d8_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 141 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products_order
-- ----------------------------
INSERT INTO `products_order` VALUES (1, 3, 60, 'completed', '2026-05-19 08:29:25.373490', '2026-05-19 08:29:25.373513', 3, 3);
INSERT INTO `products_order` VALUES (2, 1, 70, 'completed', '2026-05-19 08:29:25.376142', '2026-05-19 08:29:25.376162', 11, 1);
INSERT INTO `products_order` VALUES (3, 3, 600, 'completed', '2026-05-19 08:29:25.378183', '2026-05-19 08:29:25.378204', 15, 1);
INSERT INTO `products_order` VALUES (5, 3, 450, 'completed', '2026-05-19 08:29:25.381900', '2026-05-19 08:29:25.381921', 12, 3);
INSERT INTO `products_order` VALUES (6, 1, 80, 'cancelled', '2026-05-19 08:29:25.384195', '2026-05-19 08:29:25.384216', 2, 1);
INSERT INTO `products_order` VALUES (7, 2, 180, 'completed', '2026-05-19 08:29:25.386625', '2026-05-19 08:29:25.386646', 9, 4);
INSERT INTO `products_order` VALUES (8, 3, 300, 'cancelled', '2026-05-19 08:29:25.388916', '2026-05-19 08:29:25.388937', 4, 4);
INSERT INTO `products_order` VALUES (11, 3, 180, 'pending', '2026-05-19 08:29:25.395417', '2026-05-19 08:29:25.395438', 8, 5);
INSERT INTO `products_order` VALUES (12, 2, 60, 'pending', '2026-05-19 08:29:25.397720', '2026-05-19 08:29:25.397739', 7, 5);
INSERT INTO `products_order` VALUES (13, 2, 90, 'completed', '2026-05-19 08:29:25.399542', '2026-05-19 08:29:25.399566', 10, 5);
INSERT INTO `products_order` VALUES (14, 3, 600, 'completed', '2026-05-19 08:29:25.402341', '2026-05-19 08:29:25.402361', 5, 5);
INSERT INTO `products_order` VALUES (15, 2, 180, 'completed', '2026-05-19 08:29:25.404416', '2026-05-19 08:29:25.404441', 9, 5);
INSERT INTO `products_order` VALUES (17, 1, 70, 'completed', '2026-05-19 08:29:25.408742', '2026-05-19 08:29:25.408764', 11, 4);
INSERT INTO `products_order` VALUES (18, 2, 100, 'completed', '2026-05-19 08:29:25.410967', '2026-05-19 08:29:25.410987', 1, 3);
INSERT INTO `products_order` VALUES (19, 3, 75, 'cancelled', '2026-05-19 08:29:25.413097', '2026-05-19 08:29:25.413120', 14, 5);
INSERT INTO `products_order` VALUES (20, 1, 25, 'completed', '2026-05-19 08:29:25.415446', '2026-05-19 08:29:25.415467', 14, 1);
INSERT INTO `products_order` VALUES (21, 1, 70, 'pending', '2026-05-19 08:29:25.417505', '2026-05-19 08:29:25.417527', 11, 1);
INSERT INTO `products_order` VALUES (22, 2, 90, 'cancelled', '2026-05-19 08:29:25.419963', '2026-05-19 08:29:25.419984', 10, 5);
INSERT INTO `products_order` VALUES (25, 2, 80, 'pending', '2026-05-19 08:29:25.425981', '2026-05-19 08:29:25.426001', 6, 3);
INSERT INTO `products_order` VALUES (26, 2, 400, 'completed', '2026-05-19 08:29:25.428209', '2026-05-19 08:29:25.428239', 5, 3);
INSERT INTO `products_order` VALUES (27, 2, 120, 'pending', '2026-05-19 08:29:25.430335', '2026-05-19 08:29:25.430360', 8, 1);
INSERT INTO `products_order` VALUES (28, 2, 180, 'pending', '2026-05-19 08:29:25.432548', '2026-05-19 08:29:25.432572', 9, 3);
INSERT INTO `products_order` VALUES (29, 1, 30, 'completed', '2026-05-19 08:29:25.434861', '2026-05-19 08:29:25.434881', 7, 5);
INSERT INTO `products_order` VALUES (30, 3, 135, 'completed', '2026-05-19 08:29:25.436953', '2026-05-19 08:29:25.436973', 10, 4);
INSERT INTO `products_order` VALUES (31, 2, 80, 'completed', '2026-05-19 08:29:25.439457', '2026-05-19 08:29:25.439477', 6, 5);
INSERT INTO `products_order` VALUES (32, 3, 600, 'pending', '2026-05-19 08:29:25.441515', '2026-05-19 08:29:25.441536', 5, 5);
INSERT INTO `products_order` VALUES (33, 3, 210, 'pending', '2026-05-19 08:29:25.443483', '2026-05-19 08:29:25.443500', 11, 4);
INSERT INTO `products_order` VALUES (34, 2, 80, 'completed', '2026-05-19 08:29:25.445477', '2026-05-19 08:29:25.445493', 6, 1);
INSERT INTO `products_order` VALUES (35, 1, 200, 'completed', '2026-05-19 08:29:25.447119', '2026-05-19 08:29:25.447134', 5, 4);
INSERT INTO `products_order` VALUES (36, 2, 400, 'completed', '2026-05-19 08:29:25.448787', '2026-05-19 08:29:25.448803', 15, 3);
INSERT INTO `products_order` VALUES (37, 1, 70, 'cancelled', '2026-05-19 08:29:25.450576', '2026-05-19 08:29:25.450592', 11, 5);
INSERT INTO `products_order` VALUES (38, 2, 60, 'pending', '2026-05-19 08:29:25.453264', '2026-05-19 08:29:25.453284', 7, 3);
INSERT INTO `products_order` VALUES (39, 2, 50, 'pending', '2026-05-19 08:29:25.455258', '2026-05-19 08:29:25.455276', 14, 4);
INSERT INTO `products_order` VALUES (41, 3, 60, 'completed', '2026-05-19 08:29:25.458269', '2026-05-19 08:29:25.458285', 3, 4);
INSERT INTO `products_order` VALUES (42, 1, 200, 'completed', '2026-05-19 08:29:25.460301', '2026-05-19 08:29:25.460320', 15, 4);
INSERT INTO `products_order` VALUES (43, 3, 450, 'pending', '2026-05-19 08:29:25.462099', '2026-05-19 08:29:25.462114', 12, 1);
INSERT INTO `products_order` VALUES (44, 3, 135, 'cancelled', '2026-05-19 08:29:25.463739', '2026-05-19 08:29:25.463754', 10, 5);
INSERT INTO `products_order` VALUES (45, 3, 300, 'completed', '2026-05-19 08:29:25.465369', '2026-05-19 08:29:25.465386', 4, 1);
INSERT INTO `products_order` VALUES (46, 2, 160, 'completed', '2026-05-19 08:29:25.466910', '2026-05-19 08:29:25.466924', 2, 4);
INSERT INTO `products_order` VALUES (47, 1, 45, 'completed', '2026-05-19 08:29:25.469154', '2026-05-19 08:29:25.469188', 10, 4);
INSERT INTO `products_order` VALUES (48, 2, 400, 'completed', '2026-05-19 08:29:25.471506', '2026-05-19 08:29:25.471526', 5, 4);
INSERT INTO `products_order` VALUES (49, 1, 50, 'pending', '2026-05-19 08:29:25.473498', '2026-05-19 08:29:25.473518', 1, 3);
INSERT INTO `products_order` VALUES (50, 3, 300, 'cancelled', '2026-05-19 08:29:25.475410', '2026-05-19 08:29:25.475430', 4, 5);
INSERT INTO `products_order` VALUES (51, 3, 180, 'cancelled', '2026-05-19 08:29:25.477293', '2026-05-19 08:29:25.477312', 8, 5);
INSERT INTO `products_order` VALUES (52, 2, 80, 'completed', '2026-05-19 08:29:25.479082', '2026-05-19 08:29:25.479102', 6, 5);
INSERT INTO `products_order` VALUES (53, 2, 60, 'pending', '2026-05-19 08:29:25.481220', '2026-05-19 08:29:25.481240', 7, 3);
INSERT INTO `products_order` VALUES (54, 2, 400, 'cancelled', '2026-05-19 08:29:25.483239', '2026-05-19 08:29:25.483259', 5, 5);
INSERT INTO `products_order` VALUES (57, 3, 450, 'completed', '2026-05-19 08:29:25.490233', '2026-05-19 08:29:25.490255', 12, 4);
INSERT INTO `products_order` VALUES (58, 2, 400, 'pending', '2026-05-19 08:29:25.492387', '2026-05-19 08:29:25.492408', 15, 3);
INSERT INTO `products_order` VALUES (59, 1, 60, 'pending', '2026-05-19 08:29:25.494465', '2026-05-19 08:29:25.494485', 8, 3);
INSERT INTO `products_order` VALUES (60, 3, 210, 'completed', '2026-05-19 08:29:25.496489', '2026-05-19 08:29:25.496509', 11, 1);
INSERT INTO `products_order` VALUES (61, 1, 180, 'cancelled', '2026-05-19 08:29:25.498331', '2026-05-19 08:29:25.498350', 13, 3);
INSERT INTO `products_order` VALUES (64, 3, 270, 'completed', '2026-05-19 08:29:25.504615', '2026-05-19 08:29:25.504638', 9, 1);
INSERT INTO `products_order` VALUES (65, 1, 100, 'completed', '2026-05-19 08:29:25.506680', '2026-05-19 08:29:25.506700', 4, 4);
INSERT INTO `products_order` VALUES (66, 3, 60, 'pending', '2026-05-19 08:29:25.508523', '2026-05-19 08:29:25.508543', 3, 4);
INSERT INTO `products_order` VALUES (67, 3, 60, 'completed', '2026-05-19 08:29:25.510338', '2026-05-19 08:29:25.510357', 3, 3);
INSERT INTO `products_order` VALUES (68, 2, 200, 'completed', '2026-05-19 08:29:25.512196', '2026-05-19 08:29:25.512215', 4, 1);
INSERT INTO `products_order` VALUES (69, 2, 100, 'completed', '2026-05-19 08:29:25.514102', '2026-05-19 08:29:25.514122', 1, 1);
INSERT INTO `products_order` VALUES (70, 3, 135, 'completed', '2026-05-19 08:29:25.516457', '2026-05-19 08:29:25.516480', 10, 5);
INSERT INTO `products_order` VALUES (71, 2, 60, 'cancelled', '2026-05-19 08:29:25.518720', '2026-05-19 08:29:25.518740', 7, 4);
INSERT INTO `products_order` VALUES (72, 3, 60, 'pending', '2026-05-19 08:29:25.520914', '2026-05-19 08:29:25.520934', 3, 4);
INSERT INTO `products_order` VALUES (73, 3, 540, 'cancelled', '2026-05-19 08:29:25.522811', '2026-05-19 08:29:25.522832', 13, 3);
INSERT INTO `products_order` VALUES (74, 1, 60, 'pending', '2026-05-19 08:29:25.524937', '2026-05-19 08:29:25.524957', 8, 3);
INSERT INTO `products_order` VALUES (77, 2, 300, 'pending', '2026-05-19 08:29:25.530401', '2026-05-19 08:29:25.530423', 12, 1);
INSERT INTO `products_order` VALUES (78, 3, 120, 'completed', '2026-05-19 08:29:25.532624', '2026-05-19 08:29:25.532643', 6, 5);
INSERT INTO `products_order` VALUES (79, 2, 100, 'completed', '2026-05-19 08:29:25.534703', '2026-05-19 08:29:25.534723', 1, 4);
INSERT INTO `products_order` VALUES (80, 1, 20, 'pending', '2026-05-19 08:29:25.536918', '2026-05-19 08:29:25.536938', 3, 3);
INSERT INTO `products_order` VALUES (81, 1, 400, 'paid', '2026-05-19 08:37:24.985725', '2026-05-19 08:37:24.985748', 5, 15);
INSERT INTO `products_order` VALUES (82, 2, 700, 'delivered', '2026-05-19 08:37:24.988263', '2026-05-19 08:37:24.988286', 17, 13);
INSERT INTO `products_order` VALUES (83, 1, 240, 'shipped', '2026-05-19 08:37:24.990184', '2026-05-19 08:37:24.990205', 21, 8);
INSERT INTO `products_order` VALUES (84, 2, 180, 'pending', '2026-05-19 08:37:24.992430', '2026-05-19 08:37:24.992452', 13, 4);
INSERT INTO `products_order` VALUES (85, 1, 50, 'pending', '2026-05-19 08:37:24.994271', '2026-05-19 08:37:24.994288', 14, 4);
INSERT INTO `products_order` VALUES (86, 2, 150, 'paid', '2026-05-19 08:37:24.996127', '2026-05-19 08:37:24.996154', 1, 11);
INSERT INTO `products_order` VALUES (87, 3, 120, 'pending', '2026-05-19 08:37:24.998466', '2026-05-19 08:37:24.998486', 8, 9);
INSERT INTO `products_order` VALUES (88, 3, 1350, 'paid', '2026-05-19 08:37:25.000621', '2026-05-19 08:37:25.000640', 19, 13);
INSERT INTO `products_order` VALUES (89, 3, 880, 'shipped', '2026-05-19 08:37:25.002401', '2026-05-19 08:37:25.002418', 16, 8);
INSERT INTO `products_order` VALUES (90, 3, 2640, 'delivered', '2026-05-19 08:37:25.004395', '2026-05-19 08:37:25.004425', 16, 7);
INSERT INTO `products_order` VALUES (91, 1, 360, 'shipped', '2026-05-19 08:37:25.006066', '2026-05-19 08:37:25.006092', 21, 10);
INSERT INTO `products_order` VALUES (92, 2, 180, 'shipped', '2026-05-19 08:37:25.008204', '2026-05-19 08:37:25.008223', 8, 11);
INSERT INTO `products_order` VALUES (93, 2, 90, 'delivered', '2026-05-19 08:37:25.010232', '2026-05-19 08:37:25.010253', 10, 5);
INSERT INTO `products_order` VALUES (94, 3, 135, 'paid', '2026-05-19 08:37:25.012438', '2026-05-19 08:37:25.012460', 10, 10);
INSERT INTO `products_order` VALUES (95, 1, 80, 'paid', '2026-05-19 08:37:25.014665', '2026-05-19 08:37:25.014689', 2, 1);
INSERT INTO `products_order` VALUES (96, 2, 1280, 'delivered', '2026-05-19 08:37:25.017007', '2026-05-19 08:37:25.017027', 18, 8);
INSERT INTO `products_order` VALUES (97, 2, 3840, 'pending', '2026-05-19 08:37:25.018948', '2026-05-19 08:37:25.018968', 18, 15);
INSERT INTO `products_order` VALUES (98, 1, 200, 'delivered', '2026-05-19 08:37:25.021150', '2026-05-19 08:37:25.021172', 5, 8);
INSERT INTO `products_order` VALUES (99, 3, 40, 'paid', '2026-05-19 08:37:25.023290', '2026-05-19 08:37:25.023310', 3, 6);
INSERT INTO `products_order` VALUES (100, 2, 400, 'pending', '2026-05-19 08:37:25.025190', '2026-05-19 08:37:25.025210', 15, 9);
INSERT INTO `products_order` VALUES (101, 2, 160, 'pending', '2026-05-19 08:37:25.027700', '2026-05-19 08:37:25.027721', 2, 9);
INSERT INTO `products_order` VALUES (102, 2, 2560, 'paid', '2026-05-19 08:37:25.029670', '2026-05-19 08:37:25.029693', 18, 1);
INSERT INTO `products_order` VALUES (103, 1, 80, 'pending', '2026-05-19 08:37:25.031988', '2026-05-19 08:37:25.032013', 6, 7);
INSERT INTO `products_order` VALUES (104, 2, 150, 'delivered', '2026-05-19 08:37:25.034386', '2026-05-19 08:37:25.034409', 12, 1);
INSERT INTO `products_order` VALUES (105, 3, 150, 'pending', '2026-05-19 08:37:25.036487', '2026-05-19 08:37:25.036509', 12, 13);
INSERT INTO `products_order` VALUES (106, 3, 150, 'shipped', '2026-05-19 08:37:25.038431', '2026-05-19 08:37:25.038452', 1, 3);
INSERT INTO `products_order` VALUES (107, 1, 45, 'shipped', '2026-05-19 08:37:25.040282', '2026-05-19 08:37:25.040301', 10, 15);
INSERT INTO `products_order` VALUES (108, 1, 3840, 'delivered', '2026-05-19 08:37:25.042299', '2026-05-19 08:37:25.042320', 18, 9);
INSERT INTO `products_order` VALUES (109, 3, 75, 'paid', '2026-05-19 08:37:25.044145', '2026-05-19 08:37:25.044165', 14, 9);
INSERT INTO `products_order` VALUES (110, 1, 180, 'shipped', '2026-05-19 08:37:25.046315', '2026-05-19 08:37:25.046339', 13, 6);
INSERT INTO `products_order` VALUES (111, 1, 60, 'shipped', '2026-05-19 08:38:59.604814', '2026-05-19 08:38:59.604834', 7, 3);
INSERT INTO `products_order` VALUES (112, 2, 540, 'shipped', '2026-05-19 08:38:59.607039', '2026-05-19 08:38:59.607060', 13, 5);
INSERT INTO `products_order` VALUES (113, 3, 25, 'paid', '2026-05-19 08:38:59.609168', '2026-05-19 08:38:59.609199', 14, 15);
INSERT INTO `products_order` VALUES (114, 1, 45, 'delivered', '2026-05-19 08:38:59.612564', '2026-05-19 08:38:59.612593', 10, 8);
INSERT INTO `products_order` VALUES (115, 2, 45, 'pending', '2026-05-19 08:38:59.614828', '2026-05-19 08:38:59.614849', 10, 11);
INSERT INTO `products_order` VALUES (116, 3, 840, 'paid', '2026-05-19 08:38:59.616814', '2026-05-19 08:38:59.616835', 20, 4);
INSERT INTO `products_order` VALUES (117, 2, 360, 'delivered', '2026-05-19 08:38:59.618793', '2026-05-19 08:38:59.618814', 13, 8);
INSERT INTO `products_order` VALUES (118, 3, 240, 'delivered', '2026-05-19 08:38:59.620693', '2026-05-19 08:38:59.620715', 2, 5);
INSERT INTO `products_order` VALUES (119, 1, 880, 'shipped', '2026-05-19 08:38:59.622922', '2026-05-19 08:38:59.622944', 16, 9);
INSERT INTO `products_order` VALUES (120, 2, 3840, 'paid', '2026-05-19 08:38:59.625135', '2026-05-19 08:38:59.625166', 18, 3);
INSERT INTO `products_order` VALUES (121, 1, 100, 'shipped', '2026-05-19 08:38:59.627371', '2026-05-19 08:38:59.627392', 1, 3);
INSERT INTO `products_order` VALUES (122, 3, 60, 'shipped', '2026-05-19 08:38:59.629964', '2026-05-19 08:38:59.629985', 3, 15);
INSERT INTO `products_order` VALUES (123, 3, 2640, 'paid', '2026-05-19 08:38:59.632385', '2026-05-19 08:38:59.632410', 16, 12);
INSERT INTO `products_order` VALUES (124, 3, 25, 'delivered', '2026-05-19 08:38:59.634349', '2026-05-19 08:38:59.634370', 14, 14);
INSERT INTO `products_order` VALUES (125, 2, 90, 'pending', '2026-05-19 08:38:59.636307', '2026-05-19 08:38:59.636327', 10, 1);
INSERT INTO `products_order` VALUES (126, 2, 60, 'shipped', '2026-05-19 08:38:59.638311', '2026-05-19 08:38:59.638332', 3, 11);
INSERT INTO `products_order` VALUES (127, 3, 60, 'shipped', '2026-05-19 08:38:59.640387', '2026-05-19 08:38:59.640414', 3, 3);
INSERT INTO `products_order` VALUES (128, 2, 200, 'pending', '2026-05-19 08:38:59.643470', '2026-05-19 08:38:59.643494', 5, 15);
INSERT INTO `products_order` VALUES (129, 3, 1350, 'pending', '2026-05-19 08:38:59.646106', '2026-05-19 08:38:59.646133', 19, 8);
INSERT INTO `products_order` VALUES (130, 1, 90, 'pending', '2026-05-19 08:38:59.649761', '2026-05-19 08:38:59.649786', 9, 6);
INSERT INTO `products_order` VALUES (131, 3, 840, 'pending', '2026-05-19 08:38:59.652746', '2026-05-19 08:38:59.652768', 20, 13);
INSERT INTO `products_order` VALUES (132, 2, 180, 'delivered', '2026-05-19 08:38:59.655947', '2026-05-19 08:38:59.656011', 8, 11);
INSERT INTO `products_order` VALUES (133, 3, 600, 'shipped', '2026-05-19 08:38:59.659166', '2026-05-19 08:38:59.659192', 5, 3);
INSERT INTO `products_order` VALUES (134, 2, 30, 'delivered', '2026-05-19 08:38:59.663209', '2026-05-19 08:38:59.663243', 7, 11);
INSERT INTO `products_order` VALUES (135, 2, 210, 'delivered', '2026-05-19 08:38:59.666608', '2026-05-19 08:38:59.666630', 11, 9);
INSERT INTO `products_order` VALUES (136, 1, 75, 'pending', '2026-05-19 08:38:59.669280', '2026-05-19 08:38:59.669302', 14, 12);
INSERT INTO `products_order` VALUES (137, 1, 135, 'paid', '2026-05-19 08:38:59.671482', '2026-05-19 08:38:59.671506', 10, 6);
INSERT INTO `products_order` VALUES (138, 3, 600, 'pending', '2026-05-19 08:38:59.674210', '2026-05-19 08:38:59.674231', 5, 5);
INSERT INTO `products_order` VALUES (139, 2, 350, 'delivered', '2026-05-19 08:38:59.676819', '2026-05-19 08:38:59.676840', 17, 13);
INSERT INTO `products_order` VALUES (140, 2, 240, 'pending', '2026-05-19 08:38:59.679370', '2026-05-19 08:38:59.679393', 21, 15);

-- ----------------------------
-- Table structure for products_product
-- ----------------------------
DROP TABLE IF EXISTS `products_product`;
CREATE TABLE `products_product`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `price` int NOT NULL,
  `stock` int NOT NULL,
  `image_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `points_required` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products_product
-- ----------------------------
INSERT INTO `products_product` VALUES (1, '环保购物袋', '可重复使用的环保帆布购物袋，结实耐用', 8, 200, '', 1, '2026-05-19 08:29:24.845589', '2026-05-19 08:29:24.845612', 50);
INSERT INTO `products_product` VALUES (2, '便携餐具套装', '不锈钢筷子+勺子+叉子三件套', 12, 150, '', 1, '2026-05-19 08:29:24.848101', '2026-05-19 08:29:24.848123', 80);
INSERT INTO `products_product` VALUES (3, '垃圾分类贴纸', '四色分类标识贴纸一套', 3, 500, '', 1, '2026-05-19 08:29:24.850126', '2026-05-19 08:29:24.850146', 20);
INSERT INTO `products_product` VALUES (4, '有机肥料', '厨余堆肥制成的有机花肥500g', 15, 80, '', 1, '2026-05-19 08:29:24.852152', '2026-05-19 08:29:24.852171', 100);
INSERT INTO `products_product` VALUES (5, '环保水杯', '304不锈钢保温杯500ml', 35, 60, '', 1, '2026-05-19 08:29:24.854217', '2026-05-19 08:29:24.854237', 200);
INSERT INTO `products_product` VALUES (6, '竹制牙刷', '天然竹柄软毛牙刷10支装', 6, 300, '', 1, '2026-05-19 08:29:24.856308', '2026-05-19 08:29:24.856342', 40);
INSERT INTO `products_product` VALUES (7, '垃圾分类指南手册', '图文并茂的分类指导手册', 5, 400, '', 1, '2026-05-19 08:29:24.858399', '2026-05-19 08:29:24.858419', 30);
INSERT INTO `products_product` VALUES (8, '可降解垃圾袋', 'PLA材质中号垃圾袋100只', 10, 250, '', 1, '2026-05-19 08:29:24.860243', '2026-05-19 08:29:24.860262', 60);
INSERT INTO `products_product` VALUES (9, '植物种子包', '蔬菜/花卉混合种子礼包', 14, 120, '', 1, '2026-05-19 08:29:24.862200', '2026-05-19 08:29:24.862223', 90);
INSERT INTO `products_product` VALUES (10, '环保笔记本', '再生纸制作的记事本', 7, 180, '', 1, '2026-05-19 08:29:24.865170', '2026-05-19 08:29:24.865190', 45);
INSERT INTO `products_product` VALUES (11, 'LED节能灯泡', '5W暖白光LED灯泡', 11, 130, '', 1, '2026-05-19 08:29:24.867161', '2026-05-19 08:29:24.867180', 70);
INSERT INTO `products_product` VALUES (12, '垃圾分类游戏棋', '亲子互动垃圾分类教育玩具', 22, 40, '', 1, '2026-05-19 08:29:24.869410', '2026-05-19 08:29:24.869431', 150);
INSERT INTO `products_product` VALUES (13, '手提编织篮', '天然藤编手提篮', 28, 50, '', 1, '2026-05-19 08:29:24.871423', '2026-05-19 08:29:24.871443', 180);
INSERT INTO `products_product` VALUES (14, '除味炭包', '活性炭除味包200g', 4, 350, '', 1, '2026-05-19 08:29:24.873542', '2026-05-19 08:29:24.873562', 25);
INSERT INTO `products_product` VALUES (15, '积分兑换券', '合作商家通用优惠券', 0, 100, '', 1, '2026-05-19 08:29:24.875507', '2026-05-19 08:29:24.875527', 200);
INSERT INTO `products_product` VALUES (16, '有机蔬菜礼盒', '新鲜有机蔬菜，健康生活从餐桌开始', 88, 50, NULL, 1, '2026-05-19 08:35:09.730531', '2026-05-19 08:35:09.730565', 880);
INSERT INTO `products_product` VALUES (17, '绿植盆栽', '净化空气的绿色植物，美化家居环境', 35, 30, NULL, 1, '2026-05-19 08:35:09.734510', '2026-05-19 08:35:09.734531', 350);
INSERT INTO `products_product` VALUES (18, '太阳能充电宝', '环保充电设备，利用太阳能充电', 128, 20, NULL, 1, '2026-05-19 08:35:09.738288', '2026-05-19 08:35:09.738311', 1280);
INSERT INTO `products_product` VALUES (19, '竹制餐具套装', '天然竹制餐具，可降解环保材料', 45, 80, NULL, 1, '2026-05-19 08:35:09.741774', '2026-05-19 08:35:09.741811', 450);
INSERT INTO `products_product` VALUES (20, '环保洗衣液', '无磷无荧光剂，保护环境', 28, 60, NULL, 1, '2026-05-19 08:35:09.745668', '2026-05-19 08:35:09.745688', 280);
INSERT INTO `products_product` VALUES (21, '种子礼包', '包含多种蔬菜和花卉种子', 12, 150, NULL, 1, '2026-05-19 08:35:09.748569', '2026-05-19 08:35:09.748589', 120);

-- ----------------------------
-- Table structure for users_house
-- ----------------------------
DROP TABLE IF EXISTS `users_house`;
CREATE TABLE `users_house`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `building` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `room` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_verified` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `users_house_user_id_c7c6bd68_fk_users_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `users_house_user_id_c7c6bd68_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users_house
-- ----------------------------

-- ----------------------------
-- Table structure for users_user
-- ----------------------------
DROP TABLE IF EXISTS `users_user`;
CREATE TABLE `users_user`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `wechat_openid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `family_members` int NULL DEFAULT NULL,
  `points` int NOT NULL,
  `level` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users_user
-- ----------------------------
INSERT INTO `users_user` VALUES (1, 'pbkdf2_sha256$600000$Vsg5Lkk7Btr73nXSazH858$hfoC/jB18obKGVTJFpoTmADF96rCe10LDANO6sN+XJE=', '2026-06-03 01:30:35.716683', 1, 'admin', '', '', '1962475042@qq.com', 1, '2026-05-19 08:17:47.174849', 'resident', NULL, NULL, 1, 0, '新手', 1, '2026-05-19 08:17:47.523378', '2026-05-19 08:17:47.523392');
INSERT INTO `users_user` VALUES (3, 'pbkdf2_sha256$600000$Goq4jxC4GEk6nCy85Tv8sO$x3sRbqD9Q8vKzLfDuj3j4EYX2CRtEK930v2+wkFb8JM=', NULL, 0, '王学文', '', '', '1962475042@qq.com', 0, '2026-04-02 11:37:13.792404', 'resident', '19189964166', NULL, 1, 0, '新手', 1, '2026-05-19 08:29:24.748764', '2026-05-19 08:29:24.748774');
INSERT INTO `users_user` VALUES (4, 'pbkdf2_sha256$600000$nz2M7DHK7TFEVoSDVx91ta$MkOh7yv7wNwIx71KGHOl23nsq1QT52Hd+kf+78MRGxA=', NULL, 0, '邓莹', '', '', '1962475042@qq.com', 0, '2026-04-02 11:40:14.087458', 'resident', '12345678910', NULL, 1, 0, '新手', 1, '2026-05-19 08:29:24.751766', '2026-05-19 08:29:24.751777');
INSERT INTO `users_user` VALUES (5, 'pbkdf2_sha256$600000$DmdlvdYzimHJQBwcukYcPt$cA6tsmSvEkXkD1NqnbzBF9rIOgb1iohjcc6K9eu0bck=', NULL, 0, '王靖雯', '', '', '1962475142@qq.com', 0, '2026-04-06 10:22:14.559575', 'resident', '13113111313', NULL, 1, 0, '新手', 1, '2026-05-19 08:29:24.754010', '2026-05-19 08:29:24.754021');
INSERT INTO `users_user` VALUES (6, 'pbkdf2_sha256$600000$107oizAs3rqu9NTNdphTL8$TZIE0gBP5nwsAj5zo98qezZsh9tH88ze1iHniQsbi4A=', NULL, 0, '雷玉琴', '', '', '1962475041@qq.com', 0, '2026-04-06 12:42:21.355285', 'resident', '13113111310', NULL, 1, 0, '新手', 1, '2026-05-19 08:29:24.756795', '2026-05-19 08:29:24.756806');
INSERT INTO `users_user` VALUES (7, 'pbkdf2_sha256$600000$2d1D1Wq0sJrMhlTCJyfDqg$s3MAwG4qgtzsrsOjvhDe/C5rGo5ul2JN8M5mLrWWfqA=', NULL, 1, '我爱你', '', '', '1234567890@qq.com', 1, '2026-04-22 14:00:42.271206', 'resident', NULL, NULL, 1, 0, '新手', 1, '2026-05-19 08:29:24.759119', '2026-05-19 08:29:24.759130');
INSERT INTO `users_user` VALUES (8, 'pbkdf2_sha256$600000$Ge7O8RrPIIsJ2NRtuIYk99$fZQF9n6OdG7qvaAjpIJp1AWR+H2qoe69PKc96bw2Zsc=', NULL, 0, '大帅哥', '', '', '1962475046@qq.com', 0, '2026-05-11 14:43:16.360563', 'resident', '13087245161', NULL, 1, 0, '新手', 1, '2026-05-19 08:29:24.761415', '2026-05-19 08:29:24.761426');
INSERT INTO `users_user` VALUES (9, 'pbkdf2_sha256$600000$bzNcCDxEZyvu9lZmKkj5Lo$pRIfWf1ToNgXVvGkEJc6AiLGNLLodgFC/AhU0dYrbk4=', NULL, 0, '大帅哥是我', '', '', '1962475142@qq.com', 0, '2026-05-11 14:53:14.152409', 'resident', '13087245160', NULL, 1, 0, '新手', 1, '2026-05-19 08:29:24.763931', '2026-05-19 08:29:24.763941');
INSERT INTO `users_user` VALUES (10, 'pbkdf2_sha256$600000$MIvt5nh470B3tIUnlm5sE9$HiVmJElbfiLn/N71ZUYFzZyG4MOqL0xaDDZ/GsbS2y0=', NULL, 0, '螺线春', '', '', '1962475642@qq.com', 0, '2026-05-19 08:32:55.299392', 'resident', '19189964161', NULL, 1, 0, '新手', 1, '2026-05-19 08:32:55.674546', '2026-05-19 08:32:55.674557');
INSERT INTO `users_user` VALUES (11, 'pbkdf2_sha256$600000$R3FaIv5Z5fosIwowY8wdSb$7JL0oy1loGl04bvU0CZmI+f6lJ04Wt7fgr6D4a19yY8=', NULL, 0, 'zhangsan', '三', '张', 'zhangsan@example.com', 0, '2026-05-19 08:33:58.895376', 'resident', '13800138001', NULL, 1, 1250, '新手', 1, '2026-05-19 08:33:59.329714', '2026-05-19 08:33:59.329728');
INSERT INTO `users_user` VALUES (12, 'pbkdf2_sha256$600000$aBhROEMwc77kUH65PGpVP4$7Xj0vKAk6lx9PuYbvet5XwEQ38e6cV8zMgQegAbfqrA=', NULL, 0, 'lisi', '四', '李', 'lisi@example.com', 0, '2026-05-19 08:33:59.334271', 'resident', '13800138002', NULL, 1, 890, '新手', 1, '2026-05-19 08:33:59.693608', '2026-05-19 08:33:59.693618');
INSERT INTO `users_user` VALUES (13, 'pbkdf2_sha256$600000$lvni0Kbwnr0deXSB8DQFzu$H+YIB3+YetaDytF0PgoN8kMpWwi0yPsxDXQJgrsojks=', NULL, 0, 'wangwu', '五', '王', 'wangwu@example.com', 0, '2026-05-19 08:33:59.697674', 'resident', '13800138003', NULL, 1, 2100, '新手', 1, '2026-05-19 08:34:00.077894', '2026-05-19 08:34:00.077904');
INSERT INTO `users_user` VALUES (14, 'pbkdf2_sha256$600000$vfTddCV1UvFa6GEfPeizjS$5/rJpTpqsqtuD85/AsvYmbDBUkQzGaej0dEMBvNjb2U=', NULL, 0, 'zhaoliu', '六', '赵', 'zhaoliu@example.com', 0, '2026-05-19 08:34:00.081972', 'resident', '13800138004', NULL, 1, 3400, '新手', 1, '2026-05-19 08:34:00.465985', '2026-05-19 08:34:00.465995');
INSERT INTO `users_user` VALUES (15, 'pbkdf2_sha256$600000$UIbFxM6yFfax7WGxv0tJmj$WQBifVuWyGz2u7fiXD83YQBGfYw/TvYw3FKpG+K6VbQ=', NULL, 0, 'sunqi', '七', '孙', 'sunqi@example.com', 0, '2026-05-19 08:34:00.470359', 'admin', '13800138005', NULL, 1, 560, '新手', 1, '2026-05-19 08:34:00.850058', '2026-05-19 08:34:00.850068');
INSERT INTO `users_user` VALUES (16, 'pbkdf2_sha256$600000$tHy882JEuacuAnx5m9s63C$S/LDcVzIfafPNEBUnwDQ+zn66vcOTaWk/f7c1vxHrCw=', NULL, 0, '赵伟', '', '', '1962475341@qq.com', 0, '2026-05-19 14:33:36.655946', 'resident', '13087245161', NULL, 1, 0, '新手', 1, '2026-05-19 14:33:37.087215', '2026-05-19 14:33:37.087233');
INSERT INTO `users_user` VALUES (17, 'pbkdf2_sha256$600000$cPbuga6o71ezQzgjjKYi3d$TmwHbGOuSXIphuQL5VpxtsRTMWNd9EkUzD+Bj+6Umc4=', NULL, 0, '你好', '', '', '1962475942@qq.com', 0, '2026-05-19 23:15:32.058958', 'resident', '13087245160', NULL, 1, 1011, '模范', 1, '2026-05-19 23:15:32.439079', '2026-05-19 23:34:49.139505');
INSERT INTO `users_user` VALUES (18, 'pbkdf2_sha256$600000$yYofip3WuKFOHwElk1zf7e$PtGk7eBlLMmwHpPQ+s7paD+fA8yzbcwzjWriTYD2z74=', NULL, 0, 'hello', '', '', '1962475049@qq.com', 0, '2026-05-20 00:47:18.280858', 'property', '13087245161', NULL, 1, 0, '新手', 1, '2026-05-20 00:47:19.010799', '2026-05-20 00:47:19.010815');

-- ----------------------------
-- Table structure for users_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `users_user_groups`;
CREATE TABLE `users_user_groups`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_user_groups_user_id_group_id_b88eab82_uniq`(`user_id` ASC, `group_id` ASC) USING BTREE,
  INDEX `users_user_groups_group_id_9afc8d0e_fk_auth_group_id`(`group_id` ASC) USING BTREE,
  CONSTRAINT `users_user_groups_group_id_9afc8d0e_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `users_user_groups_user_id_5f6f5a90_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for users_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `users_user_user_permissions`;
CREATE TABLE `users_user_user_permissions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_user_user_permissions_user_id_permission_id_43338c45_uniq`(`user_id` ASC, `permission_id` ASC) USING BTREE,
  INDEX `users_user_user_perm_permission_id_0b93982e_fk_auth_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `users_user_user_perm_permission_id_0b93982e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `users_user_user_permissions_user_id_20aca447_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for waste_records_pointtransaction
-- ----------------------------
DROP TABLE IF EXISTS `waste_records_pointtransaction`;
CREATE TABLE `waste_records_pointtransaction`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `related_record_id` bigint NULL DEFAULT NULL,
  `user_id` bigint NOT NULL,
  `points` int NOT NULL,
  `transaction_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `waste_records_pointt_related_record_id_e4a9dc69_fk_waste_rec`(`related_record_id` ASC) USING BTREE,
  INDEX `waste_records_pointtransaction_user_id_2908af92_fk_users_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `waste_records_pointt_related_record_id_e4a9dc69_fk_waste_rec` FOREIGN KEY (`related_record_id`) REFERENCES `waste_records_wasterecord` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `waste_records_pointtransaction_user_id_2908af92_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 54 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of waste_records_pointtransaction
-- ----------------------------
INSERT INTO `waste_records_pointtransaction` VALUES (20, '连续打卡奖励', '2026-05-19 08:29:25.307932', NULL, 3, 5, 'earn');
INSERT INTO `waste_records_pointtransaction` VALUES (21, '连续打卡奖励', '2026-05-19 08:29:25.310240', NULL, 3, 16, 'earn');
INSERT INTO `waste_records_pointtransaction` VALUES (22, '正确分类奖励', '2026-05-19 08:29:25.312687', NULL, 3, 38, 'earn');
INSERT INTO `waste_records_pointtransaction` VALUES (23, '参与活动奖励', '2026-05-19 08:29:25.314645', NULL, 3, 21, 'earn');
INSERT INTO `waste_records_pointtransaction` VALUES (24, '投放可回收物获得积分', '2026-05-19 08:29:25.316329', NULL, 3, 38, 'earn');
INSERT INTO `waste_records_pointtransaction` VALUES (25, '绿色出行奖励', '2026-05-19 08:29:25.318660', NULL, 3, 7, 'earn');
INSERT INTO `waste_records_pointtransaction` VALUES (26, '兑换环保购物袋', '2026-05-19 08:29:25.320535', NULL, 3, 154, 'spend');
INSERT INTO `waste_records_pointtransaction` VALUES (27, '兑换便携餐具', '2026-05-19 08:29:25.322437', NULL, 3, 147, 'spend');
INSERT INTO `waste_records_pointtransaction` VALUES (28, '兑换环保水杯', '2026-05-19 08:29:25.324147', NULL, 3, 51, 'spend');
INSERT INTO `waste_records_pointtransaction` VALUES (29, '兑换有机肥料', '2026-05-19 08:29:25.325993', NULL, 3, 180, 'spend');
INSERT INTO `waste_records_pointtransaction` VALUES (30, '每日签到奖励', '2026-05-19 08:29:25.328189', NULL, 3, 13, 'earn');
INSERT INTO `waste_records_pointtransaction` VALUES (31, '每日签到奖励', '2026-05-19 08:29:25.329949', NULL, 3, 10, 'earn');
INSERT INTO `waste_records_pointtransaction` VALUES (32, '兑换有机肥料', '2026-05-19 08:29:25.331724', NULL, 3, 195, 'spend');
INSERT INTO `waste_records_pointtransaction` VALUES (33, '兑换环保水杯', '2026-05-19 08:29:25.333596', NULL, 3, 181, 'spend');
INSERT INTO `waste_records_pointtransaction` VALUES (34, '每日签到奖励', '2026-05-19 08:29:25.335972', NULL, 3, 29, 'earn');
INSERT INTO `waste_records_pointtransaction` VALUES (35, '兑换兑换券', '2026-05-19 08:29:25.338123', NULL, 3, 198, 'spend');
INSERT INTO `waste_records_pointtransaction` VALUES (36, '投放厨余垃圾获得积分', '2026-05-19 08:29:25.339893', NULL, 3, 37, 'earn');
INSERT INTO `waste_records_pointtransaction` VALUES (37, '兑换兑换券', '2026-05-19 08:29:25.341585', NULL, 4, 99, 'spend');
INSERT INTO `waste_records_pointtransaction` VALUES (38, '连续打卡奖励', '2026-05-19 08:29:25.343984', NULL, 4, 34, 'earn');
INSERT INTO `waste_records_pointtransaction` VALUES (39, '参与活动奖励', '2026-05-19 08:29:25.345823', NULL, 4, 48, 'earn');
INSERT INTO `waste_records_pointtransaction` VALUES (40, '绿色出行奖励', '2026-05-19 08:29:25.347560', NULL, 4, 40, 'earn');
INSERT INTO `waste_records_pointtransaction` VALUES (41, '兑换LED灯泡', '2026-05-19 08:29:25.349130', NULL, 4, 167, 'spend');
INSERT INTO `waste_records_pointtransaction` VALUES (42, '每日签到奖励', '2026-05-19 08:29:25.350883', NULL, 5, 20, 'earn');
INSERT INTO `waste_records_pointtransaction` VALUES (43, '每日签到奖励', '2026-05-19 08:29:25.353175', NULL, 5, 30, 'earn');
INSERT INTO `waste_records_pointtransaction` VALUES (44, '绿色出行奖励', '2026-05-19 08:29:25.355140', NULL, 5, 13, 'earn');
INSERT INTO `waste_records_pointtransaction` VALUES (45, '投放可回收物获得积分', '2026-05-19 08:29:25.357038', NULL, 5, 20, 'earn');
INSERT INTO `waste_records_pointtransaction` VALUES (46, '邀请邻居奖励', '2026-05-19 08:29:25.359047', NULL, 5, 35, 'earn');
INSERT INTO `waste_records_pointtransaction` VALUES (47, '兑换便携餐具', '2026-05-19 08:29:25.361364', NULL, 5, 140, 'spend');
INSERT INTO `waste_records_pointtransaction` VALUES (48, '兑换环保笔记本', '2026-05-19 08:29:25.363565', NULL, 5, 34, 'spend');
INSERT INTO `waste_records_pointtransaction` VALUES (49, '兑换有机肥料', '2026-05-19 08:29:25.365704', NULL, 5, 114, 'spend');
INSERT INTO `waste_records_pointtransaction` VALUES (50, '兑换垃圾分类贴纸', '2026-05-19 08:29:25.368036', NULL, 5, 179, 'spend');
INSERT INTO `waste_records_pointtransaction` VALUES (51, '兑换兑换券', '2026-05-19 08:29:25.370199', NULL, 5, 157, 'spend');
INSERT INTO `waste_records_pointtransaction` VALUES (52, '投放臭垃圾获得积分', '2026-05-19 23:34:21.868559', 221, 17, 11, 'earn');
INSERT INTO `waste_records_pointtransaction` VALUES (53, '投放生活垃圾获得积分', '2026-05-19 23:34:49.143015', 222, 17, 1000, 'earn');

-- ----------------------------
-- Table structure for waste_records_wastecategory
-- ----------------------------
DROP TABLE IF EXISTS `waste_records_wastecategory`;
CREATE TABLE `waste_records_wastecategory`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `point_value` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of waste_records_wastecategory
-- ----------------------------
INSERT INTO `waste_records_wastecategory` VALUES (1, '臭垃圾', '垃圾', 1, '2026-05-19 08:29:24.766860');
INSERT INTO `waste_records_wastecategory` VALUES (2, '生活垃圾', '123145', 1, '2026-05-19 08:29:24.769231');
INSERT INTO `waste_records_wastecategory` VALUES (3, '可回收物', '废纸、塑料、玻璃、金属、布料等。示例：报纸、纸箱、塑料瓶、易拉罐、玻璃瓶', 10, '2026-05-19 08:37:24.857300');
INSERT INTO `waste_records_wastecategory` VALUES (4, '有害垃圾', '对环境和人体有害的垃圾。示例：电池、灯管、药品、油漆桶', 20, '2026-05-19 08:37:24.860942');
INSERT INTO `waste_records_wastecategory` VALUES (5, '厨余垃圾（湿垃圾）', '易腐烂的有机废弃物。示例：剩菜剩饭、果皮果核、菜叶茶叶', 5, '2026-05-19 08:37:24.863973');
INSERT INTO `waste_records_wastecategory` VALUES (6, '其他垃圾（干垃圾）', '除上述三类外的其他生活垃圾。示例：卫生纸、烟蒂、陶瓷碎片、尘土', 3, '2026-05-19 08:37:24.866735');

-- ----------------------------
-- Table structure for waste_records_wasterecord
-- ----------------------------
DROP TABLE IF EXISTS `waste_records_wasterecord`;
CREATE TABLE `waste_records_wasterecord`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `weight` double NOT NULL,
  `points_earned` int NOT NULL,
  `is_qualified` tinyint(1) NOT NULL,
  `image_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `category_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `waste_point_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `waste_records_waster_category_id_8fdb6e72_fk_waste_rec`(`category_id` ASC) USING BTREE,
  INDEX `waste_records_wasterecord_user_id_8f4b68bd_fk_users_user_id`(`user_id` ASC) USING BTREE,
  INDEX `waste_records_waster_waste_point_id_a11a7528_fk_points_wa`(`waste_point_id` ASC) USING BTREE,
  CONSTRAINT `waste_records_waster_category_id_8fdb6e72_fk_waste_rec` FOREIGN KEY (`category_id`) REFERENCES `waste_records_wastecategory` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `waste_records_waster_waste_point_id_a11a7528_fk_points_wa` FOREIGN KEY (`waste_point_id`) REFERENCES `points_wastepoint` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `waste_records_wasterecord_user_id_8f4b68bd_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 223 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of waste_records_wasterecord
-- ----------------------------
INSERT INTO `waste_records_wasterecord` VALUES (1, 1, 0, 0, '', '2026-05-19 08:29:24.975269', 1, 1, 6);
INSERT INTO `waste_records_wasterecord` VALUES (4, 4, 4, 1, '', '2026-05-19 08:29:24.986182', 1, 1, 5);
INSERT INTO `waste_records_wasterecord` VALUES (5, 6.5, 6, 1, '', '2026-05-19 08:29:24.989206', 1, 1, 1);
INSERT INTO `waste_records_wasterecord` VALUES (6, 2, 2, 1, '', '2026-05-19 08:29:24.992108', 1, 3, 6);
INSERT INTO `waste_records_wasterecord` VALUES (7, 1, 1, 1, '', '2026-05-19 08:29:24.994975', 1, 4, 3);
INSERT INTO `waste_records_wasterecord` VALUES (8, 5.9, 5, 1, '', '2026-05-19 08:29:24.997583', 1, 4, 8);
INSERT INTO `waste_records_wasterecord` VALUES (9, 7, 7, 1, '', '2026-05-19 08:29:24.999664', 1, 3, 8);
INSERT INTO `waste_records_wasterecord` VALUES (10, 2.1, 2, 1, '', '2026-05-19 08:29:25.001927', 1, 1, 6);
INSERT INTO `waste_records_wasterecord` VALUES (11, 4.6, 4, 1, '', '2026-05-19 08:29:25.004277', 1, 1, 5);
INSERT INTO `waste_records_wasterecord` VALUES (12, 1.4, 1, 1, '', '2026-05-19 08:29:25.006321', 1, 4, 5);
INSERT INTO `waste_records_wasterecord` VALUES (13, 6.6, 6, 1, '', '2026-05-19 08:29:25.008220', 1, 4, 5);
INSERT INTO `waste_records_wasterecord` VALUES (14, 1.5, 1, 1, '', '2026-05-19 08:29:25.010062', 1, 3, 2);
INSERT INTO `waste_records_wasterecord` VALUES (16, 1.5, 1, 1, '', '2026-05-19 08:29:25.013696', 1, 5, 10);
INSERT INTO `waste_records_wasterecord` VALUES (17, 4.3, 4, 1, '', '2026-05-19 08:29:25.015659', 1, 4, 5);
INSERT INTO `waste_records_wasterecord` VALUES (19, 3.1, 3, 1, '', '2026-05-19 08:29:25.020016', 1, 4, 5);
INSERT INTO `waste_records_wasterecord` VALUES (21, 5.5, 5, 1, '', '2026-05-19 08:29:25.025430', 1, 3, 9);
INSERT INTO `waste_records_wasterecord` VALUES (23, 1.4, 1, 1, '', '2026-05-19 08:29:25.029519', 1, 4, 10);
INSERT INTO `waste_records_wasterecord` VALUES (24, 5.2, 5, 1, '', '2026-05-19 08:29:25.031697', 1, 5, 8);
INSERT INTO `waste_records_wasterecord` VALUES (25, 3, 3, 1, '', '2026-05-19 08:29:25.034133', 1, 4, 3);
INSERT INTO `waste_records_wasterecord` VALUES (26, 6.5, 6, 1, '', '2026-05-19 08:29:25.036594', 1, 3, 9);
INSERT INTO `waste_records_wasterecord` VALUES (27, 4.6, 4, 1, '', '2026-05-19 08:29:25.038631', 1, 5, 10);
INSERT INTO `waste_records_wasterecord` VALUES (28, 2.1, 2, 1, '', '2026-05-19 08:29:25.040819', 1, 1, 2);
INSERT INTO `waste_records_wasterecord` VALUES (29, 7.1, 0, 0, '', '2026-05-19 08:29:25.043284', 1, 1, 5);
INSERT INTO `waste_records_wasterecord` VALUES (30, 5.3, 5, 1, '', '2026-05-19 08:29:25.045474', 1, 3, 7);
INSERT INTO `waste_records_wasterecord` VALUES (31, 0.8, 0, 1, '', '2026-05-19 08:29:25.047462', 1, 4, 4);
INSERT INTO `waste_records_wasterecord` VALUES (32, 2.8, 2, 1, '', '2026-05-19 08:29:25.049820', 1, 5, 4);
INSERT INTO `waste_records_wasterecord` VALUES (33, 5.7, 5, 1, '', '2026-05-19 08:29:25.052209', 1, 4, 1);
INSERT INTO `waste_records_wasterecord` VALUES (34, 1.2, 1, 1, '', '2026-05-19 08:29:25.054742', 1, 1, 4);
INSERT INTO `waste_records_wasterecord` VALUES (35, 2.7, 2, 1, '', '2026-05-19 08:29:25.057098', 1, 4, 9);
INSERT INTO `waste_records_wasterecord` VALUES (37, 5.8, 5, 1, '', '2026-05-19 08:29:25.061467', 1, 4, 5);
INSERT INTO `waste_records_wasterecord` VALUES (38, 4.6, 4, 1, '', '2026-05-19 08:29:25.063442', 1, 1, 8);
INSERT INTO `waste_records_wasterecord` VALUES (39, 5.5, 5, 1, '', '2026-05-19 08:29:25.065842', 1, 4, 9);
INSERT INTO `waste_records_wasterecord` VALUES (40, 7.3, 7, 1, '', '2026-05-19 08:29:25.068413', 1, 1, 7);
INSERT INTO `waste_records_wasterecord` VALUES (41, 1.4, 1, 1, '', '2026-05-19 08:29:25.070888', 1, 3, 1);
INSERT INTO `waste_records_wasterecord` VALUES (42, 4.1, 4, 1, '', '2026-05-19 08:29:25.073427', 1, 4, 10);
INSERT INTO `waste_records_wasterecord` VALUES (43, 3.1, 3, 1, '', '2026-05-19 08:29:25.075792', 1, 1, 6);
INSERT INTO `waste_records_wasterecord` VALUES (44, 6.9, 6, 1, '', '2026-05-19 08:29:25.078116', 1, 1, 4);
INSERT INTO `waste_records_wasterecord` VALUES (45, 1.6, 1, 1, '', '2026-05-19 08:29:25.080306', 1, 1, 10);
INSERT INTO `waste_records_wasterecord` VALUES (46, 2.3, 2, 1, '', '2026-05-19 08:29:25.082474', 1, 4, 8);
INSERT INTO `waste_records_wasterecord` VALUES (47, 1.5, 1, 1, '', '2026-05-19 08:29:25.084952', 1, 3, 1);
INSERT INTO `waste_records_wasterecord` VALUES (49, 4, 4, 1, '', '2026-05-19 08:29:25.089328', 1, 1, 7);
INSERT INTO `waste_records_wasterecord` VALUES (50, 5.7, 5, 1, '', '2026-05-19 08:29:25.091911', 1, 1, 7);
INSERT INTO `waste_records_wasterecord` VALUES (52, 2.4, 2, 1, '', '2026-05-19 08:29:25.096040', 1, 1, 2);
INSERT INTO `waste_records_wasterecord` VALUES (53, 7.6, 0, 0, '', '2026-05-19 08:29:25.098486', 1, 5, 5);
INSERT INTO `waste_records_wasterecord` VALUES (54, 1.4, 1, 1, '', '2026-05-19 08:29:25.100469', 1, 4, 1);
INSERT INTO `waste_records_wasterecord` VALUES (55, 5.9, 0, 0, '', '2026-05-19 08:29:25.103211', 1, 4, 7);
INSERT INTO `waste_records_wasterecord` VALUES (58, 3.8, 3, 1, '', '2026-05-19 08:29:25.109655', 1, 1, 1);
INSERT INTO `waste_records_wasterecord` VALUES (59, 2, 2, 1, '', '2026-05-19 08:29:25.111982', 1, 5, 5);
INSERT INTO `waste_records_wasterecord` VALUES (60, 1.2, 1, 1, '', '2026-05-19 08:29:25.113961', 1, 3, 8);
INSERT INTO `waste_records_wasterecord` VALUES (61, 0.9, 0, 1, '', '2026-05-19 08:29:25.116172', 1, 5, 8);
INSERT INTO `waste_records_wasterecord` VALUES (62, 2.8, 2, 1, '', '2026-05-19 08:29:25.118581', 1, 3, 9);
INSERT INTO `waste_records_wasterecord` VALUES (64, 3.6, 3, 1, '', '2026-05-19 08:29:25.122381', 1, 4, 5);
INSERT INTO `waste_records_wasterecord` VALUES (65, 4.7, 4, 1, '', '2026-05-19 08:29:25.124623', 1, 1, 3);
INSERT INTO `waste_records_wasterecord` VALUES (66, 6.4, 6, 1, '', '2026-05-19 08:29:25.126453', 1, 1, 5);
INSERT INTO `waste_records_wasterecord` VALUES (67, 7.1, 0, 0, '', '2026-05-19 08:29:25.128641', 1, 3, 2);
INSERT INTO `waste_records_wasterecord` VALUES (69, 6.6, 6, 1, '', '2026-05-19 08:29:25.132363', 1, 5, 5);
INSERT INTO `waste_records_wasterecord` VALUES (70, 7.5, 7, 1, '', '2026-05-19 08:29:25.134811', 1, 1, 4);
INSERT INTO `waste_records_wasterecord` VALUES (72, 6.6, 6, 1, '', '2026-05-19 08:29:25.139022', 1, 3, 5);
INSERT INTO `waste_records_wasterecord` VALUES (74, 4.8, 4, 1, '', '2026-05-19 08:29:25.143255', 1, 3, 5);
INSERT INTO `waste_records_wasterecord` VALUES (75, 1.1, 0, 0, '', '2026-05-19 08:29:25.145220', 1, 1, 9);
INSERT INTO `waste_records_wasterecord` VALUES (76, 1.5, 1, 1, '', '2026-05-19 08:29:25.147146', 1, 1, 3);
INSERT INTO `waste_records_wasterecord` VALUES (77, 5, 5, 1, '', '2026-05-19 08:29:25.148994', 1, 1, 5);
INSERT INTO `waste_records_wasterecord` VALUES (78, 1.7, 1, 1, '', '2026-05-19 08:29:25.150967', 1, 4, 1);
INSERT INTO `waste_records_wasterecord` VALUES (80, 4.8, 4, 1, '', '2026-05-19 08:29:25.154933', 1, 3, 3);
INSERT INTO `waste_records_wasterecord` VALUES (82, 1.2, 1, 1, '', '2026-05-19 08:29:25.158934', 1, 4, 8);
INSERT INTO `waste_records_wasterecord` VALUES (84, 1.1, 1, 1, '', '2026-05-19 08:29:25.162534', 1, 4, 10);
INSERT INTO `waste_records_wasterecord` VALUES (86, 7.1, 7, 1, '', '2026-05-19 08:29:25.166943', 1, 4, 4);
INSERT INTO `waste_records_wasterecord` VALUES (87, 1.5, 1, 1, '', '2026-05-19 08:29:25.169088', 1, 5, 3);
INSERT INTO `waste_records_wasterecord` VALUES (88, 5.5, 5, 1, '', '2026-05-19 08:29:25.171025', 1, 5, 8);
INSERT INTO `waste_records_wasterecord` VALUES (89, 2.8, 2, 1, '', '2026-05-19 08:29:25.173388', 1, 4, 6);
INSERT INTO `waste_records_wasterecord` VALUES (90, 3.7, 3, 1, '', '2026-05-19 08:29:25.175530', 1, 3, 7);
INSERT INTO `waste_records_wasterecord` VALUES (91, 6.8, 6, 1, '', '2026-05-19 08:29:25.177438', 1, 3, 4);
INSERT INTO `waste_records_wasterecord` VALUES (92, 5.2, 5, 1, '', '2026-05-19 08:29:25.179601', 1, 4, 9);
INSERT INTO `waste_records_wasterecord` VALUES (95, 2, 2, 1, '', '2026-05-19 08:29:25.186045', 1, 4, 8);
INSERT INTO `waste_records_wasterecord` VALUES (96, 3.7, 3, 1, '', '2026-05-19 08:29:25.188546', 1, 1, 2);
INSERT INTO `waste_records_wasterecord` VALUES (98, 5.4, 5, 1, '', '2026-05-19 08:29:25.192454', 1, 4, 2);
INSERT INTO `waste_records_wasterecord` VALUES (99, 4.6, 4, 1, '', '2026-05-19 08:29:25.194527', 1, 3, 9);
INSERT INTO `waste_records_wasterecord` VALUES (100, 7.2, 7, 1, '', '2026-05-19 08:29:25.196493', 1, 1, 4);
INSERT INTO `waste_records_wasterecord` VALUES (101, 5.5, 5, 1, '', '2026-05-19 08:29:25.198660', 1, 4, 6);
INSERT INTO `waste_records_wasterecord` VALUES (102, 3.9, 3, 1, '', '2026-05-19 08:29:25.200861', 1, 4, 6);
INSERT INTO `waste_records_wasterecord` VALUES (104, 6.6, 6, 1, '', '2026-05-19 08:29:25.205395', 1, 5, 3);
INSERT INTO `waste_records_wasterecord` VALUES (105, 2, 2, 1, '', '2026-05-19 08:29:25.207663', 1, 5, 5);
INSERT INTO `waste_records_wasterecord` VALUES (107, 1.4, 1, 1, '', '2026-05-19 08:29:25.211709', 1, 5, 7);
INSERT INTO `waste_records_wasterecord` VALUES (108, 6.9, 6, 1, '', '2026-05-19 08:29:25.214018', 1, 4, 1);
INSERT INTO `waste_records_wasterecord` VALUES (110, 2.6, 2, 1, '', '2026-05-19 08:29:25.218047', 1, 5, 4);
INSERT INTO `waste_records_wasterecord` VALUES (111, 2.7, 2, 1, '', '2026-05-19 08:29:25.220807', 1, 1, 4);
INSERT INTO `waste_records_wasterecord` VALUES (112, 3.6, 3, 1, '', '2026-05-19 08:29:25.222815', 1, 4, 6);
INSERT INTO `waste_records_wasterecord` VALUES (115, 5.2, 5, 1, '', '2026-05-19 08:29:25.228032', 1, 1, 6);
INSERT INTO `waste_records_wasterecord` VALUES (116, 3.2, 0, 0, '', '2026-05-19 08:29:25.230086', 1, 1, 3);
INSERT INTO `waste_records_wasterecord` VALUES (117, 1.9, 1, 1, '', '2026-05-19 08:29:25.231927', 1, 1, 4);
INSERT INTO `waste_records_wasterecord` VALUES (118, 6.2, 6, 1, '', '2026-05-19 08:29:25.233835', 1, 1, 6);
INSERT INTO `waste_records_wasterecord` VALUES (119, 1.1, 1, 1, '', '2026-05-19 08:29:25.236759', 1, 4, 1);
INSERT INTO `waste_records_wasterecord` VALUES (121, 5.5, 27, 1, NULL, '2026-05-19 08:37:24.873913', 5, 8, 10);
INSERT INTO `waste_records_wasterecord` VALUES (122, 4.2, 84, 1, NULL, '2026-05-19 08:37:24.876458', 4, 3, 1);
INSERT INTO `waste_records_wasterecord` VALUES (123, 5.8, 116, 1, NULL, '2026-05-19 08:37:24.878534', 4, 12, 2);
INSERT INTO `waste_records_wasterecord` VALUES (124, 8.7, 26, 1, NULL, '2026-05-19 08:37:24.880233', 6, 12, 4);
INSERT INTO `waste_records_wasterecord` VALUES (125, 8.6, 8, 1, NULL, '2026-05-19 08:37:24.882251', 2, 6, 8);
INSERT INTO `waste_records_wasterecord` VALUES (126, 8.7, 87, 1, NULL, '2026-05-19 08:37:24.884297', 3, 3, 9);
INSERT INTO `waste_records_wasterecord` VALUES (127, 1.7, 34, 1, NULL, '2026-05-19 08:37:24.886153', 4, 4, 2);
INSERT INTO `waste_records_wasterecord` VALUES (128, 6, 6, 1, NULL, '2026-05-19 08:37:24.888372', 2, 12, 2);
INSERT INTO `waste_records_wasterecord` VALUES (129, 7.8, 78, 1, NULL, '2026-05-19 08:37:24.890706', 3, 3, 4);
INSERT INTO `waste_records_wasterecord` VALUES (130, 4.6, 13, 1, NULL, '2026-05-19 08:37:24.892718', 6, 7, 9);
INSERT INTO `waste_records_wasterecord` VALUES (131, 9.5, 47, 1, NULL, '2026-05-19 08:37:24.895054', 5, 5, 5);
INSERT INTO `waste_records_wasterecord` VALUES (132, 7.5, 22, 1, NULL, '2026-05-19 08:37:24.896930', 6, 12, 9);
INSERT INTO `waste_records_wasterecord` VALUES (133, 2, 2, 1, NULL, '2026-05-19 08:37:24.899158', 2, 9, 7);
INSERT INTO `waste_records_wasterecord` VALUES (134, 1, 1, 1, NULL, '2026-05-19 08:37:24.901366', 2, 1, 3);
INSERT INTO `waste_records_wasterecord` VALUES (135, 3.2, 16, 1, NULL, '2026-05-19 08:37:24.903671', 5, 9, 2);
INSERT INTO `waste_records_wasterecord` VALUES (136, 8.4, 8, 1, NULL, '2026-05-19 08:37:24.905709', 1, 3, 6);
INSERT INTO `waste_records_wasterecord` VALUES (137, 7.2, 72, 1, NULL, '2026-05-19 08:37:24.907921', 3, 1, 3);
INSERT INTO `waste_records_wasterecord` VALUES (138, 5.3, 26, 1, NULL, '2026-05-19 08:37:24.910620', 5, 10, 5);
INSERT INTO `waste_records_wasterecord` VALUES (139, 8, 160, 1, NULL, '2026-05-19 08:37:24.912683', 4, 5, 5);
INSERT INTO `waste_records_wasterecord` VALUES (140, 9.3, 27, 1, NULL, '2026-05-19 08:37:24.915319', 6, 1, 8);
INSERT INTO `waste_records_wasterecord` VALUES (141, 7.4, 74, 1, NULL, '2026-05-19 08:37:24.917611', 3, 11, 3);
INSERT INTO `waste_records_wasterecord` VALUES (142, 5.9, 5, 1, NULL, '2026-05-19 08:37:24.919710', 1, 10, 1);
INSERT INTO `waste_records_wasterecord` VALUES (143, 7.8, 156, 1, NULL, '2026-05-19 08:37:24.925416', 4, 11, 8);
INSERT INTO `waste_records_wasterecord` VALUES (144, 5.8, 5, 1, NULL, '2026-05-19 08:37:24.927906', 1, 5, 2);
INSERT INTO `waste_records_wasterecord` VALUES (145, 9.9, 198, 1, NULL, '2026-05-19 08:37:24.929966', 4, 1, 10);
INSERT INTO `waste_records_wasterecord` VALUES (146, 2.8, 2, 1, NULL, '2026-05-19 08:37:24.932240', 2, 12, 5);
INSERT INTO `waste_records_wasterecord` VALUES (147, 7.3, 36, 1, NULL, '2026-05-19 08:37:24.934649', 5, 13, 1);
INSERT INTO `waste_records_wasterecord` VALUES (148, 8, 8, 1, NULL, '2026-05-19 08:37:24.936614', 2, 15, 10);
INSERT INTO `waste_records_wasterecord` VALUES (149, 3.3, 16, 1, NULL, '2026-05-19 08:37:24.938384', 5, 3, 7);
INSERT INTO `waste_records_wasterecord` VALUES (150, 5.5, 5, 1, NULL, '2026-05-19 08:37:24.940010', 1, 12, 1);
INSERT INTO `waste_records_wasterecord` VALUES (151, 2.4, 12, 1, NULL, '2026-05-19 08:37:24.941535', 5, 12, 1);
INSERT INTO `waste_records_wasterecord` VALUES (152, 4.5, 13, 1, NULL, '2026-05-19 08:37:24.943245', 6, 3, 1);
INSERT INTO `waste_records_wasterecord` VALUES (153, 8.4, 8, 1, NULL, '2026-05-19 08:37:24.944889', 1, 3, 7);
INSERT INTO `waste_records_wasterecord` VALUES (154, 7, 21, 1, NULL, '2026-05-19 08:37:24.946528', 6, 1, 2);
INSERT INTO `waste_records_wasterecord` VALUES (155, 6.7, 67, 1, NULL, '2026-05-19 08:37:24.948966', 3, 6, 10);
INSERT INTO `waste_records_wasterecord` VALUES (156, 6.9, 6, 1, NULL, '2026-05-19 08:37:24.951817', 2, 9, 4);
INSERT INTO `waste_records_wasterecord` VALUES (157, 3.3, 33, 1, NULL, '2026-05-19 08:37:24.953896', 3, 8, 2);
INSERT INTO `waste_records_wasterecord` VALUES (158, 3.9, 19, 1, NULL, '2026-05-19 08:37:24.956132', 5, 5, 5);
INSERT INTO `waste_records_wasterecord` VALUES (159, 4.1, 41, 1, NULL, '2026-05-19 08:37:24.957981', 3, 4, 9);
INSERT INTO `waste_records_wasterecord` VALUES (160, 3.7, 11, 1, NULL, '2026-05-19 08:37:24.959981', 6, 13, 6);
INSERT INTO `waste_records_wasterecord` VALUES (161, 4.8, 24, 1, NULL, '2026-05-19 08:37:24.962185', 5, 13, 1);
INSERT INTO `waste_records_wasterecord` VALUES (162, 7.4, 7, 1, NULL, '2026-05-19 08:37:24.963928', 2, 7, 7);
INSERT INTO `waste_records_wasterecord` VALUES (163, 7.9, 39, 1, NULL, '2026-05-19 08:37:24.966177', 5, 11, 1);
INSERT INTO `waste_records_wasterecord` VALUES (164, 1.5, 7, 1, NULL, '2026-05-19 08:37:24.968636', 5, 9, 6);
INSERT INTO `waste_records_wasterecord` VALUES (165, 0.6, 6, 1, NULL, '2026-05-19 08:37:24.970609', 3, 11, 8);
INSERT INTO `waste_records_wasterecord` VALUES (166, 2.6, 7, 1, NULL, '2026-05-19 08:37:24.972485', 6, 4, 8);
INSERT INTO `waste_records_wasterecord` VALUES (167, 0.9, 9, 1, NULL, '2026-05-19 08:37:24.974645', 3, 8, 7);
INSERT INTO `waste_records_wasterecord` VALUES (168, 7.4, 148, 1, NULL, '2026-05-19 08:37:24.976531', 4, 13, 1);
INSERT INTO `waste_records_wasterecord` VALUES (169, 1.2, 12, 1, NULL, '2026-05-19 08:37:24.978347', 3, 11, 9);
INSERT INTO `waste_records_wasterecord` VALUES (170, 7.8, 7, 1, NULL, '2026-05-19 08:37:24.980096', 2, 12, 8);
INSERT INTO `waste_records_wasterecord` VALUES (171, 4.1, 12, 1, NULL, '2026-05-19 08:38:59.483770', 6, 9, 10);
INSERT INTO `waste_records_wasterecord` VALUES (172, 9.6, 9, 1, NULL, '2026-05-19 08:38:59.486649', 1, 5, 5);
INSERT INTO `waste_records_wasterecord` VALUES (173, 5.8, 58, 1, NULL, '2026-05-19 08:38:59.489038', 3, 13, 6);
INSERT INTO `waste_records_wasterecord` VALUES (174, 8, 8, 1, NULL, '2026-05-19 08:38:59.491240', 1, 3, 10);
INSERT INTO `waste_records_wasterecord` VALUES (175, 4.1, 20, 1, NULL, '2026-05-19 08:38:59.493304', 5, 10, 3);
INSERT INTO `waste_records_wasterecord` VALUES (176, 3.1, 15, 1, NULL, '2026-05-19 08:38:59.496591', 5, 8, 1);
INSERT INTO `waste_records_wasterecord` VALUES (177, 4.5, 45, 1, NULL, '2026-05-19 08:38:59.498726', 3, 13, 4);
INSERT INTO `waste_records_wasterecord` VALUES (178, 9, 45, 1, NULL, '2026-05-19 08:38:59.500739', 5, 6, 5);
INSERT INTO `waste_records_wasterecord` VALUES (179, 6.6, 132, 1, NULL, '2026-05-19 08:38:59.503483', 4, 8, 8);
INSERT INTO `waste_records_wasterecord` VALUES (180, 6.9, 20, 1, NULL, '2026-05-19 08:38:59.505689', 6, 13, 6);
INSERT INTO `waste_records_wasterecord` VALUES (181, 1.2, 6, 1, NULL, '2026-05-19 08:38:59.507744', 5, 8, 9);
INSERT INTO `waste_records_wasterecord` VALUES (182, 4.6, 13, 1, NULL, '2026-05-19 08:38:59.509800', 6, 9, 7);
INSERT INTO `waste_records_wasterecord` VALUES (183, 5, 50, 1, NULL, '2026-05-19 08:38:59.512635', 3, 5, 10);
INSERT INTO `waste_records_wasterecord` VALUES (184, 3.7, 11, 1, NULL, '2026-05-19 08:38:59.514905', 6, 9, 2);
INSERT INTO `waste_records_wasterecord` VALUES (185, 7.4, 148, 1, NULL, '2026-05-19 08:38:59.516918', 4, 15, 7);
INSERT INTO `waste_records_wasterecord` VALUES (186, 3.3, 16, 1, NULL, '2026-05-19 08:38:59.519520', 5, 6, 3);
INSERT INTO `waste_records_wasterecord` VALUES (187, 7.2, 7, 1, NULL, '2026-05-19 08:38:59.521510', 2, 12, 1);
INSERT INTO `waste_records_wasterecord` VALUES (188, 8.8, 26, 1, NULL, '2026-05-19 08:38:59.524108', 6, 10, 2);
INSERT INTO `waste_records_wasterecord` VALUES (189, 4.6, 4, 1, NULL, '2026-05-19 08:38:59.526182', 1, 1, 4);
INSERT INTO `waste_records_wasterecord` VALUES (190, 5.4, 5, 1, NULL, '2026-05-19 08:38:59.528890', 2, 6, 7);
INSERT INTO `waste_records_wasterecord` VALUES (191, 5.6, 112, 1, NULL, '2026-05-19 08:38:59.531959', 4, 4, 7);
INSERT INTO `waste_records_wasterecord` VALUES (192, 5.3, 5, 1, NULL, '2026-05-19 08:38:59.534473', 2, 5, 2);
INSERT INTO `waste_records_wasterecord` VALUES (193, 3.3, 33, 1, NULL, '2026-05-19 08:38:59.536501', 3, 8, 1);
INSERT INTO `waste_records_wasterecord` VALUES (194, 4.6, 4, 1, NULL, '2026-05-19 08:38:59.538515', 2, 15, 7);
INSERT INTO `waste_records_wasterecord` VALUES (195, 4.1, 4, 1, NULL, '2026-05-19 08:38:59.540510', 1, 10, 7);
INSERT INTO `waste_records_wasterecord` VALUES (196, 1.7, 17, 1, NULL, '2026-05-19 08:38:59.542614', 3, 10, 1);
INSERT INTO `waste_records_wasterecord` VALUES (197, 1, 10, 1, NULL, '2026-05-19 08:38:59.545287', 3, 3, 5);
INSERT INTO `waste_records_wasterecord` VALUES (198, 5.4, 5, 1, NULL, '2026-05-19 08:38:59.547790', 2, 12, 4);
INSERT INTO `waste_records_wasterecord` VALUES (199, 2, 6, 1, NULL, '2026-05-19 08:38:59.549966', 6, 3, 3);
INSERT INTO `waste_records_wasterecord` VALUES (200, 7.6, 7, 1, NULL, '2026-05-19 08:38:59.552224', 1, 6, 2);
INSERT INTO `waste_records_wasterecord` VALUES (201, 8.5, 25, 1, NULL, '2026-05-19 08:38:59.554332', 6, 12, 9);
INSERT INTO `waste_records_wasterecord` VALUES (202, 5.1, 15, 1, NULL, '2026-05-19 08:38:59.556321', 6, 13, 2);
INSERT INTO `waste_records_wasterecord` VALUES (203, 1.3, 13, 1, NULL, '2026-05-19 08:38:59.558336', 3, 10, 5);
INSERT INTO `waste_records_wasterecord` VALUES (204, 9.1, 182, 1, NULL, '2026-05-19 08:38:59.560353', 4, 14, 9);
INSERT INTO `waste_records_wasterecord` VALUES (205, 4.8, 48, 1, NULL, '2026-05-19 08:38:59.563791', 3, 10, 10);
INSERT INTO `waste_records_wasterecord` VALUES (206, 6.3, 18, 1, NULL, '2026-05-19 08:38:59.566029', 6, 15, 10);
INSERT INTO `waste_records_wasterecord` VALUES (207, 8.4, 42, 1, NULL, '2026-05-19 08:38:59.568028', 5, 1, 10);
INSERT INTO `waste_records_wasterecord` VALUES (208, 2.8, 2, 1, NULL, '2026-05-19 08:38:59.569995', 1, 14, 3);
INSERT INTO `waste_records_wasterecord` VALUES (209, 2.7, 27, 1, NULL, '2026-05-19 08:38:59.572365', 3, 13, 3);
INSERT INTO `waste_records_wasterecord` VALUES (210, 4.7, 4, 1, NULL, '2026-05-19 08:38:59.574390', 2, 13, 7);
INSERT INTO `waste_records_wasterecord` VALUES (211, 9.5, 9, 1, NULL, '2026-05-19 08:38:59.576455', 2, 13, 6);
INSERT INTO `waste_records_wasterecord` VALUES (212, 3.2, 3, 1, NULL, '2026-05-19 08:38:59.579582', 1, 5, 9);
INSERT INTO `waste_records_wasterecord` VALUES (213, 3.7, 3, 1, NULL, '2026-05-19 08:38:59.581960', 2, 12, 8);
INSERT INTO `waste_records_wasterecord` VALUES (214, 7.8, 7, 1, NULL, '2026-05-19 08:38:59.584388', 1, 4, 9);
INSERT INTO `waste_records_wasterecord` VALUES (215, 8.4, 168, 1, NULL, '2026-05-19 08:38:59.586713', 4, 15, 1);
INSERT INTO `waste_records_wasterecord` VALUES (216, 5, 15, 1, NULL, '2026-05-19 08:38:59.588872', 6, 14, 2);
INSERT INTO `waste_records_wasterecord` VALUES (217, 1.9, 1, 1, NULL, '2026-05-19 08:38:59.591163', 1, 10, 4);
INSERT INTO `waste_records_wasterecord` VALUES (218, 3, 60, 1, NULL, '2026-05-19 08:38:59.593264', 4, 14, 7);
INSERT INTO `waste_records_wasterecord` VALUES (219, 5, 5, 1, NULL, '2026-05-19 08:38:59.596693', 1, 14, 1);
INSERT INTO `waste_records_wasterecord` VALUES (220, 8.2, 8, 1, NULL, '2026-05-19 08:38:59.599176', 1, 7, 4);
INSERT INTO `waste_records_wasterecord` VALUES (221, 1.1, 11, 1, NULL, '2026-05-19 23:34:21.856523', 1, 17, 1);
INSERT INTO `waste_records_wasterecord` VALUES (222, 100, 1000, 1, NULL, '2026-05-19 23:34:49.135006', 2, 17, 3);

SET FOREIGN_KEY_CHECKS = 1;
