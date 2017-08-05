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
<link href="../css/background_image.css?ver=12" rel="stylesheet"
	type="text/css">
<link href="../css/member.css?ver=14" rel="stylesheet" type="text/css">

<!-- 스크립트 -->
<!-- 우편번호 검색 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?ver=100" type="text/javascript"></script>
<script type="text/javascript">

	/* 주소 변경 */
	function addr() {
		// 주소 입력됬으면 수정, 입력안됬으면 주소 수정안함
		var postAddr = document.getElementById("sample6_postcode").value;	// 우편번호
		var addr = document.getElementById("sample6_address").value;		// 주소
		var addr2 = document.getElementById("sample6_address2").value;	// 상세주소
		var address="";	// DB에 저장 될 최종 주소
		// 우편번호
		if(document.getElementById("sample6_postcode").value.length != 0) {
			postAddr="(우편번호)"+postAddr+"<br>";
			address = address+postAddr;
		}
		// 주소
		if(document.getElementById("sample6_address").value.length != 0) {
			addr = addr + " ";
			address = address+addr;
		}
		// 상세주소
		if(document.getElementById("sample6_address2").value.length != 0) {
			address = address + addr2;
		}
		// 주소수정란에 입력 됬으면
		if(address != "") {
			document.fr.address.value = address;
		}
	}

	/* 우편번호 검색 */
	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var fullAddr = ''; // 최종 주소 변수
						var extraAddr = ''; // 조합형 주소 변수

						// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							fullAddr = data.roadAddress;

						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							fullAddr = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
						if (data.userSelectedType === 'R') {
							//법정동명이 있을 경우 추가한다.
							if (data.bname !== '') {
								extraAddr += data.bname;
							}
							// 건물명이 있을 경우 추가한다.
							if (data.buildingName !== '') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
							fullAddr += (extraAddr !== '' ? ' (' + extraAddr
									+ ')' : '');
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
						document.getElementById('sample6_address').value = fullAddr;

						// 커서를 상세주소 필드로 이동한다.
						document.getElementById('sample6_address2').focus();
					}
				}).open();
	}

</script>

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
		String gender = mb.getGender();
		if (gender == null) {
			gender = "남";
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
		<h1>회원정보 수정</h1>
		<form action="updatePro.jsp" id="join" method="post" name="fr" onsubmit="return addr()" >
			<fieldset>
				<legend>
					[<%=id%>] Info
				</legend>
				<table>
					<tr>
						<th>이름</th>
						<td><input type="text" name="name" value="<%=mb.getName()%>"></td>
					</tr>

					<tr>
						<th>나이</th>
						<td><input type="text" name="age" value="<%=mb.getAge()%>"></td>
					</tr>

					<tr>
						<th>성별</th>
						<td><input type="radio" name="gender" value="남"
							<%if (gender.equals("남")) {%> checked="checked" <%}%>>남 <input
							type="radio" name="gender" value="여"
							<%if (gender.equals("여")) {%> checked="checked" <%}%>>여</td>
					</tr>

					<tr>
						<th>e-mail</th>
						<td><input type="text" name="email"
							value="<%=mb.getEmail()%>"></td>
					</tr>

					<tr>
						<th>주소</th>
						<td><input type="text" id="sample6_postcode" placeholder="우편번호"> 
							<input type="button" class="dup" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
							<input type="text" id="sample6_address" placeholder="주소"><br>
							<input type="text" id="sample6_address2" placeholder="상세주소">
							<input type="text" name="address" value="<%=mb.getAddress()%>" readonly="readonly"></td>
					</tr>

					<tr>
						<th>전화번호</th>
						<td><input type="text" name="phone"
							value="<%=mb.getPhone()%>"></td>
					</tr>

					<tr>
						<th>휴대폰번호</th>
						<td><input type="text" name="mobile"
							value="<%=mb.getMobile()%>"></td>
					</tr>
				</table>
			</fieldset>
			<div id="buttons">
				<input type="submit" value="수정" class="submit"> <input
					type="reset" value="되돌리기" class="cancel">
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