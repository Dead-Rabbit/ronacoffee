<%@page import="dao.ShopDao"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="controller.RonaCoffeeMenu"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="entity.*" %>
<%@ page import="java.util.*" %>
<%@ page import="controller.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String weichatId = (String) request.getAttribute("weichatId");//用户的微信openid
Boolean ifVip = (Boolean) request.getAttribute("ifVip").equals("true")?true:false;//用户是否为VIP
List<Shops> shops = (List) request.getAttribute("shops");//商店（已排序）
String shopId = (String) request.getAttribute("shopId");//获取当前商店ID号
RonaCoffeeMenu rona = new RonaCoffeeMenu(request,response);

JSONArray prices = rona.getPricesByShopId(shopId);

ShopDao shopDao = new ShopDao();
Shops defaShop = shopDao.getShopById(shopId);

//用于发送内容的JSON
JSONObject sendMenuJson = rona.getItemAPricesByShopId(shopId);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="zh">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><script type="text/javascript" src="./js/jquery.min.js"></script>
	<meta name="description" content="罗纳咖啡-微信点单">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=no">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="format-detection" content="telephone=no">

	<title>罗纳咖啡-微信点单</title>

	<link href="./css/main.css" rel="stylesheet" type="text/css">
	<link href="./css/pop.css" rel="stylesheet" type="text/css">
	<script src="./js/jquery-1.10.1.min.js" type="text/javascript"></script>
	<script src="./js/share.js" type="text/javascript"></script>


</head>
<body style="padding-top: 5.5em;">
<header>
  <div class="nav">

    <h1><span class="icon-select-arrow" id="restNameSpan"><%=defaShop.getShopName() %></span></h1>

    </div>

  <div class="order_filter">
   <div class="move_box">
    <ul>
	<!--
      <li class="all"><a href="javascript:">全部</a></li>
	  -->
	  <li class="all"><a>类别</a></li>
      <li><a>全部</a></li>
      <li><a>特价</a></li>
      <li><a>招牌</a></li>
    </ul>
    <div class="cur_bg" style="width: 337.25px; left: 337.25px;"></div>
    </div>
  </div>
</header>

<!--order dishes content start-->
<section class="wrap"> 
  <!--瀑布流布局-->
  <div class="order_box"> 
    <!--left listview-->
    <div class="order_list" id="left_list"> 
<%
Iterator<Object> it = prices.iterator();
System.out.println("prices：" + prices);
int showI = 0;
while (it.hasNext()) {
	showI++;
	JSONObject one = (JSONObject) it.next();
	if(showI%2 == 1){
		JSONObject oneItem = (JSONObject) one.get("item");
		//System.out.println(oneItem);
		String delePrice = "";//显示被删除价格
		String showPrice = "";//显示未删除价格
		if(ifVip){
			delePrice = "原价&nbsp;&nbsp;<i class=\"icon-great deleteLine\">￥"+one.get("price")+"</i>";
			showPrice = "￥<i class=\"price_num\">"+one.get("vipPrice")+"</i>";
		}else{
			delePrice = "会员价&nbsp;&nbsp;<i class=\"icon-great deleteLine\">￥"+one.get("vipPrice")+"</i>";
			showPrice = "￥<i class=\"price_num\">"+one.get("price")+"</i>";
		}
%>
       <div class="item_li my_li"  sign="<%=one.getString("sign") %>">
       <%
       //标志展示
       if(one.getString("sign").equals("招牌")){
       %>
      	<div class="special_tag4"></div>
       <%
       }
        %>
      	<a href=""> <img src="./img/2015_1_8_1722415639_min.jpg"></a> 

        <div class="item_text" id="<%=oneItem.get("itemId") %>" itemname="<%=oneItem.get("itemName") %>" orderamount="0">
          <h3><%=oneItem.get("itemName") %></h3>
          <span class="add_btn" onclick="addDishes(&#39;<%=oneItem.get("itemId") %>&#39;);"></span> <span id="amount_<%=oneItem.get("itemId") %>" class="amount">0</span>
          <p><span class="sales"><%=delePrice %></span><span class="price"><%=showPrice %></span></p>
        </div>
      </div>
<% 
	}
}
 %>
   </div>
   <!--right listview-->
   <div class="order_list" id="right_list"> 
     <%
