
// 아이디
// 5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.

// 비밀번호
// 6~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.


// 가입 조건확인
function joinInspect() {
	var check = 1;
	/* 필수입력 */
	// 아이디
	if(document.fr.id.value.length == 0) {
		document.getElementById("id").style.display="inline";
		check = 0;
	}else {
		document.getElementById("id").style.display="none";
	}
	
	var id_reg = /^[a-z][a-zA-Z0-9_-]{4,19}$/m;	// 아이디 정규식
	if(id_reg.test(document.fr.id.value)!=true) {
		document.getElementById("desc_id").style.display = "inline";
		check = 0;
	}else {
		document.getElementById("desc_id").style.display = "none";
	}
	
	// 비밀번호
	if(document.fr.pass.value.length == 0) {
		document.getElementById("pass").style.display="inline";
		check = 0;
	}else {
		document.getElementById("pass").style.display="none";
	}
	
	var pass_reg = /^[a-zA-Z][a-zA-Z!@#$%^&*0-9_-]{5,15}$/m;	// 비밀번호 정규식
	if(pass_reg.test(document.fr.pass.value)!=true) {
		document.getElementById("desc_pass").style.display = "inline";
		check = 0;
	}else {
		document.getElementById("desc_pass").style.display = "none";
	}
	
	// 비밀번호 확인
	if(document.fr.pass.value != document.fr.pass2.value) {
		document.getElementById("desc_pass2").style.display = "inline";
		check = 0;
	}else {
		document.getElementById("desc_pass2").style.display = "none";
	}
	
	// 이름
	if(document.fr.name.value.length == 0) {
		document.getElementById("name").style.display="inline";
		check = 0;
	}else {
		document.getElementById("name").style.display="none";
	}
	
	// 나이
	if(document.fr.age.value.length == 0) {
		document.getElementById("age").style.display="inline";
		check = 0;
	}else {
		document.getElementById("age").style.display="none";
	}
	
	var age_reg = /[0-9]/g;	// 나이 정규식
	if(age_reg.test(document.fr.age.value)!=true || document.fr.age.value < 0) {
		document.getElementById("desc_age").style.display = "inline";
		check = 0;
	}else {
		document.getElementById("desc_age").style.display = "none";
	}
	
	// 이메일
	if(document.fr.email.value.length == 0) {
		document.getElementById("email").style.display="inline";
		check = 0;
	}else {
		document.getElementById("email").style.display="none";
	}
	
	// 이메일 인증
	if(document.fr.email_cert.value.length == 0) {	// 이메일 인증 번호가 입력이 안된 상태
		alert("이메일 인증이 필요합니다.");
		check = 0;
	}else if(document.fr.email_cert.value != random) {	// 인증번호가 틀린경우
		alert("인증번호가 일치하지 않습니다.");
		check = 0;
	}
	
	
	/* 선택입력 */
	// 주소
	var postAddr = document.getElementById("sample6_postcode").value;	// 우편번호
	var addr = document.getElementById("sample6_address").value;		// 주소
	var addr2 = document.getElementById("sample6_address2").value;	// 상세주소
	if(document.getElementById("sample6_postcode").value.length != 0) {
		postAddr="(우편번호)"+postAddr+"<br>";
	}
	document.fr.address.value = postAddr + addr + " " + addr2;
	
	// 집 전화번호
	if(document.fr.phone.value.length == 0) {
		document.fr.phone.value = " ";
	}
	
	// 휴대 전화번호
	if(document.fr.mobile.value.length == 0) {
		document.fr.mobile.value = " ";
	}
	
	if(check == 0) {
		return false;;
	}else {
		return true;
	}
}

// 인증번호 메일로 전송
var random = 0;	// 인증번호
function emailCert() {
	// 이메일 주소 입력 안했을때
	if(document.fr.email.value.length == 0 || document.fr.email2.value.length == 0) {
		alert("이메일 주소를 입력해주세요.");
		return;
	}
	
	// 난수생성 
	while(random==0) {
		random = Math.floor(Math.random() * 100000);	// 인증번호 난수(5자리)
	}
	// 이메일 전송
	var email = document.fr.email.value + "@" + document.fr.email2.value;	// 인증번호 받을 이메일 주소
	/*location.href="email_cert.jsp?random="+random+"&email="+email;*/
	window.open('email_cert.jsp?random='+random+"&email="+email,'popup','width='+(400)+',height='+200+',top=150,left=600');
}

// 폼 조건 설명(아이디)
function descForm_id() {
	// 아이디
	var id_reg = /^[a-z][a-zA-Z0-9_-]{4,19}$/m;	// 아이디 정규식
	if(id_reg.test(document.fr.id.value)!=true) {
		document.getElementById("desc_id").style.display = "inline";
	}else {
		document.getElementById("desc_id").style.display = "none";
	}
}

// 폼 조건 설명(비밀번호)
function descForm_pass() {
	// 비밀번호
	var pass_reg = /^[a-zA-Z][a-zA-Z!@#$%^&*0-9_-]{5,15}$/m;	// 비밀번호 정규식
	if(pass_reg.test(document.fr.pass.value)!=true) {
		document.getElementById("desc_pass").style.display = "inline";
	}else {
		document.getElementById("desc_pass").style.display = "none";
	}
}

// 폼 조건 설명(비밀번호 확인)
function descForm_pass2() {
	// 비밀번호 확인
	if(document.fr.pass.value != document.fr.pass2.value) {
		document.getElementById("desc_pass2").style.display = "inline";
	}else {
		document.getElementById("desc_pass2").style.display = "none";
	}
}

// 폼 조건 설명(나이)
function descForm_age() {
	// 나이
	var age_reg = /[0-9]/g;	// 나이 정규식
	if(age_reg.test(document.fr.age.value)!=true || document.fr.age.value < 0) {
		document.getElementById("desc_age").style.display = "inline";
	}else {
		document.getElementById("desc_age").style.display = "none";
	}
}

/* 비밀번호 변경 */
// 최종적으로 비밀번호 확인
function checkNewPassOvallall() {
	// 필수정보
	if(document.fr.pass.value.length == 0) {
		document.getElementById("pass").style.display="inline";
		check = 0;
		return false;
	}else {
		document.getElementById("pass").style.display="none";
	}
	// 설명문
	var pass_reg = /^[a-zA-Z][a-zA-Z!@#$%^&*0-9_-]{5,15}$/m;	// 비밀번호 정규식
	if(pass_reg.test(document.fr.pass.value)!=true) {
		document.getElementById("desc_pass").style.display = "inline";
		return false;
	}else {
		document.getElementById("desc_pass").style.display = "none";
	}
	
	/* 새 비밀번호 */
	// 설명문
	var pass_reg = /^[a-zA-Z][a-zA-Z!@#$%^&*0-9_-]{5,15}$/m;	// 비밀번호 정규식
	if(pass_reg.test(document.fr.newPass.value)!=true) {
		document.getElementById("desc_Npass").style.display = "inline";
		return false;
	}else {
		document.getElementById("desc_Npass").style.display = "none";
	}
	// 새 비밀번호 일치 여부
	if((document.fr.newPass.value == document.fr.newPass2.value) && document.fr.newPass.value != ""){	// 비밀번호가 일치할 때
		document.getElementById("desc_Npass2").style.display = "none";
	}else {	// 비밀번호가 일치하지 않을 때
		document.getElementById("desc_Npass2").style.display = "inline";
		return false;
	}
	
	// 현재 비밀번호랑 새 비밀번호랑 같은지
	if(document.fr.pass.value == document.fr.newPass.value) {	// 기존 비밀번호랑 새 비밀번호랑 같음
		alert("기존 비밀번호랑 동일합니다.");
		return false;
	}
	
	return true;
}

// 기존 비밀번호
function checkNewPass() {
	/* 비밀번호 */
	// 필수정보
	if(document.fr.pass.value.length == 0) {
		document.getElementById("pass").style.display="inline";
		check = 0;
		return false;
	}else {
		document.getElementById("pass").style.display="none";
	}
	// 설명문
	var pass_reg = /^[a-zA-Z][a-zA-Z!@#$%^&*0-9_-]{5,15}$/m;	// 비밀번호 정규식
	if(pass_reg.test(document.fr.pass.value)!=true) {
		document.getElementById("desc_pass").style.display = "inline";
		return false;
	}else {
		document.getElementById("desc_pass").style.display = "none";
	}

	return true;
}
// 새 비밀번호 조건 확인
function checkNewPass2() {
	/* 새 비밀번호 */
	// 설명문
	var pass_reg = /^[a-zA-Z][a-zA-Z!@#$%^&*0-9_-]{5,15}$/m;	// 비밀번호 정규식
	if(pass_reg.test(document.fr.newPass.value)!=true) {
		document.getElementById("desc_Npass").style.display = "inline";
	}else {
		document.getElementById("desc_Npass").style.display = "none";
	}
}
function checkNewPass3() {
	// 새 비밀번호 일치 여부
	if((document.fr.newPass.value == document.fr.newPass2.value) && document.fr.newPass.value != ""){	// 비밀번호가 일치할 때
		document.getElementById("desc_Npass2").style.display = "none";	
	}else {	// 비밀번호가 일치하지 않을 때
		document.getElementById("desc_Npass2").style.display = "inline";
	}
}

