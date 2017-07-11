// JavaScript Document
window.onload = function(){
	function Tab(){
		var oLi = document.getElementById('nav_tab').getElementsByTagName('li');
		var oUl = document.getElementById('nav_content').getElementsByTagName('ul');
		for(var i = 0; i < oLi.length;i++){
			oLi[i].index = i;
			oLi[i].onmouseover = function(){
				for(var n = 0 ; n < oLi.length ; n++) oLi[n].className = '';
				this.className = 'active';
				for(var n = 0 ;n < oUl.length ; n++) oUl[n].style.display = 'none';
				oUl[this.index].style.display = 'block';
			
			}
		}
	}
	Tab();
}
	