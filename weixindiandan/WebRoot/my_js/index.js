var message = {
	'type':'getAllItemsByShopId',
	'shopId':shopId
};
function getItems(){
	sendMesge(message);
}
//发送请求

//getItems();
//当获得json时触发
function receiveItems(mess){
	var left_list = document.getElementById("left_list");
	var right_list = document.getElementById("right_list");
	if(Array.isArray(mess.items)){
		console.log("is Array");
	}else{
		// left_list.innerHTML = "";
		// right_list.innerHTML = "";
//		console.log(left_list.innerHTML);
//		set_innerHTML("left_list",JsonToItem(	mess));
//		console.log(left_list.innerHTML);

	}
}
//json解析出一个item，转化为前端
function JsonToItem(oneItem){
	var imgSrc = "./img/2015_1_8_1722415639_min.jpg";//图片链接
	var itemId = "3623";
	var itemName = "芒果蛋糕";
	var price = "10";
	var vipPrice = "8";
	var delePrice = "";//显示被删除价格
	var showPrice = "";//显示未删除价格
	if(ifVip){
		delePrice = '原价&nbsp;&nbsp;<i class="icon-great deleteLine">￥'+price+'</i>';
		showPrice = '￥<i class="price_num">'+vipPrice+'</i>&nbsp;';
	}else{
		delePrice = '会员价&nbsp;&nbsp;<i class="icon-great deleteLine">￥'+vipPrice+'</i>';
		showPrice = '￥<i class="price_num">'+price+'</i>&nbsp;';
	}
	var item = '<div class="item_li"><div class="special_tag4"></div>'+
      	'<a href=""><img src="'+imgSrc+'"></a>'+
        '<div class="item_text" id="'+itemId+'" itemname="'+itemName+'" orderamount="0">'+
          '<h3>'+itemName+'</h3>'+
          '<span class="add_btn" onclick="addDishes(&#39;'+itemId+'&#39;);"></span> <span id="amount_'+itemId+'" class="amount">0</span>'+
          '<p><span class="sales">'+delePrice+'</span>&nbsp;<span class="price">'+showPrice+'</span></p>'+
        '</div>'+
      '</div>';
    var test = '<div class="item_li">'+
	    '<div class="special_tag4"></div>'+
	    '<a href=""> <img src="./img/2015_1_8_737835605_min.jpg"></a> '+
    	'<div class="item_text" id="3626" itemname="提拉米苏蛋糕" orderamount="0">'+
          '<h3>提拉米苏蛋糕</h3>'+
          '<span class="add_btn" onclick="addDishes(&#39;3626&#39;);"></span> <span id="amount_3626" class="amount">0</span>'+
          '<p><span class="sales">会员价<i class="icon-great deleteLine">￥25</i></span>&nbsp;<span class="price">￥<i class=" price_num">35.0</i></span></p>'+
        '</div>'+
      '</div>';
    return test;
}