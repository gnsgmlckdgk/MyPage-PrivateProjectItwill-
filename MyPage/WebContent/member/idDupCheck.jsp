<%@page import="java.util.regex.Pattern"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FunWeb - Join</title>
<script type="text/javascript">

	// join.jsp로 값 옮기고 창 닫기
	function return_join(check) {
		if(check == 1){
			opener.document.fr.id.value = document.wfr.id.value;
			window.close();
		} else {
			opener.document.fr.id.value = "";
			opener.document.fr.id.focus();
			window.close();
		}
	}
	
</script>

<style type="text/css">
	div {
		width: 340px;
		height: 140px;
		position: relative;
	}
	
	form {
		float: left;
		position: absolute;
		left: 40px;
	}

	#label {
		font-size: 20px;
		font-family: "맑은고딕", sans-serif;
		font-weight: bold;
		color: #0100FF;
	}

	.id_f {
		background-color: #FFFFD2;
		width: 180px;
		height: 20px;
		font-size: 18px;
	}
	
	.desc {
		font-size: 1.2em;
		font-family: "맑은고딕", sans-serif;
		font-weight: bold;
		color: green;
	}

</style>

</head>
<body>
	<%
	// 한글처리
	request.setCharacterEncoding("UTF-8");
	
	// 파라미터 값 받기
	String id = request.getParameter("id");
	if(id==null) {
		id = "";
	}
	// 중복확인
	MemberDAO mdao = new MemberDAO();
	int check = mdao.dupIdCheck(id);
	%>
	
	<!-- 아이디 중복확인 -->
	<div>
	<form action="idDupCheck.jsp" method="post" name="wfr">
	<label id="label">ID </label><input type="text" name="id" value="<%=id %>" class="id_f"> 
	<input type="submit" value="중복확인" class="btn" ><br>
	
	<%
	if(check==-1) {	// 아이디 중복인 경우
		%>
		<span class="desc"> - 사용 불가능한 아이디 입니다.<br></span>
		<%
	}else if(check == 1) {
		%>
		<span class="desc"> - 사용 가능한 아이디 입니다.<br></span>
		<%
	}
	%>
	
	<input type="button" value="확인" class="btn" onclick="return_join(<%=check %>)" >
	</form>
	</div>
	
	
</body>
</html>