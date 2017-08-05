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

	<h1>deleteMemberPro.jsp</h1>

	<%
	// 한글처리
	request.setCharacterEncoding("UTF-8");
	
	// 파라미터 값 가져오기
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	
	MemberDAO mdao = new MemberDAO();
	int check = mdao.deleteMember(id, pass);
	if(check == 1) {
		session.invalidate();
		%>
		<script type="text/javascript">
		alert("<%=id %> 님의 회원탈퇴가 완료되었습니다.");
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