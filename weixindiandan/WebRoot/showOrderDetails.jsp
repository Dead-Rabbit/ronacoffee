<%@page import="dao.*"%>
<%@page import="entity.*" %>
<%@page import="Util.*" %>
<%@page import="net.sf.json.JSONArray" %>
<%@page import="net.sf.json.JSONObject" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String weichatId = request.getParameter("weichatId");
String orderId = request.getParameter("orderId");
WorkOrderDao workDao = new WorkOrderDao();
ShopDao shopDao = new ShopDao();
ItemDao itemDao = new ItemDao();
List<WorkOrders> workList = workDao.getWordOrderByOrder(orderId);
%>

<html lang="zh">
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><script type="text/javascript" src="./js/jquery.min.js"></script>

<meta name="description" content="罗纳咖啡-我的订单">
<meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<title>罗纳咖啡-订单详情</title>
<link href="./css/main.css" rel="stylesheet" type="text/css">
<link href="./css/main2.css" rel="stylesheet" type="text/css">
<link href="./css/pop.css" rel="stylesheet" type="text/css">

<style>
.xf-item{
  padding:.5rem .5rem .5rem 0.5rem;
  border-bottom:1px solid #e6e6e6;
}
</style>
<script src="./js/jquery-1.10.1.min.js" type="text/javascript"></script>
</head>

<body style="background: rgb(248, 248, 248);">
	<header>
		<div class="nav">
			<a href="./wodedingdan.jsp?weichatId=<%=weichatId %>" class="back">&nbsp;&nbsp;&nbsp;&nbsp;</a>
			<h1>订单详情</h1>
			
		</div>
	</header>
	
	<section class="wrap" style="margin-top:.5rem;">  
  <!--booking form start-->
  <div class="my_order">
<%
for(WorkOrders order : workList){
%>

    <div class="my_order_list">
      <p class="title_order_detail">订单日期：<%=TimeUtil.getTime(order.getCreateTime()) %></p>
      <ul>      
      	<li><span class="fl"><%=shopDao.getShopById(order.getShopId()).getShopName() %></span></li>
      	<li><span class="fl">订单编号：<b class="org_text"><%=order.getOrderId() %></b></span></li>
      	
      		<li><span class="fl">桌号：<b class="org_text"><%=order.getToken() %></b></span></li>

      		<li><span class="fl">支付方式：收银台支付</span></li>
      	
      	<li><span class="fl">消费金额：<%=order.getPrice() %>元</span></li>
     	<li hidden="hidden"><span class="fl">订单状态：<%=order.getIfBalance()?"已结算":"未结算" %></span></li>
     	<!-- <li><span class="fl">订单备注：</span></li> -->
      </ul>
      <div class="pay_detail">
          <h3>消费明细</h3>  
<%
JSONArray items = ItemsUtil.getItemsFItemsId(order.getItemIds());
Iterator<Object> it = items.iterator();
while (it.hasNext()) {
	JSONObject one = (JSONObject) it.next();
 %>		
		      	<div class="xf-item clearfix">
			     <div class="htitle"><%=itemDao.getItemById(one.getString("itemId")).getItemName() %></div>
		      	  <span class="htitle_nav" style="padding-right:20px;">单价<b class="org_text">￥<%=one.getString("price") %></b></span>
		      	  <span class="htitle_nav" style="">数量:<b><%=one.getString("number") %></b></span>
		      	  <span class="htitle_nav" style="float:right;">小计<b class="org_text">￥<%=Float.parseFloat(one.getString("price"))*Integer.parseInt(one.getString("number")) %></b></span>
		        </div>
<% 
}
%>
                <div class="clearfix" style="padding-right:.5rem;padding-top:.8rem;padding-bottom:.8rem;">
		      	  <span style="float:right;">总价：<b class="org_text">￥<%=order.getPrice() %></b></span>
		        </div>
      </div>
    </div>
<%
}
 %>
  </div>
  <br>
  <!--booking form end--> 
</section>
    <!--
	<footer style="margin-top:4rem;">
	-->
		<!--tab nav-->
		<!--
		<div class="tab_nav">
			<ul>
				<li><a
					href="order_dishes.jsp?commTenaId=32"><span
						class="tab_icon01">点菜</span></a></li>
				<li><a href="has_list.jsp?commTenaId=32"><span
						class="tab_icon02">已点</span></a></li>
				<li><a href="index.jsp?commTenaId=32"><span
						class="tab_icon03">首页</span></a></li>
				<li class="current"><a href="my_order1.jsp?commTenaId=32"><span class="tab_icon04">订单</span></a></li>
				<li><a href="my_data.jsp?commTenaId=32"><span
						class="tab_icon05">我</span></a></li>
			</ul>
		</div>
	</footer>
	-->
	
	<script src="./js/jquery-1.10.1.min.js" type="text/javascript"></script>


</body></html>