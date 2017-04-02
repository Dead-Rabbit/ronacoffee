<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%String ifVip = (String) request.getAttribute("ifVip");
String shopId = (String) request.getAttribute("shop");
if(ifVip.equals("true")){
	%>会员登录<%
}else{
	%>非会员登录<%
}
 %>
</body>
</html>