<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>logout.jsp</h1>
	<%
	String id = (String) session.getAttribute("id");
	%>
	<script type="text/javascript">
	alert("<%=id %> 님 로그아웃 되었습니다.");
	</script>
	<%
	session.invalidate();	// 세션 종료
	%>
	<script type="text/javascript">
	location.href="login.jsp";
	</script>
	
</body>
</html>