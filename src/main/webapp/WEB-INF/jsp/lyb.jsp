<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<meta http-equiv="pragma" content="no-cache"> 
<meta http-equiv="cache-control" content="no-cache"> 
<meta http-equiv="expires" content="0">   <title>留言板</title>
<link rel="stylesheet" href="css/top.css" type="text/css">
<link rel="stylesheet" href="css/subpage.css" type="text/css"> 
<link rel="stylesheet" href="css/subpage_opinion.css" type="text/css"> 
<link rel="stylesheet" href="css/foot.css" type="text/css"> 
</head>

<body>
<div class="top">	
	<img src="img/school.png"	style="float:right" class="topImg">
    <div class="top_img">
    	<img src="img/LOGO2.png" class="logo">
    </div>
    <div class="top_nav">
    	<ul>
        	<li><a href="index.do">首页</a></li>
            <li><a href="zjfc.do">专家风采</a></li>
            <li><a href="nav.do">全部文章</a></li>
        </ul>
    </div> 	
</div>
<div id="subpage">
    <div id="subContent">
        <div id="subContent_left">
            <div id="subContent_left_title">站点导航</div>
            <ul type="none">
                <li><a href="#">部门简介</a></li>
                <li><a href="#">新闻速递</a></li>
                <li><a href="#">通知公告</a></li>
                <li><a href="#">制度法规</a></li>
                <li><a href="#">宣传教育</a></li>
                <li><a href="#">安全知识</a></li>
                <li><a href="#">失物招领</a></li>
                <li><a href="#">留言板</a></li>
            </ul>
        </div>
        <div id="subContent_right">
            <div id="subContent_right_title">
                <span>首页</span>
                <span> > </span>
                <span style="color:#3ad;">留言板</span>
            </div>
            <div id="subContent_right_content">
                <form action="#" method="get">
                    <table>
                        <tr>
                            <td>姓名:</td>
                            <td><input type="text" placeholder="请输您的姓名"></td>
                        </tr>
                        <tr>
                            <td>邮箱:</td>
                            <td><input type="text"  required="true" placeholder="请输入您的邮箱"></td>
                        </tr>
                        <tr>
                            <td valign="top">内容:</td>
                            <td><textarea required placeholder="请输入您要提交的意见"></textarea></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><input type="submit" value="提交" id="sub">	</td>
                        </tr>
                    </table>
                    
                </form>
            </div>
        </div>
    </div>
</div>
<div class="foot">
		<span>Copyright&copy;2015 广元市经信委 版权所有</span> <span>技术支持：睿意科技</span>
	</div>
</body>
</html>
