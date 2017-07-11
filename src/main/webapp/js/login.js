/**
 * 登陆脚本
 */
$(function(){
	$(".subform").Validform({
		tiptype: 4,
		btnSubmit:".sub-btn",
		ajaxPost:true,
		callback:function(data){
			if(!data.code){
				alert("验证码错误，点击图片可以更换验证码！");
			}else{
			if(data.testUser){
				if(data.testList){
					alert("您已被拉黑！");
				}else{
					location.href="index.do";					
				}
			}else{
				alert("用户名或密码不正确！");
				}
			}
		}
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