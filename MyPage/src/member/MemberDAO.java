package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Pattern;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	String sql="";
	
	// DB연결
	private Connection getConnection() {
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource) init.lookup("java:comp/env/MySQL/mydb");
			con = ds.getConnection();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return con;
	}
	
	// 회원가입
	public void insertMember(MemberBean mb) {
		
		try {
			con = getConnection();
			
			sql = "insert into member(id, pass, name, reg_date, age, gender, email, address, phone, mobile) "
					+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			
			ps = con.prepareStatement(sql);
			ps.setString(1, mb.getId());
			ps.setString(2, mb.getPass());
			ps.setString(3, mb.getName());
			ps.setTimestamp(4, mb.getReg_date());
			ps.setInt(5, mb.getAge());
			ps.setString(6, mb.getGender());
			ps.setString(7, mb.getEmail());
			ps.setString(8, mb.getAddress());
			ps.setString(9, mb.getPhone());
			ps.setString(10, mb.getMobile());
			
			ps.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(con!=null) con.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	// 아이디 중복확인
	public int dupIdCheck(String id) {
		// 아이디
		// 5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.
		String id_reg = "^[a-z][a-z0-9_-]{4,19}$";	// 아이디 정규표현식
		int check = 1;	// 중복없으면 1, 중복이면 -1
		try {
			con = getConnection();
			sql = "select id from member where id = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			
			if(rs.next()) {	// 아이디 중복
				check = -1;
			}else {	// 중복없음
				if(id.matches(id_reg)){	// 정규표현식에 맞으면
					check = 1;
				}else {	// 정규표현식에 맞지 않으면
					check = -1;
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(con!=null) con.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return check; 
	}
	
	// 로그인 인증
	public CheckResult idCheck(String id, String pass) {
		
		CheckResult cr = new CheckResult();
		String name = "";
		
		try {
			con = getConnection();
			
			sql = "select pass, name from member where id = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			
			rs = ps.executeQuery();
			
			if(rs.next()) {	// 아이디 있음
				if(pass.equals(rs.getString("pass")))	{	// 비밀번호 맞음
					name = rs.getString("name");
					cr.setCheck(1);
					cr.setName(name);
				}
				else {	// 비밀번호 틀림
					cr.setCheck(0);
					cr.setName("");
				}
			}else {	// 아이디 없음
				cr.setCheck(-1);
				cr.setName("");
			}	
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(con!=null) con.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return cr;
	}
	
	// 회원정보 반환
	public MemberBean getInfo(String id) {
		MemberBean mb = new MemberBean();
		try {
			con = getConnection();
			sql = "select * from member where id = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			
			if(rs.next()) {	// 아이디 있음
				mb.setId(rs.getString("id"));
				mb.setPass(rs.getString("pass"));
				mb.setName(rs.getString("name"));
				mb.setReg_date(rs.getTimestamp("reg_date"));
				mb.setAge(rs.getInt("age"));
				mb.setGender(rs.getString("gender"));
				mb.setEmail(rs.getString("email"));
				mb.setAddress(rs.getString("address"));
				mb.setPhone(rs.getString("phone"));
				mb.setMobile(rs.getString("mobile"));
			}else {	// 아이디 없음
				return mb;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(con!=null) con.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return mb;
	}

	// 회원정보 수정
	public void updateInfo(MemberBean mb) {
		try {
			con = getConnection();
			sql = "update member set name=?, age=?, gender=?, email=?, address=?, phone=?, mobile=? where id = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, mb.getName());
			ps.setInt(2, mb.getAge());
			ps.setString(3, mb.getGender());
			ps.setString(4, mb.getEmail());
			ps.setString(5, mb.getAddress());
			ps.setString(6, mb.getPhone());
			ps.setString(7, mb.getMobile());
			ps.setString(8, mb.getId());
				
			ps.executeUpdate();
			
			}catch(Exception e) {
				e.printStackTrace();
			}finally{
				try {
					if(rs!=null) rs.close();
					if(ps!=null) ps.close();
					if(con!=null) con.close();
				}catch(SQLException e) {
					e.printStackTrace();
				}
			}
		}

	// 비밀번호 변경
	public int changePass(String id, String pass, String newPass) {
		int check = -1;
		
		try {
			con = getConnection();
			
			// 비밀번호 확인
			sql = "select pass from member where id=?";
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			
			if(rs.next()) {	// 아이디 있음
				if(pass.equals(rs.getString("pass"))) {	// 비밀번호 맞음
					check = 1;
					
					sql = "update member set pass = ? where id = ?";
					ps = con.prepareStatement(sql);
					ps.setString(1, newPass);
					ps.setString(2, id);
					
					ps.executeUpdate();
				
				}else {	// 비밀번호 틀림
					check = 0;
				}
			}else {	// 아이디 없음
				check = -1;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(con!=null) con.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return check;
	}
	
	// 회원탈퇴
	public int deleteMember(String id, String pass) {
		int check = -1;
		try {
			con = getConnection();
			// 비밀번호 확인 
			sql = "select pass from member where id = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			if(rs.next()) {	// 아이디 있음
				if(pass.equals(rs.getString("pass"))) {	// 비밀번호 맞음
					check = 1;
					sql = "delete from member where id = ?";
					ps = con.prepareStatement(sql);
					ps.setString(1, id);
					ps.executeUpdate();
					
				}else {	// 비밀번호 틀림
					check = 0;
				}
			}else {	// 아이디 없음
				check = -1;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(con!=null) con.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return check;
	}
	
}
