Iterator<Object> it2 = prices.iterator();
showI = 0;
while (it2.hasNext()) {
	showI++;
	JSONObject one = (JSONObject) it2.next();
	if(showI%2 == 0){
		JSONObject oneItem = (JSONObject) one.get("item");
		//System.out.println(oneItem);
		String delePrice = "";//显示被删除价格
		String showPrice = "";//显示未删除价格
		if(ifVip){
			delePrice = "原价&nbsp;&nbsp;<i class=\"icon-great deleteLine\">￥"+one.get("price")+"</i>";
			showPrice = "￥<i class=\"price_num\">"+one.get("vipPrice")+"</i>";
		}else{
			delePrice = "会员价&nbsp;&nbsp;<i class=\"icon-great deleteLine\">￥"+one.get("vipPrice")+"</i>";
			showPrice = "￥<i class=\"price_num\">"+one.get("price")+"</i>";
		}
%>
       <div class="item_li my_li" sign="<%=one.getString("sign") %>">
      	<%
	       //标志展示
	       if(one.getString("sign").equals("招牌")){
	       %>
	      	<div class="special_tag4"></div>
	       <%
	       }
        %>
      	<a href=""> <img src="./img/2015_1_8_1722415639_min.jpg"></a> 

        <div class="item_text" id="<%=oneItem.get("itemId") %>" itemname="<%=oneItem.get("itemName") %>" orderamount="0">
          <h3><%=oneItem.get("itemName") %></h3>
          <span class="add_btn" onclick="addDishes(&#39;<%=oneItem.get("itemId") %>&#39;);"></span> <span id="amount_<%=oneItem.get("itemId") %>" class="amount">0</span>
          <p><span class="sales"><%=delePrice %></span><span class="price"><%=showPrice %></span></p>
        </div>
      </div>
<% 
	}
}
 %>
    </div>
  </div>
</section>
<!--order dishes content start end-->
<footer> 

    <div class="cart-btns-fixed" id="cart1">
    	<div class="cart-btns-fixed-box"> 
		<a href="./我的订单/index.html" class="btn2 btn-cart" id="add_cart">查看订单</a> 
		<a href="http://yun.menu123.cn/newMenu/wechat/pre_list.jsp?commTenaId=32" class="btn2 btn-buy" id="gotohas_list">我选好了</a> 
		 </div>
    </div>
</footer>

<!--pop content start--> 
<!--all mask pop-->
<div class="mask_bg" style="display:none"></div>
<div class="mask_bg2" style="display:none"></div>
<!--全部分类-->
<div class="pop_sort_class pop_shadow" style="display:none">
  <div class="sort_con">
    <a href="javascript:" class="cancel">取消</a>
    <h4>目录</h4>
   <ul>
      <li id="531"><a href="javascript:">蛋糕西点
        <!-- <span class="bubble">7</span> -->
      </a></li>
      
    </ul> 
  </div>
</div>
<!--全部分店-->
<div class="pop_sort_store pop_shadow" style="display:none">
  <div class="sort_con_store">
    <a href="javascript:" class="cancelStore">取消</a>
    <h4>分店</h4>
    <ul>
<%
for(Shops shop : shops){

%>
      <li id="<%=shop.getShopId() %>" class="selected"><a href="./testGetInMenu?shopId=<%=shop.getShopId() %>"><span id="store_<%=shop.getShopId() %>"><%=shop.getShopName() %></span></a></li>
<%
} 
%>
    </ul>
  </div>
</div>

<!---->
<div class="pop_count pop_shadow" style="display: none; margin-top: -82px;">
  <div class="sort_con" id="orderDiv" goodsid="">
    <h4><span id="orderGoodsName"></span></h4>
    <div class="count_item">
    <p style="padding-top:.5em">数量：</p>
    <p class="count_item_con" style="margin: 0px auto; width: 152px;">
      <a class="plus_btn2 fl" style="background-image:url('./img/icon-plus.png')"></a>
      <span id="orderAmount" class="bubble2 fl">0</span>
      <a class="add_btn3 fl" style="background-image:url('./img/icon-add.png')"></a>
    </p>
    </div>
    <div class="count_item" style="margin-top:.4em"><a href="javascript:" class="cancel02">取 消</a><a href="javascript:" class="confirm">确 定</a></div>
  </div>
