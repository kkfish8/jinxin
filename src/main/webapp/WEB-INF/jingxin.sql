-- phpMyAdmin SQL Dump
-- version 2.10.2
-- http://www.phpmyadmin.net
-- 
-- 主机: localhost
-- 生成日期: 2015 年 12 月 25 日 07:36
-- 服务器版本: 5.0.45
-- PHP 版本: 5.2.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- 
-- 数据库: `jingxin`
-- 

-- --------------------------------------------------------

-- 
-- 表的结构 `apply`
-- 

CREATE TABLE `apply` (
  `Id` int(15) NOT NULL,
  `UserId` int(11) default NULL,
  `Name` varchar(30) default NULL,
  `Sex` char(2) default NULL,
  `Brithday` varchar(30) default NULL,
  `IdCard` varchar(20) default NULL,
  `PoliticalStatus` varchar(20) default NULL,
  `Nation` varchar(10) default NULL,
  `WorkType` varchar(30) default NULL,
  `WorkName` varchar(50) default NULL,
  `Department` varchar(50) default NULL,
  `WorkAddress` varchar(50) default NULL,
  `InchPhoto` varchar(50) default NULL,
  `WorkDuties` varchar(50) default NULL,
  `WorkTitle` varchar(50) default NULL,
  `MailingAddress` varchar(50) default NULL COMMENT '讯通地址',
  `PhoneNumber` varchar(15) default NULL COMMENT '手机号码',
  `FixedTelephone` varchar(20) default NULL COMMENT '固定电话',
  `Mail` varchar(50) default NULL,
  `Education` varchar(10) default NULL COMMENT '学历',
  `AcademicDegree` varchar(10) default NULL COMMENT '学位',
  `Major` varchar(20) default NULL COMMENT '专业',
  `GraduateSchool` varchar(50) default NULL COMMENT '毕业学校',
  `NowMajor` varchar(50) default NULL COMMENT '现在从事的专业',
  `Field` int(11) unsigned default NULL COMMENT '领域Id',
  `JobResume` text NOT NULL COMMENT '工作简历',
  `FamiliarField` text NOT NULL COMMENT '熟悉的技术领域简介',
  `ResearchProject` text NOT NULL COMMENT '科研项目研究情况',
  `PublishedPapers` text NOT NULL COMMENT '发表论文情况',
  `PublishedMonograph` text NOT NULL COMMENT '发表专著情况',
  `ScienceTechnology` text NOT NULL COMMENT '科技奖励',
  `OnlyProperty` text NOT NULL COMMENT '知识产权',
  `ProjectDevelopment` text NOT NULL,
  `DeclarationPath` varchar(50) NOT NULL,
  `ProfessionalPath` varchar(50) NOT NULL,
  `EducationPath` varchar(50) NOT NULL,
  `Explain` text NOT NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- 导出表中的数据 `apply`
-- 


-- --------------------------------------------------------

-- 
-- 表的结构 `article`
-- 

CREATE TABLE `article` (
  `Id` int(11) NOT NULL,
  `Author` int(11) default NULL,
  `Title` varchar(255) default NULL,
  `Content` text,
  `PublishDate` datetime default NULL,
  `Type` tinyint(4) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- 导出表中的数据 `article`
-- 


-- --------------------------------------------------------

-- 
-- 表的结构 `user`
-- 

CREATE TABLE `user` (
  `Id` int(11) unsigned NOT NULL auto_increment,
  `Field` int(11) default NULL,
  `UserName` varchar(20) default NULL,
  `PassWord` varchar(32) default NULL,
  `Type` tinyint(1) default '1',
  `Question` varchar(50) default NULL,
  `Answer` varchar(50) default NULL,
  `Name` varchar(10) default NULL,
  `Sex` char(2) default NULL,
  `Number` char(11) default NULL,
  `Mail` varchar(50) default NULL,
  `IsBlack` tinyint(1) unsigned default '0',
  `UserImage` varchar(255) default NULL,
  `AbsentNum` int(11) default '0',
  `participateNum` int(11) default NULL COMMENT '0',
  `registerDate` datetime default NULL,
  `lastLoginDate` datetime default NULL,
  PRIMARY KEY  (`Id`),
  UNIQUE KEY `UserName` (`UserName`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- 
-- 导出表中的数据 `user`
-- 

INSERT INTO `user` VALUES (1, 1, 'admini', '827ccb0eea8a706c4c34a16891f84e7b', 1, '您的小学班主任是谁？', '张三', '张三', '男', '13987654321', '123@163.com', 0, 'userImage/aaa.jpg', 0, 0, '2015-12-25 09:29:14', '2015-12-25 09:29:18');
