<%@page import="mail.EmailCertification"%>
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
	// 파라미터 값 가져오기
	String random = request.getParameter("random");
	String email = request.getParameter("email");
	if(email==null) {
		email = "dohauzi@gmail.com";
	}
	
	// 메일 보내기 객체 생성
	EmailCertification ecf = new EmailCertification(email);
	ecf.certification(random);
	
	// 닫기
	%>
	<script type="text/javascript">
	opener.alert("인증번호를 전송하였습니다.");
	window.close();
	</script>
</body>
</html>