//选择星级JS

var oScore = document.getElementById("score");
var oTip   = document.getElementById("tip");
var oLi    =   oScore.getElementsByTagName('li');
var oStrong=   oScore.getElementsByTagName('strong');
var oSpan  =   oScore.getElementsByTagName('span')[0];
var iScore = iPoint = isClick = 0;
var msg=['1星  非常糟糕','2星  糟糕','3星  一般','4星  良好','5星  非常nice'];
var review=['1星满意度,尽情发泄不满','2星满意度,下手轻点','3星满意度,一般一般','4星满意度,还有提升空间','5星满意度,送上最高评价'];
for(var i=0;i<oLi.length;i++){
	oLi[i].index=i;
	oLi[i].onmouseover = function(){
		iScore = this.index+1;             //记录下索引值
		fnPoint(iScore);                   //鼠标移过显示评分
		oTip.style.display='block';        //让提示框显示在对应的位置
		oTip.style.left = 160+this.index*48+'px';
		oStrong[1].innerHTML = msg[this.index];  //移过不同的星星显示对应的文字
	}
	oLi[i].onclick = function(){
		oStrong[0].innerHTML = review[this.index]; //右上角评价结果显示
		iPoint = this.index+1;       //鼠标点击事件，记录下索引，并返回索引值
		isClick = 1;
		$("#grade").val(iPoint);
		return iPoint;
	}
	oLi[i].onmouseout = function(){  //接收点击的索引，鼠标移出后，恢复上次的评分
		fnPoint(iPoint);
		crush();
		oTip.style.display='none';     //鼠标移出隐藏提示框
	}
}
function fnPoint(arg){                
	iScore = arg? arg:iScore;        //接收一个参数，如果没传进参数就用iScore
	for(var i=0;i<oLi.length;i++){   //遍历oLi,对点击的和之前的都亮起来，之后的不亮
		oLi[i].className = i<iScore? 'current':'';  
	}
}
function crush(){
	if(isClick==1)	return;
	for(var i=0;i<oLi.length;i++){   //遍历oLi,对点击的和之前的都亮起来，之后的不亮
		oLi[i].className = '';
	}
}