package notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class NoticeDAO {
	
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	String sql = "";
	
	// DB연결
	public Connection getConnection() {
		
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource) init.lookup("java:comp/env/MySQL/mydb");
			con = ds.getConnection();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return con;
	}
	
	// 공지글 작성(DB저장)
	public void insertNotice(NoticeBean nb) {
		
		int num = 0;
		
		try {
			con = getConnection();
			
			// 글번호 구하기
			sql="select MAX(num) as max from notice";
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {	// 게시글이 있으면
				num = rs.getInt("max") + 1;
			}
			
			// 글 저장
			sql="insert into notice(num, name, pass, subject, content, readcount, re_ref, re_lev, re_seq, date, ip, file) "
					+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?, ?)";
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);
			ps.setString(2, nb.getName());
			ps.setString(3, nb.getPass());
			ps.setString(4, nb.getSubject());
			ps.setString(5, nb.getContent());
			ps.setInt(6, 0);	// 조회수
			ps.setInt(7, num);	// 답글 그룹번호
			ps.setInt(8, 0);	// 답글 래밸(들여쓰기)
			ps.setInt(9, 0);	// 몇번째 답글인지(답글 순서)
			ps.setString(10, nb.getIp());
			ps.setString(11, nb.getFile());
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

	// 전체 게시글 수 반환
	public int getCount() {
		
		int count = 0;
		try {
			con = getConnection();
			
			sql = "select count(*) as count from notice";
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("count");
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
		return count;
	}
	
	// 전체 게시글 수 반환(검색)
	public int getCount(String search) {
			
			int count = 0;
			try {
				con = getConnection();
				
				sql = "select count(*) as count from notice where subject like ?";
				ps = con.prepareStatement(sql);
				ps.setString(1, "%"+search+"%");
				rs = ps.executeQuery();
				
				if(rs.next()) {
					count = rs.getInt("count");
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
			return count;
		}
	
	// 공지글 리스트 반환
	public List<NoticeBean> getNoticeList(int startRow, int pageSize) {
	
		List<NoticeBean> list = new ArrayList<NoticeBean>();
		try {
			con = getConnection();
			
			sql = "select * from notice order by re_ref desc, re_seq asc limit ?, ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, startRow-1);
			ps.setInt(2, pageSize);
			rs = ps.executeQuery();
			
			NoticeBean nb = null;
			while(rs.next()) {
				nb = new NoticeBean();
				
				nb.setNum(rs.getInt("num"));
				nb.setName(rs.getString("name"));
				nb.setPass(rs.getString("pass"));
				nb.setSubject(rs.getString("subject"));
				nb.setContent(rs.getString("content"));
				nb.setReadcount(rs.getInt("readCount"));
				nb.setRe_ref(rs.getInt("re_ref"));
				nb.setRe_lev(rs.getInt("re_lev"));
				nb.setRe_seq(rs.getInt("re_seq"));
				nb.setDate(rs.getDate("date"));
				nb.setIp(rs.getString("ip"));
				nb.setFile(rs.getString("file"));
				
				list.add(nb);
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
		return list;
	}

	// 공지글 리스트 반환(검색)
	public List<NoticeBean> getNoticeList(int startRow, int pageSize, String search) {
		
			List<NoticeBean> list = new ArrayList<NoticeBean>();
			try {
				con = getConnection();
				
				sql = "select * from notice where subject like ? order by re_ref desc, re_seq asc limit ?, ?";
				ps = con.prepareStatement(sql);
				ps.setString(1, "%"+search+"%");
				ps.setInt(2, startRow-1);
				ps.setInt(3, pageSize);
				rs = ps.executeQuery();
				
				NoticeBean nb = null;
				while(rs.next()) {
					nb = new NoticeBean();
					
					nb.setNum(rs.getInt("num"));
					nb.setName(rs.getString("name"));
					nb.setPass(rs.getString("pass"));
					nb.setSubject(rs.getString("subject"));
					nb.setContent(rs.getString("content"));
					nb.setReadcount(rs.getInt("readCount"));
					nb.setRe_ref(rs.getInt("re_ref"));
					nb.setRe_lev(rs.getInt("re_lev"));
					nb.setRe_seq(rs.getInt("re_seq"));
					nb.setDate(rs.getDate("date"));
					nb.setIp(rs.getString("ip"));
					nb.setFile(rs.getString("file"));
					
					list.add(nb);
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
			return list;
		}
	
	// 조회수 증가
	public void updateReadCount(int num) {
		
		try {
			con = getConnection();
			
			sql = "update notice set readcount = readcount+1 where num = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);
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
	
	
	// 공지글 반환
	public NoticeBean getNotice(int num) {
		
		NoticeBean nb = new NoticeBean();
		try {
			con = getConnection();
			
			sql = "select * from notice where num = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				nb.setNum(rs.getInt("num"));
				nb.setName(rs.getString("name"));
				nb.setPass(rs.getString("pass"));
				nb.setSubject(rs.getString("subject"));
				nb.setContent(rs.getString("content"));
				nb.setReadcount(rs.getInt("readCount"));
				nb.setRe_ref(rs.getInt("re_ref"));
				nb.setRe_lev(rs.getInt("re_lev"));
				nb.setRe_seq(rs.getInt("re_seq"));
				nb.setDate(rs.getDate("date"));
				nb.setIp(rs.getString("ip"));
				nb.setFile(rs.getString("file"));
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
		return nb;
	}
	
	// 게시글 삭제
	public void deleteNotice(int num) {

		try {
			con = getConnection();
			
			sql = "delete from notice where num=?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);
			ps.executeUpdate();
		}
		catch(Exception e) {
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
	
	// 게시글 수정
	public void updateNotice(NoticeBean nb, int num) {
		
		try {
			con = getConnection();
			
			sql = "update notice set subject=?, name=?, file=?, content=?, ip=? where num=?";
			ps = con.prepareStatement(sql);
			ps.setString(1, nb.getSubject());
			ps.setString(2, nb.getName());
			ps.setString(3, nb.getFile());
			ps.setString(4, nb.getContent());
			ps.setString(5, nb.getIp());
			ps.setInt(6, num);
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
	
}









