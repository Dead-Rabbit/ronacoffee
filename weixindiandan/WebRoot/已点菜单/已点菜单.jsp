<%@page import="dao.WorkOrderDao"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="dao.UserDao" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<html lang="zh"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><script type="text/javascript" src="./js/jquery.min.js"></script>
<script type="text/javascript">
 var ctx = "/newMenu";
 function UrlEncode(str){ 
    str = "http://yun.menu123.cn"+str;
    return str;
    var ret=encodeURIComponent(str); 
    return ret;
 }
 
 function firstPage(){
	 var pageNo = 1;
	 goPage(pageNo);
 }
 function lastPage(){
	 goPage($('#totalPage').val());
 }
 function prePage(pageNo){
	 if(pageNo ==1 ) return;
	 var prePageNo = parseInt(pageNo)-1;
	 goPage(prePageNo);
 }
 function nextPage(pageNo){
	 var nextPageNo = parseInt(pageNo)+1;
	 goPage(nextPageNo);
 }
 function goPage(pageNo){
	 $('#pageNo').val(pageNo); 
	 $('form')[0].submit(); 
 }
 function selPage(){
	 var selPageNo = $('#selPage').val();
	 var lastPage = parseInt($('#totalPage').val());//最后页
	 var thisPage = parseInt(selPageNo);//输入页数
	 if(thisPage>lastPage){
		 thisPage = lastPage;
	 }else if(thisPage==0){
		 thisPage=1;
	 }
	 goPage(thisPage);    
 }
 $(function(){
		 var reg = new RegExp("^[0-9]*$");
		 if(!reg.test("")){  
		 }
 })
<%
request.setCharacterEncoding("UTF-8");

String getMenu = request.getParameter("sendInput");

JSONObject menu = new JSONObject();
menu = JSONObject.fromString(getMenu);	

UserDao userDao = new UserDao();
boolean ifVip = userDao.ifExist(menu.getString("openid"));

int number_items = 0;

//获取点餐数目
JSONArray items = JSONArray.fromString(menu.get("items").toString());
System.out.println(items);
Iterator<Object> it = items.iterator();
while (it.hasNext()) {
	JSONObject oneItem = (JSONObject) it.next();
	if(oneItem.getInt("number") > 0){
		number_items++;
	}
	//System.out.println(oneItem);
}
//页面开始生成新的工单号
WorkOrderDao workOrder = new WorkOrderDao();
String newOrderId = workOrder.getNewOrderId();
%>
var menu = JSON.parse('<%=getMenu %>');
menu.orderId = '<%=newOrderId %>';
</script>
<meta name="description" content="罗纳咖啡-已点菜单">
<meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<title>罗纳咖啡-已点菜单</title>
<link href="./css/main.css" rel="stylesheet" type="text/css">
</head>

<body style="background: rgb(255, 255, 255);">
<header>
  <div class="nav"> <a  onclick="window.location.href='../testGetInMenu?shopId=<%=menu.get("shopId") %>'" class="back">&nbsp;&nbsp;&nbsp;&nbsp;</a>
    <h1>我的已点菜单</h1>
  </div>
</header>
<section class="wrap"> 
  <!--Has ordered a dish css start-->
  <div class="has_num">您已经点了&nbsp;<strong class="num"><%=number_items %></strong>&nbsp;道产品</div>
  
  <div class="has_list">
    <ul>
<%
it = items.iterator();
while (it.hasNext()) {
	JSONObject oneItem = (JSONObject) it.next();
	Double showPrice = oneItem.getDouble("price");
	if(ifVip){
		showPrice = oneItem.getDouble("vipPrice");
	}
	if(oneItem.getInt("number") > 0){
%>
	<li>
        <div class="has_con">
          <h3><%=oneItem.get("itemName") %></h3>
          <p>￥<span class=" price_num"><%=showPrice %></span></p>
        </div>
        <div class="num_change"><a href="javascript:" class="add_btn2" onclick="orderAdd('<%=oneItem.get("itemId") %>')"></a><span id="amount_<%=oneItem.get("itemId") %>"><%=oneItem.getInt("number") %></span><a href="javascript:" class="plus_btn" onclick="orderSub('<%=oneItem.get("itemId") %>')"></a></div>
	</li>
<%
	}	
}
%>
    </ul>
  </div>
  
  <div class="count">
  <p>您点了 <%=number_items %> 点道产品</p>
  <p class=" total_box">总价：<strong class="total_price" id="totalMoney">￥0.0</strong></p>
  </div>
  <div class="btn_box3">
  <!--
  <p style="padding:0 .5em 2.75em .5em"><input type="button" name="" value="提 交" onclick="submitConfirmOrder()" class="btn"/></p>
  -->
  <span style="padding:0 .5em 3.75em .5em"><input type="button" name="" value="重新点餐" class="btn3" onclick="window.location.href='../testGetInMenu?shopId=<%=menu.get("shopId") %>'"></span>
  <span style="padding:0 .5em 3.75em .5em"><input type="button" name="" id="submitBtn" value="确认提交" class="btn3" onclick="submitConfirmOrder()"></span>
 
  </div>
  
  <!--Has ordered a dish css end--> 
