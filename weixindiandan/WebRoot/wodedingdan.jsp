<%@page import="dao.ShopDao"%>
<%@page import="entity.WorkOrders"%>
<%@page import="dao.WorkOrderDao"%>
<%@page import="Util.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.util.Date"%>

<%
String weichatId = request.getParameter("weichatId");
System.out.println(weichatId);
WorkOrderDao workOrderDao = new WorkOrderDao();
ShopDao shopDao = new ShopDao();
List<WorkOrders> workList = workOrderDao.getWordOrderByOpenId(weichatId);
 %>
<html lang="zh">
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><script type="text/javascript" src="./js/jquery.min.js"></script>
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
</script>
<%
 %>

<meta name="description" content="罗纳咖啡,我的订单">
<meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<title>罗纳咖啡-我的订单</title>
<link href="./css/main.css" rel="stylesheet" type="text/css">
<link href="./css/main2.css" rel="stylesheet" type="text/css">
<link href="./css/pop.css" rel="stylesheet" type="text/css">
</head>

<body style="background: rgb(248, 248, 248);">
	<header>
		<div class="nav">
			<a href="./testGetInMenu" class="back">&nbsp;&nbsp;&nbsp;&nbsp;</a>
			<h1>我的预点订单</h1>
			
		</div>
		
		<div class="order_list">
		   <div class="move_box2">
		    <ul>
		      <li  style="width: 100%"><a href="#">我的订单</a></li>
<!-- 		      <li><a href="http://yun.menu123.cn/newMenu/wechat/pre_my_order.jsp?commTenaId=32&amp;his=1">历史订单</a></li> -->
		    </ul>
		    <div class="cur_bg" style="width: 160px; left: 0px;"></div>
		    </div>
	  </div>
  
	</header>
	<section class="wrap" style="margin-top:4rem;">  
<%
for(WorkOrders order : workList){
%>
    <div class="my_order_list" style="margin-top:1rem;margin-left:1rem;margin-right:1rem;">
      <p>订单日期： <%=TimeUtil.getTime(order.getCreateTime()) %></p>
      <ul>      
      	<li><span class="fl"><%=shopDao.getShopById(order.getShopId()).getShopName() %></span></li>
      	<li><span class="fl">订单编号：<a href="./showOrderDetails.jsp?orderId=<%=order.getOrderId() %>&weichatId=<%=weichatId %>"><b class="org_text"><%=order.getOrderId() %></b></a></span></li>
		<li><span class="fl">餐桌号码：<%=order.getToken() %></span></li>
      	<li><span class="fl">消费金额：<%=order.getPrice() %></span></li>
      	<!--  <li><span class="fl">使用特权：20元回馈老顾客代金券（2张）</span></li>-->
      	<li><span class="fl">订单状态：<%=order.getIfBalance()?"已结算":"未结算" %></span></li>
      </ul>
    </div>
<%
}
 %>					
		
	</section>

	<footer style="margin-top:4rem;">

	<!--footer_bar-->
	  <div class="footer_bar3">
		<ul>
			<li style="width: 50%;text-align: center;"><a href="./testGetInMenu"><span class="tab_nav31">我要点菜</span></a></li>

			<li style="width: 50%;text-align: center;"><a href="./wodedingdan.jsp?weichatId=<%=weichatId %>" class="current"><span class="tab_nav33">我的订单</span></a></li>
		</ul>
	  </div>
	</footer>
	<script src="./js/jquery-1.10.1.min.js" type="text/javascript"></script>
	<script>
		$(function(){
		
		var silderW = $(".order_list").outerWidth();
		console.log(silderW);
		$('.cur_bg').css('width',silderW).css('left',silderW);
		var sider = $(".order_list li").click(function(){
			var idx = 0;
			if(idx>=0){
				$('.cur_bg').animate({
					left:idx*silderW
				},500,function(){
					//alert(idx);
					
				})
			}
		})
		var curIdx = 0;
		$('.cur_bg').animate({
					left:curIdx*silderW
				},500,function(){
					//alert(curIdx);
					
				});
		});
    </script>
</body></html>