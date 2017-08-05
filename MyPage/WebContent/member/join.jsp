<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FunWeb - Join</title>
<link href="../css/default.css?ver=16" rel="stylesheet" type="text/css">
<link href="../css/subpage.css?ver=11" rel="stylesheet" type="text/css">

<!-- 추가해서 넣은 css -->
<link href="../css/background_image.css?ver=12" rel="stylesheet"
	type="text/css">
<link href="../css/member.css?ver=13" rel="stylesheet" type="text/css">
<style type="text/css">

/* 필수정보 알림 */
.essential { color: red; margin-bottom: 10px; }
#id { display: none; }
#pass {	display: none; }
#name {	display: none; }
#age { display: none; }
#gender { display: none; }
#email { display: none; }

/* 폼 설명문 */
.desc {	color: green; }
#desc_id { display: none; }
#desc_pass { display: none; }
#desc_pass2 { display: none; }
#desc_age { display: none; }
#desc_email2 { display: none; }

/* 이메일 뒷부분 콤보박스 */
select { font-size: 1.2em; padding-bottom: 7px; }
/* 주소 입력창 */
#sample6_postcode { /* 우편번호 입력란 */
	width: 100px; }
#sample6_address, #sample6_address2 {	/* 주소, 상세주소 입력란 */
	position: relative;
	left: 140px; }

</style>

<!-- 스크립트 -->
<!-- 우편번호 검색 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?ver=100"
	type="text/javascript"></script>
<!-- 회원가입 제약사항 -->
<script type="text/javascript" src="script/formInspect.js?ver=2">
</script>

<script type="text/javascript">
	//아이디 중복 확인
	function idCheck() {
	var id = document.fr.id.value;
	window.open('idDupCheck.jsp?id=' + id, 'popup', 'width=' + (400)
			+ ',height=' + 200 + ',top=150,left=600');
	}

	// 이메일 콤보박스
	function selectEvent() {
		var str = document.fr.email_sel.value; // 선택된 옵션의 value 값
		document.fr.email2.value = str;
	}

	// 우편번호 검색
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
				<li><a href="terms.jsp">회원가입</a></li>
			</ul>
		</nav>
		<!-- 왼쪽메뉴 -->
		<!-- 본문내용 -->
		<article>
			<h1>Join Us</h1>
			<form action="joinPro.jsp" id="join" method="post" name="fr"
				onsubmit="return joinInspect();">
				<fieldset id="join_jsp">
					<legend>Basic Info</legend>

					<!-- 아이디 -->
					<label>아이디</label> <input type="text" name="id" class="id"
						maxlength="20" readonly="readonly" placeholder="중복확인 버튼을 눌러주세요."> <input
						type="button" value="중복확인" class="dup" onclick="idCheck()">
					<span class="essential" id="id"> * 필수정보 입니다.</span>
					<!-- 설명문 -->
					<span class="desc" id="desc_id"> <br> - 5~20자의 영문 소문자,
						숫자와 특수기호(_),(-)만 사용 가능합니다.
					</span><br>

					<!-- 비밀번호 -->
					<label>비밀번호</label> <input type="password" name="pass"
						maxlength="16" onblur="descForm_pass();"> <span
						class="essential" id="pass"> * 필수정보 입니다.</span> <span class="desc"
						id="desc_pass"><br> - 6~16자 영문 대소문자, 숫자, 특수문자를 사용하세요.</span><br>
					<!-- 비밀번호 확인 -->
					<label>비밀번호 확인</label> <input type="password" name="pass2"
						maxlength="16" onblur="descForm_pass2();"> <span
						class="desc" id="desc_pass2"><br> - 비밀번호가 일치하지 않습니다.</span><br>

					<!-- 이름 -->
					<label>이름</label> <input type="text" name="name"> <span
						class="essential" id="name"> * 필수정보 입니다.</span><br>

					<!-- 나이 -->
					<label>나이</label> <input type="text" name="age"
						onblur="descForm_age();"> <span class="essential" id="age">
						* 필수정보 입니다.</span> <span class="desc" id="desc_age"><br> -
						숫자만 입력가능합니다.(음수X)</span><br>

					<!-- 성별 -->
					<label>성별</label> <input type="radio" name="gender" value="남"
						checked="checked">남 <input type="radio" name="gender"
						value="여">여<br>
					<br>

					<!-- E-mail -->
					<label>E-Mail</label> <input type="text" name="email"
						style="width: 180px;">@ <input type="text" name="email2"
						style="width: 100px;"> <select name="email_sel"
						onchange="selectEvent()">
						<option value="">직접입력</option>
						<option value="naver.com">네이버</option>
						<option value="daum.net">다음</option>
						<option value="gmail.com">구글</option>
					</select> <input type="button" value="인증번호 보내기" class="dup"
						onclick="emailCert()"> <input type="text"
						name="email_cert" value="" placeholder="인증번호 입력"
						style="margin-left: 20px; width: 100px;"> <br>
					<span class="essential" id="email"> * 필수정보 입니다.</span><br>
				</fieldset>

				<fieldset>
					<legend>Optional</legend>
					<label>주소</label> 
					<input type="text" id="sample6_postcode" placeholder="우편번호">
					<input type="button" class="dup" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
					<input type="text" id="sample6_address" placeholder="주소"><br>
					<input type="text" id="sample6_address2" placeholder="상세주소">
					<input type="hidden" name="address"><br>
					
					<label>집 전화번호</label> <input type="text" name="phone"><br>
					<label>휴대 전화번호</label> <input type="text" name="mobile"><br>
				</fieldset>
				<div class="clear"></div>
				<div id="buttons">
					<input type="submit" value="가입" class="submit"> 
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