</section>

<footer> 
  <!--tab nav-->
 <!--
  <div class="tab_nav">
    <ul>
      <li><a href="order_dishes.jsp?takeOut=0&commTenaId=32&tagIndex=0&classId=">
	      <span class="tab_icon01">点菜</span></a></li>
      <li class="current"><a href="#"><span class="tab_icon02">已点</span></a></li>
      <li><a href="index.jsp?commTenaId=32"><span class="tab_icon03">首页</span></a></li>
      <li><a href="my_order1.jsp?commTenaId=32"><span class="tab_icon04">订单</span></a></li>
      <li><a href="vip.jsp?commTenaId=32"><span class="tab_icon05">我</span></a></li>
    </ul>
  </div>
-->

	<!--tab nav-->
    <!--
	<div class="tab_nav3">
		<ul>
			<li><a
				href="pre_order.jsp?takeOut=0&commTenaId=32&tagIndex=1&classId="><span
					class="tab_icon01">我要点菜</span></a></li>
			<li class="current"><a href="#"><span
					class="tab_icon02">我的购物车</span></a></li>
			<li><a href="pre_my_order.jsp?commTenaId=32"><span class="tab_icon04">我的订单</span></a></li>
		</ul>
	</div>
    -->
  <div class="footer_bar3">
  	<ul>
    	<li><a  onclick="window.location.href='../testGetInMenu?shopId=<%=menu.get("shopId") %>'"><span class="tab_nav31">我要点单</span></a></li>
        <li><a  class="current"><span class="tab_nav32">购物车</span></a></li>
        <li><a href="../我的订单/wodedingdan.jsp?userId=<%=menu.getString("openid") %>"><span class="tab_nav33">我的订单</span></a></li>
    </ul>
  </div>
</footer>

<form action="../WorkOrderServlet" method="post" style="display:none" id="sendForm">
	<input id="sendInput" name="sendInput" />
</form>

<script src="./js/jquery-1.10.1.min.js" type="text/javascript"></script> 
<script type="text/javascript">
var totalMoney = 0.0;
calculatorAll();
function orderSub(goodsId){
	var amount = Number($('#amount_'+goodsId).text());
	if(amount==0){
		return;
	}
	amount = amount -1;
	if(amount<0){
		amount = 0;
	}
	submitOrder(goodsId,amount);
	calculatorAll();
}
	
function orderAdd(goodsId){
	var amount = Number($('#amount_'+goodsId).text());
	amount = amount +1;
	submitOrder(goodsId,amount);
	calculatorAll();
}	
//在sendMenu 中添加数值
function submitOrder(goodsId,amount){
	$('#amount_'+goodsId).text(amount);
	
	for(var oneJson in menu.items){
	   	if(menu.items[oneJson].itemId == goodsId){
	   		menu.items[oneJson].number = parseInt($('#amount_'+goodsId).text());
	   		//console.log(parseInt($('#orderAmount').text()));
	   	}
    }
}

function submitConfirmOrder(){
/*	var url = "/newMenu/wechat/pre_confirm.jsp";
	if("1"=="0"){
		url = "/newMenu/wechat/single_confirm.jsp";
	}
	window.location.href = "";
*/
	if(totalMoney <= 0){
		alert("您还未点餐!");
		return ;
	}
	var sendMess = {
		'type':'userUpload',
		'content':menu
	}
	document.getElementById("sendInput").value = JSON.stringify(sendMess);
	document.getElementById("sendForm").submit();
	
}
function calculatorAll(){
	totalMoney = 0.0;
	var useType = "price";
	if(menu.ifVip == "true"){
		useType = "vipPrice";
	}
	for(var oneJson in menu.items){
	   	if(menu.items[oneJson].number > 0){
	   		totalMoney += menu.items[oneJson][useType] * menu.items[oneJson].number;
	   	}
    }
    document.getElementById("totalMoney").innerHTML = "￥" + totalMoney;
    console.log(totalMoney);
}
</script>
<script type="text/javascript" src="../my_js/json2.js"></script>
</body></html>