</div>

<!--点完-->
<div class="pop_complete" style="display:none">
<p>您共点了<span id="totalNum"></span>道菜，总价：<strong class="price_num"><span id="totalPrice"></span></strong>元</p>
<a href="http://yun.menu123.cn/newMenu/wechat/pre_list.jsp?takeOut=0&amp;commTenaId=32&amp;tagIndex=1&amp;classId=">确定下单</a>
</div>


<script type="text/javascript">
//存放全局变量，与后台程序结合
	var shopId = "100012";
	var ifVip = false;
	//用来发送点单内容
	// 
	var sendMenu = JSON.parse('<%=sendMenuJson %>');
	sendMenu.ifVip = "<%=ifVip %>";	
	console.log(sendMenu);
</script>


<script type="text/javascript">

var curStoreId = "16";

function addDishes(goodsId){
return;
$('.mask_bg').fadeOut();
$('.pop_count').fadeOut();
var amount = Number($('#amount_'+goodsId).text());
amount = amount + 1;
console.log(amount);
 // $.ajax({
	// 	url : "/newMenu/wechat/common/saveOrder.jsp",
	// 	type : "post",
	// 	cache : false,
	// 	data : "commTenaId=32&goodsId="+goodsId+"&amount="+amount,
	// 	success : function(data) {
	// 	    data = data.replace(/(\n|\r|\r\n)/g,"");
		    
	// 		if (data == "success") {
	// 			$('#amount_'+goodsId).text(amount);
				
	// 		} else {
				
	// 		}
	// 	}
	// });
}

var tsCnt = 0;
function getTsCnt(){
	$.ajax({
		url : "/newMenu/wechat/common/countOrder.jsp",
		type : "post",
		cache : false,
		data : "commTenaId=32&wechatId=99999",
		success : function(data) {
		    data = data.replace(/(\n|\r|\r\n)/g,"");
		    var rtn = data.split("-");
			if (rtn[0] == "success") {
				tsCnt = rtn[1];
				if(tsCnt>=0){
					 $('#tsC').css("display","");
				     $('#tsD').css("display","");
				     $('#tsD').text(tsCnt);
			     }
			     else {
					  $('#tsC').css("display","none");
       				  $('#tsD').css("display","none");
       				  $('#tsD').text(tsCnt);
				  }
			} else {
				$('#tsC').css("display","none");
					$('#tsD').css("display","none");
			}
		}
	});
}

function submitConfirm()
{
	// window.location.href = 'pre_list.jsp?takeOut=0&commTenaId=32&tagIndex=1&classId=';
}

