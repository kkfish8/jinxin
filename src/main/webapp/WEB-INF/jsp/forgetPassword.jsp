<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<meta http-equiv="pragma" content="no-cache"> 
<meta http-equiv="cache-control" content="no-cache"> 
<meta http-equiv="expires" content="0">   
<title>忘记密码</title>
<link rel="stylesheet" href="css/top.css" type="text/css"> 
<link rel="stylesheet" href="css/forgetPass.css" type="text/css"> 
<link rel="stylesheet" href="css/foot.css" type="text/css"> 
<script src="plugin/jquery-1.11.3.min.js"></script>
<style>
	#imgObj{
		width:100px;
	}
</style>
<script>
function CheckMail(mail) {
	 var filter  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	 if (filter.test(mail)) return true;
	 else {
	 alert('您的电子邮件格式不正确');
	 return false;}
	}
	
	$(document).ready(function(){
		$(".forgetPass_frim").click(function(){
			var username = $('#username').val();
			var mail = $('#mail').val();
			var check = $('#check').val();
			
			if(username.length==0 || mail.length==0 || check.length==0){
				alert("请填写完整");
				return;
			}
			
			if(!CheckMail(mail)){
				return;
			}
			
			$.post("findPwd.do",{"username":username,"mail":mail,"check":check},function(data){
				alert(data);
			});
		});
	})
	
	function changeImg() {
        var imgSrc = $("#imgObj");
        var src = imgSrc.attr("src");
        imgSrc.attr("src", chgUrl(src));
    }
    //时间戳   
    //为了使每次生成图片不一致，即不让浏览器读缓存，所以需要加上时间戳   
    function chgUrl(url) {
        var timestamp = (new Date()).valueOf();
        url = url.substring(0, 17);
        if ((url.indexOf("&") >= 0)) {
            url = url + "×tamp=" + timestamp;
        } else {
            url = url + "?timestamp=" + timestamp;
        }
        return url;
    }
</script>
</head>

<body>
<div class="top">	
	<img src="img/school.png"	style="float:right" class="topImg">
    <div class="top_img">
    	<img src="img/LOGO2.png" class="logo">
    </div>
    <div class="top_nav">
    	<ul>
        	<a href="index.do"><li>首页</li></a>
				<a href="zjfc.do"><li>专家风采</li></a>
				<a href="news.do"><li>新闻动态</li></a>
				<a href="gonggao.do"><li>通知公告</li></a>
				<a href="download.do"><li>资料下载</li></a>
        </ul>
    </div> 	
</div>
<div class="forgetPass">
	<div class="forgetPass_title">
    	<div>忘记密码</div>
    </div>
    <form class="from">
	<table>
	
		<tr>
        	<td><label>用户名：</label></td>
            <td><input type="text" placeholder="请输入您的用户名" class="forgetPass_input" id="username"></td>
        </tr>
        <tr>
        	<td><label>邮 箱：</label></td>
            <td><input type="text" placeholder="请输入您的邮箱" class="forgetPass_input" id="mail"></td>
        </tr>
        <tr>
        	<td><div><img id="imgObj"  alt="验证码" src="code.do" onclick="changeImg()" ></div></td>
            <td><input type="text" placeholder="请输入验证码" class="forgetPass_input" id="check"></td>      	
        </tr>
        <tr>
        	<td colspan="2"><input type="button" value="确 定"  class="forgetPass_frim"></td>              	
        </tr>
       
	</table>
	 </form>
</div>


<div class="foot">
		<span>Copyright&copy;2015 广元市经信委 版权所有</span> <span>技术支持：睿意科技</span>
	</div>
</body>
</html>
