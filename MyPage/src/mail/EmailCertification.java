package mail;

import javax.mail.MessagingException;

public class EmailCertification {
	
	String inputEmail;
	
	public EmailCertification() {}
	public EmailCertification(String inputEmail) {
		this.inputEmail = inputEmail;
	}
	
	public void certification(String random) {
		String from = "dohauzi@gmail.com"; // 메일 보내는 사람
		String to = inputEmail; // 메일 받는사람
		String cc = "dohauzi@gmail.com"; // 참조
		String subject = "FunWeb 회원가입 인증번호";// 제목
		String content = "안녕하세요.\nFunWeb에서 발송하는 인증번호는 다음과 같습니다.\n인증번호: "+ random;// 내용

		if (from.trim().equals("")) {
			System.out.println("보내는 사람을 입력하지 않았습니다.");
		} else if (to.trim().equals("")) {
			System.out.println("받는 사람을 입력하지 않았습니다.");
		} else {
			try {
				MailTest mt = new MailTest(); // 메일보내는 설정 작업 및 보내는 클래스
				// 메일보내기
				mt.sendEmail(from, to, cc, subject, content);
				System.out.println("메일 전송에 성공하였습니다.");
			} catch (MessagingException me) {
				System.out.println("메일 전송에 실패하였습니다.");
				System.out.println("실패 이유 : " + me.getMessage());
			} catch (Exception e) {
				System.out.println("메일 전송에 실패하였습니다.");
				System.out.println("실패 이유 : " + e.getMessage());
			}
		}
	}
	
}



