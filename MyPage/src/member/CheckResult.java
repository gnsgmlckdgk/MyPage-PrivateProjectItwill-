package member;

//인증 값과 이름 담는 클래스
public class CheckResult {	
	int check;
	String name;
	CheckResult() { }
	CheckResult(int check, String name) {
		this.check = check;
		this.name = name;
	}
	public void setCheck(int check) { this.check = check; }
	public void setName(String name) { this.name = name; }
	public int getCheck() { return check; }
	public String getName() { return name; }
}