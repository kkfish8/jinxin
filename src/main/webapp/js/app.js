$(".demoform").Validform({
	btnSubmit:"#reg", 
	tiptype:1, 
	ajaxPost:true,
	callback:function(data){
		switch(parseInt(data)){
			case -1:
				alert("用户名已存在！");
				break;
			case 1:
				alert("注册成功！");
				location.href="index.do";
				break;
			case 0:
				alert("注册失败！");
				break;
			default : 
				alert("异常错误！")
				break;
		}
			
	}
});