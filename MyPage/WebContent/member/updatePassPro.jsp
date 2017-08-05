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

	<h1>updatePassPro.jsp</h1>

	<%
	// 한글처리
	request.setCharacterEncoding("UTF-8");
	
	// 파라미터 값 가져오기
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	String newPass = request.getParameter("newPass");
	
	// DB작업
	MemberDAO mdao = new MemberDAO();
	int check = mdao.changePass(id, pass, newPass);
	
	if(check == 1) {
		// 로그아웃 하고 다시 로그인 시킴
		session.invalidate();
		%>
		<script type="text/javascript">
		alert("비밀번호 변경 완료");
		location.href="login.jsp";
		</script>
		<%
	}else if(check == 0) {
		%>
		<script type="text/javascript">
		alert("비밀번호가 맞지 않습니다.");
		history.back();
		</script>
		<%
	}else if(check == -1) {
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