/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50723
Source Host           : localhost:3306
Source Database       : research_home

Target Server Type    : MYSQL
Target Server Version : 50723
File Encoding         : 65001

Date: 2019-03-18 14:53:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for annualintegrals
-- ----------------------------
DROP TABLE IF EXISTS `annualintegrals`;
CREATE TABLE `annualintegrals` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `MemberId` int(11) NOT NULL,
  `Years` int(11) NOT NULL,
  `AnnualIntegral` int(11) NOT NULL,
  `UpdatedTime` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of annualintegrals
-- ----------------------------
INSERT INTO `annualintegrals` VALUES ('1', '1', '2018', '11', '2018-12-05 13:00:49', null, '2019-03-15 10:05:49');
INSERT INTO `annualintegrals` VALUES ('2', '2', '2018', '47', '2018-10-09 09:34:55', null, '2019-03-15 10:05:49');
INSERT INTO `annualintegrals` VALUES ('3', '3', '2018', '45', '2018-10-09 09:34:55', null, '2019-03-15 10:05:49');
INSERT INTO `annualintegrals` VALUES ('4', '4', '2018', '8', '2018-10-09 09:34:55', null, '2019-03-15 10:05:49');
INSERT INTO `annualintegrals` VALUES ('5', '7', '2019', '181959', '2019-03-11 10:13:40', null, '2019-03-15 10:05:49');
INSERT INTO `annualintegrals` VALUES ('7', '1', '2019', '495', '2019-03-01 15:28:41', null, '2019-03-15 10:05:49');
INSERT INTO `annualintegrals` VALUES ('8', '6', '2019', '2', '2019-01-22 16:48:12', null, '2019-03-15 10:05:49');
INSERT INTO `annualintegrals` VALUES ('9', '3', '2019', '196', '2019-03-15 13:33:31', null, '2019-03-15 13:33:31');
INSERT INTO `annualintegrals` VALUES ('10', '5', '2019', '72', '2019-03-15 13:33:31', null, '2019-03-15 13:33:31');
INSERT INTO `annualintegrals` VALUES ('11', '9', '2019', '136', '2019-03-11 12:01:15', null, '2019-03-15 10:05:49');
INSERT INTO `annualintegrals` VALUES ('12', '2', '2019', '3646', '2019-03-14 18:56:29', null, '2019-03-15 10:05:49');
INSERT INTO `annualintegrals` VALUES ('13', '4', '2019', '10023', '2019-03-11 10:31:52', null, '2019-03-15 10:05:49');

-- ----------------------------
-- Table structure for appraisals
-- ----------------------------
DROP TABLE IF EXISTS `appraisals`;
CREATE TABLE `appraisals` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Year` int(4) NOT NULL,
  `Type` varchar(4) COLLATE utf8mb4_bin NOT NULL,
  `ValueScore` decimal(5,2) DEFAULT NULL,
  `PerformanceScore` decimal(5,2) DEFAULT NULL,
  `Level` varchar(10) COLLATE utf8mb4_bin NOT NULL COMMENT '四个等级',
  `MemberId` int(11) NOT NULL,
  `CreatedMemberId` int(11) NOT NULL,
  `CreatedTime` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `TotalScore` decimal(5,2) DEFAULT NULL,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of appraisals
-- ----------------------------
INSERT INTO `appraisals` VALUES ('1', '2019', '年中', '25.66', '78.00', '达到预期', '7', '7', '2019-01-22 15:00:24', '81.77', '2019-03-15 10:05:37');
INSERT INTO `appraisals` VALUES ('2', '2019', '年末', '30.00', '99.00', '达到预期', '3', '7', '2019-01-22 17:00:44', '99.50', '2019-03-15 10:05:37');
INSERT INTO `appraisals` VALUES ('3', '2019', '年末', '25.00', '99.99', '达到预期', '3', '7', '2019-01-22 16:24:02', '91.66', '2019-03-15 10:05:37');
INSERT INTO `appraisals` VALUES ('4', '2019', '年中', '25.50', '45.00', '低于预期', '2', '7', '2019-01-22 16:38:55', '65.00', '2019-03-15 10:05:37');
INSERT INTO `appraisals` VALUES ('5', '2019', '年中', '30.00', '10.00', '低于预期', '5', '7', '2019-01-22 16:39:05', '55.00', '2019-03-15 10:05:37');
INSERT INTO `appraisals` VALUES ('6', '2018', '年末', '30.00', '90.00', '达到预期', '1', '7', '2019-01-22 16:40:36', '95.00', '2019-03-15 10:05:37');
INSERT INTO `appraisals` VALUES ('7', '2019', '年中', '30.00', '99.00', '达到预期', '9', '7', '2019-01-22 16:46:05', '99.50', '2019-03-15 10:05:37');
INSERT INTO `appraisals` VALUES ('8', '2019', '年末', '1.50', '1.50', '低于预期', '2', '7', '2019-01-22 16:54:06', '3.25', '2019-03-15 10:05:37');
INSERT INTO `appraisals` VALUES ('9', '2018', '年中', '12.00', '12.00', '低于预期', '3', '7', '2019-03-08 10:50:37', '26.00', '2019-03-15 10:05:37');
INSERT INTO `appraisals` VALUES ('10', '2019', '转正', '24.00', '50.00', '低于预期', '3', '7', '2019-01-22 16:58:47', '65.00', '2019-03-15 10:05:37');
INSERT INTO `appraisals` VALUES ('11', '2019', '年中', '12.00', '12.00', '低于预期', '3', '7', '2019-01-22 16:58:58', '26.00', '2019-03-15 10:05:37');
INSERT INTO `appraisals` VALUES ('12', '2019', '转正', '29.00', '99.00', '达到预期', '3', '7', '2018-01-22 16:59:39', '97.83', '2019-03-15 10:05:37');
INSERT INTO `appraisals` VALUES ('13', '2019', '年中', '30.00', '99.00', '达到预期', '3', '7', '2019-01-22 17:00:08', '99.50', '2019-03-15 10:05:37');
INSERT INTO `appraisals` VALUES ('14', '2019', '年中', '30.00', '99.00', '达到预期', '3', '7', '2018-01-22 17:00:19', '99.50', '2019-03-15 10:05:37');
INSERT INTO `appraisals` VALUES ('15', '2019', '转正', '30.00', '99.00', '达到预期', '9', '7', '2019-01-22 17:01:12', '99.50', '2019-03-15 10:05:37');
INSERT INTO `appraisals` VALUES ('16', '2019', '年中', '10.00', '90.00', '低于预期', '4', '7', '2019-01-22 17:19:25', '61.67', '2019-03-15 10:05:37');
INSERT INTO `appraisals` VALUES ('17', '2019', '年中', '20.00', '99.00', '达到预期', '1', '7', '2019-01-23 10:43:50', '82.83', '2019-03-15 10:05:37');
INSERT INTO `appraisals` VALUES ('18', '2019', '年中', '29.99', '99.00', '达到预期', '1', '7', '2019-01-23 10:44:32', '99.48', '2019-03-15 10:05:37');
INSERT INTO `appraisals` VALUES ('19', '2018', '年末', '20.00', '90.00', '达到预期', '4', '7', '2019-03-11 13:18:00', '0.00', '2019-03-15 10:05:37');
INSERT INTO `appraisals` VALUES ('20', '2019', '年中', '21.00', '90.00', '达到预期', '4', '7', '2019-03-11 10:30:08', '80.00', '2019-03-15 10:05:37');
INSERT INTO `appraisals` VALUES ('21', '2019', '年中', '20.00', '90.00', '达到预期', '9', '7', '2019-03-11 11:57:07', '78.33', '2019-03-15 10:05:37');
INSERT INTO `appraisals` VALUES ('22', '2019', '年中', '30.00', '90.00', '达到预期', '9', '7', '2019-03-11 11:58:08', '95.00', '2019-03-15 10:05:37');
INSERT INTO `appraisals` VALUES ('23', '2019', '年末', '30.00', '90.00', '达到预期', '4', '7', '2019-03-11 13:16:50', '95.00', '2019-03-15 10:05:37');

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `Author` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `Photo` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `PhotoHD` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `MemberId` int(11) DEFAULT NULL,
  `average_score` int(11) NOT NULL DEFAULT '0',
  `resource` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `state` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0可借，1已借，2丢失',
  `last_comment` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES ('1', '234', '12', '/files/uploads/71ac74fff9b24507b52fe4ab031b8c2dpart.jpeg', '/files/uploads/71ac74fff9b24507b52fe4ab031b8c2d.jpeg', '0', '2', '研究院购买', '0', '12312', '2019-03-12 14:07:47', '2019-03-12 14:29:08');
INSERT INTO `book` VALUES ('2', 'wqewq', 'qwe', '/files/uploads/f67b01ebda504cceb05e1ce533c0ba70part.jpeg', '/files/uploads/f67b01ebda504cceb05e1ce533c0ba70.jpeg', '0', '0', '研究院购买', '2', '丢失原因:werew', '2019-03-12 14:29:16', '2019-03-12 14:43:03');
INSERT INTO `book` VALUES ('3', '123', '11', '/files/uploads/8b250465493b4704beec08157ff1460epart.jpeg', '/files/uploads/8b250465493b4704beec08157ff1460e.jpeg', '0', '0', '研究院购买', '0', null, '2019-03-15 19:09:50', '2019-03-15 19:09:49');

-- ----------------------------
-- Table structure for book_comment
-- ----------------------------
DROP TABLE IF EXISTS `book_comment`;
CREATE TABLE `book_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `book_id` int(11) NOT NULL,
  `member_id` int(255) NOT NULL,
  `comment` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `score` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of book_comment
-- ----------------------------
INSERT INTO `book_comment` VALUES ('1', '2019-02-13 13:19:11', '2019-02-14 20:17:09', '1', '7', '123321', '5');
INSERT INTO `book_comment` VALUES ('2', '2019-02-13 13:19:10', '2019-02-25 14:42:53', '1', '1', '11111123111111111123111111111', '0');
INSERT INTO `book_comment` VALUES ('3', '2019-02-13 13:19:12', '2019-02-25 14:42:52', '2', '7', '123321123111111111123111111111123111111111123111111111', '0');
INSERT INTO `book_comment` VALUES ('4', '2019-02-14 19:37:52', '2019-02-25 14:42:51', '1', '7', '000000000123111111111123111111111', '0');
INSERT INTO `book_comment` VALUES ('5', '2019-02-21 19:24:09', '2019-02-21 19:24:09', '13', '7', '', '0');
INSERT INTO `book_comment` VALUES ('6', '2019-02-21 19:32:39', '2019-02-21 19:32:39', '13', '7', '', '0');
INSERT INTO `book_comment` VALUES ('7', '2019-02-21 19:37:17', '2019-02-21 19:37:17', '13', '7', '', '0');
INSERT INTO `book_comment` VALUES ('8', '2019-02-21 19:43:55', '2019-02-21 19:43:55', '13', '7', '', '0');
INSERT INTO `book_comment` VALUES ('9', '2019-02-21 19:46:44', '2019-02-21 19:46:44', '13', '7', '', '0');
INSERT INTO `book_comment` VALUES ('10', '2019-02-22 10:10:31', '2019-02-22 10:10:31', '13', '7', '', '0');
INSERT INTO `book_comment` VALUES ('11', '2019-02-22 10:13:05', '2019-02-22 10:13:05', '13', '7', '4444', '4');
INSERT INTO `book_comment` VALUES ('12', '2019-02-22 11:30:19', '2019-02-26 16:25:28', '13', '7', '不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看好看', '4');
INSERT INTO `book_comment` VALUES ('13', '2019-02-24 09:35:30', '2019-02-26 16:06:31', '13', '7', '12311111123111111111123111111111123111111111123111111111123111111111123111111123111111111123111111111123111111111123111111111123111111111123111111123111111111123111111111123111111111123111111111123111111111123111111111112311111111112311111111112311111111', '0');
INSERT INTO `book_comment` VALUES ('14', '2019-02-24 09:37:29', '2019-02-25 14:42:48', '13', '7', 'undefined123111111111123111111111123111111111123111111111123111111111', '0');
INSERT INTO `book_comment` VALUES ('15', '2019-02-24 09:44:15', '2019-02-25 14:42:50', '13', '7', '324234123111111111123111111111123111111111123111111111123111111111', '5');
INSERT INTO `book_comment` VALUES ('16', '2019-02-25 18:55:23', '2019-02-25 18:55:23', '20', '7', '', '5');
INSERT INTO `book_comment` VALUES ('17', '2019-02-26 16:22:02', '2019-02-26 16:23:14', '19', '7', '不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看不好看好看', '5');
INSERT INTO `book_comment` VALUES ('18', '2019-02-26 17:17:41', '2019-02-26 17:17:41', '22', '7', '1231', '5');
INSERT INTO `book_comment` VALUES ('19', '2019-02-26 17:59:46', '2019-02-26 17:59:46', '22', '7', 'ioioio', '4');
INSERT INTO `book_comment` VALUES ('20', '2019-02-26 18:01:41', '2019-02-26 18:01:41', '22', '7', 'sadadasd', '5');
INSERT INTO `book_comment` VALUES ('21', '2019-02-26 18:03:44', '2019-02-26 18:03:44', '22', '7', '898989', '5');
INSERT INTO `book_comment` VALUES ('22', '2019-02-26 18:04:15', '2019-02-26 18:04:15', '22', '7', '4454444', '1');
INSERT INTO `book_comment` VALUES ('23', '2019-02-26 18:06:04', '2019-02-26 18:06:04', '22', '7', 'http://1图书自助页面：权限：需要登录            管理员： 添加、丢失、详情（可编辑）、借阅，归还            ', '5');
INSERT INTO `book_comment` VALUES ('24', '2019-02-26 18:06:53', '2019-02-26 18:06:53', '22', '7', '32423', '4');
INSERT INTO `book_comment` VALUES ('25', '2019-02-26 18:07:47', '2019-02-26 18:07:47', '22', '7', 'weqeq', '4');
INSERT INTO `book_comment` VALUES ('26', '2019-02-26 18:08:41', '2019-02-26 18:08:41', '22', '7', '123123', '3');
INSERT INTO `book_comment` VALUES ('27', '2019-02-26 18:09:46', '2019-02-26 18:09:46', '22', '7', '123123', '4');
INSERT INTO `book_comment` VALUES ('28', '2019-02-26 18:11:44', '2019-02-26 18:11:44', '22', '7', '435345', '4');
INSERT INTO `book_comment` VALUES ('29', '2019-02-26 18:14:27', '2019-02-26 18:14:27', '22', '7', 'qweqwe', '4');
INSERT INTO `book_comment` VALUES ('30', '2019-02-26 18:15:03', '2019-02-26 18:15:03', '22', '7', '2312312', '4');
INSERT INTO `book_comment` VALUES ('31', '2019-02-26 18:19:18', '2019-02-26 18:19:18', '22', '7', '132', '4');
INSERT INTO `book_comment` VALUES ('32', '2019-02-26 18:20:42', '2019-02-26 18:20:42', '22', '7', '456456', '5');
INSERT INTO `book_comment` VALUES ('33', '2019-02-26 18:27:35', '2019-02-26 18:27:35', '22', '7', '13123', '5');
INSERT INTO `book_comment` VALUES ('34', '2019-02-26 18:29:13', '2019-02-26 18:29:13', '22', '7', '21312', '4');
INSERT INTO `book_comment` VALUES ('35', '2019-02-26 18:29:48', '2019-02-26 18:29:48', '22', '7', '211', '5');
INSERT INTO `book_comment` VALUES ('36', '2019-02-26 18:30:57', '2019-02-26 18:30:57', '22', '7', '432', '4');
INSERT INTO `book_comment` VALUES ('37', '2019-02-26 18:40:21', '2019-02-26 18:40:21', '22', '7', '1242', '2');
INSERT INTO `book_comment` VALUES ('38', '2019-02-26 18:41:54', '2019-02-26 18:41:54', '22', '7', '456', '4');
INSERT INTO `book_comment` VALUES ('39', '2019-02-26 18:43:18', '2019-02-26 18:43:18', '22', '7', '1312', '4');
INSERT INTO `book_comment` VALUES ('40', '2019-02-26 18:44:24', '2019-02-26 18:44:24', '22', '7', 'fdsdfs', '4');
INSERT INTO `book_comment` VALUES ('41', '2019-02-26 18:45:39', '2019-02-26 18:45:39', '22', '7', 'rter', '4');
INSERT INTO `book_comment` VALUES ('42', '2019-02-26 18:46:30', '2019-02-26 18:46:30', '22', '7', 'dsfsd', '4');
INSERT INTO `book_comment` VALUES ('43', '2019-02-26 18:49:24', '2019-02-26 18:49:24', '22', '7', '4536543', '3');
INSERT INTO `book_comment` VALUES ('44', '2019-02-26 18:51:52', '2019-02-26 18:51:52', '22', '7', '546', '4');
INSERT INTO `book_comment` VALUES ('45', '2019-02-26 18:55:04', '2019-02-26 18:55:04', '22', '7', '1456', '5');
INSERT INTO `book_comment` VALUES ('46', '2019-02-26 18:56:56', '2019-02-26 18:56:56', '22', '7', '456', '5');
INSERT INTO `book_comment` VALUES ('47', '2019-02-26 18:58:20', '2019-02-26 18:58:20', '22', '7', '1321', '5');
INSERT INTO `book_comment` VALUES ('48', '2019-02-26 19:22:10', '2019-02-26 19:22:10', '22', '7', '43543', '4');
INSERT INTO `book_comment` VALUES ('49', '2019-02-26 19:22:44', '2019-02-26 19:22:44', '22', '7', '234234', '4');
INSERT INTO `book_comment` VALUES ('50', '2019-02-26 19:23:24', '2019-02-26 19:23:24', '22', '7', '23123', '4');
INSERT INTO `book_comment` VALUES ('51', '2019-02-26 19:23:53', '2019-02-26 19:23:53', '22', '7', '35435345', '4');
INSERT INTO `book_comment` VALUES ('52', '2019-02-26 19:25:26', '2019-02-26 19:25:26', '22', '7', '111', '4');
INSERT INTO `book_comment` VALUES ('53', '2019-02-26 19:25:49', '2019-02-26 19:25:49', '22', '7', '12312', '4');
INSERT INTO `book_comment` VALUES ('54', '2019-02-26 19:26:00', '2019-02-26 19:26:00', '22', '7', '1111111111111111', '3');
INSERT INTO `book_comment` VALUES ('55', '2019-02-27 09:08:32', '2019-02-27 09:08:32', '22', '7', 'qweqwe', '5');
INSERT INTO `book_comment` VALUES ('56', '2019-02-27 09:22:57', '2019-02-27 09:22:57', '24', '7', '真的是非常好的书，认真读完，推荐大家也读一下，哈哈哈', '5');
INSERT INTO `book_comment` VALUES ('57', '2019-02-27 09:33:11', '2019-02-27 09:33:11', '22', '7', '4354354334435555555555555555555555555555555555555555555555555555555555555555555555555', '4');
INSERT INTO `book_comment` VALUES ('58', '2019-02-27 09:34:23', '2019-02-27 09:34:23', '23', '9', '还是不错的', '4');
INSERT INTO `book_comment` VALUES ('59', '2019-02-27 09:40:39', '2019-02-27 09:40:39', '25', '9', '德鲁克认为，并不是有了工作才有目标，而是相反，有了目标才能确定每个人的工作。所以“企业的使命和任务，必须转化为目标”，如果一个领域没有目标，这个领域的工作必然被忽视。', '5');
INSERT INTO `book_comment` VALUES ('60', '2019-02-27 10:30:25', '2019-02-27 10:30:25', '25', '7', '33333', '5');
INSERT INTO `book_comment` VALUES ('61', '2019-03-01 14:13:38', '2019-03-01 14:13:38', '23', '7', '用 Dart 2 Common Front-End (CFE) 构建新的语言特性 – 你现在可以实现 set literals，这在起初只作为 CFE 的特性。后端可以先使用 CFE 的实现，之后再独立地后端的原生支持。这使后端可以延迟原生支持，直到对新特性的性能部分有了更好的理解。', '5');
INSERT INTO `book_comment` VALUES ('62', '2019-07-04 10:17:46', '2019-07-04 10:17:46', '23', '7', '123', '1');
INSERT INTO `book_comment` VALUES ('63', '2019-03-12 14:08:02', '2019-03-12 14:08:02', '1', '7', '3423', '3');
INSERT INTO `book_comment` VALUES ('64', '2019-03-12 14:29:08', '2019-03-12 14:29:08', '1', '7', '12312', '4');

-- ----------------------------
-- Table structure for contribution_standard
-- ----------------------------
DROP TABLE IF EXISTS `contribution_standard`;
CREATE TABLE `contribution_standard` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `ParentId` int(11) NOT NULL,
  `Name` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `Level` int(11) NOT NULL,
  `CreatedTime` datetime NOT NULL,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of contribution_standard
-- ----------------------------
INSERT INTO `contribution_standard` VALUES ('1', '0', '贡献值', '1', '2018-11-23 10:18:33', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('2', '1', '完成任务', '2', '2018-11-27 10:59:34', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('3', '1', '积分调整', '2', '2018-11-27 11:04:04', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('4', '2', '任务完成情况', '3', '2018-11-27 11:33:25', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('5', '2', '基础得分计算', '3', '2018-11-27 11:39:35', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('7', '5', '（截止日期-参与日期）的天数', '4', '2018-11-27 11:43:10', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('8', '4', '完成所有关键结果', '4', '2018-11-27 11:43:33', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('9', '3', '调整事项', '3', '2018-11-27 11:44:10', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('10', '3', '逐项检查，定级，加分', '3', '2018-11-27 11:44:30', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('13', '10', '三级=小规模收益，+5分', '4', '2018-11-27 12:29:26', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('16', '12', '有', '5', '2018-11-27 12:30:14', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('17', '12', '没有', '5', '2018-11-27 12:30:42', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('22', '4', '没有影响正常使用的BUG', '4', '2018-12-11 16:54:03', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('27', '26', '难度超过预期', '5', '2018-12-11 16:55:52', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('28', '26', '难度符合预期', '5', '2018-12-11 16:56:15', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('29', '26', '难度低于预期', '5', '2018-12-11 16:56:28', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('30', '6', '提出需求上的创新', '4', '2018-12-11 16:57:46', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('31', '6', '提出用户体验上的改进方案', '4', '2018-12-11 16:58:04', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('34', '18', '做到', '5', '2018-12-11 16:59:05', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('35', '18', '做不到', '5', '2018-12-11 16:59:19', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('36', '9', '用户体验非常好', '4', '2018-12-11 17:00:09', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('37', '9', '超额完成任务', '4', '2018-12-11 17:00:19', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('38', '9', '超出预期的创新', '4', '2018-12-11 17:00:34', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('42', '41', '大幅早于截至日期', '5', '2018-12-11 17:37:01', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('43', '41', '截至日期左右', '5', '2018-12-11 17:37:13', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('44', '41', '大幅晚于截至日期', '5', '2018-12-11 17:38:08', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('45', '30', '有', '5', '2018-12-11 17:44:52', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('46', '30', '没有', '5', '2018-12-11 17:45:04', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('47', '31', '有', '5', '2018-12-11 17:47:48', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('48', '31', '没有', '5', '2018-12-11 17:47:58', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('55', '11', '开发额外的工具', '4', '2018-12-11 17:51:33', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('56', '11', '引入提高效率的工具', '4', '2018-12-11 17:51:58', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('57', '55', '有', '5', '2018-12-11 17:52:20', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('58', '55', '没有', '5', '2018-12-11 17:52:30', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('59', '56', '有', '5', '2018-12-11 17:52:37', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('60', '56', '没有', '5', '2018-12-11 17:52:44', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('61', '10', '二级=中等规模收益，+10分', '4', '2018-12-12 15:52:27', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('62', '10', '一级=大规模收益，+20分', '4', '2018-12-12 15:52:51', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('63', '9', '超出预期的重构', '4', '2018-12-12 15:54:13', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('64', '9', '超出预期的优化', '4', '2018-12-12 15:54:25', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('65', '9', '开发额外的辅助工具', '4', '2018-12-12 15:54:39', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('66', '9', '引入提高效率的工具', '4', '2018-12-12 15:54:51', '2019-03-15 10:05:21');
INSERT INTO `contribution_standard` VALUES ('67', '4', '遵守代码规范', '4', '2019-01-04 15:34:35', '2019-03-15 10:05:21');

-- ----------------------------
-- Table structure for feedbacks
-- ----------------------------
DROP TABLE IF EXISTS `feedbacks`;
CREATE TABLE `feedbacks` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Content` text COLLATE utf8mb4_bin NOT NULL,
  `MemberId` int(11) DEFAULT NULL,
  `ProviderId` int(11) DEFAULT NULL,
  `CreatedTime` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `ProviderName` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of feedbacks
-- ----------------------------
INSERT INTO `feedbacks` VALUES ('67', 0xE6B7BBE58AA0E58F8DE9A688, '4', '7', '2019-01-22 16:41:31', null, '2019-03-15 10:05:13', '2019-03-15 10:05:13');
INSERT INTO `feedbacks` VALUES ('68', 0x3132333132, '2', '7', '2019-03-14 18:57:29', null, '2019-03-15 10:05:13', '2019-03-15 10:05:13');

-- ----------------------------
-- Table structure for fund
-- ----------------------------
DROP TABLE IF EXISTS `fund`;
CREATE TABLE `fund` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `ItemName` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `InsertTime` datetime DEFAULT NULL,
  `Description` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `OperatMoney` decimal(15,2) DEFAULT NULL,
  `RemainMoney` decimal(15,2) DEFAULT '0.00',
  `MemberId` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=198 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of fund
-- ----------------------------
INSERT INTO `fund` VALUES ('174', '1111', '2019-02-11 15:32:54', '11111111111111', '-1.00', '-1.00', '7', '2019-03-15 10:05:01', '2019-03-15 10:05:01');
INSERT INTO `fund` VALUES ('175', '11111', '2019-02-11 15:36:26', '11111', '-1.00', '-2.00', '7', '2019-03-15 10:05:01', '2019-03-15 10:05:01');
INSERT INTO `fund` VALUES ('176', '1321', '2019-02-12 09:12:05', '213123', '-11.00', '-13.00', '7', '2019-03-15 10:05:01', '2019-03-15 10:05:01');
INSERT INTO `fund` VALUES ('177', '213123', '2019-02-12 09:12:16', '123', '123.00', '110.00', '7', '2019-03-15 10:05:01', '2019-03-15 10:05:01');
INSERT INTO `fund` VALUES ('178', '111', '2019-02-12 09:13:55', '11', '11.00', '121.00', '7', '2019-03-15 10:05:01', '2019-03-15 10:05:01');
INSERT INTO `fund` VALUES ('179', '123', '2019-02-12 09:14:13', '111', '-11.00', '110.00', '7', '2019-03-15 10:05:01', '2019-03-15 10:05:01');
INSERT INTO `fund` VALUES ('180', '2q3', '2019-02-12 10:58:43', '111', '-11.00', '99.00', '7', '2019-03-15 10:05:01', '2019-03-15 10:05:01');
INSERT INTO `fund` VALUES ('181', '11', '2019-02-13 11:59:42', '11', '-1.00', '98.00', '7', '2019-03-15 10:05:01', '2019-03-15 10:05:01');
INSERT INTO `fund` VALUES ('182', '11', '2019-02-13 14:56:28', '11', '-1.00', '97.00', '7', '2019-03-15 10:05:01', '2019-03-15 10:05:01');
INSERT INTO `fund` VALUES ('183', '1', '2019-02-14 17:36:33', '多伦多海鲜自助(万达广场颛桥店)', '-1.00', '96.00', '7', '2019-03-15 10:05:01', '2019-03-15 10:05:01');
INSERT INTO `fund` VALUES ('184', '1', '2019-02-14 17:37:45', '多伦多海鲜自助(万达广场颛桥店)', '-1.00', '95.00', '7', '2019-03-15 10:05:01', '2019-03-15 10:05:01');
INSERT INTO `fund` VALUES ('185', '123', '2019-02-15 12:32:59', '11', '-11.00', '84.00', '7', '2019-03-15 10:05:01', '2019-03-15 10:05:01');
INSERT INTO `fund` VALUES ('186', '123', '2019-02-15 14:27:23', '大石安防高清视界体验中心', '-11.00', '73.00', '7', '2019-03-15 10:05:01', '2019-03-15 10:05:01');
INSERT INTO `fund` VALUES ('187', '11', '2019-02-15 14:29:12', '水岸东方(公交站)', '-11.00', '62.00', '7', '2019-03-15 10:05:01', '2019-03-15 10:05:01');
INSERT INTO `fund` VALUES ('188', '123', '2019-02-15 14:29:55', '浅味染烫吧', '-1.00', '61.00', '7', '2019-03-15 10:05:01', '2019-03-15 10:05:01');
INSERT INTO `fund` VALUES ('189', '123', '2019-02-15 14:32:05', ' ', '-11.00', '50.00', '7', '2019-03-15 10:05:01', '2019-03-15 10:05:01');
INSERT INTO `fund` VALUES ('190', '1', '2019-02-15 14:36:30', '九寨沟(暂停营业)', '-1.00', '49.00', '7', '2019-03-15 10:05:01', '2019-03-15 10:05:01');
INSERT INTO `fund` VALUES ('191', 'qwe++wqeqwae', '2019-02-15 15:48:42', ' ', '-1.00', '48.00', '7', '2019-03-15 10:05:01', '2019-03-15 10:05:01');
INSERT INTO `fund` VALUES ('192', '123', '2019-02-15 15:51:48', '112312', '-11.00', '37.00', '7', '2019-03-15 10:05:01', '2019-03-15 10:05:01');
INSERT INTO `fund` VALUES ('193', '123', '2019-02-15 15:51:55', null, '-1.00', '36.00', '7', '2019-03-15 10:05:01', '2019-03-15 10:05:01');
INSERT INTO `fund` VALUES ('194', '24234', '2019-02-26 18:33:42', 'AE依酷', '-11.00', '25.00', '7', '2019-03-15 10:05:01', '2019-03-15 10:05:01');
INSERT INTO `fund` VALUES ('195', '4546', '2019-03-12 11:02:01', '甘南花园', '-44.00', '-19.00', '7', '2019-03-15 10:05:01', '2019-03-15 10:05:01');
INSERT INTO `fund` VALUES ('196', '12312', '2019-03-12 14:30:36', 'We+', '-11.00', '-30.00', '7', '2019-03-15 10:05:01', '2019-03-15 10:05:01');
INSERT INTO `fund` VALUES ('197', '2123', '2019-03-12 14:34:51', '2123', '-1111.00', '-1141.00', '7', '2019-03-15 10:05:01', '2019-03-15 10:05:01');

-- ----------------------------
-- Table structure for gifts
-- ----------------------------
DROP TABLE IF EXISTS `gifts`;
CREATE TABLE `gifts` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `Hyperlink` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `MemberId` int(11) NOT NULL,
  `CreatedTime` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `CreatedMemberId` int(11) NOT NULL,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of gifts
-- ----------------------------
INSERT INTO `gifts` VALUES ('1', '显示器增高架×2', '178.00', 'https://item.jd.com/4833940.html', '2', '2018-09-20 13:40:08', '1', '2019-03-15 10:04:53');
INSERT INTO `gifts` VALUES ('2', '显示器增高架×2', '178.00', 'https://item.jd.com/4833940.html', '5', '2018-10-11 15:55:01', '1', '2019-03-15 10:04:53');

-- ----------------------------
-- Table structure for integrals
-- ----------------------------
DROP TABLE IF EXISTS `integrals`;
CREATE TABLE `integrals` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `MemberId` int(11) DEFAULT NULL,
  `CreatedTime` datetime DEFAULT NULL,
  `Integral` int(11) DEFAULT NULL,
  `Description` text COLLATE utf8mb4_bin,
  `SourceId` int(11) DEFAULT NULL,
  `SourceType` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of integrals
-- ----------------------------
INSERT INTO `integrals` VALUES ('67', '7', '2019-03-01 00:00:00', '45', 0x3334, '44', 'Tasks', '2019-03-15 10:04:39');
INSERT INTO `integrals` VALUES ('68', '7', '2018-08-24 00:00:00', '25', 0x30313131, '45', 'Tasks', '2019-03-15 10:04:39');
INSERT INTO `integrals` VALUES ('69', '2', '2019-03-08 00:00:00', '1213', '', '49', 'Tasks', '2019-03-15 10:04:39');
INSERT INTO `integrals` VALUES ('70', '2', '2019-03-08 00:00:00', '1213', '', '49', 'Tasks', '2019-03-15 10:04:39');
INSERT INTO `integrals` VALUES ('71', '2', '2019-03-08 00:00:00', '1213', '', '49', 'Tasks', '2019-03-15 10:04:39');
INSERT INTO `integrals` VALUES ('72', '7', '2019-03-08 00:00:00', '21', '', '46', 'Tasks', '2019-03-15 10:04:39');
INSERT INTO `integrals` VALUES ('73', '7', '2019-03-08 00:00:00', '21', '', '46', 'Tasks', '2019-03-15 10:04:39');
INSERT INTO `integrals` VALUES ('74', '7', '2019-03-08 00:00:00', '121', '', '52', 'Tasks', '2019-03-15 10:04:39');
INSERT INTO `integrals` VALUES ('75', '1', '2019-03-08 00:00:00', '10', '', '50', 'Tasks', '2019-03-15 10:04:39');
INSERT INTO `integrals` VALUES ('76', '1', '2019-03-08 00:00:00', '10', 0x61616161, '54', 'Tasks', '2019-03-15 10:04:39');
INSERT INTO `integrals` VALUES ('77', '3', '2019-03-08 00:00:00', '34', 0x3232, '51', 'Tasks', '2019-03-15 10:04:39');
INSERT INTO `integrals` VALUES ('78', '1', '2019-03-08 00:00:00', '2', 0x32, '53', 'Tasks', '2019-03-15 10:04:39');
INSERT INTO `integrals` VALUES ('79', '1', '2019-03-08 00:00:00', '10', 0xE7AC83E5AE9AE588B0, '56', 'Tasks', '2019-03-15 10:04:39');
INSERT INTO `integrals` VALUES ('80', '4', '2019-03-05 17:34:21', '23', 0x34353433, '48', 'Tasks', '2019-03-15 10:04:39');
INSERT INTO `integrals` VALUES ('81', '7', '2019-03-08 15:40:22', '1', '', '72', 'Tasks', '2019-03-15 10:04:39');
INSERT INTO `integrals` VALUES ('82', '7', '2019-03-08 16:59:02', '1', '', '80', 'Tasks', '2019-03-15 10:04:39');
INSERT INTO `integrals` VALUES ('83', '7', '2019-03-08 17:02:54', '1', '', '82', 'Tasks', '2019-03-15 10:04:39');
INSERT INTO `integrals` VALUES ('84', '7', '2019-03-11 10:07:01', '12', '', '86', 'Tasks', '2019-03-15 10:04:39');
INSERT INTO `integrals` VALUES ('85', '7', '2019-03-11 10:13:32', '21', '', '87', 'Tasks', '2019-03-15 10:04:39');
INSERT INTO `integrals` VALUES ('86', '4', '2019-03-11 10:31:52', '10000', 0x667365, null, null, '2019-03-15 10:04:39');
INSERT INTO `integrals` VALUES ('87', '9', '2019-03-11 12:00:11', '12', 0x313233, null, null, '2019-03-15 10:04:39');
INSERT INTO `integrals` VALUES ('88', '9', '2019-03-11 12:01:15', '123', 0x646173666473616664736166, null, null, '2019-03-15 10:04:39');
INSERT INTO `integrals` VALUES ('89', '3', '2019-03-11 12:03:52', '10', '', '89', 'Tasks', '2019-03-15 10:04:39');
INSERT INTO `integrals` VALUES ('90', '3', '2019-03-11 12:03:52', '10', '', '89', 'Tasks', '2019-03-15 10:04:39');
INSERT INTO `integrals` VALUES ('91', '3', '2019-03-11 12:03:52', '10', '', '89', 'Tasks', '2019-03-15 10:04:39');
INSERT INTO `integrals` VALUES ('92', '2', '2019-03-14 18:56:29', '1', 0x3132333132, null, null, '2019-03-15 10:04:39');
INSERT INTO `integrals` VALUES ('93', '3', '2019-03-15 13:33:17', '11', '', '91', 'Tasks', '2019-03-15 13:33:31');
INSERT INTO `integrals` VALUES ('94', '5', '2019-03-15 13:33:17', '12', '', '91', 'Tasks', '2019-03-15 13:33:31');

-- ----------------------------
-- Table structure for introductions
-- ----------------------------
DROP TABLE IF EXISTS `introductions`;
CREATE TABLE `introductions` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `Content` text COLLATE utf8mb4_bin,
  `Type` int(11) DEFAULT NULL COMMENT '1.介绍',
  `CreateUser` int(11) DEFAULT NULL,
  `UpdateUser` int(11) DEFAULT NULL,
  `CreateTime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `UpdateTime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`),
  KEY `article_ibfk_1` (`CreateUser`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of introductions
-- ----------------------------

-- ----------------------------
-- Table structure for keyresults
-- ----------------------------
DROP TABLE IF EXISTS `keyresults`;
CREATE TABLE `keyresults` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `LastUpdateMemberId` int(11) DEFAULT NULL,
  `CreateTime` datetime DEFAULT NULL,
  `Status` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '开放，关闭',
  `ClosedMemberId` int(11) DEFAULT NULL,
  `ClosedTime` datetime DEFAULT NULL,
  `Remark` text COLLATE utf8mb4_bin COMMENT '备注',
  `LastUpdateTime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `TaskId` int(11) DEFAULT NULL,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of keyresults
-- ----------------------------
INSERT INTO `keyresults` VALUES ('1', '数据统计（增量数据和总数据）\r\n', '1', '2018-12-10 15:46:52', '关闭', '1', '2018-12-10 15:46:55', 0xEFBC8831EFBC89E7BB9FE8AEA1E68980E69C89E688BFE6BA90EFBC8CE58FAFE4BBA5E68C89E59F8EE5B882E7AD9BE980890D0AEFBC8832EFBC89E7BB9FE8AEA1E68980E69C89E5AEA2E6BA900D0AEFBC8833EFBC89E7BB9FE8AEA1E68980E69C89E8B79FE8BF9B0D0AEFBC8834EFBC89E7BB9FE8AEA1E68980E69C89E585B6E4BB96E9878DE8A681E5AFB9E8B1A10D0AEFBC8835EFBC89E7BB9FE8AEA1E695B0E68DAEE794A8E98094EFBC9AE68E8CE68FA1E5AE8FE8A782E695B0E68DAEEFBC8CE4B8BAE5A4A7E695B0E68DAEE5A484E79086E68F90E4BE9BE4BE9DE68DAEEFBC8CE58AA8E68081E695B0E68DAEE58F98E58C96E6A380E6B58B, '2018-12-10 15:46:55', '16', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('2', '数据统计（增量数据和总数据）', '5', '2018-12-10 15:47:27', '关闭', '5', '2019-01-04 18:40:12', 0xEFBC8831EFBC89E7BB9FE8AEA1E68980E69C89E688BFE6BA90EFBC8CE58FAFE4BBA5E68C89E59F8EE5B882E7AD9BE980890D0AEFBC8832EFBC89E7BB9FE8AEA1E68980E69C89E5AEA2E6BA900D0AEFBC8833EFBC89E7BB9FE8AEA1E68980E69C89E8B79FE8BF9B0D0AEFBC8834EFBC89E7BB9FE8AEA1E68980E69C89E585B6E4BB96E9878DE8A681E5AFB9E8B1A10D0AEFBC8835EFBC89E7BB9FE8AEA1E695B0E68DAEE794A8E98094EFBC9AE68E8CE68FA1E5AE8FE8A782E695B0E68DAEEFBC8CE4B8BAE5A4A7E695B0E68DAEE5A484E79086E68F90E4BE9BE4BE9DE68DAEEFBC8CE58AA8E68081E695B0E68DAEE58F98E58C96E6A380E6B58B, '2019-01-04 18:40:12', '16', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('3', '性能监测页面', '5', '2018-12-10 15:47:43', '关闭', '5', '2019-01-04 18:40:10', 0xEFBC8831EFBC89E98787E794A8E9BB91E79B92E6A8A1E5BC8FEFBC8CE5AE9AE69C9FE8AEBFE997AEE6AF8FE4B8AAE59F8EE5B882E88A82E782B9E79A84E4B8BBE8A681536572766963650D0AEFBC8832EFBC89E8AEB0E5BD95E79BB8E5BA94E697B6E997B40D0AEFBC8833EFBC89E79B91E68EA7E58F98E58C960D0AEFBC8834EFBC89E588B6E5AE9AE7BAA2E9BB84E7BBBFE68C87E6A087EFBC8CE5B9B6E7BB99E4BA88E68F90E7A4BA0D0AEFBC8835EFBC89E680A7E883BDE79B91E6B58BE794A8E98094EFBC9AE68E8CE68EA7E6A2B5E8AEAFE68980E69C89E5BA94E794A8E79A84E8BF90E8A18CE680A7E883BDEFBC8CE7BB99E4BA88E68A80E69CAFE8BF90E890A5E59BA2E9989FE4B880E4B8AAE58F82E88083EFBC8CE5908CE697B6E4B8BAE7A094E7A9B6E999A2E689BEE588B0E7A88BE5BA8FE69EB6E69E84E79A84E4BC98E58C96E782B9EFBC8CE7BB99E7A094E58F91E59BA2E9989FE7BB99E587BAE8A7A3E586B3E696B9E6A188, '2019-01-04 18:40:10', '16', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('4', '任务展示升级：任务看板，任务视图，计划视图，任务点评，任务详情。', '1', '2018-12-11 09:10:51', '关闭', '1', '2018-12-11 09:12:51', null, '2018-12-11 09:12:51', '10', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('5', '技能太多的时候挤在一块问题修复', '1', '2018-12-11 09:11:36', '关闭', '1', '2018-12-11 09:12:56', null, '2018-12-11 09:12:56', '10', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('6', '勋章分等级', '1', '2018-12-11 09:11:46', '关闭', '1', '2018-12-11 09:12:59', null, '2018-12-11 09:12:59', '10', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('7', '增加爱好，座右铭，花名和标签', '1', '2018-12-11 09:12:06', '关闭', '1', '2018-12-11 09:13:04', null, '2018-12-11 09:13:04', '10', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('8', '性能优化', '1', '2018-12-11 09:12:16', '关闭', '1', '2018-12-17 09:36:45', null, '2018-12-17 09:36:45', '10', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('9', '增加团建管理功能', '1', '2018-12-11 09:12:37', '关闭', null, null, null, '2019-01-09 09:12:42', '10', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('10', '根据用户使用情况计算房源关联度的值', '1', '2018-12-11 09:13:52', '关闭', null, null, null, '2019-01-09 09:14:19', '5', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('11', '可扩展的大数据计算平台', '1', '2018-12-11 09:14:09', '关闭', '1', '2019-01-08 14:30:50', null, '2019-01-08 14:30:50', '5', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('12', '框架基础搭建', '1', '2018-12-12 09:15:14', '关闭', '1', '2019-01-02 11:32:42', 0xE58C85E68BACE6A186E69EB6E79A84E59FBAE69CACE7BB84E68890E983A8E58886EFBC9AE5AEA2E688B7E7ABAFE79A84E5AD98E582A8E5928CE58A9FE883BDE6A8A1E59D97EFBC8CE69C8DE58AA1E599A8E7ABAFE79A84E5AD98E582A8E5928C415049E6A8A1E59D97, '2019-01-02 11:32:42', '3', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('13', '添加常用的Action：打开软件，关闭软件，登录，添加房源', '1', '2018-12-12 09:16:13', '关闭', '1', '2019-01-02 11:32:39', null, '2019-01-02 11:32:39', '3', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('14', '数据库自动备份和下载系统\r\n', '7', '2018-12-17 09:32:17', '关闭', '7', '2019-01-23 10:19:31', null, '2019-01-23 10:19:31', '17', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('15', '五天免登录的效果\r\n', '7', '2018-12-17 09:32:29', '关闭', '7', '2019-01-23 10:19:29', null, '2019-01-23 10:19:29', '17', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('16', '增加团建活动页面\r\n', '7', '2018-12-17 09:32:42', '关闭', '7', '2019-01-23 10:19:33', null, '2019-01-23 10:19:33', '17', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('17', '增加图书管理页面\r\n', '7', '2018-12-17 09:33:22', '关闭', '7', '2019-01-23 10:19:27', 0x6129E58EBBE68E89E58E9FE69DA5E38090E68891E8AFBBE8BF87E79A84E4B9A6E38091E5908EE99DA2E79A84E6B7BBE58AA0E4B9A6E7B18DE68C89E992AEEFBC8CE7A7BBE588B0E99885E8AFBBE5AE8CE68890E697B6E8AF84E58886EFBC8CE6B7BBE58AA0E8AF84E4BBB70D0A6229E38090E68891E8AFBBE8BF87E79A84E4B9A6E38091E58897E8A1A8E4B8ADE79A84E4BFAEE694B9E58A9FE883BDE4BB8DE784B6E4BF9DE795990D0A6329E69D83E99990E79A84E5809FE99885EFBC8CE8AF84E4BBB7EFBC8CE696B0E5A29EEFBC8CE4B8A2E5A4B1E5BCB9E6A1860D0A, '2019-01-23 10:19:27', '17', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('18', '集成STA后台功能', '1', '2018-12-17 09:33:54', '未完成', null, null, 0xE694B6E58F91E982AEE4BBB6EFBC8CE8AFB7E58187E5928CE9809AE8AEAFE5BD95E79A84E58A9FE883BDEFBC8CE585B3E88194535441E5908EE58FB0E8B4A6E58FB7E799BBE5BD95, '2018-12-18 14:21:44', '17', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('19', '任务进度板增加成员视图', '7', '2018-12-17 09:34:31', '关闭', '7', '2019-01-23 10:19:25', null, '2019-01-23 10:19:25', '17', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('20', '绩效报表和考评页面', '7', '2018-12-17 09:34:53', '关闭', '7', '2019-01-23 10:19:34', 0xE585B7E4BD93E79C8BE8AEBEE8AEA1, '2019-01-23 10:19:34', '17', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('21', '例会在线PPT生成和查阅', '1', '2018-12-17 09:35:07', '未完成', null, null, 0xE585B7E4BD93E79C8BE8AEBEE8AEA1, '2019-01-02 16:20:03', '17', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('22', '季度会议在线PPT生成和查阅', '1', '2018-12-17 09:35:19', '未完成', null, null, 0xE585B7E4BD93E79C8BE8AEBEE8AEA1, '2019-01-02 16:20:00', '17', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('23', '经纪人PR值的计算', '1', '2018-12-26 11:19:59', '关闭', null, null, 0xE8A1A1E9878FE7BB8FE7BAAAE4BABAE99DA0E8B0B1E4B88DE99DA0E8B0B1E79A84E68C87E695B0, '2019-01-09 09:14:19', '5', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('24', '房源PR值的计算', '1', '2018-12-26 11:20:25', '关闭', null, null, 0xE8A1A1E9878FE7B1BBE4BCBCE4BA8EE688BFE6BA90E4BBB7E580BCE79A84E68C87E695B0, '2019-01-09 09:14:19', '5', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('25', '课件：大纲，PPT，代码案例', '1', '2018-12-27 16:57:16', '关闭', '1', '2019-01-21 11:14:51', null, '2019-01-21 11:14:51', '13', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('26', '课程', '1', '2018-12-27 16:57:26', '关闭', '1', '2019-01-21 11:14:53', null, '2019-01-21 11:14:53', '13', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('27', '根据用户使用情况计算房源关联度的值', '1', '2019-01-02 14:12:19', '未完成', null, null, null, '2019-01-02 14:12:19', '19', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('28', '房源PR值的计算', '1', '2019-01-02 14:13:07', '未完成', null, null, 0xE8A1A1E9878FE7B1BBE4BCBCE4BA8EE688BFE6BA90E4BBB7E580BCE79A84E68C87E695B0, '2019-01-02 14:13:07', '19', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('29', '经纪人和公司PR值的计算', '1', '2019-01-02 14:13:58', '未完成', null, null, 0xE8A1A1E9878FE585ACE58FB8E5928CE7BB8FE7BAAAE4BABAE99DA0E8B0B1E4B88DE99DA0E8B0B1E79A84E68C87E695B0, '2019-01-02 14:13:58', '19', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('30', '封装好的软件控件', '7', '2019-01-02 14:34:48', '关闭', '7', '2019-01-22 16:57:14', null, '2019-01-22 16:57:14', '18', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('31', 'XML正确解析和运行', '7', '2019-01-02 14:35:50', '关闭', '7', '2019-01-22 16:57:10', null, '2019-01-22 16:57:10', '18', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('32', '数据交互接口', '7', '2019-01-02 14:36:16', '关闭', '7', '2019-01-22 16:57:12', null, '2019-01-22 16:57:12', '18', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('33', '调整后的软件界面', '7', '2019-01-02 14:36:51', '关闭', '7', '2019-01-22 16:57:08', null, '2019-01-22 16:57:08', '18', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('34', '优化页面长时间不点击，响应比较慢的问题', '7', '2019-01-02 16:22:54', '关闭', '7', '2019-01-23 10:19:19', null, '2019-01-23 10:19:19', '17', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('35', '小问题调整', '7', '2019-01-02 16:24:37', '关闭', '7', '2019-01-23 10:19:16', 0x312EE4B8AAE4BABAE8AFA6E68385E9A1B5E99DA2E8B083E695B40D0A322EE4B8AAE4BABAE6A087E7ADBEE694B9E68890E5BDA9E889B2E698BEE7A4BA0D0A332EE88083E8AF84E5BCB9E6A186E8B083E695B40D0A342EE58B8BE7ABA0E698BEE7A4BAE9A1BAE5BA8FE8B083E695B40D0A352EE782B9E8AF84E9A1B5E99DA2425547E4BFAEE5A48D0D0A362EE4BBBBE58AA1E9A1B5E99DA2425547E4BFAEE5A48D, '2019-01-23 10:19:16', '17', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('36', '表格列支持排序', '5', '2019-01-04 18:29:04', '关闭', '5', '2019-01-15 14:25:04', null, '2019-01-15 14:25:04', '20', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('37', '简单的登录窗口，使用公用的密码：fooww/nugget2008\r\n', '5', '2019-01-04 18:29:14', '关闭', '5', '2019-01-15 14:25:15', null, '2019-01-15 14:25:15', '20', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('38', '增加统计个人房源总数，其中二手房总数、租房总数的页面', '5', '2019-01-04 18:29:24', '关闭', '5', '2019-01-21 09:37:39', null, '2019-01-21 09:37:39', '20', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('39', '服务器端安全问题研究', '1', '2019-01-14 12:56:14', '未完成', null, null, null, '2019-01-17 18:23:57', '15', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('40', '服务器端性能研究与优化方案', '7', '2019-01-14 12:56:37', '关闭', '7', '2019-03-01 13:43:27', null, '2019-03-01 13:43:27', '15', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('41', '培训结束后的反馈调查表', '7', '2019-01-21 11:14:26', '关闭', '7', '2019-01-22 16:49:03', null, '2019-01-22 16:49:03', '13', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('42', '课程报名表', '1', '2019-01-21 11:14:44', '关闭', '1', '2019-01-21 11:14:47', null, '2019-01-21 11:14:47', '13', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('43', 'aaa', '7', '2019-01-22 16:44:12', '关闭', '7', '2019-01-22 16:46:51', null, '2019-01-22 16:46:51', '30', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('44', '111', '7', '2019-01-22 16:50:32', '未完成', null, null, null, '2019-01-22 16:50:32', '33', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('45', '灌灌灌灌', '7', '2019-01-22 16:57:28', '未完成', null, null, null, '2019-01-22 16:57:38', '18', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('46', '333', '7', '2019-01-22 17:05:08', '未完成', null, null, null, '2019-01-22 17:05:08', '34', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('47', '1232', '7', '2019-01-22 17:25:14', '未完成', null, null, 0x313233, '2019-01-22 17:25:14', '37', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('48', 'fewt', '7', '2019-01-22 17:34:17', '未完成', null, null, null, '2019-01-22 17:34:17', '39', '2019-03-15 10:04:13');
INSERT INTO `keyresults` VALUES ('49', '22', '7', '2019-01-22 17:34:29', '未完成', null, null, null, '2019-01-22 17:34:29', '39', '2019-03-15 10:04:13');

-- ----------------------------
-- Table structure for likerecords
-- ----------------------------
DROP TABLE IF EXISTS `likerecords`;
CREATE TABLE `likerecords` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `MemberId` int(11) NOT NULL,
  `LikeMeMemberId` int(11) NOT NULL,
  `LastOperateTime` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `OperateType` int(11) NOT NULL DEFAULT '0' COMMENT '点赞=1，加油=2，取消=0',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of likerecords
-- ----------------------------
INSERT INTO `likerecords` VALUES ('1', '6', '2', '2019-01-16 18:02:43', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('2', '1', '2', '2019-01-14 09:17:30', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('3', '2', '2', '2019-01-16 18:02:29', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('4', '3', '2', '2019-01-16 18:02:31', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('5', '4', '2', '2019-01-16 18:02:35', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('6', '5', '2', '2019-01-16 18:02:38', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('7', '5', '4', '2018-12-10 11:12:52', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('8', '1', '1', '2018-12-11 16:12:16', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('9', '2', '1', '2018-12-11 16:12:21', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('10', '3', '1', '2018-12-11 16:12:24', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('11', '4', '1', '2018-12-11 16:12:28', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('12', '5', '1', '2018-12-11 16:12:32', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('13', '7', '1', '2018-12-13 16:52:42', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('14', '7', '7', '2019-01-21 10:42:03', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('15', '1', '4', '2018-12-19 08:31:20', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('16', '7', '2', '2019-01-16 18:02:46', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('17', '1', '3', '2019-01-21 08:39:44', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('18', '2', '3', '2019-01-21 08:39:47', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('19', '3', '3', '2019-01-21 08:40:06', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('20', '4', '3', '2019-01-21 08:40:26', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('21', '5', '3', '2019-01-21 08:40:31', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('22', '6', '3', '2019-01-21 08:40:35', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('23', '7', '3', '2019-01-21 08:40:39', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('24', '6', '6', '2019-01-21 09:24:35', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('25', '7', '4', '2019-01-09 18:41:40', '2', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('26', '1', '6', '2019-01-09 18:55:55', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('27', '2', '6', '2019-01-09 18:55:59', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('28', '3', '6', '2019-01-09 18:56:02', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('29', '4', '6', '2019-01-09 18:56:05', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('30', '5', '6', '2019-01-09 18:56:09', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('31', '7', '6', '2019-01-09 18:56:15', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');
INSERT INTO `likerecords` VALUES ('32', '8', '3', '2019-01-21 08:40:43', '1', '2019-03-15 10:04:02', '2019-03-15 10:04:02');

-- ----------------------------
-- Table structure for medals
-- ----------------------------
DROP TABLE IF EXISTS `medals`;
CREATE TABLE `medals` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Icon` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '1',
  `Name` varchar(20) COLLATE utf8mb4_bin NOT NULL,
  `Description` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `Count` int(11) NOT NULL DEFAULT '0',
  `IsDiscard` bit(1) NOT NULL DEFAULT b'0',
  `CreatedTime` datetime DEFAULT NULL,
  `DiscardTime` datetime DEFAULT NULL,
  `Grade` int(11) NOT NULL,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of medals
-- ----------------------------
INSERT INTO `medals` VALUES ('2', '/files/medals/3b3b699ff4e24089a98a4bf47fb1ce11.png', '力挽狂澜', '在危机时刻做出关键贡献', '0', '\0', '2018-09-10 16:51:59', '0001-01-01 00:00:00', '1', '2019-03-15 10:03:54');
INSERT INTO `medals` VALUES ('3', '/files/medals/3f4f499f7605462ca0ac33252c65813b.png', '未雨绸缪', '成功的阻止一次危机的发生', '0', '\0', '2018-09-10 16:52:19', '0001-01-01 00:00:00', '1', '2019-03-15 10:03:54');
INSERT INTO `medals` VALUES ('4', '/files/medals/4169ac714ec04479af5c00587fdfce2c.png', '突飞猛进', '年度考评成绩相对前一次进步很大', '0', '\0', '2018-09-10 16:52:55', '0001-01-01 00:00:00', '1', '2019-03-15 10:03:54');
INSERT INTO `medals` VALUES ('5', '/files/medals/beade59ec96742608c91a0c8675d5078.png', '独占鳌头', '年度考评总评分数团队第一', '1', '\0', '2018-09-10 16:53:25', '0001-01-01 00:00:00', '1', '2019-03-15 10:03:54');
INSERT INTO `medals` VALUES ('6', '/files/medals/cb6ec85b8f0f41e3ad4f79cb5aa60b72.png', '如沐春风', '在考评时间段内与其他团队之间合作评价最好', '0', '\0', '2018-09-10 16:53:50', '0001-01-01 00:00:00', '2', '2019-03-15 10:03:54');
INSERT INTO `medals` VALUES ('7', '/files/medals/f2e2e35d8b2d47eab0f073dc68d127e0.png', '古道热肠', '在考评时间段内积极帮助团队成员成长，有耐心，不厌其烦', '0', '\0', '2018-09-10 16:54:20', '0001-01-01 00:00:00', '2', '2019-03-15 10:03:54');
INSERT INTO `medals` VALUES ('8', '/files/medals/9ecd7d2f3c234b2c89cf11532ef245b5.png', '孜孜不倦', '在考评时间段内持续不断学习各种新东西和新技能', '0', '\0', '2018-09-10 16:55:15', '0001-01-01 00:00:00', '3', '2019-03-15 10:03:54');
INSERT INTO `medals` VALUES ('9', '/files/medals/54487924e0264c5a8d464f4c07eb9e2c.png', '一诺千金', '在考评时间段内严格遵守承诺，非常守时', '0', '\0', '2018-09-10 16:55:34', '0001-01-01 00:00:00', '3', '2019-03-15 10:03:54');
INSERT INTO `medals` VALUES ('10', '/files/medals/75b85a36304d47219c948cb812129051.png', '奇思妙想', '在任务规划之外提出全新的思路', '0', '\0', '2018-09-10 16:56:08', '0001-01-01 00:00:00', '1', '2019-03-15 10:03:54');
INSERT INTO `medals` VALUES ('11', '/files/medals/bc868be05e714fd888998f0d216402e9.png', '中流砥柱', '在任务实施中做出重大贡献', '0', '\0', '2018-09-10 16:56:23', '0001-01-01 00:00:00', '1', '2019-03-15 10:03:54');
INSERT INTO `medals` VALUES ('12', '/files/medals/15b8b5a4a1684c2cb0a3f4bfe5feac5d.png', '良金美玉', '任务完成时代码和功能质量非常高', '0', '\0', '2018-09-10 16:56:44', '0001-01-01 00:00:00', '2', '2019-03-15 10:03:54');
INSERT INTO `medals` VALUES ('13', '/files/medals/10d50f3ab844484eb108e1eae2180ece.png', '风驰电掣', '任务完成的速度非常快', '0', '\0', '2018-09-10 16:57:02', '0001-01-01 00:00:00', '2', '2019-03-15 10:03:54');
INSERT INTO `medals` VALUES ('14', '/files/medals/387ba8d8b3b34622b95432c5581090d4.png', '同舟共济', '在任务中积极配合团队解决各种问题', '4', '\0', '2018-09-10 16:57:44', '0001-01-01 00:00:00', '3', '2019-03-15 10:03:54');
INSERT INTO `medals` VALUES ('15', '/files/medals/d9ba60bcfb6244d58446d497c78b7365.png', '兢兢业业', '按照任务需求完成任务', '5', '\0', '2018-09-10 16:58:05', '0001-01-01 00:00:00', '3', '2019-03-15 10:03:54');

-- ----------------------------
-- Table structure for memberlabels
-- ----------------------------
DROP TABLE IF EXISTS `memberlabels`;
CREATE TABLE `memberlabels` (
  `Id` int(20) NOT NULL AUTO_INCREMENT,
  `MemberId` int(20) NOT NULL,
  `Label` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `Count` int(20) NOT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of memberlabels
-- ----------------------------
INSERT INTO `memberlabels` VALUES ('1', '1', '围棋', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('2', '1', '象棋', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('3', '1', '台球高手', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('4', '3', '爱喝茶', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('5', '2', '毛毛', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('6', '4', '游泳', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('7', '7', '二次元', '2', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('8', '5', '幽默', '2', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('9', '2', '踏实', '2', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('10', '2', '靠谱青年', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('11', '3', '腼腆', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('12', '4', '健谈', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('13', '7', '破解小达人', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('14', '6', '有潜力', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('15', '5', '有深度', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('16', '1', '仁厚', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('17', '2', '疯子', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('18', '1', '儒雅', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('19', '6', '小宝', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('20', '6', '小爬虫', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('21', '7', '勤快', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('22', '2', '单身', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('23', '6', '单身', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('24', '3', '佛系青年', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('25', '2', '有原则', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('26', '2', '疯子凯', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('27', '6', '斗兽（象）棋', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('28', '4', 'warm-hearted', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('29', '6', '上进', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('30', '7', 'ewrwer', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('31', '7', 'mmmm水电费', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('32', '7', '1234567', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('33', '7', '我得到静安寺哦对', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('34', '7', '岩土体与他', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');
INSERT INTO `memberlabels` VALUES ('35', '7', 'safswdf', '1', '2019-03-15 09:58:16', '2019-03-15 09:58:16');

-- ----------------------------
-- Table structure for membermedals
-- ----------------------------
DROP TABLE IF EXISTS `membermedals`;
CREATE TABLE `membermedals` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `MemberId` int(11) NOT NULL,
  `MedalId` int(11) NOT NULL,
  `Reason` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `GainDate` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `TaskId` int(11) DEFAULT NULL COMMENT '哪个任务中获取此勋章',
  `GainType` int(11) DEFAULT NULL COMMENT '1=组内，2=外援',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of membermedals
-- ----------------------------
INSERT INTO `membermedals` VALUES ('1', '1', '15', ' 按时完成同步任务', '2018-09-10 17:02:52', null, null, '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('2', '2', '15', '完成任务进度板，积分排行，登录，英雄风采等功能', '2018-09-11 15:32:33', null, null, '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('3', '2', '14', ' 积极促进协作，解决合作问题', '2018-09-11 15:33:28', null, null, '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('4', '3', '15', '在研究院内部网站任务中，完成英雄详情，勋章，技能等功能的研发。', '2018-09-11 15:34:27', null, null, '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('5', '3', '14', ' 在研究院内部网站任务中，积极促进协作，解决合作问题。', '2018-09-11 15:35:14', null, null, '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('6', '3', '15', ' 在58任务中表现突出，获取多处有用的线索', '2018-10-11 16:42:43', null, null, '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('7', '4', '15', '  在58任务中表现很好，获取多处有用的线索', '2018-10-11 16:43:18', null, null, '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('8', '4', '14', ' 在58任务中和团队积极合作，寻求线索', '2018-10-11 16:43:53', null, null, '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('9', '3', '14', '  在58任务中和团队积极合作，寻求线索', '2018-10-11 16:44:03', null, null, '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('13', '5', '15', '', '2019-01-08 13:55:06', '16', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('14', '4', '15', '', '2019-01-08 14:24:36', '5', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('15', '4', '14', '', '2019-01-08 14:24:36', '5', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('16', '6', '15', '', '2019-01-08 14:25:19', '5', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('17', '6', '14', '', '2019-01-08 14:25:19', '5', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('18', '2', '15', '', '2019-01-08 14:56:17', '3', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('19', '2', '14', '', '2019-01-08 14:56:17', '3', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('20', '2', '13', '', '2019-01-08 14:56:17', '3', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('21', '3', '15', '', '2019-01-08 14:56:43', '3', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('22', '3', '14', '', '2019-01-08 14:56:43', '3', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('23', '3', '13', '', '2019-01-08 14:56:43', '3', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('24', '4', '14', '', '2019-01-08 14:57:54', '3', '2', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('25', '5', '15', '', '2019-01-08 15:37:19', '10', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('26', '5', '14', '', '2019-01-08 15:37:19', '10', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('27', '2', '14', '', '2019-01-08 15:37:46', '10', '2', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('28', '3', '14', '', '2019-01-08 15:37:52', '10', '2', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('29', '1', '15', '', '2019-01-08 15:38:21', '10', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('30', '1', '14', '', '2019-01-08 15:38:21', '10', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('31', '4', '15', '', '2019-01-08 16:02:17', '2', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('32', '4', '14', '', '2019-01-08 16:02:17', '2', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('33', '4', '12', '', '2019-01-08 16:02:17', '2', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('38', '5', '15', '', '2019-01-22 16:49:23', '20', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('39', '5', '14', '', '2019-01-22 16:49:23', '20', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('40', '5', '13', '', '2019-01-22 16:49:23', '20', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('57', '3', '15', '', '2019-01-22 16:54:25', '33', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('58', '3', '14', '', '2019-01-22 16:54:25', '33', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('59', '7', '15', '', '2019-01-22 16:54:33', '33', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('60', '7', '14', '', '2019-01-22 16:54:33', '33', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('61', '7', '13', '', '2019-01-22 16:54:33', '33', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('62', '7', '12', '', '2019-01-22 16:54:33', '33', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('63', '7', '11', '', '2019-01-22 16:54:33', '33', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('64', '7', '6', '', '2019-01-22 16:54:33', '33', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('65', '7', '7', '', '2019-01-22 16:54:33', '33', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('66', '7', '8', '', '2019-01-22 16:54:33', '33', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('67', '7', '9', '', '2019-01-22 16:54:33', '33', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('68', '7', '10', '', '2019-01-22 16:54:33', '33', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('69', '7', '5', '', '2019-01-22 16:54:33', '33', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('70', '7', '4', '', '2019-01-22 16:54:33', '33', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('71', '7', '3', '', '2019-01-22 16:54:33', '33', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('72', '7', '2', '', '2019-01-22 16:54:33', '33', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('73', '7', '1', '', '2019-01-22 16:54:33', '33', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('74', '1', '14', '', '2019-01-22 16:54:39', '33', '2', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('79', '1', '15', '完成很好', '2019-01-22 16:55:31', '13', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('80', '1', '14', '完成很好', '2019-01-22 16:55:31', '13', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('81', '3', '14', '帮助很大', '2019-01-22 16:55:39', '13', '2', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('98', '7', '15', '', '2019-01-22 17:23:51', '38', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('99', '2', '14', '', '2019-01-22 17:24:20', '38', '2', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('100', '3', '14', '', '2019-01-22 17:24:32', '38', '2', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('101', '7', '15', '', '2019-01-22 17:24:44', '38', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('107', '2', '14', '', '2019-01-22 17:38:42', '39', '2', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('112', '7', '13', '', '2019-01-23 14:03:42', '17', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('113', '1', '14', '', '2019-01-23 14:03:48', '17', '2', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('116', '1', '15', '', '2019-03-01 13:13:02', '25', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('117', '2', '14', '', '2019-03-01 13:13:07', '25', '2', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('118', '7', '4', '', '2019-03-01 14:24:30', '46', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('119', '7', '9', '', '2019-03-01 14:24:41', '46', '1', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('120', '1', '14', '', '2019-03-01 14:24:54', '46', '2', '2019-03-15 09:58:07', '2019-03-15 09:58:07');
INSERT INTO `membermedals` VALUES ('123', '3', '5', '测试', '2019-03-11 13:15:25', null, null, '2019-03-15 09:58:07', '2019-03-15 09:58:07');

-- ----------------------------
-- Table structure for members
-- ----------------------------
DROP TABLE IF EXISTS `members`;
CREATE TABLE `members` (
  `Id` int(20) NOT NULL AUTO_INCREMENT,
  `Account` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `Password` text COLLATE utf8mb4_bin NOT NULL,
  `PasswordKey` text COLLATE utf8mb4_bin NOT NULL,
  `Name` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `Photo` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `PhotoHD` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `art_photo` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `Gender` bit(1) NOT NULL,
  `Phone` varchar(22) COLLATE utf8mb4_bin DEFAULT '0',
  `QQ` varchar(22) COLLATE utf8mb4_bin DEFAULT '0',
  `WeChat` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `EntryTime` date NOT NULL,
  `Email` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `Title` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `BirthDay` date DEFAULT NULL,
  `Remarks` text COLLATE utf8mb4_bin,
  `IsAdmin` bit(1) NOT NULL DEFAULT b'0',
  `TotalIntegral` int(11) NOT NULL DEFAULT '0' COMMENT '总积分',
  `LikeCount` int(11) NOT NULL DEFAULT '0' COMMENT '点赞',
  `DislikeCount` int(11) NOT NULL DEFAULT '0' COMMENT '加油(鼓励)',
  `LeaveTime` date DEFAULT NULL,
  `IsLeave` bit(1) NOT NULL DEFAULT b'0',
  `AliasName` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `Motto` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of members
-- ----------------------------
INSERT INTO `members` VALUES ('1', 'admin', 0x3442363644363338433030413045464236383045343832413141424546394141384636313138464441313833443036394538314232423638424137394133434536303045384337374337433741333345314339353946333842463936393246454231313736364632313432384544323243383142333339423445364130383737, 0x3132333435383831353636353935, '董', '/files/uploads/fc322da637714b0aa4a3963e470f1a7epart.jpeg', '/files/uploads/fc322da637714b0aa4a3963e470f1a7e.jpeg', '/files/uploads/mem1.png', '', '18', '33016268', 'DXY33016268', '2015-08-31', 'show_me_good@163.com', '研究院院长', '1982-11-23', null, '\0', '164', '70', '5', null, '\0', '令狐冲', '待人，海阔天空；对事，寸步不让！', '2019-03-15 09:57:59', '2019-03-15 15:51:01');
INSERT INTO `members` VALUES ('2', 'maozk', 0x4545324631333344323633374341354132314346374635323043323630373831433146313931423730423430363534443734414345444531383030363837374634364641313633423246414342363734343930464639453832334241444338413045354438393641354641314431373346423732343745433938463442443735, 0x3A6F266853377767, '毛智凯', '/files/uploads/b61d862288144367b33bf296e909b627part.jpeg', '/files/uploads/b61d862288144367b33bf296e909b627.jpeg', '/files/uploads/mem2.png', '', '16621187813', '2501456225', 'mzk942113871', '2018-07-11', 'mzk942113871@163.com', '研究员', '1995-09-18', null, '\0', '3693', '66', '8', null, '\0', '向问天', '干干净净做人，踏踏实实做事', '2019-03-15 09:57:59', '2019-03-15 15:51:19');
INSERT INTO `members` VALUES ('3', 'lfq', 0x4634423639343639384136334235323935383044444231303731424146443641383833453333413541344634414532333142434146314531423039413344364246434439453346454530314133423245463132314639313430313443314639353434393543314441454532363144324133343933383541354331423141324435, 0x6323613C6C293463, '李富泉', '/files/uploads/340e6d6b33f74bc490e9396efccd28f6part.jpeg', '/files/uploads/340e6d6b33f74bc490e9396efccd28f6.jpeg', '/files/uploads/mem3.png', '', '18621714169', '1140968798', '1140968798', '2018-07-16', 'fuquan.li@outlook.com', '研究员', '1995-12-29', null, '\0', '296', '66', '8', null, '\0', '郭靖', null, '2019-03-15 09:57:59', '2019-03-15 15:51:23');
INSERT INTO `members` VALUES ('4', 'syl', 0x4631433730394230314631453939374246343032334441323846324236444435443237353031373745304541394443323034384544443339303932374536304346354541363445453731414530433237313032453045364634353844353437393634373846413744393838383138384530353438313035303446343436363335, 0x4E753B5377393F6F, '孙勇亮', '/files/uploads/189ffea7dc144d19845c5594508a2a0dpart.jpeg', '/files/uploads/189ffea7dc144d19845c5594508a2a0d.jpeg', '/files/uploads/mem4.png', '', '17717563327', '815673988', '815673988', '2018-08-01', 'sunfred@live.cn', '高级研究员', '1989-03-15', null, '\0', '10031', '66', '8', null, '\0', '虚竹子', 'Great people share knowledge.', '2019-03-15 09:57:59', '2019-03-15 15:51:26');
INSERT INTO `members` VALUES ('5', 'hechao', 0x4246354339384535453136363036423642313344424639393641454242343331383241373731413441373539353942303235304544464339304445394141374542343135463031413538334432333943333441324345374344414532464645383339394631373642363941314342463044443943383333393037314435324134, 0x7B712F493A624F79, '何超', '/files/uploads/cc96c8f30fb7406ebb26c0630316cef8part.jpeg', '/files/uploads/cc96c8f30fb7406ebb26c0630316cef8.jpeg', '/files/uploads/mem5.png', '', '15056099451', '1053035376', 'HeChao198994', '2018-09-25', null, '高级研究员', '1989-09-04', null, '\0', '12', '53', '2', null, '\0', '石破天', '做社会主义接班人', '2019-03-15 09:57:59', '2019-03-15 15:51:29');
INSERT INTO `members` VALUES ('6', 'raobaoshi', 0x3932343534463842303735423830384238383232454343344342383141394641333933333343323333423038313241433245354430353032353433454142384130454131373444423331434636363933364646323238454633353334363844463946323133383635364138444143423435464546354436373835394144384435, 0x26274A3074753F58, '饶宝仕', '/files/uploads/7ffb271d1a5b4098a6cb7d924437b0dcpart.jpeg', '/files/uploads/7ffb271d1a5b4098a6cb7d924437b0dc.jpeg', '/files/uploads/mem6.png', '', '15755407860', '1322096624', '15755407860', '2018-12-03', 'tinakong132209@163.com', '助理研究员', '1997-11-18', null, '\0', '0', '24', '1', null, '\0', '萧峰', '生命不息，奋斗不止', '2019-03-15 09:57:59', '2019-03-15 15:51:32');
INSERT INTO `members` VALUES ('7', 'zyl', 0x4239363244444235363133304146433746333232434641304130333430353138343437323042334136364238353044384434333345334242363636444332313832314343443343413646343041393236383946463134444643393943463136323641383645434331393132423039313431393945303446383532394542363136, 0x61624D573B5F5B71, '张宇良', '/files/uploads/4f082798771544eaa6df7bd0c728b951part.jpeg', '/files/uploads/4f082798771544eaa6df7bd0c728b951.jpeg', '/files/uploads/55ab147077ea40b6bfcf0572298ff16b.png', '', '18035445891', '572191416', 'ha_cn_yu', '2018-12-13', 'strnull@live.cn', '研究员', '1995-10-11', null, '', '181940', '23', '5', null, '\0', '张无忌', 'Gentle breeze,green leaves.', '2019-03-15 09:57:59', '2019-03-18 10:08:45');
INSERT INTO `members` VALUES ('8', 'zhouwenyang', 0x3844414141373836433239333832343044323031343636303645304543354146304244333235363646463942463335363834413137454535394636333742433730343339464231443741463039303030464635383241383044344132453441343141434245443538454433434637434637434443313233464233414439383530, 0x5B4E505173386E73, '周文阳', '/files/uploads/2f2e7af35b4f41c7a7c475602671abc8part.jpeg', '/files/uploads/2f2e7af35b4f41c7a7c475602671abc8.jpeg', '/files/uploads/mem8.png', '', '18796220903', '1057086412', 'dbms_output_line', '2019-01-14', 'wenyang.chou@foxmail.com', '研究员', '1993-10-24', null, '\0', '0', '3', '0', null, '\0', '逍遥子', null, '2019-03-15 09:57:59', '2019-03-15 15:51:38');
INSERT INTO `members` VALUES ('9', 'test', 0x3636323135433533304642383336333138443545453333343936343732373644383236454530343230323931443346384237364533414133453630303437303546423434333134413843423244384244424643374542413533333442443632343641463136383441364638324133423641443243453630423632303139334539, 0x695D63762D277751, 'test', null, '/images/public/NonePicture.png', '', '', null, null, null, '2019-01-23', null, '研究院', '2019-01-22', null, '\0', '135', '0', '0', null, '\0', null, null, '2019-03-15 09:57:59', '2019-03-15 15:51:44');

-- ----------------------------
-- Table structure for memberskills
-- ----------------------------
DROP TABLE IF EXISTS `memberskills`;
CREATE TABLE `memberskills` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `SkillId` int(11) NOT NULL,
  `MemberId` int(11) NOT NULL,
  `GainDate` date NOT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of memberskills
-- ----------------------------
INSERT INTO `memberskills` VALUES ('1', '3', '5', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('2', '17', '5', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('3', '19', '5', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('4', '9', '5', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('5', '11', '5', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('6', '35', '5', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('7', '37', '5', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('8', '38', '5', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('9', '39', '5', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('10', '22', '5', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('11', '49', '5', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('12', '24', '5', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('13', '29', '5', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('14', '30', '5', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('15', '3', '4', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('16', '7', '4', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('17', '9', '4', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('18', '11', '4', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('19', '13', '4', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('20', '37', '4', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('21', '38', '4', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('22', '39', '4', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('23', '12', '4', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('24', '22', '4', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('25', '24', '4', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('26', '57', '5', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('27', '58', '5', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('28', '59', '5', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('29', '65', '5', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('30', '66', '4', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('31', '57', '4', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('32', '58', '4', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('33', '59', '4', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('34', '70', '4', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('35', '63', '4', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('36', '64', '4', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('37', '3', '3', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('38', '17', '3', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('39', '19', '3', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('40', '9', '3', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('41', '11', '3', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('42', '35', '3', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('43', '37', '3', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('44', '38', '3', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('45', '39', '3', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('46', '15', '3', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('47', '49', '3', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('48', '21', '3', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('49', '22', '3', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('50', '24', '3', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('51', '25', '3', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('52', '29', '3', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('53', '30', '3', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('54', '33', '3', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('55', '57', '3', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('56', '59', '3', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('57', '64', '3', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('58', '65', '3', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('59', '3', '2', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('60', '17', '2', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('61', '18', '2', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('62', '19', '2', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('63', '7', '2', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('64', '8', '2', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('65', '11', '2', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('66', '38', '2', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('67', '39', '2', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('69', '49', '2', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('70', '22', '2', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('71', '24', '2', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('72', '33', '2', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('73', '34', '2', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('74', '57', '2', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('75', '58', '2', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('76', '59', '2', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('77', '60', '2', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('78', '61', '2', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('79', '3', '1', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('80', '17', '1', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('81', '9', '1', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('82', '11', '1', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('83', '35', '1', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('84', '38', '1', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('85', '36', '1', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('86', '24', '1', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('87', '30', '1', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('88', '57', '1', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('89', '58', '1', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('90', '59', '1', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('91', '60', '1', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('92', '62', '1', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('93', '63', '1', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('94', '64', '1', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('95', '65', '1', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('96', '74', '5', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('97', '71', '4', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('98', '72', '4', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('99', '74', '3', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('100', '71', '2', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('101', '71', '1', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('102', '72', '1', '2018-10-08', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('103', '4', '6', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('104', '17', '6', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('105', '18', '6', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('106', '19', '6', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('107', '7', '6', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('108', '43', '6', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('109', '75', '6', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('110', '76', '6', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('111', '22', '6', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('112', '24', '6', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('113', '25', '6', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('114', '29', '6', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('115', '30', '6', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('116', '32', '6', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('117', '57', '6', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('118', '3', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('119', '5', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('120', '17', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('121', '18', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('122', '19', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('123', '9', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('124', '11', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('125', '35', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('126', '37', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('127', '39', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('128', '40', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('129', '76', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('130', '49', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('131', '21', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('132', '22', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('133', '24', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('134', '25', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('135', '29', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('136', '30', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('137', '32', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('138', '33', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('139', '34', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('140', '71', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('141', '57', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('142', '58', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('143', '60', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('144', '62', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('145', '63', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('146', '64', '7', '2018-12-17', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('147', '79', '7', '2018-12-21', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('148', '80', '7', '2018-12-21', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('149', '78', '6', '2018-12-21', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('150', '79', '6', '2018-12-21', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('151', '78', '1', '2018-12-21', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('152', '79', '1', '2018-12-21', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('153', '81', '1', '2018-12-21', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('154', '79', '2', '2018-12-21', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('155', '79', '3', '2018-12-21', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('157', '81', '4', '2018-12-21', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('158', '79', '5', '2018-12-21', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('159', '4', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('160', '5', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('161', '17', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('162', '18', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('163', '19', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('164', '7', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('165', '8', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('166', '35', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('167', '37', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('168', '40', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('169', '41', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('170', '42', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('171', '75', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('172', '76', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('173', '12', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('174', '86', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('175', '87', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('176', '88', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('177', '89', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('178', '22', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('179', '24', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('180', '25', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('181', '29', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('182', '30', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('183', '32', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('184', '34', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('185', '57', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('186', '58', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('187', '59', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('188', '60', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('189', '61', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('190', '63', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('191', '79', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');
INSERT INTO `memberskills` VALUES ('192', '81', '8', '2019-01-14', '2019-03-15 09:57:43', '2019-03-15 09:57:43');

-- ----------------------------
-- Table structure for parties
-- ----------------------------
DROP TABLE IF EXISTS `parties`;
CREATE TABLE `parties` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `MemberId` int(11) DEFAULT '0',
  `StartTime` datetime DEFAULT NULL,
  `EndTime` datetime DEFAULT NULL,
  `Address` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `Tel` varchar(22) COLLATE utf8mb4_bin DEFAULT NULL,
  `PartyName` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `PartyPlace` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `Money` decimal(11,2) DEFAULT NULL,
  `MoneyResource` int(3) DEFAULT NULL,
  `Number` int(10) DEFAULT NULL,
  `LikeLevel` int(2) DEFAULT NULL,
  `ReviewTimes` int(11) DEFAULT '0',
  `Longitude` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `Latitude` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of parties
-- ----------------------------
INSERT INTO `parties` VALUES ('99', '7', '2019-03-12 14:30:28', '2019-03-14 00:00:00', '烟台路118-101号附近', '0532-66031799', '12312', 'We+', '11.00', '1', '1', '0', '0', '120.519975', '36.880723', '2019-03-15 09:57:24', '2019-03-15 09:57:24');

-- ----------------------------
-- Table structure for partiesreviews
-- ----------------------------
DROP TABLE IF EXISTS `partiesreviews`;
CREATE TABLE `partiesreviews` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `PartyId` int(11) DEFAULT NULL,
  `MemberId` int(11) DEFAULT NULL,
  `Review` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `ReviewTime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=127 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of partiesreviews
-- ----------------------------
INSERT INTO `partiesreviews` VALUES ('78', '84', '7', '123123', '2019-02-11 18:35:18', '2019-03-15 09:57:14', '2019-03-15 09:57:14');
INSERT INTO `partiesreviews` VALUES ('79', '84', '7', '123123', '2019-02-11 18:43:38', '2019-03-15 09:57:14', '2019-03-15 09:57:14');
INSERT INTO `partiesreviews` VALUES ('80', '84', '7', '1231231231', '2019-02-11 18:43:43', '2019-03-15 09:57:14', '2019-03-15 09:57:14');
INSERT INTO `partiesreviews` VALUES ('81', '84', '7', '1111111111', '2019-02-11 18:43:47', '2019-03-15 09:57:14', '2019-03-15 09:57:14');
INSERT INTO `partiesreviews` VALUES ('82', '84', '7', '啊啊啊啊啊啊啊啊啊啊', '2019-02-11 18:45:40', '2019-03-15 09:57:14', '2019-03-15 09:57:14');
INSERT INTO `partiesreviews` VALUES ('83', '86', '7', '123123', '2019-02-12 10:22:29', '2019-03-15 09:57:14', '2019-03-15 09:57:14');
INSERT INTO `partiesreviews` VALUES ('84', '86', '7', '1111111111', '2019-02-12 10:22:32', '2019-03-15 09:57:14', '2019-03-15 09:57:14');
INSERT INTO `partiesreviews` VALUES ('85', '86', '7', '2222222222', '2019-02-12 10:22:35', '2019-03-15 09:57:14', '2019-03-15 09:57:14');
INSERT INTO `partiesreviews` VALUES ('86', '86', '7', '333333333', '2019-02-12 10:22:38', '2019-03-15 09:57:14', '2019-03-15 09:57:14');
INSERT INTO `partiesreviews` VALUES ('87', '91', '7', '多伦多海鲜自助多伦多', '2019-02-15 14:21:34', '2019-03-15 09:57:14', '2019-03-15 09:57:14');
INSERT INTO `partiesreviews` VALUES ('88', '91', '7', '更新数据库更新数据库', '2019-02-15 14:23:59', '2019-03-15 09:57:14', '2019-03-15 09:57:14');
INSERT INTO `partiesreviews` VALUES ('89', '91', '7', '更新数据库更新数据库', '2019-02-15 14:24:14', '2019-03-15 09:57:14', '2019-03-15 09:57:14');
INSERT INTO `partiesreviews` VALUES ('90', '92', '7', '更新数据库', '2019-02-15 14:24:34', '2019-03-15 09:57:14', '2019-03-15 09:57:14');
INSERT INTO `partiesreviews` VALUES ('91', '92', '7', '更新数据库', '2019-02-15 14:24:38', '2019-03-15 09:57:14', '2019-03-15 09:57:14');
INSERT INTO `partiesreviews` VALUES ('92', '92', '7', '更新数据库', '2019-02-15 14:24:40', '2019-03-15 09:57:14', '2019-03-15 09:57:14');
INSERT INTO `partiesreviews` VALUES ('93', '89', '7', '更新数据库更新数据库', '2019-02-15 14:25:02', '2019-03-15 09:57:14', '2019-03-15 09:57:14');
INSERT INTO `partiesreviews` VALUES ('94', '89', '7', '更新数据库更新数据库', '2019-02-15 14:25:09', '2019-03-15 09:57:14', '2019-03-15 09:57:14');
INSERT INTO `partiesreviews` VALUES ('95', '89', '7', '更新数', '2019-02-15 14:25:21', '2019-03-15 09:57:14', '2019-03-15 09:57:14');
INSERT INTO `partiesreviews` VALUES ('96', '87', '7', '更新数据库更新数', '2019-02-15 14:25:58', '2019-03-15 09:57:14', '2019-03-15 09:57:14');
INSERT INTO `partiesreviews` VALUES ('97', '87', '7', '更新数据库更新数', '2019-02-15 14:26:04', '2019-03-15 09:57:14', '2019-03-15 09:57:14');
INSERT INTO `partiesreviews` VALUES ('98', '87', '7', '更新数据库', '2019-02-15 14:26:08', '2019-03-15 09:57:14', '2019-03-15 09:57:14');
INSERT INTO `partiesreviews` VALUES ('99', '93', '7', '更新数据库更新', '2019-02-15 14:28:21', '2019-03-15 09:57:14', '2019-03-15 09:57:14');
INSERT INTO `partiesreviews` VALUES ('100', '93', '7', '更新数据库更新', '2019-02-15 14:28:25', '2019-03-15 09:57:14', '2019-03-15 09:57:14');
INSERT INTO `partiesreviews` VALUES ('101', '93', '7', '更新数据库更新', '2019-02-15 14:28:28', '2019-03-15 09:57:14', '2019-03-15 09:57:14');
INSERT INTO `partiesreviews` VALUES ('102', '94', '7', '更新数据库更', '2019-02-15 14:29:19', '2019-03-15 09:57:14', '2019-03-15 09:57:14');
INSERT INTO `partiesreviews` VALUES ('103', '94', '7', '更新数据库更', '2019-02-15 14:29:22', '2019-03-15 09:57:14', '2019-03-15 09:57:14');
INSERT INTO `partiesreviews` VALUES ('104', '94', '7', '更新数据库更', '2019-02-15 14:29:25', '2019-03-15 09:57:14', '2019-03-15 09:57:14');

-- ----------------------------
-- Table structure for partyphotos
-- ----------------------------
DROP TABLE IF EXISTS `partyphotos`;
CREATE TABLE `partyphotos` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `PartyId` int(11) DEFAULT NULL,
  `ImgUrl` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `ImgUrlPart` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `ImgDescription` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of partyphotos
-- ----------------------------
INSERT INTO `partyphotos` VALUES ('50', '97', '/files/uploads/41d848be26a44533846bf889a3f834ef.jpeg', '/files/uploads/41d848be26a44533846bf889a3f834efpart.jpeg', '123', '2019-03-15 09:57:00', '2019-03-15 09:57:00');
INSERT INTO `partyphotos` VALUES ('51', '99', '/files/uploads/6d458f2f84d44b2980fa26ca8c6d13b3.jpeg', '/files/uploads/6d458f2f84d44b2980fa26ca8c6d13b3part.jpeg', '465', '2019-03-15 13:58:26', '2019-03-15 13:58:26');

-- ----------------------------
-- Table structure for pictures
-- ----------------------------
DROP TABLE IF EXISTS `pictures`;
CREATE TABLE `pictures` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Url` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `PartialPictureUrl` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `Description` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `MemberId` int(11) DEFAULT NULL,
  `UpdatedTime` datetime DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of pictures
-- ----------------------------
INSERT INTO `pictures` VALUES ('1', '/files/uploads/e89703d985ef4397b4751568f377a25f.jpeg', '/files/uploads/e89703d985ef4397b4751568f377a25fpart.jpeg', '研究院与PC一起撸串，嗨起来！', '1', '2018-09-10 09:28:29', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('2', '/files/uploads/e013904077b748db98ecab8c90cc0f73.jpeg', '/files/uploads/e013904077b748db98ecab8c90cc0f73part.jpeg', '研究院揭牌，2018-8-15！', '1', '2018-09-10 09:30:55', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('3', '/files/uploads/2d7fb3396dc347c3b08ba9844f915a41.jpeg', '/files/uploads/2d7fb3396dc347c3b08ba9844f915a41part.jpeg', '一起奋斗！！', '1', '2018-09-10 09:31:47', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('4', '/files/uploads/f25b320b9ea2468ca01546cdf8657c19.jpeg', '/files/uploads/f25b320b9ea2468ca01546cdf8657c19part.jpeg', '吃蛋糕', '1', '2018-09-10 09:35:14', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('5', '/files/uploads/91ddac9eee30412ba4659ba7f58a6a87.jpeg', '/files/uploads/91ddac9eee30412ba4659ba7f58a6a87part.jpeg', '美女与....呃，研究员们', '1', '2018-09-10 12:57:00', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('6', '/files/uploads/c9de0237cc52468f9574639ef2c77d72.jpeg', '/files/uploads/c9de0237cc52468f9574639ef2c77d72part.jpeg', '交大一日游', '1', '2018-09-10 12:57:36', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('7', '/files/uploads/76f6d345e93547a291447735c7a444f7.jpeg', '/files/uploads/76f6d345e93547a291447735c7a444f7part.jpeg', '恐怖木屋-带血的提示', '1', '2018-09-21 08:58:28', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('8', '/files/uploads/7ec598c11ef84db7bdda9c38240014fa.jpeg', '/files/uploads/7ec598c11ef84db7bdda9c38240014fapart.jpeg', '恐怖木屋 - 吓坏我了！', '1', '2018-09-21 08:58:47', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('9', '/files/uploads/d15465bb00424e3f891d685e2e1bce07.jpeg', '/files/uploads/d15465bb00424e3f891d685e2e1bce07part.jpeg', '恐怖木屋 - 成功逃出！', '1', '2018-09-21 08:58:59', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('10', '/files/uploads/dc11ef1fd4764253899523c4a0f6673c.jpeg', '/files/uploads/dc11ef1fd4764253899523c4a0f6673cpart.jpeg', '吴泾宝龙辣中缘 - 美味欲滴', '1', '2018-09-21 09:03:40', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('11', '/files/uploads/d279b2bb71aa42fcb27efca76ef1e226.jpeg', '/files/uploads/d279b2bb71aa42fcb27efca76ef1e226part.jpeg', '开启串串模式', '1', '2018-09-27 08:49:50', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('12', '/files/uploads/847bd70420d643d8b5052e4e15b3b4af.jpeg', '/files/uploads/847bd70420d643d8b5052e4e15b3b4afpart.jpeg', '欢迎何超加入！', '1', '2018-09-27 08:50:40', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('13', '/files/uploads/d4995e6a057845248de6702ce6a51e30.jpeg', '/files/uploads/d4995e6a057845248de6702ce6a51e30part.jpeg', '开撸', '1', '2018-09-27 08:50:57', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('14', '/files/uploads/cfe4945de29f4ffe8591f7c5662a7ae8.jpeg', '/files/uploads/cfe4945de29f4ffe8591f7c5662a7ae8part.jpeg', '酒足饭饱之后', '1', '2018-09-27 08:51:34', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('15', '/files/uploads/3c05eb0af16a4dbbbc321e5c6a1502d3.jpeg', '/files/uploads/3c05eb0af16a4dbbbc321e5c6a1502d3part.jpeg', '读书时间，啊哈', '1', '2018-09-28 18:38:55', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('16', '/files/uploads/91a2c11a079048458c0fb246231b1f01.jpeg', '/files/uploads/91a2c11a079048458c0fb246231b1f01part.jpeg', '红辣的火锅吃起来', '1', '2018-10-12 09:51:46', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('17', '/files/uploads/2f225cb359664224b92608ce66e66975.jpeg', '/files/uploads/2f225cb359664224b92608ce66e66975part.jpeg', '小酒喝起来', '2', '2018-10-15 13:30:22', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('18', '/files/uploads/0cb36231284843988cbf661205b1fd4b.jpeg', '/files/uploads/0cb36231284843988cbf661205b1fd4bpart.jpeg', '游完泳可以放心大吃一顿啦', '4', '2018-10-15 15:13:07', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('19', '/files/uploads/a3ff2a46ebe84f7e881e74d2d584be6f.jpeg', '/files/uploads/a3ff2a46ebe84f7e881e74d2d584be6fpart.jpeg', '测试', '5', '2018-10-23 15:38:06', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('21', '/files/uploads/3ff7648fc3984e9f9bf2817394c9babc.jpeg', '/files/uploads/3ff7648fc3984e9f9bf2817394c9babcpart.jpeg', '尔敢战否', '1', '2018-11-15 11:21:25', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('22', '/files/uploads/79db037bc54c4cb4bbd0998beefa07b6.jpeg', '/files/uploads/79db037bc54c4cb4bbd0998beefa07b6part.jpeg', '黄山之行', '1', '2018-11-23 10:48:27', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('23', '/files/uploads/39e818d325e8492f8b1998a95e048ce8.jpeg', '/files/uploads/39e818d325e8492f8b1998a95e048ce8part.jpeg', '蜜蜡打磨', '1', '2018-11-23 10:48:43', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('24', '/files/uploads/1eebe20318224e2185a6c4c4ca61aded.jpeg', '/files/uploads/1eebe20318224e2185a6c4c4ca61adedpart.jpeg', '趣味运动会优胜奖', '1', '2018-11-23 10:51:40', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('25', '/files/uploads/d0d8ad6310774920afddd22f53f75c38.jpeg', '/files/uploads/d0d8ad6310774920afddd22f53f75c38part.jpeg', '趣味运动会奖品', '1', '2018-11-23 10:51:36', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('27', '/files/uploads/ca21f349d5f74b67a35b0df57c16f7e3.jpeg', '/files/uploads/ca21f349d5f74b67a35b0df57c16f7e3part.jpeg', '园区风景', '3', '2018-12-03 08:30:31', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('28', '/files/uploads/cbd2907364f24a389c37167ff2265744.jpeg', '/files/uploads/cbd2907364f24a389c37167ff2265744part.jpeg', '咦，富泉在哪，大家来找一找', '1', '2018-12-06 10:10:37', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('29', '/files/uploads/3acf8991bdf6404a8ae0e2456cc86bab.jpeg', '/files/uploads/3acf8991bdf6404a8ae0e2456cc86babpart.jpeg', '我来了', '7', '2019-03-13 19:24:52', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('30', '/files/uploads/8e60bca0ccb94d82800f26d215f1eb28.jpeg', '/files/uploads/8e60bca0ccb94d82800f26d215f1eb28part.jpeg', '还能听', '1', '2018-12-26 15:23:05', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('31', '/files/uploads/b8376ff6502c43a7a340f6139ad952c6.jpeg', '/files/uploads/b8376ff6502c43a7a340f6139ad952c6part.jpeg', '基情满满', '1', '2018-12-26 15:23:26', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('32', '/files/uploads/13585c0414944d9494f3dcc66b4b15fe.jpeg', '/files/uploads/13585c0414944d9494f3dcc66b4b15fepart.jpeg', '好听哇', '1', '2018-12-26 15:23:49', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('33', '/files/uploads/59e30f48c38441c989f53de593718bcb.jpeg', '/files/uploads/59e30f48c38441c989f53de593718bcbpart.jpeg', '看这边', '1', '2018-12-26 15:24:17', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('34', '/files/uploads/83d65835b5194a2bb7f476d75a729105.jpeg', '/files/uploads/83d65835b5194a2bb7f476d75a729105part.jpeg', '猴哥猴哥', '1', '2018-12-26 15:24:33', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('36', '/files/uploads/f3db77fc9f7b4f598bee2d981168af97.jpeg', '/files/uploads/f3db77fc9f7b4f598bee2d981168af97part.jpeg', '肉足饭饱', '1', '2018-12-26 15:31:43', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('39', '/files/uploads/b8bb42151c8544908ec54c041883ac81.jpeg', '/files/uploads/b8bb42151c8544908ec54c041883ac81part.jpeg', '大师级的摄影', '3', '2018-12-29 19:08:26', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('40', '/files/uploads/66079c664f1b418491f827661d053679.jpeg', '/files/uploads/66079c664f1b418491f827661d053679part.jpeg', '...', '3', '2018-12-29 19:06:20', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('41', '/files/uploads/b0329e80e0804c0293a8c6e12696ed75.jpeg', '/files/uploads/b0329e80e0804c0293a8c6e12696ed75part.jpeg', '徒步三“贱”客', '3', '2018-12-29 19:07:57', '2019-03-15 09:56:52', '2019-03-15 09:56:52');
INSERT INTO `pictures` VALUES ('51', '/files/uploads/41d848be26a44533846bf889a3f834ef.jpeg', '/files/uploads/41d848be26a44533846bf889a3f834efpart.jpeg', '123', '7', '2019-03-12 10:07:43', '2019-03-15 09:56:52', '2019-03-15 09:56:52');

-- ----------------------------
-- Table structure for plans
-- ----------------------------
DROP TABLE IF EXISTS `plans`;
CREATE TABLE `plans` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `CreatedMemberId` int(11) DEFAULT NULL,
  `CreateTime` datetime DEFAULT NULL,
  `Status` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '开放，关闭',
  `ClosedTime` datetime DEFAULT NULL,
  `Remark` text COLLATE utf8mb4_bin COMMENT '备注',
  `LastUpdateTime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of plans
-- ----------------------------
INSERT INTO `plans` VALUES ('1', '研发职位培训', '1', '2018-12-10 11:35:27', '开放', null, 0xE8AEA1E58892E6AF8FE4B8AAE69C88E4B880E6ACA1, '2018-12-10 11:35:27', '2019-03-15 09:56:31');
INSERT INTO `plans` VALUES ('2', '研究院内部网站建设', '1', '2018-12-10 11:35:59', '开放', null, 0xE58886E78988E69CACE5AE9EE78EB0, '2018-12-10 11:35:59', '2019-03-15 09:56:31');
INSERT INTO `plans` VALUES ('3', '梵讯房屋网建设', '1', '2018-12-10 11:36:59', '开放', null, 0xE7A094E7A9B6E688BFE5B18BE7BD91E99C80E8A681E79A84E7AE97E6B395E5928CE59FBAE7A180E6A186E69EB6, '2018-12-10 11:36:59', '2019-03-15 09:56:31');
INSERT INTO `plans` VALUES ('4', '梵讯产品架构优化', '1', '2018-12-10 15:29:17', '开放', null, 0xE695B4E4B8AAE4BAA7E59381E4BD93E7B3BBE79A84E6A0B8E5BF83E69EB6E69E84E4BC98E58C96, '2018-12-10 15:29:17', '2019-03-15 09:56:31');
INSERT INTO `plans` VALUES ('5', '软件自动化测试框架搭建', '1', '2018-12-12 09:11:50', '开放', null, null, '2018-12-12 09:11:50', '2019-03-15 09:56:31');
INSERT INTO `plans` VALUES ('6', 'testsun', '7', '2019-01-22 17:20:58', '关闭', '2019-01-22 17:43:40', null, '2019-01-22 17:43:40', '2019-03-15 09:56:31');
INSERT INTO `plans` VALUES ('8', '111', '7', '2019-03-15 20:15:42', '开放', null, 0x313131, '2019-03-15 20:15:42', '2019-03-15 20:15:42');

-- ----------------------------
-- Table structure for skills
-- ----------------------------
DROP TABLE IF EXISTS `skills`;
CREATE TABLE `skills` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `ParentId` int(11) NOT NULL,
  `Name` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `Level` int(11) NOT NULL,
  `CreatedTime` datetime NOT NULL,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of skills
-- ----------------------------
INSERT INTO `skills` VALUES ('1', '0', '技能', '1', '2018-09-05 18:08:28', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('2', '1', '语言', '2', '0001-01-01 00:00:00', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('3', '2', 'C#', '3', '2018-09-05 18:18:17', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('4', '2', 'Python', '3', '2018-09-05 18:18:28', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('5', '2', 'Java', '3', '2018-09-05 18:18:36', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('6', '1', '数据库', '2', '2018-09-05 18:18:45', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('7', '6', 'MySQL', '3', '0001-01-01 00:00:00', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('8', '6', 'Oracle', '3', '0001-01-01 00:00:00', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('9', '6', 'SQL Server', '3', '0001-01-01 00:00:00', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('10', '1', '工具', '2', '2018-09-10 10:27:04', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('11', '10', 'Visual Studio 2017', '3', '0001-01-01 00:00:00', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('12', '14', 'Lucene.net', '3', '0001-01-01 00:00:00', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('13', '10', 'Elastic Search', '3', '2018-09-10 10:27:58', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('14', '1', '后端框架', '2', '0001-01-01 00:00:00', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('15', '14', 'ASP.NET Core', '3', '0001-01-01 00:00:00', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('16', '14', 'ASP.NET Boilerplate (ABP)', '3', '2018-09-10 10:33:29', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('17', '2', 'Javascript', '3', '2018-09-10 10:34:52', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('18', '2', 'Css', '3', '2018-09-10 10:35:04', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('19', '2', 'Html', '3', '2018-09-10 10:35:13', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('20', '1', '硬件', '2', '2018-09-19 09:30:07', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('21', '20', '主机组装', '3', '0001-01-01 00:00:00', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('22', '20', 'OS安装', '3', '0001-01-01 00:00:00', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('23', '1', '操作系统', '2', '2018-09-19 11:34:19', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('24', '23', 'Windows', '3', '2018-09-19 11:34:28', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('25', '23', 'Linux', '3', '2018-09-19 11:34:36', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('28', '1', '前端框架', '2', '2018-09-20 15:08:00', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('29', '28', 'Jquery', '3', '0001-01-01 00:00:00', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('30', '28', 'Bootstrap', '3', '2018-09-20 15:08:41', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('31', '28', 'React', '3', '2018-09-20 15:08:56', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('32', '28', 'Vue', '3', '2018-09-20 15:09:14', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('33', '28', 'Layui', '3', '2018-09-20 15:10:59', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('34', '28', 'Echarts', '3', '0001-01-01 00:00:00', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('35', '10', 'Visual Studio Code', '3', '2018-09-20 15:18:22', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('36', '14', 'Node.js', '3', '2018-09-20 15:18:57', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('37', '10', 'Git', '3', '2018-10-08 10:05:20', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('38', '10', 'TFS', '3', '2018-10-08 10:05:31', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('39', '10', 'IIS', '3', '2018-10-08 10:05:42', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('40', '10', 'Tomcat', '3', '2018-10-08 10:06:52', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('41', '10', 'Nginx', '3', '2018-10-08 10:07:39', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('42', '10', 'Photoshop', '3', '2018-10-08 10:08:35', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('43', '6', 'MongoDB', '3', '2018-10-08 10:09:32', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('44', '1', '大数据和分布式计算', '2', '2018-10-08 10:11:03', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('45', '44', 'Hadoop', '3', '2018-10-08 10:11:18', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('46', '44', 'Spark', '3', '2018-10-08 10:11:47', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('47', '1', '机器学习和人工智能', '2', '2018-10-08 10:12:13', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('48', '47', 'TensorFlow', '3', '2018-10-08 10:12:24', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('49', '14', 'ASP.NET MVC', '3', '2018-10-08 10:18:41', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('54', '1', '基本数据结构和算法', '2', '0001-01-01 00:00:00', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('56', '1', '模式与架构', '2', '0001-01-01 00:00:00', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('57', '54', '排序算法', '3', '2018-10-08 10:30:59', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('58', '54', '查找算法', '3', '2018-10-08 10:31:08', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('59', '54', '线性表算法', '3', '2018-10-08 10:31:23', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('60', '54', '树算法', '3', '2018-10-08 10:31:33', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('61', '54', '图算法', '3', '2018-10-08 10:31:39', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('62', '54', '递归与动态规划算法', '3', '2018-10-08 10:32:09', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('63', '56', '常用设计模式', '3', '2018-10-08 10:33:31', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('64', '56', '常用设计原则', '3', '2018-10-08 10:33:52', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('65', '56', '常用架构', '3', '2018-10-08 10:34:30', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('66', '47', '聚类算法', '3', '2018-10-08 10:39:22', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('67', '47', '神经网络算法', '3', '2018-10-08 10:39:39', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('68', '47', '贝叶斯算法', '3', '2018-10-08 10:39:51', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('69', '47', '图像识别常见算法', '3', '2018-10-08 10:40:11', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('70', '54', '网页排名算法', '3', '2018-10-08 10:41:19', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('71', '28', 'Winform', '3', '2018-10-08 10:49:36', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('72', '28', 'WPF', '3', '2018-10-08 10:49:44', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('73', '14', 'WCF', '3', '2018-10-08 10:49:55', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('74', '14', 'ASP.NET Web API', '3', '2018-10-08 10:50:39', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('75', '10', 'PyCharm', '3', '2018-12-17 11:17:54', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('76', '10', 'WebStorm', '3', '2018-12-17 11:18:05', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('77', '1', '项目经验', '2', '2018-12-21 14:26:38', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('78', '77', '爬虫', '3', '2018-12-21 14:26:55', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('79', '77', '网站开发', '3', '2018-12-21 14:27:08', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('80', '77', '反编译与破解', '3', '2018-12-21 14:27:29', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('81', '77', '桌面软件开发', '3', '2018-12-21 14:27:52', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('83', '2', 'PHP', '3', '0001-01-01 00:00:00', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('84', '2', 'Go', '3', '2019-01-04 11:17:22', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('85', '2', 'C++', '3', '2019-01-04 11:17:54', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('86', '14', 'Spring', '3', '2019-01-14 15:41:13', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('87', '14', 'Hibernate', '3', '2019-01-14 15:41:22', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('88', '14', 'Struts', '3', '2019-01-14 15:41:38', '2019-03-15 09:56:18');
INSERT INTO `skills` VALUES ('89', '14', 'Mybatis', '3', '2019-01-14 15:41:59', '2019-03-15 09:56:18');

-- ----------------------------
-- Table structure for taskcommunicationreplys
-- ----------------------------
DROP TABLE IF EXISTS `taskcommunicationreplys`;
CREATE TABLE `taskcommunicationreplys` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `CommunicationId` int(11) NOT NULL,
  `MemberId` int(11) NOT NULL,
  `Content` text COLLATE utf8mb4_bin,
  `ReplyMemberId` int(11) DEFAULT NULL,
  `CreatedTime` datetime DEFAULT NULL,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of taskcommunicationreplys
-- ----------------------------
INSERT INTO `taskcommunicationreplys` VALUES ('1', '1', '2', 0x363636, '4', '2018-09-27 17:07:48', '2019-03-15 09:56:11');
INSERT INTO `taskcommunicationreplys` VALUES ('2', '1', '3', 0x363636, '4', '2018-09-27 17:07:54', '2019-03-15 09:56:11');
INSERT INTO `taskcommunicationreplys` VALUES ('3', '3', '1', 0xE4B88DE99499, '1', '2018-09-29 08:59:47', '2019-03-15 09:56:11');

-- ----------------------------
-- Table structure for taskcommunications
-- ----------------------------
DROP TABLE IF EXISTS `taskcommunications`;
CREATE TABLE `taskcommunications` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `TaskId` int(11) NOT NULL,
  `Content` text COLLATE utf8mb4_bin,
  `MemberId` int(11) DEFAULT NULL,
  `CreatedTime` datetime DEFAULT NULL,
  `Type` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of taskcommunications
-- ----------------------------
INSERT INTO `taskcommunications` VALUES ('1', '8', 0x617070372E342E37E78988E69CACE4B8ADE4B8AAE588ABE688BFE6BA90E9A1B5E99DA2E8BF98E5AD98E59CA84D4435E7A081E58FAFE4BBA5E6ADA3E5B8B8E7A0B4E8A7A3EFBC8CE5A4A7E983A8E58886E4B8AAE4BABAE9A1B5E99DA2E983BDE5B7B2E7BB8FE58EBBE999A4E4BA86E8BF99E4B8AA4D4435E58685E5AEB9, '4', '2018-09-27 15:17:31', 'Communication', '2019-03-15 09:56:04');
INSERT INTO `taskcommunications` VALUES ('2', '1', null, '4', '2018-09-27 17:09:09', 'fabulous', '2019-03-15 09:56:04');
INSERT INTO `taskcommunications` VALUES ('3', '1', 0xE5819AE79A84E5BE88E5A5BD, '1', '2018-09-29 08:59:35', 'Communication', '2019-03-15 09:56:04');
INSERT INTO `taskcommunications` VALUES ('4', '1', null, '1', '2018-09-29 09:01:18', 'fabulous', '2019-03-15 09:56:04');
INSERT INTO `taskcommunications` VALUES ('5', '1', null, '3', '2018-09-29 18:28:21', 'fabulous', '2019-03-15 09:56:04');
INSERT INTO `taskcommunications` VALUES ('6', '8', null, '4', '2018-10-16 08:56:03', 'fabulous', '2019-03-15 09:56:04');
INSERT INTO `taskcommunications` VALUES ('7', '11', null, '4', '2018-10-16 08:56:04', 'fabulous', '2019-03-15 09:56:04');
INSERT INTO `taskcommunications` VALUES ('8', '4', null, '4', '2018-10-16 08:56:05', 'fabulous', '2019-03-15 09:56:04');

-- ----------------------------
-- Table structure for taskpartners
-- ----------------------------
DROP TABLE IF EXISTS `taskpartners`;
CREATE TABLE `taskpartners` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `MemberId` int(11) DEFAULT NULL,
  `TaskId` int(11) DEFAULT NULL,
  `Description` text COLLATE utf8mb4_bin,
  `CreatedTime` datetime DEFAULT NULL,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of taskpartners
-- ----------------------------
INSERT INTO `taskpartners` VALUES ('1', '1', '1', null, '0001-01-01 00:00:00', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('2', '2', '1', null, '2018-09-10 09:52:02', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('3', '3', '1', null, '2018-09-10 09:52:08', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('4', '2', '3', null, '2018-09-10 09:53:15', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('5', '3', '3', null, '2018-09-10 09:53:21', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('6', '4', '2', null, '0001-01-01 00:00:00', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('7', '1', '2', null, '2018-09-10 10:00:17', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('8', '0', '5', null, '0001-01-01 00:00:00', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('9', '1', '4', null, '0001-01-01 00:00:00', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('10', '1', '3', null, '2018-09-10 09:53:05', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('11', '1', '7', null, '0001-01-01 00:00:00', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('12', '4', '8', null, '2018-09-20 09:07:46', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('13', '3', '8', null, '2018-09-20 09:07:53', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('14', '2', '8', null, '2018-09-20 09:07:58', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('15', '1', '10', null, '0001-01-01 00:00:00', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('16', '5', '10', null, '2018-09-29 09:29:33', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('17', '1', '12', null, '0001-01-01 00:00:00', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('18', '1', '6', null, '0001-01-01 00:00:00', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('19', '1', '13', null, '2018-11-23 15:47:05', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('20', '6', '5', null, '2018-12-10 09:36:04', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('21', '6', '19', null, '2019-01-02 14:14:18', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('22', '3', '18', null, '2019-01-08 18:16:09', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('23', '8', '19', null, '2019-01-15 19:30:14', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('24', '9', '29', null, '2019-01-22 16:40:53', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('25', '3', '30', null, '2019-01-22 16:44:07', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('26', '1', '31', null, '2019-01-22 16:47:19', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('27', '3', '33', null, '2019-01-22 16:50:39', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('28', '3', '34', null, '2019-01-22 17:03:20', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('29', '9', '36', null, '2019-01-22 17:08:48', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('30', '1', '42', null, '2019-02-28 19:13:18', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('31', '3', '25', null, '2019-03-01 13:12:45', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('32', '2', '52', null, '2019-03-01 14:28:51', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('33', '5', '52', null, '2019-03-01 14:28:51', '2019-03-15 09:55:53');
INSERT INTO `taskpartners` VALUES ('34', '2', '89', null, '2019-03-15 13:20:52', '2019-03-15 13:20:51');
INSERT INTO `taskpartners` VALUES ('35', '4', '89', null, '2019-03-15 13:20:52', '2019-03-15 13:20:51');
INSERT INTO `taskpartners` VALUES ('37', '3', '91', null, '2019-03-15 13:33:05', '2019-03-15 13:33:05');
INSERT INTO `taskpartners` VALUES ('38', '2', '90', null, '2019-03-15 20:13:59', '2019-03-15 20:13:58');

-- ----------------------------
-- Table structure for taskreviews
-- ----------------------------
DROP TABLE IF EXISTS `taskreviews`;
CREATE TABLE `taskreviews` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `TaskId` int(11) NOT NULL,
  `PerfectFunction` text COLLATE utf8mb4_bin NOT NULL,
  `TroubleFunction` text COLLATE utf8mb4_bin NOT NULL,
  `StrongAspect` text COLLATE utf8mb4_bin NOT NULL,
  `WeaknessAspect` text COLLATE utf8mb4_bin NOT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of taskreviews
-- ----------------------------
INSERT INTO `taskreviews` VALUES ('1', '6', '', 0xE6B581E7A88BE4B88DE5A49FE5AE8CE59684EFBC8C505054E4B99FE6B2A1E69C89E58786E5A487E5A5BDEFBC8CE4B99FE4B88DE5A5BDE5819CE6ADA2E4BA86EFBC8CE58F82E58AA0E79A84E4BABAE5A4A7E983A8E58886E7ACACE4BA8CE6ACA1E5B0B1E4B88DE69DA5E4BA86EFBC8CE8BF99E4B8AAE4BB8EE6B581E7A88BE5928CE8AEB2E5B888E4B8A4E4B8AAE696B9E99DA2E983BDE8A681E58786E5A487E5A5BDE38082, '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('2', '16', 0x48616E6746697265E7AEA1E79086E5908EE58FB0E4BBBBE58AA1EFBC8CE8BF99E4B8AAE99D9EE5B8B8E6A392E38082, 0xE696ADE7BD91E4BA86E698BEE7A4BAE695B0E68DAEE68EA5E58FA3E5BC82E5B8B8, '', 0xE58A9FE883BDE587BAE78EB0E5BC82E5B8B8E8A18CE4B8BAE79A84E697B6E58099EFBC8CE58FAFE4BBA5E4BA92E79BB8E8AEA8E8AEBAE4B880E4B88BE38082E4BFAEE5A48DE4B880E4BA9BE997AEE9A298E4B98BE5908EEFBC8CE9809AE79FA5E4B880E4B88BE38082E58A9FE883BDE5819AE5AE8CE887AAE6B58BE5A5BDE38082, '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('3', '5', 0x616D62617269E5AFB9E99B86E7BEA4E79A84E7AEA1E790860A, '', 0xE7A094E7A9B6E696B9E6A188EFBC8CE8A7A3E586B3E997AEE9A298EFBC8CE99D9EE5B8B8E58BA4E5A58B, 0xE5AFB9E8BDAFE4BBB6E78988E69CACE58F98E58C96E8A681E69C89E4B880E5AE9AE79A84E4BA86E8A7A3E380820AE5A484E79086E997AEE9A298E88083E89991E4B88DE5A49FE7BB86E887B4EFBC8CE5AFBCE887B4E8B083E8AF95E997AEE9A298E697B6E997B4E8BE83E995BFE380820A, '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('4', '3', 0x584D4CE7BC96E8BE91E599A8, '', 0xE7A7AFE69E81E4BC98E58C96E59084E7A78DE997AEE9A298E38082E58886E5B7A5E6988EE7A1AEEFBC8CE59BA2E9989FE9858DE59088E9BB98E5A591E38082, 0xE585B3E994AEE697B6E997B4E782B9E58F8AE697B6E58F8DE9A688E38082, '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('5', '10', 0xE4BBBBE58AA1E79C8BE69DBFEFBC8CE6A087E7ADBE, 0xE4BBBBE58AA1E782B9E8AF84, 0xE7A7AFE69E81E6B29FE9809AE99C80E6B182E696B9E99DA2E79A84E7BB86E88A82EFBC8CE58F8DE9A688E997AEE9A298E5938DE5BA94E58F8AE697B6EFBC8CE58F8AE697B6E6A0B9E68DAEE99C80E6B182E8B083E695B4E58A9FE883BDE5AE9EE78EB0, 0xE58A9FE883BDE6B58BE8AF95E99C80E8A681E7BB86E887B4E4B880E4BA9B, '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('6', '2', 0xE5908EE58FB0E585B3E994AEE5AD97E6909CE7B4A2E4B8ADEFBC8CE4B8ADE69687E79A84E6909CE7B4A2E9809FE5BAA6E68F90E9AB98E4BA86E5BE88E5A49AE38082, 0xE5908EE58FB0E695B0E5AD97E6909CE7B4A2, 0xE9878DE69E84E88081E79A84E7B4A2E5BC95E5B7A5E585B7E79A84E697B6E58099E99D9EE5B8B8E7BB86E887B4EFBC8CE4BFAEE5A48DE4BA86E5BE88E5A49AE79A84425547E380820A, 0xE9A1B9E79BAEE8BF9BE5BAA6E79A84E68A8AE68FA1EFBC8CE9A1B9E79BAEE99C80E6B182E8AEA8E8AEBAE4B88DE58585E58886, '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('7', '27', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('8', '28', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('9', '29', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('10', '31', 0x313132313231, 0x31, 0x31, 0x31, '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('11', '31', 0x313132313231, 0x31, 0x31, 0x31, '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('12', '30', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('13', '30', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('14', '20', 0x646673, 0x647366, 0x647366, 0x646673, '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('15', '33', 0x3131, 0x3131, 0x3131, 0x3131, '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('16', '13', 0xE5BE88E5A5BD, 0xE5BE88E5A5BD, 0xE5BE88E5A5BD, 0xE5BE88E5A5BD, '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('17', '34', 0x71, 0x71, 0x71, 0x71, '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('18', '37', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('19', '36', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('20', '38', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('21', '38', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('22', '38', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('23', '18', 0x31, 0x32, 0x33, 0x34, '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('24', '32', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('25', '17', 0x34, 0x34, 0x35, 0x35, '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('26', '26', 0x31, 0x32, 0x33, 0x34, '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('27', '42', 0x31, 0x32, 0x33, 0x34, '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('28', '25', 0x31, 0x32, 0x33, 0x34, '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('29', '40', 0x31, 0x31, 0x32, 0x32, '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('30', '24', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('31', '22', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('32', '23', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('34', '14', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('36', '43', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('37', '44', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('38', '45', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('39', '49', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('40', '49', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('41', '49', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('42', '46', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('43', '46', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('44', '52', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('45', '50', 0xE4BAAEE782B9E58A9FE883BD, 0xE7AA9DE5BF83E58A9FE883BD, 0xE782B9E8B59EE696B9E99DA2, 0xE58AA0E6B2B9E696B9E99DA2, '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('46', '54', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('47', '51', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('48', '53', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('49', '56', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('50', '48', 0x3132, 0x7177, 0x61, 0x73, '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('56', '72', 0x0AE5A4A7E692920AE5A4A7E69292, '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('68', '77', 0x0A3434340A3434343434340A3535353535353535353535350A35353535353535353535353535, 0x0A353535, 0x0A3535353535, '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('69', '78', 0x31, 0x32, 0x33, 0x34, '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('70', '79', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('73', '82', '', '', '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('74', '86', '', '', '', 0x0A313233313233EFBC9B, '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('75', '87', '', '', 0x0A313233313233EFBC9B, '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('76', '89', 0x0AE58EBBE58EBBE58EBBEFBC9B, 0x0A777777EFBC9B, '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('77', '89', 0x0AE58EBBE58EBBE58EBBEFBC9B, 0x0A777777EFBC9B, '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');
INSERT INTO `taskreviews` VALUES ('78', '89', 0x0AE58EBBE58EBBE58EBBEFBC9B, 0x0A777777EFBC9B, '', '', '2019-03-15 09:55:42', '2019-03-15 09:55:42');

-- ----------------------------
-- Table structure for tasks
-- ----------------------------
DROP TABLE IF EXISTS `tasks`;
CREATE TABLE `tasks` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `Score` int(11) DEFAULT NULL,
  `Status` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `MemberId` int(11) DEFAULT NULL,
  `StartTime` datetime DEFAULT NULL,
  `EndTime` datetime DEFAULT NULL,
  `DeadLineTime` datetime DEFAULT NULL,
  `Description` text COLLATE utf8mb4_bin COMMENT '说明',
  `CreatedMemberId` int(11) DEFAULT NULL,
  `CreatedTime` datetime DEFAULT NULL,
  `ScoreApportioned` bit(1) DEFAULT b'0',
  `LastUpdateTime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `PlanId` int(11) DEFAULT NULL COMMENT 'NULL表示短期任务',
  `Priority` int(11) NOT NULL DEFAULT '3',
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of tasks
-- ----------------------------
INSERT INTO `tasks` VALUES ('81', '222', null, '关闭', '7', '2019-03-08 16:59:40', null, '2019-03-08 00:00:00', 0x3232, '7', '2019-03-08 16:59:31', '\0', '2019-03-08 17:00:30', null, '3', '2019-03-15 09:55:32');
INSERT INTO `tasks` VALUES ('82', '123', '11', '关闭', '7', '2019-03-08 17:02:54', '2019-03-08 17:02:54', '2019-03-08 00:00:00', 0x313131, '7', '2019-03-08 17:02:44', '', '2019-03-08 17:03:32', null, '3', '2019-03-15 09:55:32');
INSERT INTO `tasks` VALUES ('83', '测试点评', null, '完成', '7', '2019-03-08 17:16:23', '2019-03-08 17:16:32', '2019-03-13 00:00:00', '', '7', '2019-03-08 17:16:05', '\0', '2019-03-08 17:18:06', null, '3', '2019-03-15 09:55:32');
INSERT INTO `tasks` VALUES ('84', '666666666', null, '完成', '7', '2019-03-08 19:07:47', '2019-03-08 19:07:47', '2019-03-08 00:00:00', 0x3636363636, '7', '2019-03-08 19:07:28', '\0', '2019-03-08 19:07:48', null, '3', '2019-03-15 09:55:32');
INSERT INTO `tasks` VALUES ('85', '1641564', null, '完成', '7', '2019-03-11 09:57:54', '2019-03-11 09:57:54', '2019-03-28 00:00:00', '', '7', '2019-03-11 09:57:35', '\0', '2019-03-11 09:57:55', null, '1', '2019-03-15 09:55:32');
INSERT INTO `tasks` VALUES ('86', '1231231', '12', '完成', '7', '2019-03-11 10:07:01', '2019-03-11 10:07:01', '2019-04-04 00:00:00', '', '7', '2019-03-11 10:06:47', '', '2019-03-11 10:07:13', null, '3', '2019-03-15 09:55:32');
INSERT INTO `tasks` VALUES ('87', '213123123', '21', '完成', '7', '2019-03-11 10:13:32', '2019-03-11 10:13:32', '2019-03-14 00:00:00', '', '7', '2019-03-11 10:13:22', '', '2019-03-11 10:13:40', null, '3', '2019-03-15 09:55:32');
INSERT INTO `tasks` VALUES ('88', '测试1', null, '完成', '4', '2019-03-11 10:25:44', '2019-03-11 10:25:44', '2019-03-16 00:00:00', '', '7', '2019-03-11 10:24:40', '\0', '2019-03-11 12:02:31', null, '1', '2019-03-15 09:55:32');
INSERT INTO `tasks` VALUES ('89', '测试任务', '10', '测试', '3', '2019-03-11 12:03:47', '2019-03-11 12:03:52', '2019-03-11 00:00:00', '', '7', '2019-03-11 12:02:57', '', '2019-03-15 13:20:52', null, '3', '2019-03-15 13:20:51');
INSERT INTO `tasks` VALUES ('90', '刚回归', null, '测试', '6', '2019-03-15 13:21:27', null, '2019-03-21 00:00:00', '', '7', '2019-03-15 13:21:19', '\0', '2019-03-15 20:13:59', null, '2', '2019-03-15 20:13:58');
INSERT INTO `tasks` VALUES ('94', '111', null, '完成', '7', '2019-03-18 10:09:42', '2019-03-18 10:09:42', '2019-03-30 00:00:00', 0x313131, '7', '2019-03-15 20:17:52', '\0', '2019-03-18 10:09:43', null, '1', '2019-03-18 10:09:42');

-- ----------------------------
-- Table structure for tasktrackings
-- ----------------------------
DROP TABLE IF EXISTS `tasktrackings`;
CREATE TABLE `tasktrackings` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `FollowerId` int(11) DEFAULT NULL,
  `TaskId` int(11) DEFAULT NULL,
  `FollowTime` datetime DEFAULT NULL,
  `FollowDescription` text COLLATE utf8mb4_bin,
  `FollowType` varchar(150) COLLATE utf8mb4_bin DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=789 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of tasktrackings
-- ----------------------------
INSERT INTO `tasktrackings` VALUES ('1', '1', '1', '2018-09-10 09:39:20', 0xE69E84E5BBBAE7A094E7A9B6E58685E983A8E794A8E79A84E7BD91E7AB99, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('2', '1', '2', '2018-09-10 09:41:59', 0xE4BC98E58C96E4B8A4E782B9EFBC9A0D0A312E20E7B4A2E5BC95E585B3E994AEE5AD97E697B6E4BDBFE794A8E4BA86E2809C254C696B6525E2809DEFBC8CE6AF94E8BE83E685A2E380820D0A322E20E69FA5E8AFA2E99D9EE585B3E994AEE5AD97E688BFE6BA90E697B6E4BDBFE794A8E4BA86E2809C254C696B6525E2809DEFBC8CE6AF94E8BE83E685A2E38082, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('3', '1', '3', '2018-09-10 09:44:42', 0x312E205549E6B58BE8AF95E5BC95E6938E0D0A322E20415049E6B58BE8AF95E5BC95E6938E0D0A332E20E6B58BE8AF95E7AEA1E79086E6A186E69EB6, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('4', '1', '4', '2018-09-10 09:45:48', 0x312E20E5A4A7E695B0E68DAEE4B8ADE5BF83E7A88BE5BA8F425547E4BFAEE5A48DE380820D0A322E20E5A4A7E695B0E68DAEE4B8ADE5BF83E58F8DE9A688E4BFA1E681AFE4BC98E58C96E380820D0A332E20E5A4A7E695B0E68DAEE4B8ADE5BF83E5908CE6ADA5E997AEE9A298E887AAE4BFAEE5A48DE38082, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('5', '1', '1', '2018-09-10 09:47:01', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('6', '1', '1', '2018-09-10 09:51:49', '', '领取任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('7', '1', '3', '2018-09-10 09:53:05', '', '领取任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('8', '1', '5', '2018-09-10 09:56:32', null, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('9', '1', '1', '2018-09-10 09:58:13', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('10', '1', '1', '2018-09-10 09:59:56', 0x312E30E78988E69CACE5B7B2E7BB8FE5AE8CE68890EFBC8CE59FBAE69CACE58A9FE883BDEFBC9AE799BBE5BD95E38081E4B8AAE4BABAE8AFA6E68385E38081E4BBBBE58AA1E7AEA1E79086E38081E7A7AFE58886E68E92E8A18CE6A69CE38081E68A80E883BDE58B8BE7ABA0E7AD89E5B7B2E7BB8FE585B7E5A487E38082, '完成任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('11', '1', '2', '2018-09-10 10:00:10', 0xE5B086E4BBBBE58AA1E8B49FE8B4A3E4BABAE38090E58E9FEFBC9AE5AD99E58B87E4BAAEE38091E68C87E6B4BEE68890E38090E891A3E59091E998B3E38091, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('12', '1', '2', '2018-09-10 10:00:17', '', '领取任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('13', '1', '2', '2018-09-10 10:00:47', 0xE5B086E4BBBBE58AA1E8B49FE8B4A3E4BABAE38090E58E9FEFBC9AE891A3E59091E998B3E38091E68C87E6B4BEE68890E38090E5AD99E58B87E4BAAEE38091, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('14', '1', '2', '2018-09-10 10:01:10', 0xE5B086E4BBBBE58AA1E8B49FE8B4A3E4BABAE38090E58E9FEFBC9AE5AD99E58B87E4BAAEE38091E68C87E6B4BEE68890E38090E891A3E59091E998B3E38091, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('15', '1', '2', '2018-09-10 10:01:18', '', '领取任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('16', '1', '5', '2018-09-10 10:08:09', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('17', '1', '5', '2018-09-10 10:08:57', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('18', '1', '4', '2018-09-10 10:09:18', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('19', '1', '2', '2018-09-10 10:10:11', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('20', '1', '2', '2018-09-10 10:10:42', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('21', '1', '3', '2018-09-10 10:11:18', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('22', '1', '3', '2018-09-10 10:11:48', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('23', '1', '6', '2018-09-10 10:18:27', 0x312EE8AEB2E5B888EFBC9AE6A88AE78E89E9A1BAE380820D0A322EE697B6E997B4EFBC9A323031382E31302E31352D323031382E31302E3138, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('24', '1', '7', '2018-09-10 10:21:28', 0x312EE7BD91E7AB99E6909CE7B4A2E5B7A5E585B7E7A094E7A9B6E4B88EE983A8E7BDB2E38082, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('25', '1', '7', '2018-09-10 10:25:00', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('26', '4', '2', '2018-09-11 16:20:04', 0xE7A094E7A9B6E4BA86656C6173746963736561726368E983A8E7BDB2E8AEBEE7BDAEEFBC9AE58AA8E68081E58F98E69BB4E8AEBEE7BDAEEFBC8CE5BBB6E8BF9FE58886E9858DEFBC8CE6BB9AE58AA8E9878DE590AFEFBC8CE5A487E4BBBD, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('27', '4', '2', '2018-09-11 18:26:24', 0xE5AE89E8A385E4BA866B6962616E61EFBC8CE58FAFE8A786E58C96E99B86E7BEA4E4BFA1E681AF, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('28', '4', '2', '2018-09-12 17:52:29', 0xE69FA5E79C8BE5AE98E696B9362E78E78988E69CACE69687E6A1A3EFBC9AE69FA5E8AFA2E696B9E5BC8F, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('29', '4', '2', '2018-09-12 17:52:58', 0xE695B4E790866C7563656E65E5928C656C6173746963736561726368E696B9E6A188E79A84E6AF94E8BE83, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('30', '2', '3', '2018-09-12 18:03:26', 0xE5AFB9E4BA8EE59BBEE78987E887AAE58AA8E58C96E4B88AE4BCA0E79A84E6B58BE8AF95, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('31', '3', '3', '2018-09-12 18:06:23', 0xE887AAE58AA8E58C96E6B58BE8AF952DE6B7BBE58AA0E688BFE6BA90, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('32', '4', '2', '2018-09-13 18:41:30', 0xE6B7BBE58AA0E688BFE6BA90E79A84E585B6E4BB96E69FA5E8AFA2E5AD97E6AEB5E588B0E7B4A2E5BC95EFBC9BE6B7BBE58AA0E5AFB9E588B7E696B0E697B6E997B4E5928CE5889BE5BBBAE697B6E997B4E79A84E68E92E5BA8F, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('33', '4', '2', '2018-09-14 18:20:08', 0xE695B4E59088E588B0776562E9878CEFBC8CE5AE8CE68890E695B0E68DAEE5BA93E79A84E8849AE69CACE38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('34', '4', '2', '2018-09-17 18:35:46', 0xE59084E4B8AAE6A8A1E59D97E983A8E7BDB2E8B083E8AF95E68890E58A9FEFBC8CE6B58BE8AF95E4B88EE78EB0E69C89E58A9FE883BDE6AF94E8BE83E38082E59CA8E4B88BE4B880E4B8AAE78988E69CACE4B8ADE8BF9BE8A18CE4BFAEE694B9, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('35', '1', '8', '2018-09-20 09:07:33', 0xE7A094E7A9B6E5A682E4BD95E68A93E58F963538E4B8AAE4BABAE688BFE6BA90E79A84E688BFE4B89CE794B5E8AF9D, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('36', '1', '8', '2018-09-20 09:08:05', '', '领取任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('37', '1', '9', '2018-09-20 09:09:40', 0xE5928C5043E4B880E8B5B7E5AE9EE696BDE5A4A7E695B0E68DAEE4B8ADE5BF83E79A84E4BC98E58C96EFBC8CE7BB9FE8AEA1E4BC98E58C96E79A84E4BA8BE9A1B9EFBC8CE8AEBEE8AEA1E79BB8E585B3E79A84E8A18CE4B8BA, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('38', '1', '9', '2018-09-20 09:09:49', '', '领取任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('39', '1', '9', '2018-09-20 09:13:52', 0xE4BBBBE58AA1E5B7B2E7BB8FE5BC80E5A78BEFBC8CE9A284E8AEA139E69C88E5BA95E7BB93E69D9F, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('40', '1', '10', '2018-09-20 09:18:55', 0x312EE4BBBBE58AA1E6A8A1E59D97E4BC98E58C960D0A322EE68A80E883BDE6A8A1E59D97E4BC98E58C960D0A332EE58B8BE7ABA0E58886E7AD89E7BAA70D0A342EE5A29EE58AA0E788B1E5A5BDEFBC8CE5BAA7E58FB3E993AD0D0A352EE7BD91E7AB99E68993E5BC80E58DA1E997AEE9A298E4BC98E58C960D0A362EE58FAFE4BBA5E7BB99E88BB1E99B84E8B4B4E6A087E7ADBE0D0A, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('41', '1', '10', '2018-09-21 08:56:01', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('42', '1', '8', '2018-09-26 10:12:05', 0xE79BAEE5898DE69DA5E8AFB4E6AF94E8BE83E69C89E4BBB7E580BCE79A84E782B9EFBC9A0A312EE58B87E4BAAEE88EB7E58F96E79A84E590AFE58AA8415050E5898DE79A84E9A1B5E99DA20A322EE5AF8CE6B389E88EB7E58F96E588B0E79A84E88EB7E5BE97E8999AE68B9FE58FB7E5928CE58FB7E7A081E5898DE4B889E4BD8DE5928CE5908EE59B9BE4BD8DE79A84E9A1B5E99DA2E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('43', '1', '9', '2018-09-26 10:13:14', 0xE99988E9B98FE59CA8E5819AEFBC8CE587A4E8889EE8BF99E4B8A4E5A4A9E5BF99E59088E5908CE5928CE68AA5E8A1A8E8A1A8E8AEBEE8AEA1EFBC8CE9A284E8AEA1E69C80E5BFABE4BB8AE5A4A9E58FAFE4BBA5E5BC80E5A78BE38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('44', '2', '3', '2018-09-27 15:18:56', 0xE588A9E794A8E58F8DE5B0842B55494175746F6D6174696F6EEFBC8CE58FAFE4BBA5E5AE9EE78EB0E59CA8E4B8BBE7AA97E4BD93284D61696E4672616D6529E4B88AE5AFB9E794A8E688B7E887AAE5AE9AE4B989E68EA7E4BBB6E79A84E6938DE4BD9C28E6AF94E5A682E8BDAFE4BBB6E4B88AE696B9E79A84E88F9CE58D95E9A1B9E98089E68BA929, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('45', '1', '9', '2018-09-27 17:30:05', 0x312EE4BFAEE5A48DE79A84E997AEE9A298EFBC9A0AE9A696E6ACA1E799BBE5BD95E58DA1E6ADBBEFBC8CE581B6E5B094E997AAE98080EFBC8CE78AB6E68081E6A08FE581B6E5B094E4B88DE698BEE7A4BAEFBC8CE5BC80E69CBAE887AAE590AFE58AA8EFBC8CE78988E69CACE58FB7E698BEE7A4BAE588B0E5B08FE695B0E782B9E5908EE4B8A4E4BD8DEFBC8CE6B3A8E5868CE7A081E4B8A2E5A4B1E380820A322EE58F8DE9A688E4BFA1E681AFE5A29EE58AA0E5A682E4B88BE9A1B9EFBC9A0AE6938DE4BD9CE7B3BBE7BB9FE4BFA1E681AFEFBC8C435055EFBC8CE5B7B2E69C89E58685E5AD982FE680BBE58685E5AD98EFBC8CE887AAE79B98E7A381E79B98E589A9E4BD99E7A9BAE997B4EFBC8CE7BD91E7BB9CEFBC88E69C89E7BABF2FE697A0E7BABFEFBC890A332EE5908CE6ADA5E4BC98E58C96EFBC9A0AE5908CE6ADA5E997AEE9A298E887AAE4BFAEE5A48DEFBC8CE581B6E5B094E4B88DE5908CE6ADA5, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('46', '1', '8', '2018-09-28 08:47:44', 0xE5AF8CE6B389E5928CE58B87E4BAAEE8AF95E4BA86E88081E79A843538415050EFBC8CE6B2A1E69C89E689BEE588B0E4BB80E4B988E7BABFE7B4A2, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('47', '1', '10', '2018-09-29 09:29:19', '', '领取任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('48', '3', '8', '2018-09-29 15:03:25', 0xE6B2A1E69C89E8BF9BE5B1950A56352E382E322E3020E4BBA5E58F8AE5AE83E4B98BE5898DE79A84E78988E69CACE697A0E6B395E68993E5BC80E8AFA6E68385E9A1B528415050E5B4A9E6BA8329EFBC8C56362E302E322E3020E4B8AAE4BABAE688BFE6BA90E8AFA6E68385E9A1B5E698BEE7A4BAE2809CE8AFA5E794A8E688B7E590AFE794A8E4BA86E99A90E7A781E4BF9DE68AA4E2809DE38082E697A7E78988E69CAC617070E79A84E8AFA6E68385E9A1B5E4B88EE696B0E78988E69CACE8AFA6E68385E9A1B5E698AFE5908CE4B880E4B8AAE68EA5E58FA3, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('49', '1', '9', '2018-09-29 18:23:17', 0xE8BF9BE585A5E6B58BE8AF95E998B6E6AEB5EFBC8CE6B58BE8AF95E59BA2E9989FE5BC80E5A78BE6B58BE8AF95, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('50', '5', '10', '2018-09-29 18:26:29', 0xE59CA8E69CACE59CB0E690ADE5BBBAE8999AE68B9FE69CBAE5BC80E58F91E78EAFE5A283EFBC8876732B6D7973716CEFBC890AE7869FE68289E7BD91E7AB99E79A84E79BB8E585B3E8A1A8E7BB93E69E840AE69FA5E79C8BE5898DE7ABAFE6A186E69EB66C617955490A, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('51', '4', '8', '2018-09-29 18:34:34', 0xE7BB93E69E9CE5A4B1E8B4A5EFBC9AE5B09DE8AF95E5AE89E8A3853538617070E78988E69CAC76342E7820E588B0E69C80E696B0E79A84382E782E20E8BF9BE8A18CE688BFE6BA90E9A1B5E99DA2E79A84E7BD91E59D80E58886E69E90EFBC8CE4B8AAE4BABAE9A1B5E99DA2E58685E5AEB9EFBC8CE9A1B5E99DA2E68A80E69CAFE794B1786D6CE8BDACE588B07368746D6CE38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('52', '4', '8', '2018-09-30 14:03:36', 0xE7BB93E69E9CEFBC9AE4B88DE58FAFE8A18CE38082E58F8DE68EA8E4B8ADE997B434E4BD8DE794B5E8AF9DE58FB7E7A081E380820A312EE69FA5E4BA86E4B88BE4B8ADE997B434E4BD8DE695B0E585B3E7B3BBE698AFE4B880E5AFB9E5A49AEFBC8C20E5BD92E5B19EE59CB0313A6EE58FB7E7A081EFBC9A20EFBC883137372A2A2A2A32323337EFBC893220E58FB7E7A081E5BD92E5B19EE59CB0E69C89E58FAFE883BDE4B88DE58786E7A1AEE38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('53', '5', '10', '2018-09-30 17:41:26', 0xE695B4E79086E695B0E68DAEE5BA93E5AD97E585B8E69687E6A1A3EFBC8CE5BBBAE7AB8BE5BC80E58F91E8AEA1E58892E69687E6A1A3, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('54', '1', '8', '2018-10-08 15:48:16', 0xE6B2A1E69C89E69FA5E689BEE588B03538E79A84E6BC8FE6B49EEFBC8CE69C80E7BB88E98787E794A8E689ABE7A081E88EB7E58F96E8999AE68B9FE58FB7E79A84E696B9E6A188, '完成任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('55', '1', '9', '2018-10-08 16:04:21', 0xE9A284E8AEA1323031382D31302D3039E58FB7E5BC80E590AFE4B8A4E4B8AAE59F8EE5B882E6B58BE8AF95E58D87E7BAA7, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('56', '2', '3', '2018-10-08 16:54:59', 0xE5AFB9446174614772696456696577E68EA7E4BBB6E8BF9BE8A18CE4BA86E887AAE58AA8E58C96E6B58BE8AF95EFBC8CE58C85E68BACE887AAE5AE9AE4B989E58897E58F8AE68E92E5BA8FE7AD89E58FB3E994AEE88F9CE58D95E9A1B9, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('57', '2', '3', '2018-10-08 17:02:41', 0xE695B4E4B8AAE799BBE5BD95E6A8A1E59D97EFBC88E58C85E68BACE5AF86E7A081E99499E8AFAFEFBC8CE8B4A6E58FB7E4B88DE5AD98E59CA8E587BAE78EB0E98089E68BA9E794A8E688B7E58CBAE59F9FE7AD89E68385E586B529E5B7B2E5AE8CE68890E887AAE58AA8E58C96E6B58BE8AF95, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('58', '3', '3', '2018-10-08 17:10:24', 0xE6B58BE8AF95E4BA86E69D83E99990E6A8A1E59D97EFBC8CE79BAEE5898DE58FAFE887AAE58AA820E98089E68BA9E8A792E889B2E38081E887AAE58AA8E98089E68BA9E69D83E99990E58886E7B1BBE38081E887AAE58AA8E58BBEE98089E69D83E99990E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('59', '4', '2', '2018-10-08 18:31:41', 0x312EE5AE8CE6889073657276696365E68EA5E58FA3E79A84E6898BE69CBAE5928C7063E688BFE6BA90E69FA5E8AFA2E980BBE8BE910A322EE5889BE5BBBAE7A79FE688BFE38081E4BA8CE6898BE688BFE7B4A2E5BC95EFBC8CE69FA5E689BEEFBC88E983A8E58886EFBC89, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('60', '2', '3', '2018-10-08 18:42:05', 0xE5A29EE580BCE69C8DE58AA1E79A84E88F9CE58D95E9A1B9E6B58BE8AF95E5AE8CE68890, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('61', '5', '10', '2018-10-08 18:45:47', 0x312EE6A0B9E68DAEE68A80E883BDE6A091E88A82E782B9E695B0E79BAEEFBC8CE58AA8E68081E8B083E695B4E698BEE7A4BAE9AB98E5BAA60A322EE4BFAEE5A48DE68A80E883BDE5908DE5AD97E5A4AAE995BFEFBC8CE5AFBCE887B4E7BC96E8BE91E68A80E883BDE79A84E4B88BE68B89E58897E8A1A8E698BEE7A4BAE99499E4BD8D0A0A, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('62', '4', '2', '2018-10-09 11:11:06', 0xE5BBBAE7AB8B696E742C6C6F6E67E7B1BBE59E8BE79A84E7B4A2E5BC95EFBC8CE5AE9EE78EB0E88C83E59BB4E69FA5E689BEE58A9FE883BDE38082E69BBFE68DA2E4B98BE5898DE5AD97E7ACA6E4B8B2E7B4A2E5BC95E4BC9AE587BAE78EB0E79A84627567E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('63', '5', '10', '2018-10-09 19:02:25', 0x312EE99990E588B6E6AF8FE4BABAE4B880E5A4A9E69C80E5A49AE58FAFE4BBA5E782B9E4B880E4B8AAE8B59E0A322EE8B083E695B4E4BBBBE58AA1E8B79FE8BF9BE8BE93E585A5E6A186E5A4A7E5B08F0A332EE7AEA1E79086E59198E58FAFE4BBA5E7BC96E8BE91E4BBBBE58AA1E79A84E78AB6E68081E38081E5BC80E5A78BE697B6E997B4E38081E7BB93E69D9FE697B6E997B4, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('64', '4', '2', '2018-10-09 19:07:53', 0xE983A8E7BDB277656220E8BF9BE8A18CE5AEA2E688B7E7ABAFE8B083E8AF95, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('65', '4', '2', '2018-10-10 16:44:30', 0x312EE4BFAEE5A48DE5AEA2E688B7E7ABAFE6B58BE8AF95E4B8ADE79A8462756720322EE5AE9EE78EB0E4B8AAE4BABAE8AEA2E99885E79A84E98787E99B86E58A9FE883BD, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('66', '5', '10', '2018-10-10 18:51:05', 0x312EE4BBBBE58AA1E79A84E8B49FE8B4A3E4BABAE68896E7AEA1E79086E59198E5AFB9E4BBBBE58AA1E4BFA1E681AFE8BF9BE8A18CE4BFAEE694B9E5908EEFBC8CE4BBBBE58AA1E79A84E78AB6E68081E4BF9DE68C81E4B88DE58F980A322EE58EBBE68E89E58B8BE7ABA069636F6EE5A496E99DA2E79A84E799BDE8BEB9E6A186, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('67', '1', '9', '2018-10-11 15:49:42', 0xE4BB8AE5A4A9E68F90E4BAA4E5AEA1E6A0B8EFBC8C323031382D31302D3132E58588E58F91E5B883E6B288E998B3, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('68', '1', '3', '2018-10-11 15:51:44', 0xE4BDBFE794A8466C615549E58FAFE4BBA5E88EB7E58F96526962626F6E436F6E74726F6CE4B88AE99DA2E79A84E59084E7A78DE68EA7E4BBB6EFBC8CE68EA5E4B88BE69DA5E99C80E8A681E8AF95E9AA8C466C615549E883BDE590A6E88EB7E58F96E8BDAFE4BBB6E4B8ADE585B6E5AE83E79A84E59084E7A78DE68EA7E4BBB6E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('69', '1', '11', '2018-10-11 16:56:03', 0x312EE4BC98E58C96E5AEA2E688B7E7ABAFE5908CE6ADA5E7AE97E6B395EFBC8CE68F90E9AB98E5908CE6ADA5E9A291E78E87E380820D0A322EE7A9BAE799BDE695B0E68DAEE5BA93E5908CE6ADA5E697B6E6A5BCE79B98E5AD97E585B8E9809AE8BF8753657276696365E88EB7E58F96E380820D0A332EE5A29EE58AA0E688BFE6BA90E7BC93E5AD98EFBC8CE68F90E9AB98E69FA5E8AFA2E69588E78E870D0A342EE58886E5BA93EFBC8CE4BC98E58C96E695B0E68DAEE5BA93E8A1A8E7BB93E69E84E380820D0A352EE4BC98E58C96E69C8DE58AA1E599A8E7ABAFE980BBE8BE91EFBC8CE5878FE5B091E68993E5BC80E695B0E68DAEE5BA93E79A84E6ACA1E695B0EFBC8CE4B88AE4BCA0E695B0E68DAEE5908CE697B6E4B88AE4BCA04368616E6765E38082, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('70', '1', '11', '2018-10-11 16:56:10', '', '领取任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('71', '1', '11', '2018-10-11 16:56:35', 0xE59CA839E69C88E4BBBDE5B7B2E7BB8FE5AE8CE68890E38082, '完成任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('72', '1', '12', '2018-10-11 17:39:14', 0x312EE7A094E7A9B6E588A9E794A8E69C8DE58AA1E599A8E6999AE997B4E59CA8E7BABFE8AEA1E7AE97E79A84E58FAFE8A18CE680A7E5928CE696B9E6A188E380820D0A322EE7A094E7A9B6E588A9E794A8E69CACE59CB0E8AEA1E7AE97E69CBAE7A6BBE7BABFE8AEA1E7AE97E79A84E58FAFE8A18CE680A7E5928CE696B9E6A188E38082, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('73', '1', '12', '2018-10-11 17:39:59', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('74', '1', '4', '2018-10-11 17:40:50', 0xE9878DE5A48DE79A84E4BBBBE58AA1, '任务作废', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('75', '4', '2', '2018-10-11 17:44:57', 0xE7B4A2E5BC95E69BB4E696B0E68EA5E58FA3EFBC88E8BF9BE8A18CE4B8ADEFBC89, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('76', '3', '3', '2018-10-11 17:45:12', 0xE4BDBFE794A8466C61554920E6B58BE8AF95E4BA86E799BBE5BD95E5928CE69D83E99990E8AEBEE7BDAEEFBC8CE6B58BE8AF95E9809AE8BF87E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('77', '5', '10', '2018-10-11 22:29:21', 0x312EE6B2A1E69C89E58E86E58FB2E58B8BE7ABA0E697B6E698BEE7A4BAE697A0E695B0E68DAE200A322EE6B7BBE58AA0E5928CE4BFAEE694B9E58B8BE7ABA0E697B6EFBC8CE58FAFE4BBA5E7BC96E8BE91E58B8BE7ABA0E7AD89E7BAA7, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('78', '2', '3', '2018-10-12 09:03:01', 0xE6B58BE8AF95E4BA86E98787E794A8417070446F6D61696E28E5BA94E794A8E7A88BE5BA8FE59F9F29EFBC8CE68C87E5AE9AE4BA86E585B6E8BF90E8A18CE59FBAE79BAEE5BD95EFBC8CE69DA5E99A94E7A6BBE6938DE4BD9CE68891E4BBACE79A84E688BFE5B18BE7B3BBE7BB9FEFBC88E58F8DE5B0842B55494175746F6D6174696F6EEFBC89EFBC8CE4BD86E698AFE587BAE78EB0E695B0E68DAEE5BA93E8AFBBE58F96E685A2E79A84E997AEE9A298E38082E585B7E4BD93E997AEE9A298EFBC9A0A31E38081E79BB4E68EA5E8BF90E8A18CEFBC8CE58FAFE4BBA5E8BF90E8A18CE68C87E5AE9AE79BAEE5BD95E4B88BE79A84E7A88BE5BA8FEFBC8CE4BD86E698AFE59CA8E590AFE58AA8E8BF87E7A88BE4B8ADE8BE83E685A2EFBC8CE5908CE697B6E4BC9AE587BAE78EB0E695B0E68DAEE5908CE6ADA5E79A84E697B6E58099EFBC8CE68F90E7A4BAE695B0E68DAEE5BA93E69687E4BBB6E8B7AFE5BE84E4B88DE5AFB9EFBC88E59CA8E6B58BE8AF95E7A88BE5BA8FE8B7AFE5BE84E4B8ADE689BEE4B88DE588B0E68C87E5AE9AE8A1A8EFBC89E997AEE9A2980A32E38081E5B086E68C87E5AE9AE79BAEE5BD95E7A88BE5BA8FE4B88BE79A84E695B0E68DAEE5BA93E68BB7E8B49DE588B0E6B58BE8AF95E7A88BE5BA8FE4B88BEFBC8CE784B6E5908EE8BF90E8A18CEFBC8CE8BF90E8A18CE9809FE5BAA6E5BFABEFBC8CE4B894E4B88DE4BC9AE68F90E7A4BAE4B88AE8BFB0E997AEE9A298E38082E4BD86E8BF99E7A78DE696B9E6A188EFBC8CE4B88DE59088E98082EFBC8CE99C80E8A681E68BB7E8B49DE69687E4BBB6E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('79', '2', '3', '2018-10-12 09:11:18', 0xE4BDBFE794A8466C6155494133EFBC8CE4BB8EE799BBE5BD95E588B0E782B9E587BBE4BA8CE6898BE688BFEFBC88E58FAAE5819AE4BA86E6ADA3E5B8B8E68385E586B5E8BF90E8A18CEFBC8CE5BC82E5B8B8E5A682E799BBE5BD95E5A4B1E8B4A5E7AD89EFBC8CE69A82E69CAAE5819AE6B58BE8AF95EFBC89EFBC8CE58FAFE4BBA5E88EB7E58F96E588B0E68EA7E4BBB6EFBC8CE4B894E6938DE4BD9CE6ADA3E5B8B8E38082E4BD86E698AFE69C89E4B8AAE997AEE9A298EFBC8CE99C80E8A681E8A7A3E586B3EFBC9A0A20202020202020466C6155494133E799BBE5BD95E5908EE8BF9BE585A5E4B8BBE9A1B5E99DA2EFBC8CE98787E794A8E8BDAEE8AFA2E696B9E5BC8FEFBC8CE588A4E696ADE5BD93E5898DE799BBE5BD95E7AA97E4BD93E698AFE590A6E585B3E997AD28E8AFBBE58F9649734F666673637265656EE380814974656D537461747573E4BBA5E58F8A4175746F6D6174696F6E4964E7AD8929E59D87E4BC9AE587BAE78EB0E5BC82E5B8B8EFBC8CE997AEE9A298E58E9FE59BA0EFBC8CE59CA8E4B880E4B8AAE697B6E997B4E782B9E4B88AEFBC8C77696E646F77E5AFB9E8B1A1E99480E6AF81EFBC8CE68980E4BBA5E8AFBBE58F96E4B88DE588B0E5AD97E6AEB5E580BC2CE587BAE78EB0E5BC82E5B8B8, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('80', '2', '3', '2018-10-12 11:07:49', 0xE585B3E4BA8E466C615549E5BD93E7AA97E4BD93E585B3E997ADE697B6EFBC8CE8AFBBE58F9649734F666673637265656EE5A4B1E8B4A5EFBC88E68F90E7A4BAE4BA8BE4BBB6E697A0E6B395E8B083E794A8E4BBBBE4BD95E8AEA2E688B7EFBC89E997AEE9A298EFBC8CE6B7BBE58AA0E5BBB6E697B6E7AD89E5BE85EFBC885468726561642E536C656570EFBC89EFBC8CE58FAFE4BBA5E8A7A3E586B3E997AEE9A298E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('81', '1', '6', '2018-10-12 17:18:40', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('82', '4', '2', '2018-10-12 18:23:49', 0xE5AE8CE68890E69BB4E696B0E6B58BE8AF95EFBC8CE2809CE5BEB7E5BAB7E88AB1E59BADE2809DE585B3E994AEE5AD97E4BA8CE6898BE688BFE6909CE7B4A2E5B091E4BA86E4B880E4B8AAEFBC8CE585B6E4BB96E69CAAE58F91E78EB0E7BB93E69E9CE4B88DE4B880E887B4, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('83', '1', '9', '2018-10-12 18:34:49', 0xE9A1B5E99DA2E8BF98E6B2A1E69C89E69BB4E696B0EFBC8CE7AD89E5BE85E8AEBEE8AEA1E5928CE585ACE58FB8E8AFA6E68385E4B880E8B5B7E5819A, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('84', '4', '2', '2018-10-12 18:35:34', 0x73657276696365E88EB7E58F96E69BB4E696B0E5908EE79A84E7B4A2E5BC95EFBC8CE69FA5E8AFA2E697A0E69588, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('85', '2', '3', '2018-10-15 09:35:24', 0xE588A9E794A8466C615549E6A186E69EB6EFBC8CE5AE9EE78EB0E887AAE58AA8E58C96E6B58BE8AF95EFBC8CE585B3E4BA8EE799BBE5BD95E983A8E5888628E58C85E68BACE799BBE5BD95E5A4B1E8B4A5EFBC8CE8B4A6E688B7E4B88DE5AD98E59CA8E7AD89E68385E586B529E5B7B2E5AE8CE68890E6B58BE8AF95E38082E68EA5E4B88BE69DA5EFBC8CE6B58BE8AF95E887AAE58AA8E4B88AE4BCA0E59BBEE78987E58A9FE883BDE38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('86', '3', '3', '2018-10-15 11:36:13', 0xE4BDBFE794A8466C615549E6B58BE8AF95E585ACE58FB8E8AEBEE7BDAEEFBC8CE68ABDE8B083E8BE83E4B8BAE5A48DE69D82E79A84E68EA7E4BBB6E8BF9BE8A18CE6B58BE8AF95E38082E59FBAE69CACE8AEBEE7BDAEE38081E7BC96E58FB7E8AEBEE7BDAEE38081E887AAE5AE9AE4B989E7AD89E983BDE883BDE6ADA3E5B8B8E88EB7E58F96E5B9B6E689A7E8A18CE38082E5B086E7BBA7E7BBADE6B58BE8AF95E9AB98E7BAA7E8AEBEE7BDAEE79A84E585B6E4BB96E5BCB9E6A186E4B88EE9A29CE889B2E5AE9AE4B989E58A9FE883BD, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('87', '4', '2', '2018-10-15 13:02:17', 0xE58FAFE4BBA5E69BB4E696B0EFBC8CE69BB4E696B0E5908EE79A84E6909CE7B4A2E7BB93E69E9CE69C89E696B0E69C89E697A7, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('88', '2', '3', '2018-10-15 17:28:33', 0xE4BDBFE794A8466C61554933E6B58BE8AF95E69687E4BBB6E887AAE58AA8E4B88AE4BCA0E58A9FE883BDEFBC8CE9809AE8BF87E6B58BE8AF95, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('89', '5', '10', '2018-10-15 18:15:02', 0x312EE4BFAEE5A48DE9BCA0E6A087E694BEE59CA8E68A80E883BDE6A091E79A84E88A82E782B9E697B6EFBC8CE5B08FE58A9FE883BDE59D97E4BD8DE7BDAEE5BC82E5B8B80A322EE4BFAEE5A48DE4BBBBE58AA1E8AFA6E68385E4B8ADE6B7BBE58AA0E4B88DE4BA86E8B79FE8BF9BE4BFA1E681AF0A332EE4BFAEE5A48DE4B8AAE4BABAE9A1B5E99DA2E79C8BE4B88DE8A781E7AEA1E79086E59198E5A1ABE58699E7BB99E887AAE5B7B1E79A84E58F8DE9A688E8AEB0E5BD950A342EE4BBBBE58AA1E8BF9BE5BAA6E69DBFE5928CE7A7AFE58886E68E92E8A18CE6A69CE4B8ADE79A84E5BA8FE58FB7E5928CE68E92E5908DE58897E79FADE4B880E782B9EFBC8CE58897E58685E5AEB9E5B185E4B8ADE698BEE7A4BA, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('90', '4', '2', '2018-10-15 18:29:29', 0x312EE8A7A3E586B3E69BB4E696B06275672CE59BA0E4B8BAE69C89E5A49AE58FB0E69C8DE58AA1E599A8E6B2A1E69C89E585A8E983A8E69BB4E696B00A322EE8AEA8E8AEBAE4BA86E69BB4E696B0E6B581E7A88B, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('91', '4', '2', '2018-10-15 18:30:02', 0xE5AE9EE78EB073657276696365E8BF90E8A18C64656D6F, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('92', '3', '3', '2018-10-15 18:41:31', 0x466C615549E4B8ADE782B9E587BBE69F90E4B8AAE68C89E992AEEFBC8CE5BCB9E587BAE696B0E79A84E9A1B5E99DA2EFBC8CE5A682E69E9CE4BDBFE794A8496E766F6B65E6A8A1E5BC8FEFBC8CE5AEB9E69893E5AFBCE887B4E7BABFE7A88BE998BBE5A19EEFBC8CE5BBBAE8AEAEE4BDBFE794A8436C69636BE5AE9EE78EB0E782B9E587BBE38082EFBC88436C69636BE5AE9EE78EB0E698AFE98787E794A877696E3332EFBC89, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('93', '2', '3', '2018-10-16 15:26:33', 0xE5AFB9446174614772696456696577E68EA7E4BBB6E6B58BE8AF95EFBC8CE6B58BE8AF95E4BDBFE794A8E6ADA3E5B8B8, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('94', '4', '2', '2018-10-16 18:43:36', 0x3120E4BFAEE5A48DE98787E99B86E79A84E4BBB7E6A0BCE7AD9BE98089E58A9FE883BD0A322EE69FA5E79C8BE4BA86E78EB0E69C89E7B4A2E5BC95E4BBA3E7A081EFBC8CE99C80E8A681E4BFAEE694B9E4B889E4B8AAE983A8E5888620EFBC8831EFBC89E98787E99B86E688BFE6BA90E588A0E999A4E697B6E69BB4E696B0E7B4A2E5BC9520EFBC8832EFBC89E5B08FE58CBAE5AD97E585B8E69BB4E696B0E697B6EFBC8CE69BB4E696B0E7B4A2E5BC9520EFBC8833EFBC89E68AA5E5918AE4B8ADE79A84E4B880E4BA9BE695B0E68DAEE698AFE590A6E8BF98E99C80E8A681E8A1A5E9BD90, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('95', '2', '3', '2018-10-17 18:06:01', 0xE6B58BE8AF95E4BA86E6A091E7BB93E69E84E887AAE58AA8E58C96E6938DE4BD9CEFBC8CE587BAE78EB0E4BA86E587A0E4B8AAE997AEE9A298EFBC8CE88A82E782B9E5B195E5BC80E5BC82E5B8B8EFBC88E4B88DE694AFE68C81E5B195E5BC805061747465726EEFBC89EFBC8CE59CA8E698BEE7A4BAE58CBAE59F9FE5A496E79A84E782B9E697A0E6B395E98089E4B8ADE38082E69C80E5908EE8A7A3E586B3E696B9E6A188EFBC9A0A31E38081E9809AE8BF87E588A4E696ADE5AD90E88A82E782B969736F666673637265656EE79A84E696B9E5BC8FE5B195E5BC80E5BD93E5898DE782B9EFBC8CE5B9B6E98092E5BD92E588B0E79BAEE6A087E782B9EFBC8CE8A7A3E586B3E4BA8654726565E68EA7E4BBB6E5B195E5BC80E5AD90E88A82E782B9E997AEE9A2980A32E38081E4BDBFE794A857696E3332E9BCA0E6A087E6BB9AE58AA8E4BA8BE4BBB6EFBC8CE5B086E4B88DE59CA8E698BEE7A4BAE58CBAE59F9FE58685E79A84E68EA7E4BBB6EFBC8CE6BB9AE58AA8E588B0E698BEE7A4BAE58CBAE59F9FEFBC8CE5B9B6E8BF9BE8A18CE6938DE4BD9CE38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('96', '3', '3', '2018-10-17 18:10:02', 0xE6B58BE8AF95E4BA86E585ACE58FB8E8AEBEE7BDAEE4B88BE9AB98E7BAA7E8AEBEE7BDAEE79A84E9A29CE889B2E5AE9AE4B989EFBC8CE697A0E6B395E98089E68BA9E59FBAE69CACE9A29CE889B228E58FAFE9809AE8BF87E8A784E5AE9AE887AAE5AE9AE4B989E9A29CE889B2E696B9E5BC8FE8AEBEE7BDAE524742E580BC29E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('97', '3', '3', '2018-10-17 18:12:24', 0xE88083E58BA4E8AEBEE7BDAEE9878CE79A84E4B88AE78FADE697B6E997B4E698AFE4B880E4B8AA70616E65EFBC8CE697A0E6B395E88EB7E58F96E9878CE99DA2E79A84E697B6E58886E68EA7E4BBB6EFBC8CE78EB0E58FAFE4BDBFE794A8E994AEE79B98E8BE93E585A5E696B9E5BC8FE58F91E98081E580BC286B657962645F6576656E7429E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('98', '4', '2', '2018-10-17 18:29:40', 0x312EE5AE8CE68890E588A0E999A4E688BFE6BA90E69BB4E696B0E7B4A2E5BC95EFBC8C20E6B58BE8AF95627567E4BA8CE6898BE688BFE69CAAE588A0E999A4E68890E58A9F0A322EE6A5BCE79B98E5AD97E585B8E69BB4E696B020E8BF9BE8A18CE4B8AD, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('99', '5', '10', '2018-10-17 18:45:07', 0x312EE4BFAEE5A48DE8B79FE8BF9BE8BE93E585A5E6A186E58685E5AEB9E5A49AE697B6E58FAFE4BBA5E587BAE78EB0E6BB9AE58AA8E69DA1EFBC8CE5A496E5B182E4B88DE587BAE78EB06275670A322EE6A0B7E5BC8FE8B083E695B4EFBC8CE4BDBFE8AFB4E6988EE6A186E5928CE6A087E9A298E6A08FE5A29EE5A4A7E7A9BAE997B40A332EE6B7BBE58AA0E4B8AAE4BABAE4BFA1E681AFE5AD97E6AEB5EFBC9AE5BAA7E58FB3E993ADEFBC8CE88AB1E5908DEFBC8CE788B1E5A5BDEFBC8CE6A087E7ADBE0A342EE5AD90E4BBBBE58AA1E6ADA3E59CA8E8BF9BE8A18C, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('100', '4', '2', '2018-10-18 18:34:05', 0x312EE5AE8CE68890E4B8AAE4BABAE688BFE6BA90E69BB4E696B0203220E5AE8CE68890E5B08FE58CBAE5AD97E585B8E69BB4E696B0, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('101', '5', '10', '2018-10-18 18:38:25', 0xE8B79FE8BF9BE5AD90E4BBBBE58AA1EFBC8CE59CA8E59BA2E9989FE689A7E8A18CE79A84E4BBBBE58AA1E38081E5B7B2E5AE8CE68890E79A84E4BBBBE58AA1E38081E7BB93E69D9FE79A84E4BBBBE58AA1E4B8ADE58AA0E585A5E5B182E7BAA70A, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('102', '4', '2', '2018-10-19 15:54:20', 0xE69FA5E79C8BE9A1B9E79BAE564950486F75736548616E646C6572EFBC8CE58FAAE5AFB9E4B8BBE695B0E68DAEE5BA93E69C89E6938DE4BD9CEFBC8CE9BB91E5908DE58D95E5AFBCE585A5E58A9FE883BDEFBC8CE5928CE7B4A2E5BC95E697A0E585B3, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('103', '4', '2', '2018-10-19 15:56:13', 0xE69FA5E79C8B2054657374564950486F757365496E646578657220E4BBA3E7A081EFBC8CE588B0E4B8AAE4BABAE688BFE6BA90E69BB4E696B0E68EA8E98081E5AE9EE78EB0E980BBE8BE91EFBC8CE69CAAE58F91E78EB0E8B083E794A8E4BBA3E7A081, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('104', '5', '10', '2018-10-19 19:18:50', 0x312EE8B79FE8BF9BE5AD90E4BBBBE58AA1E58A9FE883BD200A322EE4BFAEE5A48DE4BBBBE58AA1E8B79FE8BF9BE4BFA1E681AFE58FAFE68DA2E8A18C, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('105', '1', '13', '2018-10-22 09:58:36', 0xE8AEB2E5B888EFBC9AE69D8EE4BC9F0D0AE697B6E997B4EFBC9A31322E31372D31322E3230, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('106', '4', '2', '2018-10-22 18:33:15', 0xE8BF9BE8A18CE4B8AD20E4B8AAE4BABAE8AEA2E99885E688BFE6BA90E68EA8E98081, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('107', '5', '10', '2018-10-22 19:26:10', 0x312EE58B8BE7ABA0E4B88DE794A8E7949FE68890E79A8470617274E59BBEE78987EFBC8CE69BB4E696B0E58899E8A686E79B960A322EE5A4B4E5838FE4BDBFE794A8E7949FE68890E79A8470617274E59BBEE78987EFBC8CE5A682E69E9CE69BB4E68DA2E58899E588A0E999A4E4B98BE5898DE79A84E59BBEE78987, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('108', '4', '2', '2018-10-23 09:28:29', 0xE6B7BBE58AA0E697B6E997B4E88C83E59BB4E69FA5E8AFA2E4BD9CE4B8BAE9BB98E8AEA4E69FA5E8AFA2E69DA1E4BBB6EFBC8CE58FAFE4BBA5E5AE9EE78EB0E697A0E69DA1E4BBB6E585A8E5B180E69FA5E689BEE38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('109', '4', '2', '2018-10-23 17:04:04', 0xE4BFAEE5A48D6275673AE69CAAE8AEBEE7BDAEE4BBB7E6A0BCE794A8E688B7E79A84E4B8AAE4BABAE8AEA2E99885E688BFE6BA90E69FA5E8AFA2E7BB93E69E9CE4B8BAE7A9BA, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('110', '4', '2', '2018-10-23 18:16:28', 0xE4BFAEE5A48DE4B8AAE4BABAE68EA8E98081E4B8AAE695B0E7BB9FE8AEA1E4B8BAE5BD93E5A4A9E79A84E688BFE6BA90E4B8AAE695B0, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('111', '4', '2', '2018-10-23 18:17:07', 0x546F446F3A20E4B8AAE4BABAE8AEA2E99885E688BFE6BA90E58685E5AEB9E4BFAEE694B9E8A7A6E58F91E69BB4E696B0E688BFE6BA90E68EA8E98081E79A84E4B8AAE695B0, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('112', '5', '10', '2018-10-23 19:23:22', 0xE59CA8E8B79FE8BF9BEFBC9AE4BBBBE58AA1E7A7AFE58886E794B1E68980E69C89E5AD90E4BBBBE58AA1E7BB9FE8AEA1E5BE97E587BA, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('113', '5', '10', '2018-10-24 15:42:59', 0x312EE4BBBBE58AA1E79A84E58886E695B0E98787E794A8E58FB6E5AD90E88A82E782B9E4BBBBE58AA1E58886E695B0E4B98BE5928C0A322EE5AE8CE68890E4BBBBE58AA1E68896E4BD9CE5BA9FE4BBBBE58AA1E697B6EFBC8CE5AD90E4BBBBE58AA1E79A84E78AB6E68081E8A681E5908CE6ADA5E69BB4E696B0, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('114', '1', '9', '2018-10-24 17:32:33', 0xE695B0E68DAEE4B8ADE5BF83E8AFA6E68385E9A1B5E99DA2E4BFAEE694B9E5AE8CE6AF95EFBC8CE5B7B2E7BB8FE4B88AE7BABF, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('115', '4', '2', '2018-10-24 17:49:42', 0xE6B58BE8AF95E4B880E8BDAEEFBC8CE4BFAEE5A48DE983A8E588866275672EE6A5BCE5B182EFBC8CE99DA2E7A7AFEFBC8CE4BBB7E6A0BCE8BE93E585A5E69FA5E8AFA2E7BB93E69E9C, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('116', '4', '2', '2018-10-24 17:52:36', 0x546F646F3A20312EE5A49AE4B8AAE7A88BE5BA8FE8BF90E8A18CE4BC9AE69C89E9878DE5A48DE68EA8E9808120322E20E588A0E999A4E688BFE6BA90E5BA94E8AFA5E4B99FE4BC9AE69C89E586B2E7AA81EFBC8CE5908EE8BF90E8A18CE689BEE4B88DE588B0E588A0E999A4E79A84E688BFE6BA90E3808233E5AEA2E688B7E7ABAFE68EA8E98081E79A84E688BFE6BA90E4B8AAE695B0EFBC8CE5AE89E8A385E69BB4E696B0E4BA8CE6898BE688BFE68896E7A79FE688BFE697B6E997B4E69DA5E69BB4E696B0EFBC8CE4B88DE698AFE585A8E983A8E88EB7E58F96E3808234E694AFE68C81E5908CE697B6E69BB4E696B0E5A49AE4B8AAE695B0E68DAEE5BA93E7B4A2E5BC95, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('117', '1', '9', '2018-10-24 18:09:48', 0xE5B7B2E7BB8FE5BC80E590AFE585A8E59BBDE58D87E7BAA7, '完成任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('118', '4', '2', '2018-10-25 17:35:52', 0xE58886E7A6BBE7B4A2E5BC95E983A8E58886E4B8BA73657276696365E8BF90E8A18C, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('119', '5', '10', '2018-10-25 18:36:06', 0xE695B4E79086E4BBBBE58AA1E6A8A1E59D97E58A9FE883BDE99C80E6B182E5AFBCE59BBE, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('120', '4', '2', '2018-10-26 18:35:01', 0x312EE5A49AE4B8AAE7A88BE5BA8FE8BF90E8A18CE4BC9AE69C89E9878DE5A48DE68EA8E9808120322E20E588A0E999A4E688BFE6BA90E5BA94E8AFA5E4B99FE4BC9AE69C89E586B2E7AA81EFBC8CE5908EE8BF90E8A18CE689BEE4B88DE588B0E588A0E999A4E79A84E688BFE6BA90E3808234E694AFE68C81E5908CE697B6E69BB4E696B0E5A49AE4B8AAE695B0E68DAEE5BA93E7B4A2E5BC95E3808220E4BFAEE694B9E5AE8CE68890EFBC8CE6B58BE8AF95E69CAAE585A8E983A8E6B58BE8AF95E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('121', '5', '10', '2018-10-26 18:51:22', 0x312EE5AE9EE78EB0E88BB1E99B84E6A087E7ADBEE8AF8DE4BA91E5B195E7A4BA0A322EE68EA2E8AEA8E4BBBBE58AA1322E30E8AFA6E68385, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('122', '4', '2', '2018-10-29 18:29:01', 0x312EE4BFAEE694B9E58E9FE7B4A2E5BC95E9A1B9E79BAEE4BBA3E7A081E5928CE78EB0E69C89E4BBA3E7A081E983A8E58886EFBC8CE7ACA6E59088E4BBA3E7A081E8A784E88C83E38082322EE6B58BE8AF95E4BA86E7B4A2E5BC95E69BB4E696B0E6A8A1E59D97E38082E4BFAEE5A48DE4BA86E79BB8E585B3627567, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('123', '2', '3', '2018-10-30 08:37:49', 0xE698A8E5A4A9E4B8BBE8A681E5819AE4BA86E4B8A4E4BBB6E4BA8BEFBC8C0AE4B880E38081E8B083E695B4584D4C20456469746F72E79A84E698BEE7A4BAE8A784E88C83E58C96EFBC8CE4BBA5E58F8AE99288E5AFB9E794A8E688B7E8BE93E585A5E887AAE58AA8E5AE8CE68890E6A0BCE5BC8FE58C96E6938DE4BD9CEFBC88E58F91E78EB0E8BF98E69C89E4B880E4B8AAE5B08FE997AEE9A298E6B2A1E5A484E79086EFBC890AE4BA8CE38081E4BBA3E7A081E79A84E59088E5B9B6E380820AE997AEE9A298EFBC9A0AE5BD93E59CA8E6A087E7ADBEE5908EE99DA2E8BE93E585A5E69687E69CACE697B6EFBC8CE69CAAE5819AE6A0BCE5BC8FE58C96E6938DE4BD9CEFBC8CE99C80E8A681E4BC98E58C96E380820AE4BB8AE5A4A9E4BBBBE58AA1EFBC9A0AE4B880E38081E4B88EE5AF8CE6B389E8AEA8E8AEBAE4B88BEFBC8CE6A091E79A84E88A82E782B9E58F82E695B0E79A84E9858DE7BDAEE380820AE4BA8CE38081E5AFB9E9858DE7BDAEE7958CE99DA2E79A84E8AEBEE8AEA10AE4B889E38081E8AEA8E8AEBAE5AFB9584D4CE8A7A3E69E90E6938DE4BD9CEFBC8CE6B58BE8AF95E7A88BE5BA8FE5A682E4BD95E6A0B9E68DAE786D6CE9858DE7BDAEE79A8453746570E68C89E5BA8FE689A7E8A18CE4BBA5E58F8AE58F82E695B0E79A84E88EB7E58F96E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('124', '3', '3', '2018-10-30 08:39:46', 0xE5AFB9E794A8E688B7E68EA7E4BBB628E7BB93E69E9CE8BE93E587BAE7AA97E58FA329E7BB8FE8A18CE4BC98E58C96E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('125', '3', '3', '2018-10-30 18:01:30', 0x312EE4BF9DE5AD98584D4C2020200A322EE5B883E5B180E8B083E695B40A332EE9878DE69E84E58F98E9878FE5908D, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('126', '4', '2', '2018-10-30 18:10:16', 0x312EE69BB4E696B0E9858DE7BDAEE69687E4BBB6EFBC8CE9878DE696B0E983A8E7BDB2EFBC8CE6B58BE8AF95E588A0E999A4E688BFE6BA9020322EE4BFAEE694B9E4BBA3E7A081E8A784E88C83EFBC88E983A8E58886EFBC89332EE58F91E78EB0E5AEA2E688B7E7ABAFE69FA5E8AFA2E695B0E9878FE4B88DE4B880E887B4627567EFBC8CE6B7BBE58AA0E69C80E5A4A7E88C83E59BB4E5AFBCE887B4E79A84E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('127', '5', '10', '2018-10-30 18:45:19', 0x312EE7BC96E58699E4BBBBE58AA1E58897E8A1A8E9A1B5E99DA2E58F8AE88EB7E58F96E695B0E68DAEE68EA5E58FA3E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('128', '4', '2', '2018-10-31 08:42:30', 0x627567312E20E588A0E999A4E79A84E688BFE6BA90EFBC8CE7B4A2E5BC95E4B8AAE695B0E8BF98E59CA8EFBC8CE58685E5AEB9E6B2A1E69C89E4BA86E38082627567322E20E7A79FE688BFE4BBB7E6A0BCE8B685E587BA696E742CE99C80E8A681E694B9E688906C6F6E67, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('129', '2', '3', '2018-10-31 08:43:24', 0xE5898DE4B8A4E5A4A9E58699E79A84E6A0BCE5BC8FE58C96E696B9E6B395E6BC8FE6B49EE5A4AAE5A49AEFBC8CE696B9E6B395E8AEBEE8AEA1E4B88DE4B8A5E8B0A8EFBC8CE5AEB9E69893E587BAE997AEE9A298EFBC8CE9878DE696B0E8AEBEE8AEA1EFBC8CE4BFAEE694B9E4BA86E6A0BCE5BC8FE58C96E696B9E6B395E38082E7BB8FE8BF87E58F8DE5A48DE8B083E8AF95EFBC8CE69A82E69CAAE587BAE78EB0E997AEE9A298E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('130', '2', '3', '2018-10-31 09:12:16', 0xE4BB8AE5A4A9E4B8BBE8A681E5B7A5E4BD9CEFBC9A0AE4B880E38081E5B086E698A8E5A4A9E58699E79A84E6A0BCE5BC8FE58C96E696B9E6B395E8A784E88C83E58C960AE4BA8CE38081E5B086E79BAEE5898DE7A1AEE5AE9AE5A5BDE79A84584D4CE69687E4BBB6E8A7A3E69E90EFBC8CE88083E89991E5A682E4BD95E6A0B9E68DAEE9858DE7BDAEE5A5BDE79A84E69687E4BBB6EFBC8CE8BF9BE8A18CE887AAE58AA8E58C96E6B58BE8AF95, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('131', '2', '3', '2018-10-31 09:12:16', 0xE4BB8AE5A4A9E4B8BBE8A681E5B7A5E4BD9CEFBC9A0AE4B880E38081E5B086E698A8E5A4A9E58699E79A84E6A0BCE5BC8FE58C96E696B9E6B395E8A784E88C83E58C960AE4BA8CE38081E5B086E79BAEE5898DE7A1AEE5AE9AE5A5BDE79A84584D4CE69687E4BBB6E8A7A3E69E90EFBC8CE88083E89991E5A682E4BD95E6A0B9E68DAEE9858DE7BDAEE5A5BDE79A84E69687E4BBB6EFBC8CE8BF9BE8A18CE887AAE58AA8E58C96E6B58BE8AF95, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('132', '4', '2', '2018-10-31 09:25:48', 0x627567E69BB4E696B0E688BFE6BA9020E697B6E997B4E68E92E5BA8FE5BC82E5B8B8, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('133', '4', '2', '2018-10-31 18:35:59', 0x627567322E20E7A79FE688BFE4BBB7E6A0BCE8B685E587BA696E742CE99C80E8A681E694B9E688906C6F6E672020E4BFAEE5A48DEFBC9B62756720E68E92E5BA8FE5BC82E5B8B8EFBC8CE7B4A2E5BC95E69BB4E696B0E5A4B1E8B4A5E5AFBCE887B4E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('134', '2', '3', '2018-11-01 08:43:26', 0xE698A8E5A4A9E4B8BBE8A681E5B7A5E4BD9CEFBC9A0A31E38081E5B086E696B9E6B395E68C89E8A681E6B182E8A784E88C83E58C96E4BA860A32E38081E8AEA8E8AEBAE4BA86786D6CE69687E6A1A3E6A0BCE5BC8F0A33E38081E5B08FE8AF95E4BA86E4B88BE7AA97E4BD93E8B083E794A8416374696F6EEFBC8CE8BF90E8A18CE887AAE58AA8E58C96E6B58BE8AF95E7A88BE5BA8FEFBC88E58FAAE5819AE4BA86E4B8AAE6B2A1E69C89E58F82E695B0E79A84E68EA5E58FA3EFBC8CE689A7E8A18CE6938DE4BD9CEFBC890A34E38081E5B09DE8AF95E7BB99E5BC80E5A78BE6A087E7ADBEE887AAE58AA8E5A1ABE58585E7BB93E69D9FE6A087E7ADBE0AE997AEE9A298EFBC9A0A31E38081E7BB99E5BC80E5A78BE6A087E7ADBEE5A1ABE58585E7BB93E69D9FE6A087E7ADBEEFBC8CE59CA8E68EA7E588B6E4B88AE99C80E8A681E5AE8CE596840AE4BB8AE5A4A9E5AE89E68E92EFBC9A0A31E38081E7AD89E5AF8CE6B389E5B086E6A091E7BB93E69E84E5BC84E5A5BDEFBC8CE4B880E8B5B7E7A094E7A9B6E8A7A3E69E90584D4CE69687E4BBB6E689A7E8A18CE887AAE58AA8E58C96E6B58BE8AF95EFBC88E4B8BBE8A681EFBC890A32E38081E88AB1E4B880E782B9E5B08FE697B6E997B4E7A094E7A9B6E4B88BE5BC80E5A78BE6A087E7ADBEE5A1ABE58585E7BB93E69D9FE6A087E7ADBEE79A84E997AEE9A298EFBC88E6ACA1E8A681EFBC89, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('135', '4', '2', '2018-11-01 10:48:28', 0x746F646F3A20312EE58FAAE5A1ABE69C80E4BD8EE7A79FE98791E69FA5E8AFA2E7BB93E69E9CE4B88DE4B880E887B4EFBC8CE69C89E5A4A7E4BA8E696E74E79A84E7A79FE9879120322E20E68891E79A84E98787E99B86E4B8ADE59088E7A79FE7AD9BE98089E697A0E6958820332E20E7A1AEE8AEA4E4B88BE588A0E999A4E688BFE6BA90E79A84E696B9E5BC8FEFBC8CE58F91E78EB0E4B880E69DA1E588A0E999A4E79A84E695B0E68DAEEFBC8CE7B4A2E5BC95E6B2A1E588A0E999A4E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('136', '3', '3', '2018-11-01 18:22:35', 0x584D4CE58685E5AEB9E8A7A3E69E90E688905465737443617365, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('137', '4', '2', '2018-11-01 18:56:40', 0xE9878DE69E84E4BBA3E7A081, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('138', '4', '2', '2018-11-02 08:55:55', 0xE69BB4E696B0E4BA86E5AE9EE696BDE69687E6A1A3E7BB99E6B58BE8AF95, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('139', '2', '3', '2018-11-02 09:01:48', 0xE698A8E5A4A9E5AE8CE68890E79A84E4BA8BEFBC9A0A31E38081E5BC80E5A78BE6A087E7ADBEE887AAE58AA8E5A1ABE58585E7BB93E69D9FE6A087E7ADBEEFBC8CE69C89E697B6E6B2A1E5BF85E8A681E5A1ABE58585E79A84E8BF9BE8A18CE4BA86E5A1ABE58585E79A84E997AEE9A298E8A7A3E586B30A32E38081E7BB99E6B58BE8AF95E794A8E4BE8BE7B1BBE6B7BBE58AA0E689A7E8A18CE696B9E6B395EFBC8CE7BB99E887AAE58AA8E58C96E6B58BE8AF95E6B7BBE58AA0E4BA86E8B083E794A8E68EA5E58FA3EFBC8CE8AEA8E8AEBAE8AEBEE8AEA1E4BA86E5A682E4BD95E8B083E794A8E887AAE58AA8E58C96E6B58BE8AF95E68EA5E58FA3E380820AE4BB8AE5A4A9E5B7A5E4BD9CEFBC9A0A31E38081E5AE9EE78EB0E8B083E794A8E887AAE58AA8E58C96E6B58BE8AF95E68EA5E58FA3EFBC8CE8B083E8AF95E8BF90E8A18CE4B880E4B8AA53746570EFBC8CE784B6E5908EE6809DE88083E4B88B786D6CE7BB93E69E84E8AEBEE8AEA1E698AFE590A6E591A8E588B0, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('140', '3', '3', '2018-11-02 09:07:30', 0xE4BB8AE697A5E5B7A5E4BD9CE5AE89E68E92EFBC9AE7BC96E5869920E5B086547265654E6F6465E7BB93E69E84E8BDACE68DA2E68890205465737443617365E7BB93E69E84E79A84E5B7A5E585B7E7B1BB, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('141', '4', '2', '2018-11-02 18:08:11', 0xE9878DE69E84E7B4A2E5BC95E6A8A1E59D97EFBC8CE4BFAEE694B9E4BBA3E7A081E8A784E88C83EFBC8CE5928CE6B58BE8AF95E7A1AEE5AE9AE6B58BE8AF95E88C83E59BB4E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('142', '5', '10', '2018-11-02 18:55:57', 0x312EE695B4E79086E59FB9E8AEADE6849FE683B3707074EFBC8CE5B9B6E58886E4BAAB0A322EE7BBA7E7BBADE4BBBBE58AA1322E30E6A8A1E59D97EFBC88E8AEBEE8AEA1E7BC96E8BE91E8AFA6E68385E9A1B5E99DA2EFBC89, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('143', '4', '2', '2018-11-05 15:35:33', 0x20312EE58FAAE5A1ABE69C80E4BD8EE7A79FE98791E69FA5E8AFA2E7BB93E69E9CE4B88DE4B880E887B4EFBC8CE69C89E5A4A7E4BA8E696E74E79A84E7A79FE9879120E58E9FE59BA0EFBC9AE69C80E5A4A7E7A79FE98791E8B685E8BF87696E7420322E20E68891E79A84E98787E99B86E4B8ADE59088E7A79FE7AD9BE98089E697A0E695882020E5B7B2E4BFAEE5A48D, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('144', '4', '2', '2018-11-05 16:32:49', 0xE68B86E58886E58E9FE7B4A2E5BC95E7A88BE5BA8F20E689B9E5A484E79086E4BBBBE58AA1E4B8BAE4B8A4E4B8AAE697B6E997B4E6AEB5EFBC8CE696B0E7B4A2E5BC95E4BBBBE58AA1E4BD8DE4BA8EE4B8ADE997B4E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('145', '2', '3', '2018-11-06 08:42:57', 0xE695B4E79086E4BA86E4B88BE698A8E5A4A9E4BBA3E7A081E6BC94E7A4BAE697B6E68F90E587BAE79A84E4B880E4BA9BE997AEE9A298E5928CE4BB8AE5A4A9E5BC80E4BC9AE8AEA8E8AEBA416374696F6EE585B7E4BD93E5AE9EE78EB0E99C80E8A681E58786E5A487E79A84E4B89CE8A5BFE38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('146', '3', '3', '2018-11-06 08:45:18', 0xE7BBA7E7BBADE5AE8CE596844C6F67676572E7B1BBE4B88EE7BB93E69E9CE8BE93E587BA28E694B9E4B8BA6C697374626F7829, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('147', '5', '10', '2018-11-06 08:57:22', 0x312EE8B083E695B4E4BBBBE58AA1E6A8A1E59D97E79A84E8A1A8E7BB93E69E840A322EE695B4E79086E8AEA8E8AEBAE5908EE79A84E4BBBBE58AA1E99C80E6B182E58F8AE683B3E6B395, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('148', '4', '2', '2018-11-07 09:10:49', 0xE4BFAEE5A48D20E6ADA3E5BC8FE78988E4B8AAE4BABAE8AEA2E99885E7BB93E69E9CE587BAE99499, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('149', '4', '2', '2018-11-07 11:01:49', 0xE4BFAEE5A48DE4BBB7E6A0BCE79BB8E585B3E69FA5E8AFA2E997AEE9A29820E58FAAE5A1ABE88C83E59BB4E4B88AE99990E68896E4B88BE7BABFE79A84E69FA5E8AFA2, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('150', '4', '2', '2018-11-07 18:55:54', 0xE58D8FE58AA9E6B58BE8AF95E8BF9BE8A18CE6B58BE8AF95, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('151', '3', '3', '2018-11-08 08:28:47', 0xE9878DE69E84E4BA864C6F67676572E7B1BBEFBC8CE696B0E6A186E69EB6E4B8ADEFBC8C6C6F67676572E7B1BBE4B88DE98082E59088E4BDBFE794A8507269736DE887AAE5B8A6E79A84E4BA8BE4BBB6EFBC8CE99C80E8A681E887AAE5AE9AE4B989E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('152', '2', '3', '2018-11-08 08:33:12', 0xE695B4E79086E5B9B6E5AE9EE78EB04C6F67696E416374696F6EEFBC8CE98187E588B0E4BA86E8BE93E587BAE7BB93E69E9CE69CAAE9858DE7BDAEE997AEE9A298EFBC8CE4BB8AE5A4A9E99C80E8A681E8AEA8E8AEBAE4B88BE38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('153', '5', '10', '2018-11-08 08:57:09', 0x312EE4BBBBE58AA1E79C8BE69DBFE59FBAE69CACE6A0B7E5BC8FE7A1AEE5AE9AEFBC8CE5BE85E5A1ABE58585E695B0E68DAE, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('154', '4', '2', '2018-11-08 18:16:36', 0x312CE58E9FE7B4A2E5BC95E694B9E68890736572766963652020322E20E6A5BCE79B98E5AD97E585B8E69BB4E696B0E58A9FE883BD20E8BF9BE8A18CE4B8AD, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('155', '2', '3', '2018-11-08 19:19:24', 0xE5AE9EE78EB0E4BA86457863657074E6A380E6B58BE9A1B9E9AA8CE8AF81E58A9FE883BDE38082E6988EE5A4A9E99C80E8A681E5A49AE58699E587A0E4B8AAE694AFE68C81E79A84457863657074E6A380E6B58BE9A1B9EFBC8CE8BF9BE8A18CE6B58BE8AF95E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('156', '3', '3', '2018-11-08 19:26:54', 0x312EE7949FE6889020546573744361736520E7BB93E69E84E4B8ADE58AA8E68081E8B58BE580BC20416374696F6E0A322EE689A9E5B1954C697374626F78, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('157', '2', '3', '2018-11-09 18:31:20', 0xE4BB8AE5A4A9E8B79FE5AF8CE6B389E5B086E4BBA3E7A081E59088E5B9B6E4BA86EFBC8CE5B9B6E6B58BE8AF95E4BA86E695B4E59088E5908EE79A84E7A88BE5BA8FEFBC8CE58F91E78EB0E69687E69CACE7BC96E8BE91E599A8EFBC8854657874456469746F72EFBC89E59CA8E5A4B1E58EBBE784A6E782B9E5908EEFBC8CE5868DE8BF9BE8A18CE7BC96E8BE91EFBC8CE4BC9AE587BAE78EB0E7BC96E8BE91E4B88DE4BA86E79A84E68385E586B5EFBC88E58589E6A087E58FAFE698BEE7A4BAEFBC8CE4BD86E68EA5E694B6E4B88DE588B0E8BE93E585A5E580BCEFBC89E38082E69C80E5908EE58AA0E4BA86E994AEE79B98E8BE93E585A5E4BA8BE4BBB6EFBC8CE5AFB9E69687E69CACE7BC96E8BE91E599A8E8B58BE4BA88E784A6E782B9E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('158', '3', '3', '2018-11-09 18:31:52', 0xE4BBA3E7A081E59088E5B9B6, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('159', '5', '10', '2018-11-09 19:28:21', 0x312EE5AE8CE68890E79C8BE69DBFE8A786E59BBEE5928CE8A1A8E6A0BCE8A786E59BBE, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('160', '4', '2', '2018-11-12 18:19:58', 0xE7A1AEE5AE9AE6A5BCE79B98E5AD97E585B8E69BB4E696B0E696B9E6A188E5B9B6E5AE9EE696BD, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('161', '5', '10', '2018-11-12 18:52:45', 0x312EE8B083E695B4E79C8BE69DBFE58F8AE8A1A8E6A0BCE8A786E59BBE0A322EE5AE8CE68890E8AEA1E58892E8A786E59BBE, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('162', '4', '2', '2018-11-13 17:10:10', 0x312EE6A5BCE79B98E5AD97E585B8E69BB4E696B0E696B9E6A188E5AE8CE6889020322E20E6B58BE8AF95E58F91E78EB020E98787E99B86E5B08FE58CBAE5908DE69CAAE69BB4E696B0, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('163', '4', '2', '2018-11-14 10:17:39', 0xE58786E5A487E5BC80E5A78BE697A5E59680E58899E7ACACE4BA8CE8BDAEE6B58BE8AF95, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('164', '3', '3', '2018-11-14 10:20:49', 0xE6B58BE8AF95E4BA8620E8AFBBE58F96786D6CE7949FE6889020416374696F6E7320E5AD97E585B820E5928C20E588A9E794A82041747472696275746520E7949FE6889020416374696F6E7320E5AD97E585B820E4B8A4E7A78DE696B9E6A188, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('165', '1', '6', '2018-11-14 10:44:43', '', '领取任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('166', '1', '6', '2018-11-14 10:45:59', 0x312EE7A1AEE5AE9A31312E32362D31312E3239E5BC80E8AFBEE380820A322EE5B7B2E88194E7B3BBE6A88AE78E89E9A1BAE58786E5A487505054, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('167', '4', '2', '2018-11-14 11:22:37', 0xE8A7A3E586B3E58E9FE7B4A2E5BC95E69BB4E696B0E6A380E69FA5EFBC8CE696B0E7B4A2E5BC95E4B99FE6B7BBE58AA0E79BB8E5BA94E79A84E6A380E69FA5E69CBAE588B6, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('168', '4', '2', '2018-11-14 16:10:37', 0xE4BFAEE5A48DE5B0B1E7B4A2E5BC95E69BB4E696B0E78988E69CAC636865636B2C20E696B0E7B4A2E5BC95E6B7BBE58AA0E79B91E68EA7E4BFA1E681AF, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('169', '4', '2', '2018-11-15 10:47:23', 0xE7A1AEE8AEA4E6B58BE8AF95E7BB93E69E9CEFBC8CE689BEE587BAE58E9FE59BA0E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('170', '1', '2', '2018-11-15 15:59:29', 0xE4B8AAE4BABAE688BFE6BA90E585B3E994AEE5AD97E4BC98E58C96E7A094E7A9B6E5B7A5E585B7E79A84E79BAEE79A84E5B7B2E7BB8FE8BEBEE588B0EFBC8CE983A8E7BDB2E4B88DE698AFE5BE88E7B4A7E680A5EFBC8CE7AD89E7A094E58F91E983A8E5B7A5E585B7E4BC98E58C96E4B98BE5908EE5868DE88083E89991E38082E4BBBBE58AA1E694B9E4B8BAE5908EE58FB0E4BFA1E681AFE585B3E994AEE5AD97E6909CE7B4A2E4BC98E58C96EFBC8C, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('171', '3', '3', '2018-11-15 18:35:26', 0x584D4CE8A7A3E69E90E9878DE69E84E5B9B6E6A0A1E9AA8CE580BC, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('172', '2', '3', '2018-11-16 08:26:32', 0xE5AE8CE68890E4BA86416374696F6EE79A84E7BB93E69E84E8B083E695B4E58F8AE4BC98E58C96EFBC8CE5908CE697B6E5AE9EE78EB0E4BA86416374696F6EE79A84E6938DE4BD9CE6ADA5E9AAA4E58F8AE69C9FE69C9BE7BB93E69E9CE9AA8CE8AF81E38082E79BAEE5898DE5AE8CE68890E4BA86E799BBE5BD95416374696F6EE79A84E799BBE5BD95E6938DE4BD9CEFBC8CE9AA8CE8AF81E5AF86E7A081E99499E8AFAFE79A84E697B6E58099EFBC8CE587BAE78EB0E79A84E4BFA1E681AFE68F90E7A4BAE4BFA1E681AFE380820AE4B88BE4B880E6ADA5E8A681E5819AE79A84E698AF584D4CE68EA7E4BBB6E79A84E4BC98E58C962CE59CA8E7958CE99DA2E4B88AE7BC96E8BE91584D4CE79A84E697B6E58099EFBC8CE587BAE78EB0E5A487E98089E68F90E7A4BAE38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('173', '1', '6', '2018-11-16 16:20:33', 0xE5B7B2E58F91E587BAE68AA5E5908DE993BEE68EA5EFBC8C3234E4BABAE68AA5E5908DEFBC8CE7BEA4E5B7B2E7BB8FE5BBBAE5A5BDEFBC8CE58786E697B6E5BC80E8AFBEE38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('174', '4', '2', '2018-11-19 18:06:49', 0xE7A094E7A9B6E5A49AE8A1A8E88194E59088E69FA5E8AFA2EFBC8C6A617661E69C89E5AE9EE78EB0EFBC8C2E6E6574E78988332E3033E79BAEE5898DE6B2A1E69C89E694AFE68C81E38082E8A7A3E586B3E58A9EE6B395EFBC9AE4BBA5E585ACE58FB8E8A1A8E4B8BAE4B8BBE8A1A8E69E84E5BBBAE7B4A2E5BC95E38082E58F82E88083EFBC9A68747470733A2F2F737461636B6F766572666C6F772E636F6D2F7175657374696F6E732F33373238343837342F7365617263682D6F7665722D74776F2D6C7563656E652D646F63756D656E7473, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('175', '5', '10', '2018-11-19 19:13:25', 0x312EE4BC98E58C96E4BBBBE58AA1E8AFA6E68385E9A1B5E99DA2, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('176', '2', '3', '2018-11-20 20:46:03', 0x584D4CE7BC96E8BE91E6A186E69EB6E690ADE5BBBAE5AE8CE68890E38082E6988EE5A4A9E5B086E695B4E79086E58F8AE59088E5B9B6E4BBA3E7A081E38082E784B6E5908EE8B79FE5AF8CE6B389E6B29FE9809AE4B88BEFBC8CE68EA5E4B88BE69DA5E79A84E5B7A5E4BD9C28E695B0E68DAEE5BA93E7BB93E69E84E79A84E8AEBEE8AEA1EFBC8C52756EE7958CE99DA2E79A84E69E84E5BBBAE7AD8929E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('177', '3', '3', '2018-11-21 19:03:21', 0xE7958CE99DA2E887AAE98082E5BA94E4B88EE68B86E58886, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('178', '3', '3', '2018-11-21 19:04:21', 0xE7BC96E58699786D6CE7BC96E8BE91E599A8E699BAE883BDE68F90E7A4BAE695B0E68DAEE79A84E68EA5E58FA3, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('179', '2', '3', '2018-11-21 19:04:40', 0xE4BB8AE5A4A9E4B8BBE8A681E5AE8CE68890E5B7A5E4BD9CEFBC9A0A31E38081E4BBA3E7A081E59088E5B9B6E5AE8CE68890EFBC8CE8B083E8AF95E5B9B6E4BFAEE694B9E4BA86E695B4E59088E5908EE587BAE78EB0E79A84E997AEE9A298E380820A32E38081E8B79FE5AF8CE6B389E6B29FE9809AE4B88BE4B880E6ADA5E8AEA1E58892EFBC8CE58F8AE585B6E4BB96E7958CE99DA2E79A84E8AEBEE8AEA1E7AD89E380820AE6988EE5A4A9E5B7A5E4BD9CEFBC9A0A31E38081E4B88E4672616E6BE6B29FE9809AE4B88BEFBC8CE79BB8E585B3E8AEBEE8AEA1E69C9FE69C9BE7BB93E69E9C0A32E38081E5BBBAE695B0E68DAEE5BA93EFBC8CE690ADE5BBBAE79BB8E585B3E7958CE99DA2, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('180', '3', '3', '2018-11-21 19:06:03', 0xE6B7BBE58AA0E688BFE6BA90616374696F6EE8BF9BE8A18CE4B8ADEFBC8CE6988EE5A4A9E7A1AEE8AEA4E7958CE99DA2E79A84E8AEBEE8AEA1, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('181', '4', '2', '2018-11-22 08:58:33', 0xE5AE9EE78EB0E7B4A2E5BC95E5BBBAE7AB8BEFBC9BE9AA8CE8AF81E69FA5E8AFA2E7BB93E69E9CE5AFB9E6AF94EFBC8CE5AFB9E695B0E5AD97E5928CE5AD97E6AF8DE98787E794A8E6A8A1E7B38AE58CB9E9858DE69FA5E8AFA2, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('182', '4', '2', '2018-11-22 17:27:30', 0xE5AE8CE68890E7B4A2E5BC95E69FA5E689BEE58A9FE883BDEFBC8CE6B189E5AD90E6909CE7B4A2E9809FE5BAA6E58F98E5BFABEFBC8CE5AD97E6AF8DE5928CE695B0E5AD97E6909CE7B4A2E69588E69E9CE4B880E888AC, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('183', '1', '13', '2018-11-23 15:47:05', '', '领取任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('184', '4', '2', '2018-11-23 17:13:06', 0xE4BFAEE694B9E69FA5E8AFA26275672CE6B7BBE58AA0E69FA5E8AFA2E58A9FE883BDE3808220746F646F3A20E6B7BBE58AA0E69FA5E8AFA2E585ACE58FB8E68980E59CA8E58CBAE58EBFEFBC9BE69BB4E696B0E7B4A2E5BC9573657276696365, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('185', '3', '3', '2018-11-23 19:51:46', 0xE6B7BBE58AA0E688BFE6BA90416374696F6E2028E6ADA3E5B8B8E6B7BBE58AA0E688BFE6BA90E6ADA5E9AAA42CE4B894E4B88DE58C85E590ABE59BBEE78987290A, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('186', '3', '3', '2018-11-23 19:52:07', 0xE5A29EE58AA0E9AA8CE8AF81E698AFE590A6E6B7BBE58AA020E68993E5BC80E8BDAFE4BBB620E5928CE585B3E997ADE8BDAFE4BBB6E6938DE4BD9C0A, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('187', '2', '3', '2018-11-26 09:00:26', 0xE5AFB9E68F90E7A4BAE5AD97E585B8E79A844C6F61646572E7B1BBE5928C5175657279E7B1BBE5819AE4BA86E9878DE69E84EFBC8CE7BB99E6A087E7ADBEE58AA0E4B88AE4BA86E68F90E7A4BAE4BFA1E681AFEFBC8CE59CA8E7958CE99DA2E4B88AE5819AE4BA86E8B083E695B4EFBC8CE4BDBFE5BE97E68F90E7A4BAE6A08FE698BEE7A4BAE6A087E7ADBEE79A84E5A487E6B3A8E4BFA1E681AFE38082E6B7BBE58AA0E4BA864C6F67696E416374696F6EE79A84E5A49AE4B8AAE6ADA5E9AAA428E5BE85E9AA8CE8AF8129EFBC8CE9878DE69E84E4BA86457870656374E79A84E7BB93E69E84EFBC8CE5B086E585ACE585B1E5B19EE680A7E4BBA5E58F8AE585ACE585B1E5B19EE680A7E79A84E9AA8CE8AF81E696B9E6B395E68F90E58F96E587BAE69DA5EFBC8CE68F90E9AB98E5A48DE794A8E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('188', '4', '2', '2018-11-26 16:21:58', 0xE5AE8CE688903A20E6B7BBE58AA0E69FA5E8AFA2E585ACE58FB8E68980E59CA8E58CBAE58EBF, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('189', '4', '2', '2018-11-26 18:34:51', 0x746F646F3AE6B7BBE58AA0E8B79FE8BF9BE4BABA20E4BBBBE58AA1E4BABAE7B4A2E5BC95E5AD97E6AEB5, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('190', '1', '6', '2018-11-27 09:05:35', 0x3236E58FB7E6ADA3E5BC8FE5BC80E8AFBEE38082E999A4E4BA86E8AFB7E58187E4B880E4BABAEFBC8CE585B6E4BD99E4BABAE983BDE58F82E58AA0E4BA86E38082E8AEB2E5B888E795A5E69C89E7B4A7E5BCA0EFBC8CE8AFBEE7A88BE4B8AD4368726F6D65E5B7A5E585B7E69C80E5A5BDE8BF98E698AFE5BA94E8AFA5E7A9BFE68F92E59CA8E8AFBEE7A88BE5BD93E4B8ADE6BC94E7A4BAEFBC8CE4B880E4B88AE69DA5E5B0B1E6BC94E7A4BAE8AEA9E5A4A7E5AEB6E79BB4E68EA5E687B5E59C88E38082E6ADA4E5A496EFBC8C505054E5928CE6BC94E7A4BAE4B8ADE5BE88E5A49AE59CB0E696B9E5AD97E4BD93E5A4AAE5B08FEFBC8CE8AEB2E5B888E5A3B0E99FB3E4B99FE5818FE5B08FE38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('191', '4', '2', '2018-11-27 09:40:45', 0xE5AE8CE68890EFBC9AE6B7BBE58AA0E8B79FE8BF9BE4BABA20E4BBBBE58AA1E4BABAE7B4A2E5BC95E5AD97E6AEB5EFBC8C20E69BB4E696B0E980BBE8BE91, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('192', '4', '2', '2018-11-28 08:18:02', 0xE6B58BE8AF95E4BABAE59198EFBC9AE69FA5E8AFA2E6B58BE8AF95E7BB93E69E9CE6B2A1E997AEE9A298E3808220746F646F3A20E69BB4E696B0E5908EE69FA5E8AFA2, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('193', '3', '3', '2018-11-28 18:55:02', 0xE690ADE5BBBA20576562415049E9A1B9E79BAE0A312EE7BC96E58699E69687E4BBB6E4B88AE4BCA0E4B88EE4B88BE8BDBDE68EA5E58FA30A322EE99B86E688904E4C6F67, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('194', '1', '14', '2018-11-29 09:18:50', 0x31E38081E58FAFE4BBA5E9809AE8BF87E98787E99B86E5A496E7BD91EFBC88E5A682E993BEE5AEB6E38081E8B49DE5A3B3E38081E68891E788B1E68891E5AEB6E7AD89E6AF94E8BE83E8A784E88C83E79A84E7BD91E7AB99EFBC89E5928CE7A0B4E8A7A3E688BFE58F8BE38081E69893E981A8E7AD89E7AB9EE5AFB9E8BDAFE4BBB6E79A84E695B0E68DAEE69DA5E4BC98E58C96E68891E4BBACE79A84E6A5BCE79B98E5AD97E585B8EFBC9B0D0A32E38081E7B1BBE993BEE5AEB6E79A84E6A5BCE79B98E5AD97E585B8E5BBBAE7AB8BEFBC88E98787E99B86E4B8BAE4B8BBEFBC8CE794A8E688B7E58F82E4B88E2BE6A2B5E8AEAFE5AEA1E6A0B8E4B8BAE8BE85EFBC89, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('195', '1', '15', '2018-11-29 09:57:27', 0xE7ACACE4B880E6ADA5EFBC9AE5BBBAE7AB8BE4B880E4B8AAE585A8E99DA2E79A84E695B0E68DAEE79B91E6B58BE79B91E68EA7E7B3BBE7BB9FEFBC8CE58C85E68BACEFBC9AE59084E7A78DE695B0E68DAEE9878FE58F8AE58F98E58C96EFBC8CE6AF8FE4B8AA73657276696365E68896E7AB99E782B9E79A84E8AEBFE997AEE9809FE5BAA6E5928CE7A8B3E5AE9AE680A7EFBC9B0D0AE7ACACE4BA8CE6ADA5EFBC9AE6A0B9E68DAEE79B91E6B58BE695B0E68DAEEFBC8CE58886E69E90E695B0E68DAEEFBC8CE689BEE587BAE997AEE9A298E5928CE6BD9CE59CA8E997AEE9A298EFBC9B0D0AE7ACACE4B889E6ADA5EFBC9AE7A094E7A9B6E4B880E4BA9BE58FAFE8A18CE79A84E696B9E6A188EFBC8CE7BB99E588B0E9A1B9E79BAEE59BA2E9989FEFBC8CE8AEA9E9A1B9E79BAEE59BA2E9989FE58EBBE4BC98E58C96E694B9E8BF9BEFBC9B, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('196', '4', '2', '2018-11-29 11:27:54', 0xE4BFAEE694B9E4BBA3E7A081E8A784E88C83EFBC8CE68F90E4BAA4E4BBA3E7A081, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('197', '1', '6', '2018-11-30 09:08:03', 0xE59FB9E8AEADE7BB93E69D9FEFBC8CE4BB8AE5A4A9E694B6E99B86E58F8DE9A688, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('198', '4', '2', '2018-11-30 16:33:27', 0xE6B58BE8AF95EFBC9AE69BB4E696B0E5908EE69FA5E8AFA2EFBC8C20E58F91E5B883E38082E695B4E79086E68F90E4BAA4766970686F757365E7B4A2E5BC95E69C8DE58AA1EFBC8CE79BB8E585B3E4BBA3E7A081E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('199', '3', '3', '2018-12-01 20:55:08', 0xE8AEBEE8AEA1E5B9B6E690ADE5BBBA427567536E69706572E695B0E68DAEE5BA93, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('200', '3', '3', '2018-12-01 20:55:24', 0xE7BC96E586992072756E20E3808120746573746361736520E7AD89E79BB8E585B3E68EA5E58FA3, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('201', '4', '5', '2018-12-03 18:31:07', '', '领取任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('202', '1', '2', '2018-12-03 18:38:12', 0xE694B9E5908EE5B7B2E4BC98E58C96E983A8E7BDB2EFBC8C566970E79A84E5B7B2E7BB8FE68F90E4BAA4E4BD86E79BAEE5898DE4B88DE983A8E7BDB2EFBC8CE4BBBBE58AA1E7BB93E69D9F, '完成任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('203', '4', '5', '2018-12-04 18:32:25', 0xE7A094E7A9B66861646F6F70E99B86E7BEA4E690ADE5BBBA, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('204', '5', '10', '2018-12-04 18:37:44', 0xE5A484E79086E6B58BE8AF95E587BAE69DA5E79A84627567E5928CE997AEE9A298, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('205', '3', '3', '2018-12-04 19:52:45', 0xE5BC80E5A78BE5AFB9E68EA5E983A8E58886E68EA5E58FA3, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('206', '1', '12', '2018-12-05 13:00:16', 0xE5B7B2E7BB8FE58C85E590ABE59CA8E7BD91E7AB99E68EA8E88D90E7AE97E6B395E4BBBBE58AA1E4B8AD, '任务作废', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('207', '2', '3', '2018-12-06 09:57:40', 0xE8BDAFE4BBB6E7958CE99DA2E690ADE5BBBAE5AE8CE68890EFBC8CE6ADA3E59CA8E8BF9BE8A18CE7BB86E58C96E5B7A5E4BD9CEFBC8CE4B88BE4B880E6ADA5E5B7A5E4BD9CE5AE9EE78EB052554EE5928C5465737463617365E59CA8E8BDAFE4BBB6E4B8ADE5B195E78EB0E79A84E5B7A5E4BD9CE6B581E7A88BE79A84E5AE8CE59684E4BBA5E58F8AE79BB8E585B3E7958CE99DA2E79A84E8B083E695B4E4BC98E58C96E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('208', '4', '5', '2018-12-06 14:51:12', 0xE5AE8CE68890207A6F6F6B656570657220E99B86E7BEA4E690ADE5BBBA, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('209', '4', '5', '2018-12-06 18:42:27', 0xE5AE8CE68890206861646F6F7020E4B8A4E4B8AAE4B8BBE88A82E782B9E99B86E7BEA4E690ADE5BBBA, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('210', '1', '13', '2018-12-07 09:37:29', 0xE68DA2E8AEB2E5B888EFBC8CE7A1AEE5AE9AE58685E5AEB9, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('211', '1', '6', '2018-12-07 09:37:56', 0xE680BBE7BB93E7BB93E69D9F, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('212', '1', '6', '2018-12-07 09:39:22', 0xE8BF87E7A88BE99C80E8A681E6A8A1E69DBFE58C96EFBC9A0A312EE6A8A1E69DBFE5B7B2E7BB8FE58786E5A487E5A5BDE380820A322EE6B581E7A88BE694B9E68890E8AEB2E5B888E58786E5A487E5A5BD505054E4B98BE5908EE6898DE4BC9AE5BC80E5A78BE68AA5E5908DE38082, '完成任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('213', '4', '5', '2018-12-07 14:01:36', 0xE7A094E7A9B66869766520E690ADE5BBBA, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('214', '5', '10', '2018-12-07 20:57:04', 0xE983A8E7BDB2E887B3E69C8DE58AA1E599A8, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('215', '2', '3', '2018-12-10 09:21:53', 0x5465737463617365E79A84E8BF90E8A18CE5AE8CE68890EFBC8C52756E526573756C74E8AFA6E68385E7958CE99DA2E5AE8CE68890EFBC8CE688AAE59BBEE5B195E7A4BAE5AE8CE68890EFBC88E69A82E69CAAE8B79FE68EA5E58FA3E5AFB9E68EA5EFBC89E38082E4B88BE4B880E6ADA5E5B7A5E4BD9CE5AE89E68E92EFBC9A31E38081E5B086E7958CE99DA2E6B689E58F8AE5A29EE588A0E694B9E69FA5E79A84E983A8E58886E4BDBFE794A8E68EA5E58FA3E88EB7E58F96E695B0E68DAEEFBC8CE58D8FE58AA9E5AF8CE6B389E7BC96E58699E99C80E8A681E79A84E68EA5E58FA3E3808232E3808152756EE79A84E8BF90E8A18CE69687E4BBB6E4B88AE4BCA0E4B88BE8BDBDEFBC8CE58D8FE58AA9E5AF8CE6B389E58699E68EA5E58FA3E3808233E38081E5AE8CE59684E799BBE5BD95416374696F6EE58F8AE8B083E8AF95, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('216', '2', '3', '2018-12-10 09:25:32', 0xE5889BE5BBBA544F444FEFBC9AE5B086E7958CE99DA2E6B689E58F8AE5A29EE588A0E694B9E69FA5E79A84E983A8E58886E4BDBFE794A8E68EA5E58FA3E88EB7E58F96E695B0E68DAEEFBC8CE58D8FE58AA9E5AF8CE6B389E7BC96E58699E99C80E8A681E79A84E68EA5E58FA3E38082, '创建TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('217', '2', '3', '2018-12-10 09:25:55', 0xE5889BE5BBBA544F444FEFBC9A52756EE79A84E8BF90E8A18CE69687E4BBB6E4B88AE4BCA0E4B88BE8BDBDEFBC8CE58D8FE58AA9E5AF8CE6B389E58699E68EA5E58FA3E38082, '创建TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('218', '2', '3', '2018-12-10 09:26:02', 0xE5889BE5BBBA544F444FEFBC9AE5AE8CE59684E799BBE5BD95416374696F6EE58F8AE8B083E8AF95, '创建TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('219', '3', '3', '2018-12-10 09:28:15', 0xE4B88AE591A8E4B8BBE8A681E5819AE79A84E69C89EFBC9A0D0A312E72756EE79A84E69FA5E8AFA2E38081E6B7BBE58AA072756EE79A847465737463617365E5928CE4BFAEE694B972756EE79A84E68EA5E58FA3E5AFB9E68EA50D0A322E7465737463617365E79A84E69FA5E8AFA2E38081E696B0E5A29EE5928CE4BFAEE694B9EFBC88E58C85E590ABE69687E4BBB6E4B88AE4BCA0E4B88EE4B88BE8BDBDEFBC8CE4B88BE8BDBDE58FAFE883BDE99C80E8A681E5868DE7BB93E59088E5908CE6ADA5E5819AE587BAE8B083E695B4EFBC890D0A332EE695B0E68DAEE5908CE6ADA528E8BF98E59CA8E8BF9BE8A18CE4B8AD290D0AE68EA5E4B88BE69DA5E4B8BBE8A681E5B7A5E4BD9CEFBC9A0D0A312EE7BBA7E7BBADE5819AE695B0E68DAEE5908CE6ADA50D0A322EE69687E4BBB6E5908CE6ADA50D0A332EE5AE8CE68890E585B6E4BB96E68EA5E58FA3E79A84E5AFB9E68EA5EFBC88E5AFB9E68EA5E4B8ADE58FAFE883BDE99C80E8A681E8B083E695B4E68EA5E58FA3EFBC89, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('220', '3', '3', '2018-12-10 09:29:36', 0xE585B3E997AD544F444FEFBC9A52756EE79A84E8BF90E8A18CE69687E4BBB6E4B88AE4BCA0E4B88BE8BDBDEFBC8CE58D8FE58AA9E5AF8CE6B389E58699E68EA5E58FA3E38082, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('221', '4', '5', '2018-12-10 09:36:04', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('222', '4', '5', '2018-12-10 09:38:46', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('223', '5', '10', '2018-12-10 10:15:59', 0xE5889BE5BBBA544F444FEFBC9AE694B6E99B86E4B88AE7BABFE5908EE79A84E997AEE9A298E58F8DE9A688E5B9B6E8B083E695B4, '创建TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('224', '5', '10', '2018-12-10 10:16:44', 0xE5889BE5BBBA544F444FEFBC9AE7BD91E7AB99E680A7E883BDE8B083E4BC98, '创建TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('225', '5', '10', '2018-12-10 10:16:59', 0xE5889BE5BBBA544F444FEFBC9AE59BA2E5BBBAE6A8A1E59D97E8AEBEE8AEA1, '创建TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('226', '4', '5', '2018-12-10 10:54:30', 0xE5889BE5BBBA544F444FEFBC9A6869766520E9858DE7BDAE4D7953514CE695B0E68DAEE5BA93, '创建TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('227', '1', '9', '2018-12-10 11:33:44', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('228', '1', '8', '2018-12-10 11:34:16', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('229', '1', '1', '2018-12-10 11:34:27', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('230', '1', '11', '2018-12-10 12:53:02', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('231', '1', '3', '2018-12-10 12:53:34', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('232', '1', '3', '2018-12-10 14:49:10', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('233', '1', '15', '2018-12-10 14:49:47', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('234', '1', '13', '2018-12-10 14:51:33', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('235', '1', '5', '2018-12-10 14:55:43', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('236', '6', '5', '2018-12-10 15:06:03', 0xE585B3E997AD544F444FEFBC9A6869766520E9858DE7BDAE4D7953514CE695B0E68DAEE5BA93, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('237', '4', '5', '2018-12-10 15:07:53', 0xE5889BE5BBBA544F444FEFBC9A4842617365E7A094E7A9B6, '创建TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('238', '1', '16', '2018-12-10 15:31:16', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9AE695B0E68DAEE7BB9FE8AEA1E5928CE680A7E883BDE79B91E6B58BE7BD91E7AB99, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('239', '4', '2', '2018-12-10 15:36:31', 0x31E4BFAEE5A48DE69FA5E8AFA262756720203220E6B7BBE58AA0E5BF83E8B7B3, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('240', '1', '16', '2018-12-10 15:46:52', 0xE5889BE5BBBAE585B3E994AEE7BB93E69E9CEFBC9AE695B0E68DAEE7BB9FE8AEA1EFBC88E5A29EE9878FE695B0E68DAEE5928CE680BBE695B0E68DAEEFBC890D0A, '创建关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('241', '1', '16', '2018-12-10 15:46:55', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE695B0E68DAEE7BB9FE8AEA1EFBC88E5A29EE9878FE695B0E68DAEE5928CE680BBE695B0E68DAEEFBC890D0A, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('242', '1', '16', '2018-12-10 15:47:28', 0xE5889BE5BBBAE585B3E994AEE7BB93E69E9CEFBC9AE695B0E68DAEE7BB9FE8AEA1EFBC88E5A29EE9878FE695B0E68DAEE5928CE680BBE695B0E68DAEEFBC89, '创建关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('243', '1', '16', '2018-12-10 15:47:44', 0xE5889BE5BBBAE585B3E994AEE7BB93E69E9CEFBC9AE680A7E883BDE79B91E6B58BE9A1B5E99DA2, '创建关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('244', '1', '16', '2018-12-10 15:48:00', 0xE69BB4E696B0E585B3E994AEE7BB93E69E9CEFBC9AE695B0E68DAEE7BB9FE8AEA1EFBC88E5A29EE9878FE695B0E68DAEE5928CE680BBE695B0E68DAEEFBC89, '更新关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('245', '1', '16', '2018-12-10 15:48:22', 0xE69BB4E696B0E585B3E994AEE7BB93E69E9CEFBC9AE680A7E883BDE79B91E6B58BE9A1B5E99DA2, '更新关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('246', '6', '5', '2018-12-10 16:01:41', 0xE5AE8CE68890E4BA8648697665E79A84E69CACE59CB0E6A8A1E5BC8FE5AE89E8A385E4B88EE9858DE7BDAE, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('247', '4', '5', '2018-12-10 17:08:24', 0xE5889BE5BBBA544F444FEFBC9A4D61686F757420E7A094E7A9B6, '创建TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('248', '4', '5', '2018-12-10 17:12:34', 0xE5889BE5BBBA544F444FEFBC9A537061726B202B6861646F6F70, '创建TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('249', '4', '5', '2018-12-10 17:13:11', 0xE5889BE5BBBA544F444FEFBC9A5374726F6D202B6861646F6F70, '创建TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('250', '1', '15', '2018-12-10 17:16:56', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('251', '4', '5', '2018-12-10 18:18:33', 0xE69BB4E696B0544F444FEFBC9A4D61686F757420E7A094E7A9B6, '更新TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('252', '6', '5', '2018-12-10 18:31:10', 0xE69BB4E696B0544F444FEFBC9A4842617365E7A094E7A9B6, '更新TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('253', '4', '5', '2018-12-10 19:19:05', 0x4D61686F7574204A617661E7A88BE5BA8F64656D6F, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('254', '6', '5', '2018-12-10 19:25:41', 0x4842617365302E3936E9858DE7BDAEE68890E58A9F, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('255', '5', '10', '2018-12-10 19:35:36', 0xE585B3E997AD544F444FEFBC9AE694B6E99B86E4B88AE7BABFE5908EE79A84E997AEE9A298E58F8DE9A688E5B9B6E8B083E695B4, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('256', '1', '10', '2018-12-11 09:10:51', 0xE5889BE5BBBAE585B3E994AEE7BB93E69E9CEFBC9AE4BBBBE58AA1E5B195E7A4BAE58D87E7BAA7EFBC9AE4BBBBE58AA1E79C8BE69DBFEFBC8CE4BBBBE58AA1E8A786E59BBEEFBC8CE8AEA1E58892E8A786E59BBE, '创建关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('257', '1', '10', '2018-12-11 09:11:07', 0xE69BB4E696B0E585B3E994AEE7BB93E69E9CEFBC9AE4BBBBE58AA1E5B195E7A4BAE58D87E7BAA7EFBC9AE4BBBBE58AA1E79C8BE69DBFEFBC8CE4BBBBE58AA1E8A786E59BBEEFBC8CE8AEA1E58892E8A786E59BBEEFBC8CE4BBBBE58AA1E782B9E8AF84EFBC8CE4BBBBE58AA1E8AFA6E68385E38082, '更新关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('258', '1', '10', '2018-12-11 09:11:37', 0xE5889BE5BBBAE585B3E994AEE7BB93E69E9CEFBC9AE68A80E883BDE5A4AAE5A49AE79A84E697B6E58099E68CA4E59CA8E4B880E59D97E997AEE9A298E4BFAEE5A48D, '创建关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('259', '1', '10', '2018-12-11 09:11:46', 0xE5889BE5BBBAE585B3E994AEE7BB93E69E9CEFBC9AE58B8BE7ABA0E58886E7AD89E7BAA7, '创建关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('260', '1', '10', '2018-12-11 09:12:07', 0xE5889BE5BBBAE585B3E994AEE7BB93E69E9CEFBC9AE5A29EE58AA0E788B1E5A5BDEFBC8CE5BAA7E58FB3E993ADEFBC8CE88AB1E5908DE5928CE6A087E7ADBE, '创建关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('261', '1', '10', '2018-12-11 09:12:16', 0xE5889BE5BBBAE585B3E994AEE7BB93E69E9CEFBC9AE680A7E883BDE4BC98E58C96, '创建关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('262', '1', '10', '2018-12-11 09:12:38', 0xE5889BE5BBBAE585B3E994AEE7BB93E69E9CEFBC9AE5A29EE58AA0E59BA2E5BBBAE7AEA1E79086E58A9FE883BD, '创建关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('263', '1', '10', '2018-12-11 09:12:51', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE4BBBBE58AA1E5B195E7A4BAE58D87E7BAA7EFBC9AE4BBBBE58AA1E79C8BE69DBFEFBC8CE4BBBBE58AA1E8A786E59BBEEFBC8CE8AEA1E58892E8A786E59BBEEFBC8CE4BBBBE58AA1E782B9E8AF84EFBC8CE4BBBBE58AA1E8AFA6E68385E38082, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('264', '1', '10', '2018-12-11 09:12:57', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE68A80E883BDE5A4AAE5A49AE79A84E697B6E58099E68CA4E59CA8E4B880E59D97E997AEE9A298E4BFAEE5A48D, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('265', '1', '10', '2018-12-11 09:13:00', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE58B8BE7ABA0E58886E7AD89E7BAA7, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('266', '1', '10', '2018-12-11 09:13:05', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE5A29EE58AA0E788B1E5A5BDEFBC8CE5BAA7E58FB3E993ADEFBC8CE88AB1E5908DE5928CE6A087E7ADBE, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('267', '1', '5', '2018-12-11 09:13:53', 0xE5889BE5BBBAE585B3E994AEE7BB93E69E9CEFBC9AE68EA8E88D90E7AE97E6B395, '创建关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('268', '1', '5', '2018-12-11 09:14:09', 0xE5889BE5BBBAE585B3E994AEE7BB93E69E9CEFBC9AE58FAFE689A9E5B195E79A84E5A4A7E695B0E68DAEE8AEA1E7AE97E5B9B3E58FB0, '创建关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('269', '2', '3', '2018-12-11 09:34:51', 0xE69BB4E696B0544F444FEFBC9AE5B086E7958CE99DA2E6B689E58F8AE5A29EE588A0E694B9E69FA5E79A84E983A8E58886E4BDBFE794A8E68EA5E58FA3E88EB7E58F96E695B0E68DAEEFBC8CE58D8FE58AA9E5AF8CE6B389E7BC96E58699E99C80E8A681E79A84E68EA5E58FA3E38082, '更新TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('270', '2', '3', '2018-12-11 09:35:02', 0xE69BB4E696B0544F444FEFBC9A52756EE79A84E8BF90E8A18CE69687E4BBB6E4B88AE4BCA0E4B88BE8BDBDEFBC8CE58D8FE58AA9E5AF8CE6B389E58699E68EA5E58FA3E38082, '更新TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('271', '2', '3', '2018-12-11 09:35:09', 0xE69BB4E696B0544F444FEFBC9A52756EE79A84E8BF90E8A18CE69687E4BBB6E4B88AE4BCA0E4B88BE8BDBDEFBC8CE58D8FE58AA9E5AF8CE6B389E58699E68EA5E58FA3E38082, '更新TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('272', '4', '5', '2018-12-11 09:44:04', 0xE5889BE5BBBA544F444FEFBC9A4170616368652053716F6F7020, '创建TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('273', '4', '5', '2018-12-11 09:59:47', 0xE5889BE5BBBA544F444FEFBC9A41706163686520416D6261726920E694AFE68C81417061636865204861646F6F70E99B86E7BEA4E79A84E4BE9BE5BA94E38081E7AEA1E79086E5928CE79B91E68EA7, '创建TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('274', '4', '5', '2018-12-11 10:00:53', 0xE5889BE5BBBA544F444FEFBC9A4170616368652050696720E5AE89E8A385, '创建TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('275', '5', '10', '2018-12-11 10:57:07', 0xE5889BE5BBBA544F444FEFBC9AE7BD91E7AB99E9A696E9A1B5E88BB1E99B84E9A38EE98787E983A8E58886E98787E794A8E59BBEE78987E68792E58AA0E8BDBDE6A8A1E5BC8F, '创建TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('276', '5', '10', '2018-12-11 10:57:16', 0xE585B3E997AD544F444FEFBC9AE7BD91E7AB99E9A696E9A1B5E88BB1E99B84E9A38EE98787E983A8E58886E98787E794A8E59BBEE78987E68792E58AA0E8BDBDE6A8A1E5BC8F, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('277', '4', '5', '2018-12-11 11:40:18', 0xE5889BE5BBBA544F444FEFBC9AE59FBAE4BA8EE58685E5AEB9E79A84E68EA8E88D90E696B9E6B395, '创建TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('278', '4', '5', '2018-12-11 11:40:29', 0xE5889BE5BBBA544F444FEFBC9AE59FBAE4BA8EE58D8FE5908CE8BF87E6BBA4E79A84E68EA8E88D90E696B9E6B395, '创建TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('279', '4', '5', '2018-12-11 15:32:30', 0xE69BB4E696B0544F444FEFBC9A4D61686F757420E7A094E7A9B6, '更新TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('280', '4', '5', '2018-12-11 15:33:09', 0xE69BB4E696B0544F444FEFBC9A4D61686F757420E7A094E7A9B6, '更新TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('281', '4', '5', '2018-12-11 15:33:32', 0xE69BB4E696B0544F444FEFBC9A537061726B202B6861646F6F70, '更新TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('282', '1', '3', '2018-12-12 09:11:01', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('283', '1', '10', '2018-12-12 09:16:57', 0xE588A0E999A4E585B3E994AEE7BB93E69E9CEFBC9AE5A29EE58AA0E59BA2E5BBBAE7AEA1E79086E58A9FE883BD, '删除关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('284', '1', '10', '2018-12-12 09:17:17', 0xE588A0E999A4544F444FEFBC9AE59BA2E5BBBAE6A8A1E59D97E8AEBEE8AEA1, '删除TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('285', '4', '5', '2018-12-13 10:17:29', 0xE585B3E997AD544F444FEFBC9A4170616368652050696720E5AE89E8A385, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('286', '3', '3', '2018-12-13 15:03:42', 0xE585B3E997AD544F444FEFBC9A52756E20526573756C7420E79A84E7949FE68890E68EA5E58FA3, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('287', '2', '3', '2018-12-13 15:05:22', 0xE585B3E997AD544F444FEFBC9AE5B086E7958CE99DA2E6B689E58F8AE5A29EE588A0E694B9E69FA5E79A84E983A8E58886E4BDBFE794A8E68EA5E58FA3E88EB7E58F96E695B0E68DAEEFBC8CE58D8FE58AA9E5AF8CE6B389E7BC96E58699E99C80E8A681E79A84E68EA5E58FA3E38082, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('288', '2', '3', '2018-12-13 15:05:25', 0xE585B3E997AD544F444FEFBC9A52756EE79A84E8BF90E8A18CE69687E4BBB6E4B88AE4BCA0E4B88BE8BDBDEFBC8CE58D8FE58AA9E5AF8CE6B389E58699E68EA5E58FA3E38082, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('289', '3', '3', '2018-12-13 16:13:22', 0xE585B3E997AD544F444FEFBC9A72756E20746573746361736520E79A84E7A7BBE999A420E5BEAEE8B083, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('290', '4', '5', '2018-12-13 16:45:08', 0xE585B3E997AD544F444FEFBC9A537061726B202B6861646F6F70, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('291', '5', '10', '2018-12-13 19:34:15', 0xE585B3E997AD544F444FEFBC9AE68B86E58886E8A786E59BBEE69687E4BBB6, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('292', '5', '10', '2018-12-13 19:34:49', 0xE585B3E997AD544F444FEFBC9AE4BFAEE5A48DE58F8DE9A688E79A84E997AEE9A298, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('293', '3', '3', '2018-12-13 20:32:55', 0xE585B3E997AD544F444FEFBC9A746573746361736520726573756C7420E7949FE68890E980BBE8BE91E8B083E695B4, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('294', '2', '3', '2018-12-13 20:38:53', 0xE585B3E997AD544F444FEFBC9A52756EE8BF90E8A18CE8B083E695B4E7BB93E69E9CE79A84E68993E58DB0, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('295', '2', '3', '2018-12-13 20:39:04', 0xE585B3E997AD544F444FEFBC9A72756E20726573756C742064657461696C20E4BFA1E681AFE698BEE7A4BAE5BEAEE8B083, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('296', '2', '3', '2018-12-14 09:09:33', 0xE585B3E997AD544F444FEFBC9AE6B58FE8A788E69CACE59CB068746D6CE69687E4BBB6, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('297', '2', '3', '2018-12-14 09:09:47', 0xE585B3E997AD544F444FEFBC9A52756E44657461696CE7958CE99DA2E58A9FE883BDE79A84E5AE9EE78EB0, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('298', '1', '13', '2018-12-14 09:19:02', 0xE69E97E885BEE5B7B2E7BB8FE7A1AEE5AE9AE5A4A7E7BAB2EFBC8CE58886E59B9BE6ACA1E8AFBEE8BF9BE8A18C, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('299', '4', '5', '2018-12-14 12:54:59', 0xE585B3E997AD544F444FEFBC9A4842617365E7A094E7A9B6, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('300', '2', '3', '2018-12-14 15:25:46', 0xE585B3E997AD544F444FEFBC9A72756E20726573756C7420E7BB93E69E9CE58886E69E90, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('301', '1', '17', '2018-12-17 09:31:41', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9AE7A094E7A9B6E999A2E58685E983A8E7BD91E7AB99332E30, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('302', '1', '17', '2018-12-17 09:33:35', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('303', '1', '10', '2018-12-17 09:36:45', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE680A7E883BDE4BC98E58C96, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('304', '1', '10', '2018-12-17 09:36:51', 0xE585B3E997AD544F444FEFBC9AE7BD91E7AB99E680A7E883BDE8B083E4BC98, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('305', '1', '10', '2018-12-17 09:37:04', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('306', '1', '17', '2018-12-17 09:44:00', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('307', '4', '5', '2018-12-17 09:48:44', 0xE585B3E997AD544F444FEFBC9A4170616368652053716F6F702020E5AE89E8A38520E6B58BE8AF95, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('308', '3', '3', '2018-12-17 09:49:18', 0xE585B3E997AD544F444FEFBC9AE794A8E688B7E5A1ABE58699E79A84E4BFA1E681AFE99C80E8A681E9AA8CE8AF81, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('309', '5', '10', '2018-12-17 11:01:59', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('310', '5', '16', '2018-12-17 11:10:56', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('311', '5', '16', '2018-12-17 11:11:07', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('312', '5', '16', '2018-12-17 11:28:32', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('313', '1', '16', '2018-12-17 11:30:10', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('314', '6', '5', '2018-12-17 11:30:35', 0xE5AE8CE68890E4BA86416D62617269E79A84E5AE89E8A385E4B88EE9858DE7BDAEEFBC8CE8BF98E99C80E8A681E7869FE68289E6938DE4BD9C, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('315', '4', '5', '2018-12-17 19:06:45', 0xE585B3E997AD544F444FEFBC9AE4BA86E8A7A3E59FBAE4BA8EE58685E5AEB9E79A84E68EA8E88D90E696B9E6B395, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('316', '2', '3', '2018-12-17 19:09:34', 0xE585B3E997AD544F444FEFBC9AE7A88BE5BA8FE6B7BBE58AA0E5BFABE68DB7E994AE, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('317', '6', '5', '2018-12-18 10:10:28', 0xE585B3E997AD544F444FEFBC9A41706163686520416D6261726920E694AFE68C81417061636865204861646F6F70E99B86E7BEA4E79A84E4BE9BE5BA94E38081E7AEA1E79086E5928CE79B91E68EA7, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('318', '6', '5', '2018-12-18 10:11:26', 0xE5AE8CE68890E4BA86616D62617269E6B7BBE58AA0E88A82E782B9EFBC8C4841E58F8CE88A82E782B9EFBC8C4842617365E69C8DE58AA1E79A84E6B7BBE58AA0, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('319', '1', '17', '2018-12-18 14:21:39', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('320', '1', '17', '2018-12-18 14:21:45', 0xE588A0E999A4E585B3E994AEE7BB93E69E9CEFBC9AE99B86E68890535441E5908EE58FB0E58A9FE883BD, '删除关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('321', '5', '16', '2018-12-18 18:22:25', 0xE585B3E997AD544F444FEFBC9AE696B0E5BBBAE4B880E4B8AAE695B0E68DAEE7BB9FE8AEA1576562E9A1B9E79BAEEFBC8CE98787E794A86173702E6E657420636F7265206D7663, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('322', '5', '16', '2018-12-18 18:22:57', 0xE585B3E997AD544F444FEFBC9AE8AEBEE8AEA1E695B0E68DAEE5B195E7A4BAE9A1B5, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('323', '7', '17', '2018-12-18 19:54:19', 0xE585B3E997AD544F444FEFBC9AE695B0E68DAEE5BA93E5A487E4BBBD, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('324', '3', '3', '2018-12-21 15:18:49', 0xE585B3E997AD544F444FEFBC9AE799BBE5BD95E5908EE58FB0E9AA8CE8AF81, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('325', '7', '17', '2018-12-21 18:29:43', 0xE585B3E997AD544F444FEFBC9AE695B0E68DAEE5BA93E58E8BE7BCA9E5928CE69687E4BBB6E4BF9DE79599, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('326', '4', '5', '2018-12-24 09:12:44', 0xE585B3E997AD544F444FEFBC9AE4BA8CE6898BE688BFEFBC8CE7A79FE688BFE695B0E68DAEE9A284E5A484E79086E588B06D7973716C, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('327', '4', '5', '2018-12-24 10:37:42', 0xE585B3E997AD544F444FEFBC9AE695B0E68DAEE5BA93E588B0686466732C68647366E5AFBCE587BAE588B0E695B0E68DAEE5BA93, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('328', '4', '5', '2018-12-24 10:38:57', 0xE585B3E997AD544F444FEFBC9AE59FBAE4BA8EE58685E5AEB9E79A84E68EA8E88D90E7AE97E6B3952064656D6F, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('329', '4', '5', '2018-12-24 17:36:15', 0xE5AE8CE6889020E688BFE997B4E4B8AAE695B0E79BB8E4BCBCE5BAA6EFBC8CE8A385E4BFAEE7A88BE5BAA6E79BB8E4BCBCE5BAA6, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('330', '4', '5', '2018-12-24 17:36:15', 0xE5AE8CE6889020E688BFE997B4E4B8AAE695B0E79BB8E4BCBCE5BAA6EFBC8CE8A385E4BFAEE7A88BE5BAA6E79BB8E4BCBCE5BAA6, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('331', '4', '5', '2018-12-24 17:36:16', 0xE5AE8CE6889020E688BFE997B4E4B8AAE695B0E79BB8E4BCBCE5BAA6EFBC8CE8A385E4BFAEE7A88BE5BAA6E79BB8E4BCBCE5BAA6, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('332', '4', '5', '2018-12-24 17:36:16', 0xE5AE8CE6889020E688BFE997B4E4B8AAE695B0E79BB8E4BCBCE5BAA6EFBC8CE8A385E4BFAEE7A88BE5BAA6E79BB8E4BCBCE5BAA6, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('333', '4', '5', '2018-12-24 17:38:17', 0xE588A0E999A4544F444FEFBC9A6665, '删除TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('334', '5', '16', '2018-12-24 17:39:16', 0xE585B3E997AD544F444FEFBC9AE8AEBEE8AEA1E695B0E68DAEE5B195E7A4BAE8A1A8E7BB93E69E84, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('335', '5', '16', '2018-12-24 17:39:18', 0xE585B3E997AD544F444FEFBC9AE8B083E794A857656253657276696365E88EB7E58F96E695B0E68DAE, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('336', '6', '5', '2018-12-25 10:39:27', 0xE585B3E997AD544F444FEFBC9AE6A5BCE5B182E79BB8E4BCBCE5BAA6E8AEA1E7AE97, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('337', '6', '5', '2018-12-25 10:39:46', 0xE5AE8CE68890E4BA86E6A5BCE5B182E79BB8E4BCBCE5BAA6E79A84E8AEA1E7AE97E4B88EE6B58BE8AF95, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('338', '2', '3', '2018-12-26 09:32:27', 0xE585B3E997AD544F444FEFBC9AE5AE8CE59684E799BBE5BD95416374696F6EE58F8AE8B083E8AF95, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('339', '3', '3', '2018-12-26 10:02:30', 0xE585B3E997AD544F444FEFBC9A416464486F757365416374696F6E, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('340', '3', '3', '2018-12-26 10:03:19', 0xE585B3E997AD544F444FEFBC9A72756E20E5928C20746573746361736520E8A2ABE588A0E999A4E588A4E696AD, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('341', '1', '13', '2018-12-27 16:56:46', 0xE69E97E885BEE5B7B2E7BB8FE58786E5A487E5A5BD505054EFBC8CE69C89E587A0E4B8AAE997AEE9A298E8A681E694B9E4B880E4B88B0D0A312EE997AEE9A298E58FAFE4BBA5E5A49AE58786E5A487E587A0E4B8AAEFBC8CE79BAEE5898DE997AEE9A298E5A4AAE5B091E4BA860D0A322EE58886E7BB84E7A7AFE58886EFBC8CE7A7AFE58886E69C80E5A49AE79A84E68891E4BBACE58FAFE4BBA5E8AEBEE7BDAEE4B880E4BA9BE5A596E58AB1EFBC8CE8BF99E4B8AAE68891E58FAFE4BBA5E69DA5E58786E5A4870D0A332EE68F90E997AEE9A298E982A3E4B8AAE59BBEE6A087E58AA8E794BBEFBC8CE69C80E5A5BDE698AFE59CA8E997AEE9A298E587BAE78EB0E5898DE58588E587BAE78EB0EFBC8CE68F90E98692E5A4A7E5AEB6E6B3A8E6848F0D0A342EE5AD97E69C89E782B9E5B08FEFBC8CE58FAFE4BBA5E58EBBE4BC9AE8AEAEE5AEA4E69C80E5908EE4B880E68E92E79C8BE79C8BEFBC8CE7A1AEE5AE9AE8B083E5A4A7E587A0E58FB7E6AF94E8BE83E59088E980820D0A352EE6AF8FE6ACA1E8AFBEE58FAFE4BBA5E59CA8E88491E4B8ADE8BF87E4B880E4B88BEFBC8CE5AFB9E4B880E4BA9BE7AA81E58F91E68385E586B5E5819AE587BAE4B880E4BA9BE5BA94E5AFB9E58786E5A4870D0A362EE6AF8FE6ACA1E8AFBEE58FAFE4BBA5E683B3E5A5BDE7ACACE4B880E88A82E9878DE782B9E8A681E5B086E79A84E58685E5AEB9E5928CE7ACACE4BA8CE88A82E9878DE782B9E8A681E8AEB2E79A84E58685E5AEB9EFBC8CE8BF99E6A0B7E697B6E997B4E5AEB9E69893E68E8CE68EA7E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('342', '4', '5', '2018-12-27 18:54:23', 0xE7A094E7A9B6E4BA866D7973716C20E5AFBCE585A5E588B06862617365E9878C, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('343', '1', '14', '2018-12-28 14:52:41', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('344', '5', '16', '2018-12-28 17:56:19', 0xE585B3E997AD544F444FEFBC9AE8B083E695B4E8B083E794A877656273657276696365E697B6E4BCA0E585A5E79A8473716CE8AFADE58FA5EFBC8CE98787E794A8E5A29EE9878FE88EB7E58F96E695B0E68DAEE696B9E5BC8F, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('345', '5', '16', '2018-12-28 17:56:23', 0xE585B3E997AD544F444FEFBC9AE7AB99E782B9E79B91E6B58BE9A1B5E99DA2E695B0E68DAEE88EB7E58F96, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('346', '7', '17', '2018-12-29 09:23:06', 0xE585B3E997AD544F444FEFBC9A35E5A4A9E5858DE799BBE5BD95, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('347', '7', '17', '2018-12-29 10:09:52', 0xE585B3E997AD544F444FEFBC9AE695B0E68DAEE5BA93E4B88BE8BDBD, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('348', '4', '5', '2018-12-29 15:49:38', 0xE585B3E997AD544F444FEFBC9AE7A79FE688BFE688BFE6BA90E79BB8E4BCBCE5BAA6E8AEA1E7AE97, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('349', '4', '5', '2018-12-29 18:47:41', 0xE5AE9EE78EB0E4BA866862617365E5AFBCE585A5E588B0686466732C20E69CAAE5AE9EE78EB068646673E5AFBCE585A5E588B06862617365, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('350', '1', '16', '2019-01-02 11:23:33', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('351', '1', '17', '2019-01-02 11:24:21', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('352', '1', '3', '2019-01-02 11:32:40', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE6B7BBE58AA0E5B8B8E794A8E79A84416374696F6EEFBC9AE68993E5BC80E8BDAFE4BBB6EFBC8CE585B3E997ADE8BDAFE4BBB6EFBC8CE799BBE5BD95EFBC8CE6B7BBE58AA0E688BFE6BA90, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('353', '1', '3', '2019-01-02 11:32:42', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE6A186E69EB6E59FBAE7A180E690ADE5BBBA, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('354', '1', '3', '2019-01-02 11:32:57', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('355', '1', '18', '2019-01-02 11:42:02', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9AE8BDAFE4BBB6E6B58BE8AF95E887AAE58AA8E58C96E6A186E69EB6312E302DE6B58BE8AF95E585ACE6B58BE78988, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('356', '1', '16', '2019-01-02 11:44:10', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('357', '1', '5', '2019-01-02 14:07:34', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('358', '1', '19', '2019-01-02 14:11:52', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9AE7BD91E7AB99E68EA8E88D90E7AE97E6B395E7A094E7A9B6, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('359', '1', '19', '2019-01-02 14:14:18', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('360', '1', '5', '2019-01-02 14:14:39', 0xE588A0E999A4E585B3E994AEE7BB93E69E9CEFBC9AE6A0B9E68DAEE794A8E688B7E4BDBFE794A8E68385E586B5E8AEA1E7AE97E688BFE6BA90E585B3E88194E5BAA6E79A84E580BC, '删除关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('361', '1', '5', '2019-01-02 14:14:41', 0xE588A0E999A4E585B3E994AEE7BB93E69E9CEFBC9AE688BFE6BA905052E580BCE79A84E8AEA1E7AE97, '删除关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('362', '1', '5', '2019-01-02 14:14:43', 0xE588A0E999A4E585B3E994AEE7BB93E69E9CEFBC9AE7BB8FE7BAAAE4BABA5052E580BCE79A84E8AEA1E7AE97, '删除关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('363', '1', '5', '2019-01-02 14:15:12', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('364', '1', '16', '2019-01-02 14:16:45', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('365', '1', '17', '2019-01-02 14:17:03', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('366', '1', '19', '2019-01-02 14:32:30', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('367', '1', '18', '2019-01-02 14:32:40', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('368', '1', '18', '2019-01-02 14:33:28', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('369', '4', '5', '2019-01-02 14:36:18', 0xE588A0E999A4544F444FEFBC9AE59FBAE4BA8EE58D8FE5908CE8BF87E6BBA4E79A84E68EA8E88D90E696B9E6B395, '删除TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('370', '4', '5', '2019-01-02 14:36:40', 0xE588A0E999A4544F444FEFBC9AE58CBFE5908DE794A8E688B7E68EA8E88D90EFBC8CE5889DE6ACA1E68EA8E88D90, '删除TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('371', '4', '5', '2019-01-02 14:36:45', 0xE588A0E999A4544F444FEFBC9A5374726F6D202B6861646F6F70, '删除TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('372', '4', '5', '2019-01-02 14:36:55', 0xE588A0E999A4544F444FEFBC9AE7BB8FE7BAAAE4BABA5052E580BCE5BE97E8AEA1E7AE97, '删除TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('373', '4', '5', '2019-01-02 14:41:16', 0xE588A0E999A4544F444FEFBC9AE7A79FE688BFE688BFE6BA90E7BBBCE59088E8AF84E58886E8AEA1E7AE97, '删除TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('374', '1', '17', '2019-01-02 16:19:56', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('375', '1', '17', '2019-01-02 16:20:01', 0xE588A0E999A4E585B3E994AEE7BB93E69E9CEFBC9AE5ADA3E5BAA6E4BC9AE8AEAEE59CA8E7BABF505054E7949FE68890E5928CE69FA5E99885, '删除关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('376', '1', '17', '2019-01-02 16:20:03', 0xE588A0E999A4E585B3E994AEE7BB93E69E9CEFBC9AE4BE8BE4BC9AE59CA8E7BABF505054E7949FE68890E5928CE69FA5E99885, '删除关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('377', '4', '5', '2019-01-02 19:04:25', 0xE6B7BBE58AA0E88A82E782B9E68890E58A9FEFBC8CE58F91E78EB0E6B2A1E69C89E695B0E68DAEE38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('378', '5', '16', '2019-01-03 16:43:22', 0xE585B3E997AD544F444FEFBC9AE983A8E7BDB2E588B0626F6172642E666F6F77772E636F6DE7AB99E782B9, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('379', '4', '5', '2019-01-04 08:57:21', 0xE588A0E999A4544F444FEFBC9AE7A79FE688BFE68EA8E88D9044656D6F, '删除TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('380', '4', '5', '2019-01-04 08:57:58', 0xE588A0E999A4544F444FEFBC9AE59FBAE4BA8EE794A8E688B7E6B58FE8A788E8AEB0E5BD95E68EA8E88D90, '删除TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('381', '4', '5', '2019-01-04 08:58:01', 0xE588A0E999A4544F444FEFBC9AE688BFE6BA90E8AFA6E68385E9A1B5E99DA2E68EA8E88D90, '删除TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('382', '4', '5', '2019-01-04 08:58:41', 0xE588A0E999A4544F444FEFBC9AE695B0E68DAEE5BA933C3D3E6862617365, '删除TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('383', '4', '5', '2019-01-04 08:58:49', 0xE588A0E999A4544F444FEFBC9A6862617365E588B0686466732C68647366E5AFBCE587BAE588B06862617365, '删除TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('384', '4', '5', '2019-01-04 08:59:00', 0xE585B3E997AD544F444FEFBC9A6861646F6F70E6B7BBE58AA0E88A82E782B9, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('385', '1', '17', '2019-01-04 18:15:28', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('386', '1', '20', '2019-01-04 18:27:13', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9AE695B0E68DAEE7BB9FE8AEA1E5928CE7AB99E782B9E680A7E883BDE79B91E6B58BE7BD91E7AB99322E30, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('387', '1', '20', '2019-01-04 18:27:32', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('388', '1', '20', '2019-01-04 18:28:26', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('389', '5', '16', '2019-01-04 18:30:10', 0xE585B3E997AD544F444FEFBC9AE6A380E69FA5E5B9B6E4BFAEE694B9E695B0E68DAEE5BC82E5B8B8E79A84627567, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('390', '5', '16', '2019-01-04 18:30:14', 0xE588A0E999A4544F444FEFBC9AE8A1A8E6A0BCE694AFE68C81E58897E68E92E5BA8F, '删除TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('391', '5', '16', '2019-01-04 18:30:17', 0xE588A0E999A4544F444FEFBC9AE7BB99E7AB99E782B9E6B7BBE58AA0E8BAABE4BBBDE8AEA4E8AF81E58A9FE883BD, '删除TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('392', '5', '16', '2019-01-04 18:39:58', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('393', '5', '16', '2019-01-04 18:40:10', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE680A7E883BDE79B91E6B58BE9A1B5E99DA2, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('394', '5', '16', '2019-01-04 18:40:12', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE695B0E68DAEE7BB9FE8AEA1EFBC88E5A29EE9878FE695B0E68DAEE5928CE680BBE695B0E68DAEEFBC89, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('395', '5', '20', '2019-01-04 18:40:39', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('396', '4', '5', '2019-01-07 08:30:59', 0xE585B3E997AD544F444FEFBC9A6861646F6F7020E588A0E999A4E88A82E782B9, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('397', '6', '5', '2019-01-07 08:33:42', 0xE585B3E997AD544F444FEFBC9A616D62617269E6B7BBE58AA0E5928CE588A0E999A4686F7374EFBC8C73657276696365, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('398', '4', '5', '2019-01-07 08:34:32', 0xE588A0E999A4544F444FEFBC9A686976652072656D6F7465E6A8A1E5BC8FE9858DE7BDAE, '删除TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('399', '4', '5', '2019-01-07 08:35:38', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('400', '6', '5', '2019-01-07 08:42:38', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('401', '6', '5', '2019-01-07 08:43:21', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('402', '6', '5', '2019-01-07 08:44:42', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('403', '6', '5', '2019-01-07 10:30:52', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('404', '2', '18', '2019-01-07 10:31:54', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('405', '6', '5', '2019-01-07 10:37:44', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('406', '4', '5', '2019-01-07 10:50:38', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('407', '4', '2', '2019-01-07 10:52:29', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('408', '5', '20', '2019-01-07 11:36:58', 0xE585B3E997AD544F444FEFBC9AE8A1A8E6A0BCE694AFE68C81E68E92E5BA8F, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('409', '5', '20', '2019-01-07 11:37:01', 0xE585B3E997AD544F444FEFBC9AE6B7BBE58AA0E799BBE5BD95E58A9FE883BD, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('410', '6', '19', '2019-01-07 13:20:20', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('411', '7', '17', '2019-01-07 13:58:26', 0xE585B3E997AD544F444FEFBC9AE695B0E68DAEE5BA93E8BF98E58E9FE5B7A5E585B7, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('412', '4', '5', '2019-01-07 15:28:49', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('413', '4', '5', '2019-01-07 15:29:19', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('414', '4', '5', '2019-01-07 15:31:04', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('415', '4', '5', '2019-01-07 15:36:58', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('416', '5', '20', '2019-01-07 19:30:44', 0xE585B3E997AD544F444FEFBC9AE4BBA3E7A081E7BB86E88A82E4BC98E58C96, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('417', '1', '6', '2019-01-08 10:17:37', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('418', '6', '19', '2019-01-08 11:23:40', 0xE585B3E997AD544F444FEFBC9A616D62617269E99B86E7BEA4E69BB4E68DA24E616D654E6F6465, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('419', '6', '19', '2019-01-08 11:23:50', 0xE585B3E997AD544F444FEFBC9AE688BFE6BA90E68EA8E88D9044656D6FE79A84E5898DE7ABAFE9A1B5E99DA2, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('420', '1', '5', '2019-01-08 12:47:23', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('421', '1', '2', '2019-01-08 12:48:24', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('422', '1', '2', '2019-01-08 12:49:42', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('423', '1', '16', '2019-01-08 12:50:37', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('424', '1', '5', '2019-01-08 12:50:54', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('425', '1', '2', '2019-01-08 12:51:07', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('426', '1', '3', '2019-01-08 12:52:31', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('427', '1', '10', '2019-01-08 12:54:10', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('428', '1', '16', '2019-01-08 14:08:03', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('429', '1', '5', '2019-01-08 14:30:50', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE58FAFE689A9E5B195E79A84E5A4A7E695B0E68DAEE8AEA1E7AE97E5B9B3E58FB0, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('430', '1', '3', '2019-01-08 15:04:12', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('431', '1', '2', '2019-01-08 16:03:05', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('432', '1', '18', '2019-01-08 18:16:09', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('433', '1', '5', '2019-01-09 09:23:30', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('434', '1', '10', '2019-01-09 09:23:38', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('435', '7', '17', '2019-01-09 09:26:20', 0xE588A0E999A4544F444FEFBC9AE695B0E68DAEE5BA93E8AEBEE8AEA1, '删除TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('436', '7', '17', '2019-01-09 10:38:53', 0xE585B3E997AD544F444FEFBC9AE799BBE99986E7958CE99DA2E4BFAEE694B9, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('437', '7', '17', '2019-01-09 10:38:55', 0xE585B3E997AD544F444FEFBC9AE997AEE9A298E4BFAEE5A48D2CE4BBBBE58AA1E8A786E59BBE, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('438', '7', '17', '2019-01-09 10:48:34', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('439', '7', '17', '2019-01-09 11:29:22', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('440', '7', '17', '2019-01-09 11:29:32', 0xE585B3E997AD544F444FEFBC9A42756720466978EFBC9AE4BBBBE58AA1E78AB6E68081E4BB8EE2809CE69CAAE5BC80E5A78BE2809DE58F98E68890E7A094E7A9B6E4BBA5E5908EEFBC8CE5BC80E5A78BE697B6E997B4E6B2A1E69C89E4BF9DE5AD98, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('441', '7', '17', '2019-01-09 13:01:26', 0xE585B3E997AD544F444FEFBC9AE997AEE9A298E4BFAEE5A48DEFBC9AE8AEA1E58892E8AFA6E68385E697B6E997B4, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('442', '3', '18', '2019-01-09 19:26:50', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('443', '3', '18', '2019-01-09 19:26:54', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('444', '5', '20', '2019-01-09 19:32:22', 0xE585B3E997AD544F444FEFBC9AE8B083E695B45549, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('445', '5', '20', '2019-01-10 09:57:35', 0xE585B3E997AD544F444FEFBC9AE68C89E59F8EE5B8822DE69C8DE58AA1E7B1BBE59E8BE69DA5E698BEE7A4BAEFBC88E59F8EE5B882E58897E38081E69C8DE58AA1E58897E38081E5938DE5BA94E697B6E997B4EFBC89, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('446', '7', '17', '2019-01-10 10:00:36', 0xE585B3E997AD544F444FEFBC9A427567204669783A544F444FE58897E8A1A8E7BB9FE8AEA1E588B0E782B9E8AF84E9A1B5E99DA2, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('447', '5', '20', '2019-01-10 11:29:26', 0xE585B3E997AD544F444FEFBC9AE5938DE5BA94E695B0E68DAE65636861727473E782B9E59BBEEFBC8CE6A8AAE59D90E6A087E58CBAE997B4E8AEBEE7BDAEE4B8BA3132E5B08FE697B6, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('448', '5', '20', '2019-01-10 15:59:19', 0xE585B3E997AD544F444FEFBC9AE7AB99E782B9E79B91E6B58BE9A1B5E99DA2E694AFE68C81E68E92E5BA8FEFBC88E69C80E8BF91E4B88DE58FAFE8AEBFE997AEE697B6E997B4E58092E58F99EFBC8CE58FAFE8AEBFE997AEE680A7E58D87E5BA8FEFBC89, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('449', '6', '19', '2019-01-10 17:30:28', 0xE585B3E997AD544F444FEFBC9AE688BFE6BA90E68EA8E88D9044656D6FE79A84E5908EE58FB0, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('450', '6', '19', '2019-01-10 17:31:09', 0xE688BFE6BA90E68EA8E88D90E79A84E5898DE58FB0E5928CE5908EE58FB0E5AE8CE68890E4BA86EFBC8CE58786E5A487E983A8E7BDB2E588B06272616E636831E4B88A, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('451', '5', '20', '2019-01-11 10:03:24', 0xE585B3E997AD544F444FEFBC9AE7AB99E782B9E79B91E6B58BE8AFA6E68385E9A1B5E99DA2E6B7BBE58AA0E6909CE7B4A2E58A9FE883BDEFBC8CE68C89E785A7E59F8EE5B8822D73657276696365E69DA5E698BEE7A4BAE6909CE7B4A2E7BB93E69E9C, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('452', '7', '17', '2019-01-11 10:29:23', 0xE585B3E997AD544F444FEFBC9AE782B9E8AF84E9A1B5E99DA2E58AA0E585A5E5AE8CE68890746F646FE58886E9A1B5, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('453', '6', '19', '2019-01-11 10:47:03', 0xE585B3E997AD544F444FEFBC9AE4BFAEE694B9686F7374206E616D65, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('454', '6', '19', '2019-01-11 11:03:08', 0xE78EB0E59CA8E79A84E99B86E7BEA4E58886E5B883E4BFAEE694B9E4B8BA3B0D0A7365727665720D0A6E616D656E6F646531EFBC8C6E616D656E6F6465320D0A646174616E6F646531EFBC8C646174616E6F646532EFBC8C646174616E6F6465330D0A646174617365727669636528E4B88DE59CA8616D62617269E4B88A29, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('455', '7', '17', '2019-01-11 11:26:19', 0xE585B3E997AD544F444FEFBC9AE782B9E8AF84E5908EE680BBE7A7AFE58886EFBC8CE5BD93E5B9B4E7A7AFE58886E7B4AFE8AEA1, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('456', '6', '19', '2019-01-11 11:29:14', 0xE585B3E997AD544F444FEFBC9AE694AFE68C81616D62617269E79A846D7973716CE7A7BBE58AA8, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('457', '6', '19', '2019-01-11 11:29:57', 0x616D62617269E79A84E58583E4BFA1E681AFEFBC886D7973716CEFBC89E5B7B2E5AD98E59CA8E59CA8646174617365727669636531EFBC883139322E3136382E312E323234EFBC89, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('458', '1', '13', '2019-01-11 13:46:53', 0x312D31347E312D3137EFBC8C31393A30302D32303A3330EFBC8CE680BBE983A8E59FB9E8AEADE5AEA4EFBC8CE5B7B2E7BB8FE9A284E5AE9AE5A5BDEFBC8CE58F91E588B0E7BEA4E9878C, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('459', '2', '18', '2019-01-11 15:08:29', 0xE5898DE7ABAFE9878DE69E84E4BA86E58886E9A1B5E79A844461746147726964EFBC8CE5B086E4B98BE5898DE99C80E8A681E5908EE7ABAFE68EA7E588B6E5898DE7ABAFE58886E9A1B5E5B7A5E585B7E5928CE697A0E695B0E68DAEE79A84E68F90E7A4BAE4BFA1E681AFE79A84E698BEE7A4BAE980BBE8BE91E5A484E79086E694BEE588B0E4BA86E5898DE7ABAFE38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('460', '2', '18', '2019-01-11 15:18:00', 0xE585B3E997AD544F444FEFBC9AE8A786E59BBEE6A0B7E5BC8FE79A84E9878DE69E84EFBC8CE68F90E58F96E587BA5374796C65, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('461', '2', '18', '2019-01-11 15:41:37', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('462', '3', '18', '2019-01-11 15:42:35', 0xE68B86E58886E4BA86576562415049E79A8420566965774D6F64656C20E5928C20E695B0E68DAE4D6F64656C, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('463', '3', '18', '2019-01-11 15:47:04', 0xE5AE8CE695B4E99B86E68890E4BA8653776167676572EFBC8CE68980E69C89E68EA5E58FA3E58FAFE59CA8E7BABFE8B083E8AF95E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('464', '7', '17', '2019-01-11 18:00:34', 0xE585B3E997AD544F444FEFBC9A427567204669783AE4BBBBE58AA1E69DBF20746F646FE58897E8A1A8E58886E9A1B5E697B6EFBC8CE680BBE695B0E68DA2E8A18CE698BEE7A4BA, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('465', '7', '17', '2019-01-11 18:01:23', 0xE585B3E997AD544F444FEFBC9A427567204669783AE782B9E8AF84E697B6E68E88E4BA88E79A84E58B8BE7ABA0, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('466', '6', '19', '2019-01-11 20:25:50', 0xE585B3E997AD544F444FEFBC9AE6B7BBE58AA0E4B880E4B8AA616D62617269E58FAFE4BBA5E69BBFE68DA2E78EB0E69C89E79A84E88A82E782B9, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('467', '3', '18', '2019-01-14 09:16:31', 0xE585B3E997AD544F444FEFBC9AE99B86E6889053776167676572, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('468', '2', '18', '2019-01-14 09:48:48', 0xE585B3E997AD544F444FEFBC9AE7A1AEE5AE9AE7A88BE5BA8FE68EA7E4BBB6E79A84E7BB93E69E84E6A091EFBC8CE8AEBEE8AEA1E5AE9AE4BD8DE58583E7B4A0E79A84E7BB93E69E84E6A091E5B7A5E585B7, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('469', '7', '17', '2019-01-14 16:03:04', 0xE585B3E997AD544F444FEFBC9A427567204669783AE7BB9FE4B880E585B3E994AEE7BB93E69E9C, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('470', '7', '17', '2019-01-14 16:03:07', 0xE585B3E997AD544F444FEFBC9AE58886E695B0E694AFE68C81E4B8A4E4BD8DE5B08FE695B0, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('471', '7', '17', '2019-01-14 16:03:09', 0xE585B3E997AD544F444FEFBC9AE88083E8AF84E5BCB9E7AA97E8B083E695B4, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('472', '1', '15', '2019-01-14 17:54:04', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('473', '2', '18', '2019-01-15 09:24:32', 0xE5B086E69FA5E689BEE58583E7B4A0E79A84E5B7A5E585B7E7A7BBE6A48DE588B0427567536E69706572E9A1B9E79BAEE4B8ADE38082E698A8E5A4A9E58F91E78EB0EFBC8C466C615549E587BAE4BA86322E30E9A284E8A788E78988EFBC8CE5AE83E69FA5E689BEE58583E7B4A0E79A84E69588E78E87E887B3E5B091E68F90E9AB98E4BA8635E5808D28E6B58BE8AF95E5BE97E587BA29EFBC8CE586B3E5AE9AE58588E5BC95E794A8E9A284E8A788E78988EFBC8CE59CA8E5BC80E58F91E8BF87E7A88BE4B8ADE69C89E997AEE9A298E79A84E59CB0E696B9E5868DE8BF9BE8A18CE8B083E695B4E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('474', '2', '18', '2019-01-15 09:25:23', 0xE585B3E997AD544F444FEFBC9AE5B086E69FA5E689BEE58583E7B4A0E79A84E5B7A5E585B7E7A7BBE6A48DE588B0427567536E69706572E9A1B9E79BAEE4B8AD, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('475', '2', '18', '2019-01-15 09:28:11', 0xE69BBFE68DA2E4BA86566965774D6F64656C73E5B7A5E7A88BEFBC8CE4B98BE5898DE698AFE79BB4E68EA5E5889BE5BBBAE79A84E7B1BBE5BA93EFBC8CE4BD86E698AF566965774D6F64656C73E698AF575046E9A1B9E79BAEE585ACE585B1E5B7A5E585B7E7B1BBEFBC8CE99C80E8A681E68F90E4BE9BE4B880E4BA9B575046E9A1B9E79BAEE68980E99C80E79A84E789B9E680A7EFBC88E8B584E6BA90E59BBEE78987EFBC8CE8B584E6BA90E69687E4BBB6E7AD89EFBC89EFBC8CE68980E4BBA5E5B086E58E9F566965774D6F64656CE5B7A5E7A88BE588A0E999A4E4BA86EFBC8CE68DA2E68890E4BA86575046E9A1B9E79BAEE5B7A5E7A88BE8BDACE79A84E7B1BBE5BA93E5B7A5E7A88B, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('476', '7', '17', '2019-01-15 11:20:01', 0xE585B3E997AD544F444FEFBC9AE7A094E7A9B6E999A2667470E69C8DE58AA1E58F91E5B883, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('477', '7', '17', '2019-01-15 11:20:09', 0xE585B3E997AD544F444FEFBC9AE68A80E883BDE58B8BE7ABA0E9A1B5E8B083E695B4, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('478', '5', '20', '2019-01-15 12:17:25', 0xE585B3E997AD544F444FEFBC9AE6B7BBE58AA0E7BB9FE8AEA1E4B8AAE4BABAE688BFE6BA90E9A1B5E99DA2, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('479', '5', '20', '2019-01-15 14:25:05', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE8A1A8E6A0BCE58897E694AFE68C81E68E92E5BA8F, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('480', '5', '20', '2019-01-15 14:25:16', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE7AE80E58D95E79A84E799BBE5BD95E7AA97E58FA3EFBC8CE4BDBFE794A8E585ACE794A8E79A84E5AF86E7A081EFBC9A666F6F77772F6E7567676574323030380D0A, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('481', '2', '18', '2019-01-15 15:31:31', 0xE585B3E997AD544F444FEFBC9AE8AEA8E8AEBAE5B9B6E7A1AEE5AE9AE7ACA6E59088E794A8E688B7E99C80E6B182E79A845465737463617365E79A84E79BB8E585B3584D4CE88A82E782B9E7BB93E69E84, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('482', '3', '18', '2019-01-15 17:07:18', 0xE8AEA8E8AEBAE5B9B6E695B4E79086786D6CE7BB93E69E84, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('483', '6', '19', '2019-01-15 17:38:50', 0xE6B7BBE58AA0E4BA86E6AF8FE4B880E4B8AAE5B08FE697B6E69BB4E696B068646673E4B8ADE794A8E688B7E69FA5E79C8BE688BFE6BA90E8AEB0E5BD95E79A84E8AEA1E58892E4BBBBE58AA1, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('484', '3', '18', '2019-01-15 18:52:48', 0xE585B3E997AD544F444FEFBC9AE588A0E999A4206275675F736E6970657220E59084E8A1A8E79A842069735F64656C6574656420E5B9B6E4BFAEE694B9E4B88EE4B98BE79BB8E585B3E79A84E4B89AE58AA1, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('485', '5', '20', '2019-01-15 19:24:46', 0xE585B3E997AD544F444FEFBC9AE4BFAEE5A48DE696ADE7BD91E5868DE8BF9EE697B6E587BAE78EB0E79A84E2809CE68EA5E58FA3E5BC82E5B8B8E2809D627567, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('486', '4', '19', '2019-01-15 19:30:14', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('487', '4', '19', '2019-01-15 19:51:58', 0xE690ADE5BBBAE4BA86616D6261726920322E37E78EAFE5A283, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('488', '8', '19', '2019-01-16 09:16:34', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('489', '7', '17', '2019-01-16 16:52:31', 0xE585B3E997AD544F444FEFBC9AE4B8AAE4BABAE8AFA6E68385E9A1B5E99DA2E8B083E695B4, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('490', '2', '18', '2019-01-16 17:21:46', 0xE585B3E997AD544F444FEFBC9AE68B96E58AA8E58583E7B4A0E6A091E7BB93E69E84E88A82E782B9E588B0584D4CE68EA7E4BBB6E4B88AEFBC8CE5AE9EE78EB0E68F92E585A5E5AFB9E5BA94E88A82E782B9E58583E7B4A0E79A84E6938DE4BD9C, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('491', '2', '18', '2019-01-16 17:26:49', 0xE7A094E7A9B6E4BA86E4B880E4B88BE68EA7E4BBB6E4BFA1E681AFE68B96E68BBDE588B054657874426F78E4B88AEFBC8CE5908EE58FB0E5A484E79086E690BAE5B8A6E8BF87E69DA5E79A84E695B0E68DAEEFBC8CE99C80E8A681E8B083E794A85072657669657744726F70EFBC8C5072657669657744726167456E746572EFBC8C5072657669657744726167486F766572EFBC8CE6ADA4E5A4965072657669657744726167456E746572E5928C5072657669657744726167486F766572E68C87E5AE9AE5908CE4B880E5A484E79086E4BA8BE4BBB6EFBC8CE4B894E794A8652E48616E646C65643D74757265E5A484E79086EFBC8CE6898DE883BDE4BDBFE5BE975072657669657744726F70E4BA8BE4BBB6E5938DE5BA94E38082E4BD86E698AFE8BF99E7A78DE696B9E6A188EFBC8CE794B1E4BA8E54657874456469746F72E79A844F6666736574E697A0E6B395E68C87E5AE9AE588B0E9BCA0E6A087E4BD8DE7BDAEEFBC8CE68980E4BBA5E586B3E5AE9AE5BC83E794A8E38082E79BB4E68EA5E98787E794A8E59CA85472656556696577E4B88AE5B086E8A681E4BCA0E98092E79A84E695B0E68DAEE58F98E68890E5AD97E7ACA6E4B8B2E7B1BBE59E8BEFBC8CE784B6E5908EE79BB4E68EA5E794A854657874456469746F722854657874426F7829E887AAE5B7B1E887AAE5B8A6E68B96E68BBDE79A84E58A9FE883BDEFBC8CE5B086E5AD97E7ACA6E4B8B2E68F92E585A5E588B0E68C87E5AE9AE4BD8DE7BDAEE38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('492', '3', '18', '2019-01-16 19:09:18', 0x312EE5AEA2E688B7E7ABAFE4B88EE69C8DE58AA1E7ABAFE79A84E68EA5E58FA3E59CB0E59D80E58F98E69BB40D0A322E73776167676572E8B7A8E59F9FE997AEE9A2980D0A, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('493', '3', '18', '2019-01-16 19:15:04', 0xE98187E588B0E4B880E4B8AAE997AEE9A298EFBC8CE99C80E7BBA7E7BBADE7A094E7A9B6E380820D0A574542415049E590AFE794A84874747073E697B6EFBC8CE5AEA2E688B7E7ABAFE8AEBFE997AE776562617069E68AA5E99499EFBC8CE68F90E7A4BAE2809CE59BA0E4B8BAE7AE97E6B395E4B88DE5908CEFBC8CE5AEA2E688B7E7ABAFE5928CE69C8DE58AA1E599A8E697A0E6B395E9809AE4BFA1E38082E2809DE38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('494', '8', '19', '2019-01-16 19:15:43', 0xE68EA8E88D90E7AE97E6B395EFBC8CE6A0B9E68DAEE887AAE5B7B1E7AE97E587BAE7A7AFE5888620E6B581E7A88BE5AE8CE68890, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('495', '3', '18', '2019-01-17 15:20:57', 0xE585B3E4BA8EE5AEA2E688B7E7ABAFE4B88EE69C8DE58AA1E7ABAFE697A0E6B395E9809AE4BFA1E997AEE9A298E698AFE794B1E4BA8EE69CACE59CB0776562617069E69CAAE8AEBEE7BDAEE8AF81E4B9A6EFBC8CE68980E4BBA5E69CACE59CB0E6B58BE8AF95E697B6E99C80E58588E7A681E794A86874747073EFBC8CE98787E794A868747470E38082E9A1B9E79BAEE58F91E5B883E588B0696973E5908EE8AEBEE7BDAEE8AF81E4B9A6E58899E4B88DE5AD98E59CA8E6ADA4E997AEE9A298E38082, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('496', '1', '21', '2019-01-17 18:23:10', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9A53514C4345E5AF86E7A081E58D87E7BAA7E696B9E6A188E7A094E7A9B6, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('497', '1', '15', '2019-01-17 18:23:57', 0xE588A0E999A4E585B3E994AEE7BB93E69E9CEFBC9AE69C8DE58AA1E599A8E7ABAFE5AE89E585A8E997AEE9A298E7A094E7A9B6, '删除关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('498', '1', '22', '2019-01-17 18:24:35', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9AE69C8DE58AA1E599A8E7ABAF415049E5928CE695B0E68DAEE68EA5E58FA3E5AE89E585A8E696B9E6A188E7A094E7A9B6, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('499', '1', '23', '2019-01-17 18:27:37', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9A5043E5908CE6ADA5E4BC98E58C96322E30, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('500', '1', '23', '2019-01-17 18:27:59', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('501', '1', '24', '2019-01-17 18:35:22', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9AE4B8AAE4BABAE688BFE6BA90E699BAE883BDE68EA8E88D90E7B3BBE7BB9FE7A094E7A9B6, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('502', '4', '19', '2019-01-17 18:49:45', 0xE5AE9EE78EB0E4BA86E794A87061696CE5BA8FE58897E58C96E58699E585A5E69687E4BBB6EFBC8C, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('503', '4', '19', '2019-01-17 18:50:40', 0xE688BFE6BA90E8AEA1E7AE97E7BB93E69E9CE6B7BBE58AA0746F70E79A84E7AD9BE98089, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('504', '6', '19', '2019-01-18 15:49:44', 0xE5AE8CE68890E4BA86E4BB8E73716CE695B0E68DAEE5BA93E5A29EE9878FE5AFBCE585A56D7973716CE4BBA5E58F8A6D7973716CE588B068646673E79A84E5AE9AE697B6E5A29EE9878FE5AFBCE585A5, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('505', '5', '20', '2019-01-21 09:37:40', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE5A29EE58AA0E7BB9FE8AEA1E4B8AAE4BABAE688BFE6BA90E680BBE695B0EFBC8CE585B6E4B8ADE4BA8CE6898BE688BFE680BBE695B0E38081E7A79FE688BFE680BBE695B0E79A84E9A1B5E99DA2, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('506', '5', '20', '2019-01-21 09:37:44', 0xE585B3E997AD544F444FEFBC9AE4BBA3E7A081E4BC98E58C96, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('507', '5', '20', '2019-01-21 09:37:57', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('508', '1', '13', '2019-01-21 11:14:48', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE8AFBEE7A88BE68AA5E5908DE8A1A8, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('509', '1', '13', '2019-01-21 11:14:51', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE8AFBEE4BBB6EFBC9AE5A4A7E7BAB2EFBC8C505054EFBC8CE4BBA3E7A081E6A188E4BE8B, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('510', '1', '13', '2019-01-21 11:14:53', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE8AFBEE7A88B, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('511', '1', '25', '2019-01-21 16:11:18', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9AE695B0E68DAEE7BB9FE8AEA1E5928CE7AB99E782B9E680A7E883BDE79B91E6B58BE7BD91E7AB99332E30, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('512', '1', '26', '2019-01-21 16:12:20', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9AE8BDAFE4BBB6E58AA0E5AF86E696B9E5BC8FE7A094E7A9B6EFBC8CE8AEA9E98791E5B1B1E9BB98E8AEA4E68385E586B5E4B88BE4B88DE69FA5, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('513', '1', '25', '2019-01-21 17:31:58', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('514', '5', '20', '2019-01-21 18:47:36', 0xE585B3E997AD544F444FEFBC9AE4BDBFE794A8E585A8E9878FE69FA5E8AFA2E88EB7E58F96E98787E99B86E695B0E68DAE, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('515', '5', '21', '2019-01-22 09:23:31', null, '领取任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('516', '1', '20', '2019-01-22 10:20:16', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('517', '5', '20', '2019-01-22 11:31:09', 0xE585B3E997AD544F444FEFBC9AE98787E99B86E680BBE695B0E4B88EE696B0E5A29EE695B0E78BACE7AB8BE69FA5E8AFA2E4B88EE8AEA1E7AE97, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('518', '7', '27', '2019-01-22 15:54:52', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9A617764726561, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('519', '7', '20', '2019-01-22 15:55:26', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('520', '7', '27', '2019-01-22 15:58:53', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('521', '7', '28', '2019-01-22 16:08:49', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9A777165, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('522', '7', '28', '2019-01-22 16:08:57', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('523', '7', '28', '2019-01-22 16:09:05', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('524', '7', '27', '2019-01-22 16:09:20', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('525', '7', '29', '2019-01-22 16:13:40', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9A313233, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('526', '7', '29', '2019-01-22 16:13:47', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('527', '7', '29', '2019-01-22 16:13:56', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('528', '7', '19', '2019-01-22 16:37:07', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('529', '7', '19', '2019-01-22 16:37:10', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('530', '7', '28', '2019-01-22 16:37:54', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('531', '7', '29', '2019-01-22 16:40:53', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('532', '7', '30', '2019-01-22 16:43:47', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9AE6B58BE8AF95E4BBBBE58AA12DE69D8EE5AF8CE6B389, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('533', '7', '30', '2019-01-22 16:44:07', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('534', '7', '30', '2019-01-22 16:44:09', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('535', '7', '30', '2019-01-22 16:44:31', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('536', '7', '30', '2019-01-22 16:44:37', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('537', '7', '30', '2019-01-22 16:44:41', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('538', '7', '30', '2019-01-22 16:44:45', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('539', '7', '30', '2019-01-22 16:44:51', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('540', '7', '30', '2019-01-22 16:45:17', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('541', '7', '30', '2019-01-22 16:45:54', 0xE585B3E997AD544F444FEFBC9A61616161, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('542', '7', '30', '2019-01-22 16:46:51', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9A616161, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('543', '7', '30', '2019-01-22 16:46:53', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('544', '7', '31', '2019-01-22 16:47:07', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9AE6B58BE8AF95, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('545', '7', '31', '2019-01-22 16:47:19', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('546', '7', '13', '2019-01-22 16:48:57', 0xE585B3E997AD544F444FEFBC9AE5A48DE79B98, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('547', '7', '13', '2019-01-22 16:48:58', 0xE585B3E997AD544F444FEFBC9AE7BB84E7BB87, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('548', '7', '32', '2019-01-22 16:48:59', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9AE5A4A7, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('549', '7', '13', '2019-01-22 16:49:00', 0xE585B3E997AD544F444FEFBC9AE68E88E8AFBE, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('550', '7', '13', '2019-01-22 16:49:04', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE59FB9E8AEADE7BB93E69D9FE5908EE79A84E58F8DE9A688E8B083E69FA5E8A1A8, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('551', '7', '32', '2019-01-22 16:49:04', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('552', '7', '13', '2019-01-22 16:49:10', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('553', '7', '32', '2019-01-22 16:49:11', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('554', '7', '21', '2019-01-22 16:49:30', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('555', '7', '33', '2019-01-22 16:49:50', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9AE6B58BE8AF95E4BBBBE58AA1322DE69D8EE5AF8CE6B389, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('556', '7', '33', '2019-01-22 16:50:12', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('557', '7', '33', '2019-01-22 16:50:17', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('558', '7', '33', '2019-01-22 16:50:21', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('559', '1', '13', '2019-01-22 16:50:22', 0xE585B3E997AD544F444FEFBC9AE69292E697A6E5A3ABE5A4A7E5A4AB, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('560', '1', '13', '2019-01-22 16:50:24', 0xE585B3E997AD544F444FEFBC9AE5958AE5A3ABE5A4A7E5A4ABE890A8E88AAC, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('561', '7', '33', '2019-01-22 16:50:34', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('562', '7', '33', '2019-01-22 16:50:39', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('563', '7', '33', '2019-01-22 16:50:45', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('564', '7', '21', '2019-01-22 16:50:47', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('565', '7', '21', '2019-01-22 16:50:58', 0xE585B3E997AD544F444FEFBC9AE5BBBAE7AB8B64656D6FEFBC8CE5B09DE8AF95E8B083E794A8E887AAE5B8A6646C6CE4BFAEE694B9E5AF86E7A081, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('566', '7', '21', '2019-01-22 16:51:00', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('567', '7', '18', '2019-01-22 16:51:27', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('568', '7', '18', '2019-01-22 16:51:36', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('569', '7', '32', '2019-01-22 16:51:37', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('570', '7', '30', '2019-01-22 16:51:47', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('571', '7', '26', '2019-01-22 16:54:31', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('572', '7', '25', '2019-01-22 16:55:27', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('573', '7', '33', '2019-01-22 16:55:33', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('574', '7', '33', '2019-01-22 16:55:42', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('575', '7', '33', '2019-01-22 16:55:56', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('576', '7', '17', '2019-01-22 16:56:41', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('577', '7', '18', '2019-01-22 16:57:08', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE8B083E695B4E5908EE79A84E8BDAFE4BBB6E7958CE99DA2, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('578', '7', '18', '2019-01-22 16:57:10', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9A584D4CE6ADA3E7A1AEE8A7A3E69E90E5928CE8BF90E8A18C, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('579', '7', '18', '2019-01-22 16:57:12', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE695B0E68DAEE4BAA4E4BA92E68EA5E58FA3, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('580', '7', '18', '2019-01-22 16:57:15', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE5B081E8A385E5A5BDE79A84E8BDAFE4BBB6E68EA7E4BBB6, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('581', '7', '18', '2019-01-22 16:57:39', 0xE588A0E999A4E585B3E994AEE7BB93E69E9CEFBC9AE7818CE7818CE7818CE7818C, '删除关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('582', '9', '29', '2019-01-22 17:02:39', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('583', '7', '34', '2019-01-22 17:03:12', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9AE6B58BE8AF95E4BBBBE58AA1332DE69D8EE5AF8CE6B389, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('584', '7', '34', '2019-01-22 17:03:20', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('585', '7', '34', '2019-01-22 17:03:27', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('586', '7', '34', '2019-01-22 17:05:28', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('587', '7', '35', '2019-01-22 17:08:03', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9AE6B58BE8AF95E4BBBBE58AA1342DE69D8EE5AF8CE6B389, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('588', '7', '36', '2019-01-22 17:08:06', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9A74657374, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('589', '7', '35', '2019-01-22 17:08:17', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('590', '7', '36', '2019-01-22 17:08:48', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('591', '7', '35', '2019-01-22 17:08:52', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('592', '7', '36', '2019-01-22 17:09:10', 0xE585B3E997AD544F444FEFBC9A6A6C6A, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('593', '7', '36', '2019-01-22 17:10:15', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('594', '9', '36', '2019-01-22 17:12:39', 0xE585B3E997AD544F444FEFBC9A31333231, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('595', '9', '36', '2019-01-22 17:12:47', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('596', '7', '37', '2019-01-22 17:21:29', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9A313233, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('597', '7', '38', '2019-01-22 17:21:38', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9A7461736B31, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('598', '7', '38', '2019-01-22 17:21:55', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('599', '7', '37', '2019-01-22 17:22:45', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('600', '7', '37', '2019-01-22 17:25:22', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('601', '7', '39', '2019-01-22 17:32:12', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9A7465737420616674657220636C6F736520706C616E, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('602', '7', '39', '2019-01-22 17:33:42', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('603', '7', '39', '2019-01-22 17:35:43', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('604', '7', '39', '2019-01-22 17:35:53', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('605', '7', '40', '2019-01-22 17:44:20', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9A74657374, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('606', '7', '41', '2019-01-22 17:45:37', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9A7465737473756E, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('607', '7', '41', '2019-01-22 17:45:53', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('608', '7', '41', '2019-01-22 17:46:06', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('609', '7', '17', '2019-01-23 10:19:17', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE5B08FE997AEE9A298E8B083E695B4, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('610', '7', '17', '2019-01-23 10:19:20', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE4BC98E58C96E9A1B5E99DA2E995BFE697B6E997B4E4B88DE782B9E587BBEFBC8CE5938DE5BA94E6AF94E8BE83E685A2E79A84E997AEE9A298, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('611', '7', '17', '2019-01-23 10:19:25', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE4BBBBE58AA1E8BF9BE5BAA6E69DBFE5A29EE58AA0E68890E59198E8A786E59BBE, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('612', '7', '17', '2019-01-23 10:19:27', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE5A29EE58AA0E59BBEE4B9A6E7AEA1E79086E9A1B5E99DA20D0A, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('613', '7', '17', '2019-01-23 10:19:29', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE4BA94E5A4A9E5858DE799BBE5BD95E79A84E69588E69E9C0D0A, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('614', '7', '17', '2019-01-23 10:19:31', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE695B0E68DAEE5BA93E887AAE58AA8E5A487E4BBBDE5928CE4B88BE8BDBDE7B3BBE7BB9F0D0A, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('615', '7', '17', '2019-01-23 10:19:33', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE5A29EE58AA0E59BA2E5BBBAE6B4BBE58AA8E9A1B5E99DA20D0A, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('616', '7', '17', '2019-01-23 10:19:35', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE7BBA9E69588E68AA5E8A1A8E5928CE88083E8AF84E9A1B5E99DA2, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('617', '7', '17', '2019-01-23 10:19:49', 0xE585B3E997AD544F444FEFBC9AE59BA2E9989FE6B4BBE58AA8E9A1B5E99DA2, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('618', '7', '17', '2019-01-23 10:39:13', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('619', '7', '13', '2019-01-23 10:41:56', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('620', '7', '17', '2019-01-30 10:29:10', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('621', '7', '42', '2019-02-11 10:52:19', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9AE5AE89E68A9AE5A4A7E4BDBFE79A84, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('622', '7', '26', '2019-02-28 18:50:39', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('623', '7', '42', '2019-02-28 19:13:18', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('624', '7', '25', '2019-03-01 13:12:45', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('625', '7', '40', '2019-03-01 13:37:30', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('626', '7', '24', '2019-03-01 13:38:52', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('627', '7', '22', '2019-03-01 13:39:52', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('628', '7', '23', '2019-03-01 13:41:08', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('629', '7', '15', '2019-03-01 13:43:28', 0xE585B3E997ADE585B3E994AEE7BB93E69E9CEFBC9AE69C8DE58AA1E599A8E7ABAFE680A7E883BDE7A094E7A9B6E4B88EE4BC98E58C96E696B9E6A188, '关闭关键结果', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('630', '7', '15', '2019-03-01 13:43:30', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('631', '7', '14', '2019-03-01 13:45:05', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('632', '7', '7', '2019-03-01 13:47:11', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('633', '7', '43', '2019-03-01 13:51:33', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9A3231333132, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('634', '7', '43', '2019-03-01 13:51:48', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('635', '7', '44', '2019-03-01 13:54:05', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9A3231333231, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('636', '7', '44', '2019-03-01 13:54:15', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('637', '7', '45', '2019-03-01 13:55:16', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9AE4BA94, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('638', '7', '45', '2019-03-01 13:55:33', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('639', '7', '46', '2019-03-01 13:59:27', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9A323133, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('640', '7', '46', '2019-03-01 13:59:34', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('641', '7', '53', '2019-03-01 14:04:52', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('642', '7', '59', '2019-03-01 14:05:06', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('643', '7', '55', '2019-03-01 14:05:17', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('644', '7', '47', '2019-03-01 14:05:29', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('645', '7', '58', '2019-03-01 14:05:40', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('646', '7', '60', '2019-03-01 14:05:56', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('647', '7', '57', '2019-03-01 14:06:05', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('648', '7', '48', '2019-03-01 14:06:12', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('649', '7', '51', '2019-03-01 14:06:21', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('650', '7', '49', '2019-03-01 14:06:28', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('651', '7', '49', '2019-03-01 14:17:15', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('652', '7', '51', '2019-03-01 14:17:33', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('653', '7', '49', '2019-03-01 14:17:41', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('654', '7', '48', '2019-03-01 14:17:43', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('655', '7', '49', '2019-03-01 14:17:45', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('656', '7', '47', '2019-03-01 14:17:48', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('657', '7', '60', '2019-03-01 14:17:51', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('658', '7', '49', '2019-03-01 14:17:58', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('659', '7', '49', '2019-03-01 14:19:04', 0xE585B3E997AD544F444FEFBC9AE5A4A7E890A8E8BEBEE69292, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('660', '7', '54', '2019-03-01 14:20:58', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('661', '7', '60', '2019-03-01 14:23:45', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('662', '7', '46', '2019-03-01 14:23:48', 0xE585B3E997AD544F444FEFBC9AE5A4A7, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('663', '7', '46', '2019-03-01 14:23:58', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('664', '9', '60', '2019-03-01 14:24:08', 0xE585B3E997AD544F444FEFBC9A617364666473616664736166647361666473616664736166, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('665', '7', '52', '2019-03-01 14:26:38', 0xE88C83E5BEB7E890A8E58F91, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('666', '7', '52', '2019-03-01 14:26:45', 0xE585B3E997AD544F444FEFBC9AE68993E7AE97, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('667', '7', '52', '2019-03-01 14:26:56', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('668', '7', '52', '2019-03-01 14:27:30', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('669', '7', '52', '2019-03-01 14:28:51', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('670', '7', '52', '2019-03-01 14:29:17', 0x313231323132, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('671', '7', '50', '2019-03-01 14:29:56', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('672', '7', '56', '2019-03-01 14:32:18', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('673', '7', '56', '2019-03-01 14:32:23', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('674', '7', '56', '2019-03-01 14:32:55', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('675', '7', '49', '2019-03-01 14:33:30', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('676', '7', '49', '2019-03-01 14:34:24', 0x666666, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('677', '7', '50', '2019-03-01 14:34:32', 0x737373, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('678', '7', '65', '2019-03-01 14:38:22', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('679', '7', '65', '2019-03-01 14:38:24', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('680', '7', '51', '2019-03-01 15:09:25', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('681', '7', '53', '2019-03-01 15:17:15', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('682', '7', '59', '2019-03-01 15:18:20', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('683', '7', '70', '2019-03-04 16:38:20', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9A313233313233313233717765777165, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('684', '7', '70', '2019-03-04 16:38:35', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('685', '7', '71', '2019-03-04 16:38:55', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9AE58092E890A8E58F91E69292E6B395, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('686', '7', '71', '2019-03-04 16:39:05', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('687', '7', '71', '2019-03-04 17:10:05', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('688', '7', '70', '2019-03-05 15:48:34', 0x343536, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('689', '7', '70', '2019-03-05 15:49:02', 0x373938, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('690', '7', '70', '2019-03-05 15:49:44', 0x34353634, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('691', '7', '70', '2019-03-05 16:07:26', 0x3433353334, '任务跟进', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('692', '7', '47', '2019-03-05 17:28:51', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('693', '7', '48', '2019-03-05 17:34:22', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('694', '7', '72', '2019-03-08 15:39:31', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9AE6B58BE8AF95E5958AE5958A, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('695', '7', '72', '2019-03-08 15:39:45', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('696', '7', '72', '2019-03-08 15:39:58', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('697', '7', '72', '2019-03-08 15:40:02', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('698', '7', '72', '2019-03-08 15:40:03', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('699', '7', '72', '2019-03-08 15:40:05', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('700', '7', '72', '2019-03-08 15:40:05', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('701', '7', '72', '2019-03-08 15:40:08', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('702', '7', '72', '2019-03-08 15:40:09', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('703', '7', '72', '2019-03-08 15:40:22', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('704', '7', '72', '2019-03-08 15:40:23', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('705', '7', '73', '2019-03-08 15:40:35', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9AE5A4A7E69292E5A4A7E69292, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('706', '7', '73', '2019-03-08 15:40:43', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('707', '7', '73', '2019-03-08 15:40:45', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('708', '7', '73', '2019-03-08 15:40:46', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('709', '7', '73', '2019-03-08 15:40:46', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('710', '7', '73', '2019-03-08 15:40:47', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('711', '7', '73', '2019-03-08 15:40:48', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('712', '7', '74', '2019-03-08 15:41:01', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9AE5A4A7E69292313131, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('713', '7', '74', '2019-03-08 15:41:05', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('714', '7', '74', '2019-03-08 15:41:07', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('715', '7', '74', '2019-03-08 15:42:13', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('716', '7', '74', '2019-03-08 15:42:17', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('717', '7', '74', '2019-03-08 15:42:18', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('718', '7', '74', '2019-03-08 15:42:19', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('719', '7', '74', '2019-03-08 15:42:24', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('720', '7', '75', '2019-03-08 15:42:35', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9A313231, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('721', '7', '75', '2019-03-08 15:42:40', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('722', '7', '75', '2019-03-08 15:42:43', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('723', '7', '75', '2019-03-08 15:42:44', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('724', '7', '75', '2019-03-08 15:42:46', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('725', '7', '75', '2019-03-08 15:42:47', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('726', '7', '75', '2019-03-08 15:42:54', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('727', '7', '75', '2019-03-08 15:42:55', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('728', '7', '75', '2019-03-08 15:42:56', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('729', '7', '75', '2019-03-08 15:42:57', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('730', '7', '75', '2019-03-08 15:42:58', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('731', '7', '75', '2019-03-08 15:42:59', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('732', '7', '75', '2019-03-08 15:43:04', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('733', '7', '75', '2019-03-08 15:43:05', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('734', '7', '75', '2019-03-08 15:43:14', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('735', '7', '75', '2019-03-08 15:43:18', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('736', '7', '75', '2019-03-08 15:43:38', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('737', '7', '76', '2019-03-08 15:52:25', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9A3132, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('738', '7', '76', '2019-03-08 15:52:42', null, '删除任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('739', '7', '73', '2019-03-08 15:57:19', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('740', '7', '74', '2019-03-08 16:30:48', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('741', '7', '77', '2019-03-08 16:35:09', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9A34343434343434343434343434343434343434, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('742', '7', '77', '2019-03-08 16:35:49', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('743', '7', '78', '2019-03-08 16:38:51', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9A3132333132, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('744', '7', '78', '2019-03-08 16:39:00', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('745', '7', '77', '2019-03-08 16:40:38', null, '删除任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('746', '7', '79', '2019-03-08 16:40:59', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9A323331323331, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('747', '7', '79', '2019-03-08 16:41:07', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('748', '7', '70', '2019-03-08 16:58:06', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('751', '7', '81', '2019-03-08 16:59:31', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9A323232, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('752', '7', '81', '2019-03-08 16:59:40', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('753', '7', '81', '2019-03-08 17:00:30', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('754', '7', '82', '2019-03-08 17:02:45', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9A313233, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('755', '7', '82', '2019-03-08 17:02:54', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('756', '7', '83', '2019-03-08 17:16:06', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9AE6B58BE8AF95E782B9E8AF84, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('757', '7', '83', '2019-03-08 17:16:23', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('758', '7', '83', '2019-03-08 17:16:33', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('759', '7', '84', '2019-03-08 19:07:29', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9A363636363636363636, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('760', '7', '84', '2019-03-08 19:07:48', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('761', '7', '85', '2019-03-11 09:57:35', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9A31363431353634, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('762', '7', '85', '2019-03-11 09:57:55', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('763', '7', '86', '2019-03-11 10:06:48', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9A31323331323331, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('764', '7', '86', '2019-03-11 10:07:02', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('765', '7', '87', '2019-03-11 10:13:23', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9A323133313233313233, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('766', '7', '87', '2019-03-11 10:13:33', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('767', '7', '88', '2019-03-11 10:24:41', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9AE6B58BE8AF9531, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('768', '7', '88', '2019-03-11 10:25:44', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('769', '7', '89', '2019-03-11 12:02:58', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9AE6B58BE8AF95E4BBBBE58AA1, '创建任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('770', '7', '89', '2019-03-11 12:03:31', 0xE585B3E997AD544F444FEFBC9AE5AE89E5AE89, '关闭TODO', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('771', '7', '89', '2019-03-11 12:03:47', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('772', '7', '89', '2019-03-11 12:03:53', null, '修改任务', '2019-03-15 09:55:17', '2019-03-15 09:55:17');
INSERT INTO `tasktrackings` VALUES ('773', '7', '89', '2019-03-15 13:20:40', null, '修改任务', '2019-03-15 13:20:40', '2019-03-15 13:20:40');
INSERT INTO `tasktrackings` VALUES ('774', '7', '89', '2019-03-15 13:20:52', null, '修改任务', '2019-03-15 13:20:51', '2019-03-15 13:20:51');
INSERT INTO `tasktrackings` VALUES ('775', '7', '90', '2019-03-15 13:21:19', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9AE5889AE59B9EE5BD92, '创建任务', '2019-03-15 13:21:19', '2019-03-15 13:21:19');
INSERT INTO `tasktrackings` VALUES ('776', '7', '90', '2019-03-15 13:21:28', null, '修改任务', '2019-03-15 13:21:27', '2019-03-15 13:21:27');
INSERT INTO `tasktrackings` VALUES ('777', '7', '90', '2019-03-15 13:21:59', null, '修改任务', '2019-03-15 13:21:59', '2019-03-15 13:21:59');
INSERT INTO `tasktrackings` VALUES ('781', '7', '90', '2019-03-15 20:13:49', null, '修改任务', '2019-03-15 20:13:49', '2019-03-15 20:13:49');
INSERT INTO `tasktrackings` VALUES ('782', '7', '90', '2019-03-15 20:13:59', null, '修改任务', '2019-03-15 20:13:58', '2019-03-15 20:13:58');
INSERT INTO `tasktrackings` VALUES ('787', '7', '94', '2019-03-15 20:17:52', 0xE5889BE5BBBAE4BBBBE58AA1EFBC9A313131, '创建任务', '2019-03-15 20:17:52', '2019-03-15 20:17:52');
INSERT INTO `tasktrackings` VALUES ('788', '7', '94', '2019-03-18 10:09:43', null, '修改任务', '2019-03-18 10:09:42', '2019-03-18 10:09:42');

-- ----------------------------
-- Table structure for task_feedback
-- ----------------------------
DROP TABLE IF EXISTS `task_feedback`;
CREATE TABLE `task_feedback` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `member_id` int(11) DEFAULT NULL,
  `type` tinyint(1) unsigned DEFAULT '0' COMMENT '1亮点2窝心3点赞4加油',
  `description` text COLLATE utf8mb4_bin,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of task_feedback
-- ----------------------------
INSERT INTO `task_feedback` VALUES ('1', '3', '2019-03-05 11:19:21', '2019-03-05 11:19:21', '7', '1', 0xE890A8E88AAC);
INSERT INTO `task_feedback` VALUES ('2', '70', '2019-03-05 15:45:48', '2019-03-05 15:45:48', '7', '1', 0x313233);
INSERT INTO `task_feedback` VALUES ('3', '70', '2019-03-05 15:47:48', '2019-03-05 15:47:48', '7', '4', 0x343536);
INSERT INTO `task_feedback` VALUES ('4', '70', '2019-03-05 16:06:51', '2019-03-05 16:06:51', '7', '2', 0x35343736353436);
INSERT INTO `task_feedback` VALUES ('5', '70', '2019-03-05 16:07:33', '2019-03-05 16:07:33', '7', '4', 0x333234323334);
INSERT INTO `task_feedback` VALUES ('6', '70', '2019-03-05 16:07:48', '2019-03-05 16:07:48', '7', '3', 0x3332343233343234);
INSERT INTO `task_feedback` VALUES ('7', '70', '2019-03-05 16:07:57', '2019-03-05 16:07:57', '7', '1', 0x32333432333432);
INSERT INTO `task_feedback` VALUES ('8', '70', '2019-03-05 16:13:06', '2019-03-05 16:13:06', '7', '1', 0x3332343233);
INSERT INTO `task_feedback` VALUES ('9', '70', '2019-03-05 16:14:03', '2019-03-05 16:14:03', '7', '2', 0x313131313131313131313131313131313131);
INSERT INTO `task_feedback` VALUES ('10', '47', '2019-03-05 17:26:38', '2019-03-05 17:26:38', '7', '1', 0x31);
INSERT INTO `task_feedback` VALUES ('11', '47', '2019-03-05 17:26:42', '2019-03-05 17:26:42', '7', '2', 0x32);
INSERT INTO `task_feedback` VALUES ('12', '47', '2019-03-05 17:26:47', '2019-03-05 17:26:47', '7', '3', 0x33);
INSERT INTO `task_feedback` VALUES ('13', '47', '2019-03-05 17:26:52', '2019-03-05 17:26:52', '7', '4', 0x34);
INSERT INTO `task_feedback` VALUES ('14', '47', '2019-03-05 17:27:01', '2019-03-05 17:27:01', '7', '4', 0x35);
INSERT INTO `task_feedback` VALUES ('15', '47', '2019-03-05 17:27:12', '2019-03-05 17:27:12', '7', '4', 0x33);
INSERT INTO `task_feedback` VALUES ('16', '48', '2019-03-05 17:33:16', '2019-03-05 17:33:16', '7', '1', 0x31);
INSERT INTO `task_feedback` VALUES ('17', '48', '2019-03-05 17:33:23', '2019-03-05 17:33:23', '7', '1', 0x32);
INSERT INTO `task_feedback` VALUES ('18', '48', '2019-03-05 17:33:36', '2019-03-05 17:33:36', '7', '2', 0x71);
INSERT INTO `task_feedback` VALUES ('19', '48', '2019-03-05 17:33:41', '2019-03-05 17:33:41', '7', '2', 0x77);
INSERT INTO `task_feedback` VALUES ('20', '48', '2019-03-05 17:33:49', '2019-03-05 17:33:49', '7', '3', 0x61);
INSERT INTO `task_feedback` VALUES ('21', '48', '2019-03-05 17:33:55', '2019-03-05 17:33:55', '7', '4', 0x73);
INSERT INTO `task_feedback` VALUES ('22', '68', '2019-03-08 15:32:40', '2019-03-08 15:32:40', '9', '1', 0xE68993E8B58FE998BFE8BFAAE696AF);
INSERT INTO `task_feedback` VALUES ('23', '72', '2019-03-08 15:39:53', '2019-03-08 15:39:53', '7', '1', 0xE5A4A7E69292);
INSERT INTO `task_feedback` VALUES ('24', '72', '2019-03-08 15:40:19', '2019-03-08 15:40:19', '7', '1', 0xE5A4A7E69292);
INSERT INTO `task_feedback` VALUES ('25', '73', '2019-03-08 15:40:40', '2019-03-08 15:40:40', '7', '1', 0xE998BFE8BFAAE696AF);
INSERT INTO `task_feedback` VALUES ('26', '74', '2019-03-08 15:42:10', '2019-03-08 15:42:10', '7', '1', 0xE5A4A7);
INSERT INTO `task_feedback` VALUES ('27', '74', '2019-03-08 15:42:15', '2019-03-08 15:42:15', '7', '1', 0xE5A4A7E69292);
INSERT INTO `task_feedback` VALUES ('28', '74', '2019-03-08 15:42:22', '2019-03-08 15:42:22', '7', '1', 0xE5A4A7E69292);
INSERT INTO `task_feedback` VALUES ('29', '75', '2019-03-08 15:43:10', '2019-03-08 15:43:10', '7', '1', 0xE681B6E8B6A3E591B3);
INSERT INTO `task_feedback` VALUES ('30', '75', '2019-03-08 15:43:21', '2019-03-08 15:43:21', '7', '1', 0xE5A4A7E69292);
INSERT INTO `task_feedback` VALUES ('31', '75', '2019-03-08 15:43:26', '2019-03-08 15:43:26', '7', '1', 0xE5A4A7E69292);
INSERT INTO `task_feedback` VALUES ('32', '75', '2019-03-08 15:43:50', '2019-03-08 15:43:50', '7', '3', 0xE5A4A7E69292E79A84E69292E5A4A7E5B08FE998BFE4B889E79A84E59387);
INSERT INTO `task_feedback` VALUES ('33', '75', '2019-03-08 15:44:05', '2019-03-08 15:44:05', '7', '2', 0xE5A4A7E69292E5A4A731E5A4A7E69292);
INSERT INTO `task_feedback` VALUES ('34', '75', '2019-03-08 15:44:09', '2019-03-08 15:44:09', '7', '4', 0xE5A4A7E69292313131);
INSERT INTO `task_feedback` VALUES ('35', '77', '2019-03-08 16:35:17', '2019-03-08 16:35:17', '7', '1', 0x343434);
INSERT INTO `task_feedback` VALUES ('36', '77', '2019-03-08 16:35:22', '2019-03-08 16:35:22', '7', '2', 0x353535);
INSERT INTO `task_feedback` VALUES ('37', '77', '2019-03-08 16:35:26', '2019-03-08 16:35:26', '7', '1', 0x343434343434);
INSERT INTO `task_feedback` VALUES ('38', '77', '2019-03-08 16:35:31', '2019-03-08 16:35:31', '7', '3', 0x3535353535);
INSERT INTO `task_feedback` VALUES ('39', '77', '2019-03-08 16:35:35', '2019-03-08 16:35:35', '7', '1', 0x353535353535353535353535);
INSERT INTO `task_feedback` VALUES ('40', '77', '2019-03-08 16:35:40', '2019-03-08 16:35:40', '7', '1', 0x35353535353535353535353535);
INSERT INTO `task_feedback` VALUES ('57', '94', '2019-03-18 10:09:33', '2019-03-18 10:09:33', '7', '4', 0x313233);
INSERT INTO `task_feedback` VALUES ('42', '83', '2019-03-08 17:16:42', '2019-03-08 17:16:42', '7', '1', 0xE9A38EE6A0BCE8B186E88590E5B9B2E8B186E88590E5B9B2);
INSERT INTO `task_feedback` VALUES ('43', '83', '2019-03-08 17:16:53', '2019-03-08 17:16:53', '7', '1', 0xE59CB0E696B9E69292E697A6E58F91E5B084E782B9E58F91);
INSERT INTO `task_feedback` VALUES ('44', '83', '2019-03-08 17:17:04', '2019-03-08 17:17:04', '7', '2', 0xE794B5E9A38EE68987E794B5E9A38EE68987);
INSERT INTO `task_feedback` VALUES ('45', '83', '2019-03-08 17:17:25', '2019-03-08 17:17:25', '7', '4', 0xE6898BE58AA8E99880E6898BE58AA8E99880);
INSERT INTO `task_feedback` VALUES ('46', '83', '2019-03-08 17:18:05', '2019-03-08 17:18:05', '7', '1', 0xE58F91E5A3ABE5A4A7E5A4ABE5A3ABE5A4A7E5A4ABE79A84E58F91E5B084E782B9E58F91E79A84E9A39EE6B492E59CB0E696B9E58F91E5B084E782B9E58F91E5B084E782B9E58F91E5B084E782B9E58F91E5B084E782B9E6898BE58AA8E99880E6898BE58AA8E99880E5A4A7E5A49AE695B0E59CB0E696B9);
INSERT INTO `task_feedback` VALUES ('47', '84', '2019-03-08 19:07:36', '2019-03-08 19:07:36', '7', '1', 0x363636363636363636);
INSERT INTO `task_feedback` VALUES ('48', '84', '2019-03-08 19:07:41', '2019-03-08 19:07:41', '7', '2', 0x33333333333333333333333333);
INSERT INTO `task_feedback` VALUES ('49', '85', '2019-03-11 09:57:43', '2019-03-11 09:57:43', '7', '2', 0x343536343536);
INSERT INTO `task_feedback` VALUES ('50', '86', '2019-03-11 10:06:54', '2019-03-11 10:06:54', '7', '4', 0x313233313233);
INSERT INTO `task_feedback` VALUES ('51', '87', '2019-03-11 10:13:28', '2019-03-11 10:13:28', '7', '3', 0x313233313233);
INSERT INTO `task_feedback` VALUES ('52', '88', '2019-03-11 10:25:13', '2019-03-11 10:25:13', '7', '4', 0xE69C89E782B9E685A2);
INSERT INTO `task_feedback` VALUES ('53', '88', '2019-03-11 12:02:31', '2019-03-11 12:02:31', '9', '4', 0xE6B58BE8AF95);
INSERT INTO `task_feedback` VALUES ('54', '89', '2019-03-11 12:03:09', '2019-03-11 12:03:09', '7', '1', 0xE58EBBE58EBBE58EBB);
INSERT INTO `task_feedback` VALUES ('55', '89', '2019-03-11 12:03:16', '2019-03-11 12:03:16', '7', '2', 0x777777);

-- ----------------------------
-- Table structure for titlechanges
-- ----------------------------
DROP TABLE IF EXISTS `titlechanges`;
CREATE TABLE `titlechanges` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `MemberId` int(11) NOT NULL,
  `OldTitle` varchar(20) COLLATE utf8mb4_bin NOT NULL,
  `NewTitle` varchar(20) COLLATE utf8mb4_bin NOT NULL,
  `ChangedTime` datetime NOT NULL,
  `CreatedMemberId` int(11) NOT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of titlechanges
-- ----------------------------
INSERT INTO `titlechanges` VALUES ('1', '1', '入职', '研究院院长', '2018-09-04 11:09:48', '1', '2019-03-15 09:55:07', '2019-03-15 09:55:07');
INSERT INTO `titlechanges` VALUES ('2', '2', '入职', '研究员', '2018-09-05 18:12:15', '1', '2019-03-15 09:55:07', '2019-03-15 09:55:07');
INSERT INTO `titlechanges` VALUES ('3', '3', '入职', '研究员', '2018-09-05 18:13:30', '1', '2019-03-15 09:55:07', '2019-03-15 09:55:07');
INSERT INTO `titlechanges` VALUES ('4', '4', '入职', '高级研究员', '2018-09-05 18:15:18', '1', '2019-03-15 09:55:07', '2019-03-15 09:55:07');
INSERT INTO `titlechanges` VALUES ('5', '5', '入职', '高级研究员', '2018-09-25 10:19:53', '1', '2019-03-15 09:55:07', '2019-03-15 09:55:07');
INSERT INTO `titlechanges` VALUES ('6', '6', '入职', '助理研究员', '2018-12-03 14:11:47', '1', '2019-03-15 09:55:07', '2019-03-15 09:55:07');
INSERT INTO `titlechanges` VALUES ('7', '7', '入职', '研究员', '2018-12-13 09:31:38', '1', '2019-03-15 09:55:07', '2019-03-15 09:55:07');
INSERT INTO `titlechanges` VALUES ('8', '8', '入职', '研究员', '2019-01-11 18:16:16', '1', '2019-03-15 09:55:07', '2019-03-15 09:55:07');
INSERT INTO `titlechanges` VALUES ('9', '9', '入职', '研究院', '2019-01-22 15:08:53', '7', '2019-03-15 09:55:07', '2019-03-15 09:55:07');
INSERT INTO `titlechanges` VALUES ('10', '10', '入职', '研究员', '2019-01-22 18:20:32', '7', '2019-03-15 09:55:07', '2019-03-15 09:55:07');
INSERT INTO `titlechanges` VALUES ('11', '10', '入职', '研究员', '2019-03-15 20:06:33', '7', '2019-03-15 20:06:33', '2019-03-15 20:06:33');

-- ----------------------------
-- Table structure for todos
-- ----------------------------
DROP TABLE IF EXISTS `todos`;
CREATE TABLE `todos` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `CreateMemberId` int(11) DEFAULT NULL,
  `CreateTime` datetime DEFAULT NULL,
  `Status` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '未完成，执行中，完成',
  `Executor` int(11) DEFAULT NULL,
  `ClosedTime` datetime DEFAULT NULL,
  `Remark` text COLLATE utf8mb4_bin COMMENT '备注',
  `LastUpdateTime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `TaskId` int(11) DEFAULT NULL,
  `modified_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of todos
-- ----------------------------
INSERT INTO `todos` VALUES ('1', '将界面涉及增删改查的部分使用接口获取数据，协助富泉编写需要的接口。', '2', '2018-12-10 09:25:32', '完成', '2', '2018-12-13 15:05:21', null, '2018-12-13 15:05:21', '3', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('2', 'Run的运行文件上传下载，协助富泉写接口。', '2', '2018-12-10 09:25:54', '完成', '2', '2018-12-13 15:05:25', null, '2018-12-13 15:05:25', '3', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('3', '完善登录Action及调试', '2', '2018-12-10 09:26:02', '完成', '2', '2018-12-26 09:32:27', null, '2018-12-26 09:32:27', '3', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('4', '收集上线后的问题反馈并调整', '5', '2018-12-10 10:15:58', '完成', '5', '2018-12-10 19:35:36', null, '2018-12-10 19:35:36', '10', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('5', '网站性能调优', '5', '2018-12-10 10:16:43', '完成', '1', '2018-12-17 09:36:50', null, '2018-12-17 09:36:50', '10', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('6', '团建模块设计', '5', '2018-12-10 10:16:59', '未完成', null, null, null, '2018-12-12 09:17:16', '10', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('7', 'hive 配置MySQL数据库', '4', '2018-12-10 10:54:30', '完成', '6', '2018-12-10 15:06:02', null, '2018-12-10 15:06:02', '5', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('8', 'HBase研究', '4', '2018-12-10 15:07:53', '完成', null, null, 0xE58886E5B883E5BC8FE690ADE5BBBA, '2018-12-14 12:54:58', '5', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('9', 'Mahout 研究', '4', '2018-12-10 17:08:23', '完成', null, null, null, '2018-12-11 15:33:08', '5', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('10', 'Spark +hadoop', '4', '2018-12-10 17:12:33', '完成', null, null, null, '2018-12-13 16:45:08', '5', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('11', 'Strom +hadoop', '4', '2018-12-10 17:13:10', '未完成', null, null, null, '2019-01-02 14:36:44', '5', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('12', 'Apache Sqoop  安装 测试', '4', '2018-12-11 09:44:04', '完成', null, null, null, '2018-12-17 09:48:44', '5', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('13', 'Apache Ambari 支持Apache Hadoop集群的供应、管理和监控', '4', '2018-12-11 09:59:47', '完成', '6', '2018-12-18 10:10:28', 0x416D62617269E5B7B2E694AFE68C81E5A4A7E5A49AE695B04861646F6F70E7BB84E4BBB6EFBC8CE58C85E68BAC48444653E380814D6170526564756365E3808148697665E38081506967E38081204862617365E380815A6F6F6B6565706572E3808153716F6F70E5928C48636174616C6F67E7AD89E38082, '2018-12-18 10:10:28', '5', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('14', 'Apache Pig 安装', '4', '2018-12-11 10:00:52', '完成', '4', '2018-12-13 10:17:28', null, '2018-12-13 10:17:28', '5', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('15', '网站首页英雄风采部分采用图片懒加载模式', '5', '2018-12-11 10:57:06', '完成', '5', '2018-12-11 10:57:15', null, '2018-12-11 10:57:15', '10', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('16', '了解基于内容的推荐方法', '4', '2018-12-11 11:40:17', '完成', '4', '2018-12-17 19:06:45', 0xE4BA86E8A7A3E696B9E6B395E79A84E8BE93E585A5E8BE93E587BAEFBC8CE5AE9EE78EB0E980BBE8BE91, '2018-12-17 19:06:45', '5', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('17', '基于协同过滤的推荐方法', '4', '2018-12-11 11:40:28', '未完成', null, null, 0xE4BA86E8A7A3E696B9E6B395E79A84E8BE93E585A5E8BE93E587BAEFBC8CE5AE9EE78EB0E980BBE8BE91, '2019-01-02 14:36:18', '5', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('18', 'Run Result 的生成接口', '3', '2018-12-12 08:32:35', '完成', '3', '2018-12-13 15:03:42', null, '2018-12-13 15:03:42', '3', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('19', 'run result 结果分析', '3', '2018-12-13 15:04:34', '完成', '2', '2018-12-14 15:25:45', null, '2018-12-14 15:25:45', '3', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('20', 'run testcase 的移除 微调', '3', '2018-12-13 15:05:06', '完成', '3', '2018-12-13 16:13:21', null, '2018-12-13 16:13:21', '3', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('21', 'run result detail 信息显示微调', '3', '2018-12-13 15:05:26', '完成', '2', '2018-12-13 20:39:03', null, '2018-12-13 20:39:03', '3', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('22', 'AddHouseAction', '3', '2018-12-13 15:05:40', '完成', '3', '2018-12-26 10:02:29', null, '2018-12-26 10:02:29', '3', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('23', 'Run运行调整结果的打印', '2', '2018-12-13 15:06:23', '完成', '2', '2018-12-13 20:38:53', null, '2018-12-13 20:38:53', '3', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('24', 'RunDetail界面功能的实现', '2', '2018-12-13 15:06:32', '完成', '2', '2018-12-14 09:09:46', null, '2018-12-14 09:09:46', '3', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('25', '用户填写的信息需要验证', '2', '2018-12-13 15:35:23', '完成', '3', '2018-12-17 09:49:18', null, '2018-12-17 09:49:18', '3', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('26', '浏览本地html文件', '3', '2018-12-13 15:59:10', '完成', '2', '2018-12-14 09:09:33', null, '2018-12-14 09:09:33', '3', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('27', '拆分视图文件', '5', '2018-12-13 19:34:09', '完成', '5', '2018-12-13 19:34:14', null, '2018-12-13 19:34:14', '10', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('28', '修复反馈的问题', '5', '2018-12-13 19:34:45', '完成', '5', '2018-12-13 19:34:48', null, '2018-12-13 19:34:48', '10', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('29', 'testcase result 生成逻辑调整', '3', '2018-12-13 20:32:52', '完成', '3', '2018-12-13 20:32:55', null, '2018-12-13 20:32:55', '3', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('30', 'hive remote模式配置', '4', '2018-12-14 09:10:52', '未完成', null, null, null, '2019-01-07 08:34:31', '5', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('31', '程序添加快捷键', '2', '2018-12-14 18:22:23', '完成', '2', '2018-12-17 19:09:33', null, '2018-12-17 19:09:33', '3', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('32', '新建一个数据统计Web项目，采用asp.net core mvc', '5', '2018-12-17 17:28:42', '完成', '5', '2018-12-18 18:22:24', null, '2018-12-18 18:22:24', '16', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('33', '基于内容的推荐算法 demo', '4', '2018-12-17 18:54:40', '完成', '4', '2018-12-24 10:38:57', null, '2018-12-24 10:38:57', '5', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('34', '数据库到hdfs,hdsf导出到数据库', '4', '2018-12-17 18:55:56', '完成', '4', '2018-12-24 10:37:41', 0xE7A88BE5BA8FE5AE9EE78EB020707974686F6E20206A61766120, '2018-12-24 10:37:41', '5', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('35', 'hbase到hdfs,hdsf导出到hbase', '4', '2018-12-17 18:56:25', '未完成', null, null, null, '2019-01-04 08:58:49', '5', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('36', '数据库<=>hbase', '4', '2018-12-17 18:57:14', '未完成', null, null, null, '2019-01-04 08:58:41', '5', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('37', '登录后台验证', '2', '2018-12-17 19:10:22', '完成', '3', '2018-12-21 15:18:48', null, '2018-12-21 15:18:48', '3', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('38', '数据库备份', '7', '2018-12-18 17:16:16', '完成', '7', '2018-12-18 19:54:19', 0xE8AEA1E58892E4BBBBE58AA1E887AAE58AA8E5A487E4BBBDE695B0E68DAEE5BA93, '2018-12-18 19:54:19', '17', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('39', '设计数据展示页', '5', '2018-12-18 18:22:50', '完成', '5', '2018-12-18 18:22:56', null, '2018-12-18 18:22:56', '16', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('40', '设计数据展示表结构', '5', '2018-12-18 18:23:27', '完成', '5', '2018-12-24 17:39:15', null, '2018-12-24 17:39:15', '16', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('41', '调用WebService获取数据', '5', '2018-12-18 18:24:01', '完成', '5', '2018-12-24 17:39:18', null, '2018-12-24 17:39:18', '16', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('42', '数据库下载', '7', '2018-12-18 19:54:52', '完成', '7', '2018-12-29 10:09:51', null, '2018-12-29 10:09:51', '17', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('43', '数据库压缩和文件保留', '7', '2018-12-21 15:10:41', '完成', '7', '2018-12-21 18:29:43', 0xE4BF9DE795993330E5A4A9E79A84E69687E4BBB6, '2018-12-21 18:29:43', '17', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('44', '5天免登录', '7', '2018-12-21 15:11:08', '完成', '7', '2018-12-29 09:23:06', null, '2018-12-29 09:23:06', '17', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('45', '二手房，租房数据预处理到mysql', '4', '2018-12-24 09:04:12', '完成', '4', '2018-12-24 09:12:44', null, '2018-12-24 09:12:44', '5', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('46', '楼层相似度计算', '4', '2018-12-24 09:04:46', '完成', '6', '2018-12-25 10:39:27', null, '2018-12-25 10:39:27', '5', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('47', '匿名用户推荐，初次推荐', '4', '2018-12-24 10:34:39', '未完成', null, null, 0xE6B2A1E69C89E794A8E688B7E4BFA1E681AFE4B88BE79A84E68EA8E88D90, '2019-01-02 14:36:40', '5', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('48', '房源详情页面推荐', '4', '2018-12-24 10:36:05', '未完成', null, null, 0xE794A8E688B7E782B9E587BBE6B58FE8A788E4B880E4B8AAE688BFE6BA90EFBC8CE4BBA5E8AFA5E688BFE6BA90E4B8BAE59FBAE7A180E68EA8E88D90E79BB8E585B3E688BFE6BA90, '2019-01-04 08:58:01', '5', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('49', '基于用户浏览记录推荐', '4', '2018-12-24 10:37:03', '未完成', null, null, 0xE58886E69E90E794A8E688B7E79A84E6B58FE8A788E688BFE6BA90EFBC8CE6909CE7B4A2E69DA1E4BBB6EFBC8CE69E84E5BBBAE587BAE794A8E688B7E5969CE5A5BDE789B9E5BE81E8BF9BE8A18CE68EA8E88D90, '2019-01-04 08:57:58', '5', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('50', '租房房源相似度计算', '4', '2018-12-24 11:06:46', '完成', '4', '2018-12-29 15:49:37', null, '2018-12-29 15:49:37', '5', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('51', '租房房源综合评分计算', '4', '2018-12-24 11:08:49', '执行中', null, null, 0xE7BB99E688BFE6BA90E68993E4B8AAE58886EFBC8CE4B880E4B8AAE680BBE58886EFBC8CE58FAFE4BBA5E8AEA1E7AE97E587A0E4B8AAE585B6E4BB96E7BBB4E5BAA6E79A84E58886E695B0, '2019-01-02 14:41:15', '5', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('52', 'fe', '4', '2018-12-24 17:38:04', '未完成', null, null, null, '2018-12-24 17:38:16', '5', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('53', '调整调用webservice时传入的sql语句，采用增量获取数据方式', '5', '2018-12-24 17:40:15', '完成', '5', '2018-12-28 17:56:19', null, '2018-12-28 17:56:19', '16', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('54', 'run 和 testcase 被删除判断', '3', '2018-12-26 10:03:15', '完成', '3', '2018-12-26 10:03:18', null, '2018-12-26 10:03:18', '3', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('55', '站点监测页面数据获取', '5', '2018-12-26 11:36:21', '完成', '5', '2018-12-28 17:56:22', null, '2018-12-28 17:56:22', '16', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('56', '经纪人PR值得计算', '6', '2018-12-29 09:01:34', '未完成', null, null, 0xE7BB8FE7BAAAE4BABAE8AF84E58886EFBC8CE5AE9EE58B98EFBC8CE5B8A6E79C8BEFBC8CE4B89AE7BBA9E58886E68890EFBC8CE59088E5908CE7ADBEE7BAA6, '2019-01-02 14:36:54', '5', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('57', '登陆界面修改', '7', '2018-12-29 10:10:45', '完成', '7', '2019-01-09 10:38:52', 0xE58AA0E585A5E5858DE799BBE5BD95E98089E9A1B9, '2019-01-09 10:38:52', '17', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('58', '数据库设计', '7', '2018-12-29 10:12:05', '未完成', null, null, 0xE5A29EE58AA0E59BA2E5BBBAE5928CE4B9A6E7B18DE695B0E68DAE, '2019-01-09 09:26:20', '17', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('59', '租房推荐Demo', '6', '2018-12-29 15:20:58', '执行中', null, null, 0xE794A8E688B7E69FA5E79C8BE688BFE6BA90E9A1B5E99DA2EFBC8CE782B9E587BBE68EA8E88D90E9A1B5E99DA2, '2019-01-04 08:57:21', '5', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('60', 'hadoop添加节点', '4', '2019-01-02 19:03:49', '完成', null, null, null, '2019-01-04 08:58:59', '5', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('61', '部署到board.fooww.com站点', '5', '2019-01-03 16:43:17', '完成', '5', '2019-01-03 16:43:21', null, '2019-01-03 16:43:21', '16', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('62', '用户租房推荐Demo', '4', '2019-01-04 08:57:16', '执行中', null, null, null, '2019-01-14 09:15:20', '19', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('63', 'hadoop 删除节点', '4', '2019-01-04 08:59:12', '完成', null, null, null, '2019-01-07 08:30:59', '5', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('64', '检查并修改数据异常的bug', '5', '2019-01-04 09:16:55', '完成', '5', '2019-01-04 18:30:09', null, '2019-01-04 18:30:09', '16', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('65', '给站点添加身份认证功能', '5', '2019-01-04 09:17:24', '未完成', null, null, null, '2019-01-04 18:30:16', '16', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('66', '表格支持列排序', '5', '2019-01-04 09:17:50', '未完成', null, null, null, '2019-01-04 18:30:14', '16', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('67', '表格支持排序', '5', '2019-01-04 18:29:27', '完成', '5', '2019-01-07 11:36:58', null, '2019-01-07 11:36:58', '20', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('68', '添加登录功能', '5', '2019-01-04 18:29:42', '完成', '5', '2019-01-07 11:37:00', null, '2019-01-07 11:37:00', '20', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('69', 'ambari添加和删除host，service', '6', '2019-01-07 08:33:31', '完成', null, null, null, '2019-01-07 08:33:42', '5', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('70', 'hive remote模式配置', '4', '2019-01-07 08:34:47', '未完成', null, null, null, '2019-01-07 08:34:47', '19', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('71', '数据库还原工具', '7', '2019-01-07 09:15:44', '完成', '7', '2019-01-07 13:58:26', 0xE5A487E4BBBDE695B0E68DAEE8BF98E58E9FE695B0E68DAEE5BA93, '2019-01-07 13:58:26', '17', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('72', '房源推荐Demo的前端页面', '6', '2019-01-07 10:57:00', '完成', null, null, null, '2019-01-08 11:23:50', '19', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('73', '房源推荐Demo的后台', '6', '2019-01-07 10:58:01', '完成', '6', '2019-01-10 17:30:28', null, '2019-01-10 17:30:28', '19', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('74', 'ambari集群更换NameNode', '6', '2019-01-07 13:26:20', '完成', null, null, 0xE5B0866272616E636831E4B88AE79A844E616D654E6F6465E69BB4E68DA2E588B06272616E636833, '2019-01-08 11:23:39', '19', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('75', '添加统计个人房源页面', '5', '2019-01-07 15:05:34', '完成', '5', '2019-01-15 12:17:25', null, '2019-01-15 12:17:25', '20', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('76', '视图样式的重构，提取出Style', '2', '2019-01-07 15:12:13', '完成', '2', '2019-01-11 15:17:59', null, '2019-01-11 15:17:59', '18', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('77', '确定程序控件的结构树，设计定位元素的结构树工具', '2', '2019-01-07 15:14:19', '完成', '2', '2019-01-14 09:48:48', null, '2019-01-14 09:48:48', '18', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('78', '讨论并确定符合用户需求的Testcase的相关XML节点结构', '2', '2019-01-07 15:15:05', '完成', '2', '2019-01-15 15:31:31', null, '2019-01-15 15:31:31', '18', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('79', '代码细节优化', '5', '2019-01-07 18:39:00', '完成', '5', '2019-01-07 19:30:43', null, '2019-01-07 19:30:43', '20', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('80', '调整UI', '5', '2019-01-09 09:23:46', '完成', '5', '2019-01-09 19:32:22', null, '2019-01-09 19:32:22', '20', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('81', '问题修复,任务视图', '7', '2019-01-09 09:27:56', '完成', '7', '2019-01-09 10:38:54', 0xE4BBBBE58AA1E8A786E59BBEE4B8ADEFBC8CE2809CE68891E58F82E4B88EE79A84E4BBBBE58AA1E2809DE5BA94E8AFA5E58C85E590ABE585B3E997ADE79A84E4BBBBE58AA1, '2019-01-09 10:38:54', '17', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('82', '问题修复：计划详情时间', '7', '2019-01-09 09:28:34', '完成', '7', '2019-01-09 13:01:25', null, '2019-01-09 13:01:25', '17', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('83', 'Bug Fix：任务状态从“未开始”变成研究以后，开始时间没有保存', '7', '2019-01-09 10:40:59', '完成', '7', '2019-01-09 11:29:31', null, '2019-01-09 11:29:31', '17', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('84', 'Bug Fix:TODO列表统计到点评页面', '7', '2019-01-09 13:02:15', '完成', '7', '2019-01-10 10:00:36', null, '2019-01-10 10:00:36', '17', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('85', '站点监测页面支持排序（最近不可访问时间倒叙，可访问性升序）', '5', '2019-01-10 09:36:49', '完成', '5', '2019-01-10 15:59:18', null, '2019-01-10 15:59:18', '20', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('86', '修复断网再连时出现的“接口异常”bug', '5', '2019-01-10 09:39:26', '完成', '5', '2019-01-15 19:24:45', null, '2019-01-15 19:24:45', '20', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('87', '响应数据echarts点图，横坐标区间设置为12小时', '5', '2019-01-10 09:41:17', '完成', '5', '2019-01-10 11:29:25', null, '2019-01-10 11:29:25', '20', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('88', '按城市-服务类型来显示（城市列、服务列、响应时间）', '5', '2019-01-10 09:46:55', '完成', '5', '2019-01-10 09:57:34', null, '2019-01-10 09:57:34', '20', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('89', '考评弹窗调整', '7', '2019-01-10 10:17:16', '完成', '7', '2019-01-14 16:03:08', null, '2019-01-14 16:03:08', '17', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('90', '分数支持两位小数', '7', '2019-01-10 10:17:42', '完成', '7', '2019-01-14 16:03:06', null, '2019-01-14 16:03:06', '17', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('91', '站点监测详情页面添加搜索功能，按照城市-service来显示搜索结果', '5', '2019-01-10 10:34:20', '完成', '5', '2019-01-11 10:03:24', null, '2019-01-11 10:03:24', '20', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('92', '修改host name', '6', '2019-01-11 09:11:01', '完成', null, null, 0x736572766572EFBC9AE5AE89E8A385616D626172692D7365727665720D0A6E616D656E6F6465312C6E616D656E6F6465320D0A646174616E6F6465312C322C332C340D0A64617461736572766963653A6D7973716CE68980E59CA8686F7374, '2019-01-11 10:47:03', '19', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('93', '添加一个ambari可以替换现有的节点', '4', '2019-01-11 09:11:43', '完成', '6', '2019-01-11 20:25:49', null, '2019-01-11 20:25:49', '19', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('94', '支持ambari的mysql移动', '4', '2019-01-11 09:12:15', '完成', '6', '2019-01-11 11:29:13', null, '2019-01-11 11:29:13', '19', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('95', '点评页面加入完成todo分页', '7', '2019-01-11 09:33:39', '完成', '7', '2019-01-11 10:29:22', null, '2019-01-11 10:29:22', '17', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('96', '点评后总积分，当年积分累计', '7', '2019-01-11 09:53:02', '完成', '7', '2019-01-11 11:26:18', null, '2019-01-11 11:26:18', '17', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('97', 'Bug Fix:任务板 todo列表分页时，总数换行显示', '7', '2019-01-11 11:27:26', '完成', '7', '2019-01-11 18:00:33', 0xE588A0E999A4E5BA95E983A8E680BBE695B0E7BB9FE8AEA1, '2019-01-11 18:00:33', '17', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('98', 'Bug Fix:点评时授予的勋章', '7', '2019-01-11 11:32:43', '完成', '7', '2019-01-11 18:01:22', 0xE6B7BBE58AA0E9878DE7BDAEE6B885E999A4E58A9FE883BD, '2019-01-11 18:01:22', '17', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('99', 'Bug Fix:统一关键结果', '7', '2019-01-11 18:02:18', '完成', '7', '2019-01-14 16:03:03', null, '2019-01-14 16:03:03', '17', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('100', '公司租房评分值计算', '4', '2019-01-14 09:05:47', '未完成', null, null, 0xE5AE9EE78EB0E4B880E4B8AAE7AE80E58D95E58FAFE689A9E5B195E79A84E585ACE58FB8E8AF84E58886E585ACE5BC8FE8AEA1E7AE97E59084E4B8AAE585ACE58FB8E79A84E8AF84E4BBB7E58886E695B0, '2019-01-14 09:22:33', '19', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('101', '经纪人（租房）评分值计算', '4', '2019-01-14 09:07:21', '未完成', null, null, 0xE5AE9EE78EB0E4B880E4B8AAE7BB8FE7BAAAE4BABAE59CA8E7A79FE688BFE696B9E99DA2E79A84E8AF84E58886E79A84E8AEA1E7AE97E585ACE5BC8F, '2019-01-14 09:22:12', '19', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('102', '个人房源租房评分值计算', '4', '2019-01-14 09:08:16', '执行中', null, null, null, '2019-01-15 19:30:53', '19', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('103', '集成Swagger', '3', '2019-01-14 09:16:27', '完成', '3', '2019-01-14 09:16:30', null, '2019-01-14 09:16:30', '18', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('104', '设计定位元素结构树节点上给指定元素节点添加各种行为的方式', '2', '2019-01-14 09:50:43', '未完成', null, null, null, '2019-01-14 09:50:43', '18', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('105', '拖动元素树结构节点到XML控件上，实现插入对应节点元素的操作', '2', '2019-01-14 09:51:40', '完成', '2', '2019-01-16 17:21:45', null, '2019-01-16 17:21:45', '18', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('106', '删除 bug_sniper 各表的 is_deleted 并修改与之相关的业务', '3', '2019-01-14 11:15:18', '完成', '3', '2019-01-15 18:52:48', null, '2019-01-15 18:52:48', '18', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('107', '用户看房（租房）记录导入，实现增量更新', '4', '2019-01-14 12:49:00', '未完成', null, null, null, '2019-01-14 12:49:00', '19', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('108', '房源 记录导入，实现增量更新', '4', '2019-01-14 12:49:14', '未完成', null, null, null, '2019-01-14 12:49:14', '19', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('109', 'release环境部署', '4', '2019-01-14 12:56:33', '未完成', null, null, null, '2019-01-14 12:56:33', '19', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('110', '将查找元素的工具移植到BugSniper项目中', '2', '2019-01-15 09:25:18', '完成', '2', '2019-01-15 09:25:22', null, '2019-01-15 09:25:22', '18', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('111', '技能勋章页调整', '7', '2019-01-15 10:37:17', '完成', '7', '2019-01-15 11:20:08', null, '2019-01-15 11:20:08', '17', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('112', '研究院ftp服务发布', '7', '2019-01-15 11:19:52', '完成', '7', '2019-01-15 11:20:01', 0xE58FAFE9809AE8BF87206674703A2F2F72657365617263682E666F6F77772E636F6D2F20E8AEBFE997AEE695B0E68DAEE5BA93E5A487E4BBBD, '2019-01-15 11:20:01', '17', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('113', '个人详情页面调整', '7', '2019-01-15 11:20:39', '完成', '7', '2019-01-16 16:52:31', 0x612909E5AEBDE5BAA6E8B083E695B4E68890E4B88EE588ABE79A84E9A1B5E99DA2E4B880E887B4EFBC9A313238300D0A622909E5A29EE58AA0E8BF94E59B9EE4B88AE4B880E9A1B5E68C89E992AE0D0A632909E68A80E883BDE6A091EFBC88E58C85E68BACE68A80E883BDE6A091EFBC89E4BBA5E4B88BE79A84E695B0E68DAEE694B9E68890E68792E58AA0E8BDBDEFBC8CE4B99FE5B0B1E698AFE6BB9AE58AA8E588B0E79A84E697B6E58099E5868DE58AA0E8BDBD0D0A, '2019-01-16 16:52:31', '17', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('114', '抽象符合XML结构树的底层数据结构，以及编写XML文本时的提示字典', '2', '2019-01-15 15:33:27', '未完成', null, null, null, '2019-01-15 15:33:27', '18', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('115', '针对控件，封装一些控件的行为（点击行为，输入值，选中等）', '2', '2019-01-15 15:35:58', '未完成', null, null, null, '2019-01-15 15:35:58', '18', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('116', '团队活动页面', '7', '2019-01-16 17:21:52', '完成', '7', '2019-01-23 10:19:48', null, '2019-01-23 10:19:48', '17', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('117', '代码优化', '5', '2019-01-16 18:49:37', '完成', '5', '2019-01-21 09:37:43', null, '2019-01-21 09:37:43', '20', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('118', '使用全量查询获取采集数据', '5', '2019-01-21 18:47:33', '完成', '5', '2019-01-21 18:47:36', null, '2019-01-21 18:47:36', '20', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('119', '建立demo，尝试调用自带dll修改密码', '5', '2019-01-22 09:24:39', '完成', '7', '2019-01-22 16:50:57', null, '2019-01-22 16:50:57', '21', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('120', '采集总数与新增数独立查询与计算', '5', '2019-01-22 11:09:33', '完成', '5', '2019-01-22 11:31:08', null, '2019-01-22 11:31:08', '20', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('121', 'aaaa', '7', '2019-01-22 16:44:25', '完成', '7', '2019-01-22 16:45:54', null, '2019-01-22 16:45:54', '30', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('122', '组织', '7', '2019-01-22 16:48:40', '完成', '7', '2019-01-22 16:48:58', null, '2019-01-22 16:48:58', '13', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('123', '授课', '7', '2019-01-22 16:48:46', '完成', '7', '2019-01-22 16:48:59', null, '2019-01-22 16:48:59', '13', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('124', '复盘', '7', '2019-01-22 16:48:52', '完成', '7', '2019-01-22 16:48:56', null, '2019-01-22 16:48:56', '13', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('125', '啊士大夫萨芬', '1', '2019-01-22 16:50:10', '完成', '1', '2019-01-22 16:50:23', null, '2019-01-22 16:50:23', '13', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('126', '撒旦士大夫', '1', '2019-01-22 16:50:15', '完成', '1', '2019-01-22 16:50:21', null, '2019-01-22 16:50:21', '13', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('127', '111', '7', '2019-01-22 16:50:28', '未完成', null, null, null, '2019-01-22 16:50:28', '33', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('128', 'jlj', '7', '2019-01-22 17:09:04', '完成', '7', '2019-01-22 17:09:09', null, '2019-01-22 17:09:09', '36', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('129', '1321', '9', '2019-01-22 17:12:36', '完成', '9', '2019-01-22 17:12:39', null, '2019-01-22 17:12:39', '36', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('130', 'eqweqw', '7', '2019-02-28 19:13:13', '未完成', null, null, 0x65717765, '2019-02-28 19:13:13', '42', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('131', '大萨达撒', '7', '2019-03-01 14:18:54', '完成', '7', '2019-03-01 14:19:03', 0xE998BFE8BEBE, '2019-03-01 14:19:03', '49', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('132', 'asdfdsafdsafdsafdsafdsaf', '7', '2019-03-01 14:22:34', '完成', '9', '2019-03-01 14:24:07', null, '2019-03-01 14:24:07', '60', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('133', '大', '7', '2019-03-01 14:23:43', '完成', '7', '2019-03-01 14:23:47', null, '2019-03-01 14:23:47', '46', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('134', '打算', '7', '2019-03-01 14:26:42', '完成', '7', '2019-03-01 14:26:45', null, '2019-03-01 14:26:45', '52', '2019-03-15 09:54:43');
INSERT INTO `todos` VALUES ('135', '安安', '7', '2019-03-11 12:03:25', '完成', '7', '2019-03-11 12:03:31', null, '2019-03-11 12:03:31', '89', '2019-03-15 09:54:43');