$(function(){
    //发送？
    // getTsCnt();
    
	$('.all').click(function(){
		$('.mask_bg').fadeIn();
		$('.pop_sort_class').fadeIn();
	});
	
	$('.icon-select-arrow').click(function(){
		$('.mask_bg').fadeIn();
		$('.pop_sort_store').fadeIn();
	});
	
	$('.item_text').click(function(){
		$('.mask_bg').fadeIn();
		$('.pop_count').fadeIn();	
		
		$('#orderDiv').attr("goodsId",$(this)[0].id) ;
		$('#orderAmount').text($('#amount_'+$(this)[0].id).text());
		$('#orderGoodsName').text($(this).attr("itemname"));
	});
	
	$('.plus_btn2').click(function(){
		var amount = Number($('#orderAmount').text());
		amount = amount -1;
		if(amount<0){
			amount = 0;
		}
		$('#orderAmount').text(amount);	
	});
	
	$('.add_btn3').click(function(){
		var amount = Number($('#orderAmount').text());
		amount = amount +1;
		$('#orderAmount').text(amount);		
	});	
	
	$('.cancel02').click(function(){
		$('.mask_bg').fadeOut();
		$('.pop_count').fadeOut();		
	});
	
	
	//每次点击确定后触发
	$('.confirm').click(function(){
      //直接在本地添加内容	
      //$('#orderDiv').attr("goodsId")) 为商品ID
		$('#amount_'+$('#orderDiv').attr("goodsId")).text($('#orderAmount').text());
            $('.mask_bg').fadeOut();
            $('.pop_count').fadeOut();
            var itemId = $('#orderDiv').attr("goodsId");
            //console.log($('#orderAmount').text());
			for(var oneJson in sendMenu.items){
            	if(sendMenu.items[oneJson].itemId == itemId){
            		sendMenu.items[oneJson].number = parseInt($('#orderAmount').text());
            		console.log(parseInt($('#orderAmount').text()));
            	}
            }
	   	});
	   	
	$('.pre_end_btn').click(function(){
		submitConfirm();
	});	
	
	$('.pre_end_btn2').click(function(){
		submitConfirm();
	});	
	
	$('.pre_end_btn3').click(function(){
		submitConfirm();
	});	
	
	$('.pre_end_btn1').click(function(){
		submitConfirm();		
	});	
		
	$('.mask_bg').click(function(){
		$('.mask_bg').fadeOut();
		$('.pop_sort').fadeOut();
		$('.pop_sort_class').fadeOut();
		$('.pop_sort_store').fadeOut();
		$('.pop_count').fadeOut();		
	});
	
	$('.mask_bg2').click(function(){
		$('.mask_bg2').fadeOut();
		$('.pop_complete').fadeOut();		
	});	
	
	var popH = $('.pop_sort').outerHeight(),
	    popH2 = $('.pop_count').outerHeight();
	$('.pop_sort').css('margin-top',-popH/2);
	$('.pop_count').css('margin-top',-popH2/2);
	$('.count_item_con').width($('.plus_btn2').outerWidth()+$('.plus_btn2').outerWidth()+$('.add_btn3').outerWidth()+20);
	
	$('.sort_con li').click(function(){
		$('.sort_con li').removeClass('selected');
		$(this).addClass('selected');
		var classId = $(this)[0].id;
		window.location.href += "#"+classId;
		
	});
	
	$('.cancel').click(function(){
		$('.sort_con li').removeClass('selected');
		$('.mask_bg').fadeOut();
		$('.pop_sort').fadeOut();
		$('.pop_sort_class').fadeOut();
	});	
	
	$('.sort_con_store li').click(function(){
		var storeId = $(this)[0].id;
		if(storeId == curStoreId){
			$('.mask_bg').fadeOut();
			$('.pop_sort_store').fadeOut();
			return;
		}
	
	});
	
	$('.cancelStore').click(function(){
		//$('.sort_con_store li').removeClass('selected');
		$('.mask_bg').fadeOut();
		$('.pop_sort_store').fadeOut();
	});	
	
	//
	//filter nav switching
  // 四个标题 点击之后的效果和链接
	//
	var signs = ["无","特价","招牌"];
	var silderW = $(".order_filter").outerWidth()/4;
	console.log(silderW);
	$('.cur_bg').css('width',silderW).css('left',silderW);
	var sider = $(".order_filter li").click(function(){
		var idx = sider.index(this);

		if(idx>=1){
			$('.cur_bg').animate({
				left:idx*silderW
			},500,function(){
				//alert(idx);
				if(idx>0){
				  // window.location.href = "";
				  //改变横条位置
				  switch(idx){
					case 1:doShowAllItems();break;
					case 2:doShowItemsBySign(signs[idx-1]);break;
					case 3:doShowItemsBySign(signs[idx-1]);break;
					}
				}
  			})
		}
	})
	//横条位置
	var curIdx = 1;
	$('.cur_bg').animate({
		left:curIdx*silderW
	},500,function(){
		//alert(curIdx);
	});
		
})
function doShowItemsBySign(sign){
	var a = document.getElementsByClassName("my_li");
	for(var i=0;i<a.length;i++){ 
		var one = i;
		if(a[one].getAttribute("sign") == sign){
			a[one].style.display="block";
		}else{
			a[one].style.display="none";
		}
	}
}
function doShowAllItems(){
	var a = document.getElementsByClassName("my_li");
	for(var i=0;i<a.length;i++){ 
		var one = i;
		a[one].style.display="block";
		//console.log(a[one].getAttribute("sign"));
	}
}
</script>
<!-- 我的JS文件 -->
<script type="text/javascript" src="./my_js/json2.js"></script>
<script type="text/javascript" src="./my_js/sendMessage.js"></script>
<script type="text/javascript" src="./my_js/index.js"></script>
</body>
</html>
