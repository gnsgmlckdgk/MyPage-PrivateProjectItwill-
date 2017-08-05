<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FunWeb - Member</title>

<script type="text/javascript" src="script/formInspect.js">
</script>

<link href="../css/default.css?ver=16" rel="stylesheet" type="text/css">
<link href="../css/subpage.css?ver=11" rel="stylesheet" type="text/css">

<!-- 추가해서 넣은 css -->
<link href="../css/background_image.css?ver=12" rel="stylesheet" type="text/css">
<link href="../css/member.css?ver=14" rel="stylesheet" type="text/css" >

<style type="text/css">
/* 필수정보 알림 */
	.essential {
		/* border: 1px solid red; */
		color: red;
		margin-bottom: 10px;
	}
	#pass {
		display: none;
	}
	
/* 설명문 */
	.desc {
		color: green;
	}
	#desc_pass {
		display: none;
	}
	#desc_Npass {
		display: none;
	}
	#desc_Npass2 {
		display: none;
	}
</style>

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
		<h1>비밀번호 변경</h1>
		<form action="updatePassPro.jsp" id="join" method="post" name="fr" onsubmit = "return checkNewPassOvallall();">
			<fieldset>
				<legend>Password change</legend>
				<table>
					<tr>
						<th>아이디</th>
						<td><input type="text" name="id" value="<%=id %>" readonly="readonly"></td>
					</tr>

					<tr>
						<th rowspan="2">현재 비밀번호</th>
						<td><input type="password" name="pass" onblur="checkNewPass();" ></td>
					</tr>
					<tr>
						<td>	
							<span class = "essential" id="pass"> * 필수정보 입니다.</span><br>
							<span class = "desc" id="desc_pass"> - 6~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.</span>
						</td>
					</tr>

					<tr>
						<th rowspan="2">새 비밀번호</th>
						<td><input type="password" name="newPass" onblur="checkNewPass2();"></td>
					</tr>
					<tr>
						<td>
							<span class = "desc" id="desc_Npass"><br> - 6~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.</span>
						</td>
					</tr>

					<tr>
						<th rowspan="2">새 비밀번호 확인</th>
						<td><input type="password" name="newPass2" onblur="checkNewPass3();"></td>
					</tr>
					<tr>
						<td>	
							<span class = "desc" id="desc_Npass2"><br> - 비밀번호가 일치하지 않습니다.</span>
						</td>
					</tr>
				</table>
			</fieldset>
		<div id="buttons">
			<input type="submit" value="변경" class="submit">
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