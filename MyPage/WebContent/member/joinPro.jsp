<%@page import="member.MemberDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<h1>JoinPro.jsp</h1>
	
	<%
	// 한글처리
	request.setCharacterEncoding("UTF-8");
	
	// 파라미터 값 가져와서 빈 클래스로
	%>
	<jsp:useBean id="mb" class="member.MemberBean" />
	<jsp:setProperty property="*" name="mb"/>
	<%
	String email = request.getParameter("email") + "@" + request.getParameter("email2");
	mb.setEmail(email);
	
	// 가입 날짜 및 시간
	Timestamp reg_date = new Timestamp(System.currentTimeMillis());
	mb.setReg_date(reg_date);
	
	// DB작업
	MemberDAO mdao = new MemberDAO();
		// ID중복확인
		int check = mdao.dupIdCheck(mb.getId());
		if(check == -1) {	// 아이디가 중복될때
			%>
			<script type="text/javascript">
			alert("중복된 아이디가 있습니다.");
			history.back();
			</script>
			<%
		}else {
			// DB저장
			mdao.insertMember(mb);
			response.sendRedirect("login.jsp");
		}
	%>
	
</body>
</html>






