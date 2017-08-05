<%@page import="image.ImageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	// 세션값 가져오기
	String id = (String)session.getAttribute("id");
	if(id == null) {
		response.sendRedirect("../member/login.jsp");
	}
	
	// 파라미터 값 가져오기
	String pageNum = request.getParameter("pageNum");
	int num = Integer.parseInt(request.getParameter("num"));
	
	// DB작업
	ImageDAO idao = new ImageDAO();
	idao.deleteBoard(num);
	
	// 이동
	response.sendRedirect("imageBoard.jsp?pageNum="+pageNum);
	
	%>
</body>
</html>
