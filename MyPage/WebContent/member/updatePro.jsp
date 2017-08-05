<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<h1>updatePro.jsp</h1>
	
	<%
	// 한글처리
	request.setCharacterEncoding("UTF-8");
	
	// 세션값 가져오기
	String id = (String)session.getAttribute("id");
	if(id==null) {
		response.sendRedirect("login.jsp");
	}
	
	// 세션값 재정의(이름)
	session.setAttribute("name", request.getParameter("name"));
	
	// 파라미터 값 가져오기
	%>
	<jsp:useBean id="mb" class="member.MemberBean"/>
	<jsp:setProperty property="*" name="mb"/>
	<%
	mb.setId(id);
	
	// 수정 DB작업
	MemberDAO mdao = new MemberDAO();
	mdao.updateInfo(mb);
	%>
	<script type="text/javascript">
	alert("수정완료");
	location.href="info.jsp";
	</script>
</body>
</html>