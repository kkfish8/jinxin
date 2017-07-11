$(function(){
	var i = 0;
	$(".demoform").Validform({
		btnSubmit:"next",
		tiptype:1, 
		datatype:{
			"z2-10" : /^[\u4E00-\u9FA5\uf900-\ufa2d]{2,10}$/
		},
	});
	
});
//	function x(){
//		$("#img").attr("src",$("#test").val());
//	}
function n(i){
	
	if(i==2){
		$(".r_top1").css('background','url("../img/setp-icon.png") 0 -35px no-repeat');
		$(".r_top2").css('background','url("../img/setp-icon.png") 0 -35px no-repeat');
		$(".r_top3").css('background','url("../img/setp-icon.png") 0  0px no-repeat');
		$(".r_top1").css('color','#3a4161');
		$(".r_top2").css('color','#3a4161');
		$(".r_top3").css('color','#fff');
		$(".main").css('display','none');  
		$(".main1").css('display','none');  
		$(".main2").css('display','block');
	}else{
		$(".r_top1").css('background','url("../img/setp-icon.png") 0 -35px no-repeat');
		$(".r_top2").css('background','url("../img/setp-icon.png") 0  0px no-repeat');
		$(".r_top3").css('background','url("../img/setp-icon.png") 0 -35px no-repeat');
		$(".r_top1").css('color','#3a4161');
		$(".r_top2").css('color','#fff');
		$(".r_top3").css('color','#3a4161');
		$(".main").css('display','none');  
		$(".main1").css('display','block');
		
	}
	
}
function r(i){
	if(i==0){
		$(".r_top1").css('background','url("../img/setp-icon.png") 0  0px no-repeat');
		$(".r_top2").css('background','url("../img/setp-icon.png") 0 -35px no-repeat');
		$(".r_top3").css('background','url("../img/setp-icon.png") 0 -35px no-repeat');
		$(".r_top1").css('color','#fff');
		$(".r_top2").css('color','#3a4161');
		$(".r_top3").css('color','#3a4161');
		$(".main").css('display','block');  
		$(".main1").css('display','none');  
		$(".main2").css('display','none');
	}
	if(i==1){
		$(".r_top1").css('background','url("../img/setp-icon.png") 0 -35px no-repeat');
		$(".r_top2").css('background','url("../img/setp-icon.png") 0  0px no-repeat');
		$(".r_top3").css('background','url("../img/setp-icon.png") 0 -35px no-repeat');
		$(".r_top1").css('color','#3a4161');
		$(".r_top2").css('color','#fff');
		$(".r_top3").css('color','#3a4161');
		$(".main").css('display','none');  
		$(".main2").css('display','none'); 
		$(".main1").css('display','block');
	}
	if(i==2){
		$(".r_top1").css('background','url("../img/setp-icon.png") 0 -35px no-repeat');
		$(".r_top2").css('background','url("../img/setp-icon.png") 0 -35px no-repeat');
		$(".r_top3").css('background','url("../img/setp-icon.png") 0  0px no-repeat');
		$(".r_top1").css('color','#3a4161');
		$(".r_top2").css('color','#3a4161');
		$(".r_top3").css('color','#fff');
		$(".main").css('display','none');  
		$(".main1").css('display','none');  
		$(".main2").css('display','block');
	}
}