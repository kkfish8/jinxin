/*
Navicat MySQL Data Transfer

Source Server         : 139.129.37.178_3306
Source Server Version : 50544
Source Host           : 139.129.37.178:3306
Source Database       : jingxin

Target Server Type    : MYSQL
Target Server Version : 50544
File Encoding         : 65001

Date: 2016-01-06 10:49:21
*/

CREATE DATABASE IF NOT EXISTS jingxin DEFAULT CHARSET utf8 COLLATE utf8_general_ci;

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for apply
-- ----------------------------
DROP TABLE IF EXISTS `apply`;
CREATE TABLE `apply` (
  `Id` int(15) unsigned NOT NULL AUTO_INCREMENT,
  `UserId` int(11) unsigned DEFAULT NULL,
  `Name` varchar(30) DEFAULT NULL,
  `Sex` char(2) DEFAULT NULL,
  `Brithday` date DEFAULT NULL,
  `IdCard` varchar(20) DEFAULT NULL,
  `PoliticalStatus` varchar(20) DEFAULT NULL,
  `Nation` varchar(10) DEFAULT NULL,
  `WorkType` varchar(30) DEFAULT NULL,
  `WorkName` varchar(50) DEFAULT NULL,
  `Department` varchar(50) DEFAULT NULL,
  `WorkAddress` varchar(50) DEFAULT NULL,
  `InchPhoto` varchar(255) DEFAULT NULL,
  `WorkDuties` varchar(50) DEFAULT NULL,
  `WorkTitle` varchar(50) DEFAULT NULL,
  `MailingAddress` varchar(50) DEFAULT NULL COMMENT '讯通地址',
  `PhoneNumber` varchar(15) DEFAULT NULL COMMENT '手机号码',
  `FixedTelephone` varchar(20) DEFAULT NULL COMMENT '固定电话',
  `Mail` varchar(50) DEFAULT NULL,
  `Education` varchar(10) DEFAULT NULL COMMENT '学历',
  `AcademicDegree` varchar(10) DEFAULT NULL COMMENT '学位',
  `Major` varchar(20) DEFAULT NULL COMMENT '专业',
  `GraduateSchool` varchar(50) DEFAULT NULL COMMENT '毕业学校',
  `NowMajor` varchar(50) DEFAULT NULL COMMENT '现在从事的专业',
  `Field` int(11) unsigned DEFAULT NULL COMMENT '领域Id',
  `JobResume` text COMMENT '工作简历',
  `FamiliarField` text COMMENT '熟悉的技术领域简介',
  `ResearchProject` text COMMENT '科研项目研究情况',
  `PublishedPapers` text COMMENT '发表论文情况',
  `PublishedMonograph` text COMMENT '发表专著情况',
  `ScienceTechnology` text COMMENT '科技奖励',
  `OnlyProperty` text COMMENT '知识产权',
  `ProjectDevelopment` text,
  `DeclarationPath` varchar(255) DEFAULT NULL,
  `ProfessionalPath` varchar(255) DEFAULT NULL,
  `EducationPath` varchar(255) DEFAULT NULL,
  `Note` text,
  `IsPass` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`Id`),
  KEY `fk_apply_user` (`UserId`),
  CONSTRAINT `fk_apply_user` FOREIGN KEY (`UserId`) REFERENCES `user` (`Id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Author` int(11) unsigned DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `Content` text,
  `PublishDate` datetime DEFAULT NULL,
  `Type` int(4) DEFAULT NULL,
  `Note` text,
  `ClickCount` int(11) DEFAULT NULL,
  `ArticleOrder` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `fk_article_manager` (`Author`),
  CONSTRAINT `fk_article_manager` FOREIGN KEY (`Author`) REFERENCES `user` (`Id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;



-- ----------------------------
-- Table structure for field
-- ----------------------------
DROP TABLE IF EXISTS `field`;
CREATE TABLE `field` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  `Note` text,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of field
-- ----------------------------
INSERT INTO `field` VALUES ('0', '无', null);


-- ----------------------------
-- Table structure for record
-- ----------------------------
DROP TABLE IF EXISTS `record`;
CREATE TABLE `record` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `RecordManager` int(10) unsigned DEFAULT NULL,
  `Field` int(10) unsigned DEFAULT NULL,
  `RecordDate` datetime DEFAULT NULL,
  `Note` text,
  PRIMARY KEY (`Id`),
  KEY `FK_Field` (`Field`),
  KEY `fk_record_user` (`RecordManager`),
  CONSTRAINT `FK_Field` FOREIGN KEY (`Field`) REFERENCES `field` (`Id`) ON DELETE SET NULL,
  CONSTRAINT `fk_record_user` FOREIGN KEY (`RecordManager`) REFERENCES `user` (`Id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;



-- ----------------------------
-- Table structure for recordUser
-- ----------------------------
DROP TABLE IF EXISTS `recordUser`;
CREATE TABLE `recordUser` (
  `RecordId` int(10) unsigned NOT NULL,
  `UserId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`RecordId`,`UserId`),
  KEY `fk_recordUser_user` (`UserId`),
  CONSTRAINT `fk_recordUser_record` FOREIGN KEY (`RecordId`) REFERENCES `record` (`Id`),
  CONSTRAINT `fk_recordUser_user` FOREIGN KEY (`UserId`) REFERENCES `user` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- ----------------------------
-- Table structure for setup
-- ----------------------------
DROP TABLE IF EXISTS `setup`;
CREATE TABLE `setup` (
  `name` varchar(50) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of setup
-- ----------------------------
INSERT INTO `setup` VALUES ('lunbo1', 'upload/2016-01-04/apply/xiaowu_49.61284280794873_fileupload.jpg');
INSERT INTO `setup` VALUES ('lunbo2', 'upload/2016-01-04/apply/xiaowu_36.420612658997044_fileupload.png');
INSERT INTO `setup` VALUES ('lunbo3', 'upload/2016-01-04/apply/xiaowu_95.1768810362866_fileupload.jpg');
INSERT INTO `setup` VALUES ('title', '广元经信委专家库欢迎您');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Field` int(11) unsigned DEFAULT '0',
  `Username` varchar(20) DEFAULT NULL,
  `Password` varchar(32) DEFAULT NULL,
  `Sid` varchar(32) DEFAULT NULL,
  `Type` int(1) DEFAULT '5',
  `Name` varchar(10) DEFAULT NULL,
  `Sex` char(2) DEFAULT NULL,
  `Number` char(11) DEFAULT NULL,
  `Mail` varchar(50) DEFAULT NULL,
  `IsBlack` tinyint(1) unsigned DEFAULT '0',
  `UserImage` varchar(255) DEFAULT NULL,
  `AbsentNum` int(11) DEFAULT '0',
  `ParticipateNum` int(11) DEFAULT '0',
  `RegisterDate` datetime DEFAULT NULL,
  `LastLoginDate` datetime DEFAULT NULL,
  `Note` text,
  `ContractDate` date DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UserName` (`Username`),
  KEY `fk_user_field` (`Field`),
  CONSTRAINT `fk_user_field` FOREIGN KEY (`Field`) REFERENCES `field` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '2c204d849495890a8fad6b44ee78ac73', '0', '超级管理员', '男', '13111111111', '1@qq.com', '0', 'userImage/aaa.jpg', '0', '0', '2015-12-26 15:47:24', '2016-01-04 16:16:55', null, '2999-12-31');
