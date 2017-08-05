<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FunWeb - Member</title>
<link href="../css/default.css?ver=16" rel="stylesheet" type="text/css">
<link href="../css/subpage.css?ver=11" rel="stylesheet" type="text/css">

<!-- 추가해서 넣은 css -->
<link href="../css/background_image.css?ver=12" rel="stylesheet" type="text/css" >
<link href="../css/member.css?ver=14" rel="stylesheet" type="text/css" >

</head>
<body>
	<%
		// 한글처리
		request.setCharacterEncoding("UTF-8");

		// 세션값 가져오기
		String id = (String) session.getAttribute("id");
		if (id == null) { // 세션값 없으면 로그인 화면으로
			response.sendRedirect("login.jsp");
		}

		// 파라미터 값 가져오기
		MemberDAO mdao = new MemberDAO();
		MemberBean mb = mdao.getInfo(id);
	%>

	<!-- 회원정보 출력 -->
	<div id="wrap">
		<!-- 헤더들어가는 곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더들어가는 곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문메인이미지 -->
		<div id="sub_img_member"></div>
		<!-- 본문메인이미지 -->
		<!-- 왼쪽메뉴 -->
		<nav id="sub_menu">
		<ul>
			<li><a href="info.jsp">회원정보</a></li>
			<li><a href="updateInfo.jsp">회원정보 수정</a></li>
			<li><a href="updatePass.jsp">비밀번호 변경</a></li>
			<li><a href="deleteMember.jsp">회원탈퇴</a></li>
		</ul>
		</nav>
		<!-- 왼쪽메뉴 -->
		<!-- 본문내용 -->
		<article>
		<h1>회원정보</h1>
		<form action="loginPro.jsp" id="join" method="post" name="fr">
			<fieldset>
				<legend>My Info</legend>
				<table>
					<tr>
						<th>아이디</th>
						<td><%=mb.getId()%></td>
					</tr>
					<tr>
						<th>이름</th>
						<td><%=mb.getName()%></td>
					</tr>
					<tr>
						<th>나이</th>
						<td><%=mb.getAge()%></td>
					</tr>
					<tr>
						<th>성별</th>
						<td><%=mb.getGender()%></td>
					</tr>
					<tr>
						<th>e-mail</th>
						<td><%=mb.getEmail()%></td>
					</tr>
					<tr>
						<th>주소</th>
						<td><%=mb.getAddress()%></td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td><%=mb.getPhone()%></td>
					</tr>
					<tr>
						<th>휴대폰번호</th>
						<td><%=mb.getMobile()%></td>
					</tr>
					<tr>
						<th>가입날짜</th>
						<td><%=mb.getReg_date()%></td>
					</tr>
				</table>
		</fieldset>
		</form>
		</article>
		<!-- 본문내용 -->
		<!-- 본문들어가는 곳 -->

		<div class="clear"></div>
		<!-- 푸터들어가는 곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터들어가는 곳 -->
	</div>

</body>
</html>