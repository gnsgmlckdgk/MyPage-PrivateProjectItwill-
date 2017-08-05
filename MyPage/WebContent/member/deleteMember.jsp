<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
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
<link href="../css/background_image.css?ver=12" rel="stylesheet" type="text/css">
<link href="../css/member.css?ver=14" rel="stylesheet" type="text/css" >

<!-- 추가한 스크립트 -->
<script type="text/javascript">
	function deleteConfirm() {
		if(confirm("회원탈퇴를 하시겠습니까?")) {
			return true;
		}
		return false;
	}
	
</script>

</head>
<body>
	<%
	// 한글처리
	request.setCharacterEncoding("UTF-8");
	
	// 세션값 가져오기
	String id = (String)session.getAttribute("id");
	if(id == null) {	// 세션값 없으면 로그인 화면으로
		response.sendRedirect("login.jsp");
	}
	
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
		<h1>회원탈퇴</h1>
		<form action="deleteMemberPro.jsp" id="join" method="post" name="fr" onsubmit="return deleteConfirm()">
			<fieldset>
				<legend>Member secession</legend>
				<table>
					<tr>
						<th>아이디</th>
						<td><input type="text" name="id" value="<%=id %>" readonly="readonly"></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input type="password" name="pass" ></td>
					</tr>
				</table>
			
			</fieldset>

		<div id="buttons">
			<input type="submit" value="회원탈퇴" class="submit">
			<input type="reset" value="되돌리기" class="cancel">
		</div>
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