<%@page import="member.CheckResult"%>
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

	<h1>loginPro.jsp</h1>

	<%
	// 한글처리
	request.setCharacterEncoding("UTF-8");
	
	// 파라미터 값 가져오기
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	
	// DB작업
	MemberDAO mdao = new MemberDAO();
	CheckResult cr = mdao.idCheck(id, pass);
	
	if(cr.getCheck() == 1) {
		session.setAttribute("id", id);				// 세션값 저장
		session.setAttribute("name", cr.getName());	// 세션값 저장
		%>
		<script type="text/javascript">
		location.href = "../main/main.jsp";
		</script>
		<%
	}else if(cr.getCheck() == 0) {
		%>
		<script type="text/javascript">
		alert("비밀번호가 맞지 않습니다.");
		history.back();
		</script>
		<%
	}else {
		%>
		<script type="text/javascript">
		alert("아이디가 존재하지 않습니다.");
		history.back();
		</script>
		<%
	}
	%>

</body>
</html>