package mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

/* 인증클래스 */
class SMTPAuthenticator extends Authenticator {
 protected PasswordAuthentication getPasswordAuthentication() {
  String username = "dohauzi@gmail.com"; // gmail 사용자
  String password = "qwe21221";  // 패스워드
  return new PasswordAuthentication(username, password);
 }
}