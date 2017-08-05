package image;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ImageDAO {
	
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	String sql = "";
	
	private Connection getConnection() {
		
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/MySQL/mydb");
			con = ds.getConnection();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return con;
	}
	
	// 사진 게시판 작성
	public void insertImageBoard(ImageBean ib) {
		
		int num = 0;
		try {
			con = getConnection();
			
			// num의 값 구하기
			sql = "select max(num) as max from imageBoard";
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				num = rs.getInt("max") + 1;
			}
			
			// 글 저장
			sql = "insert into imageBoard(num, name, pass, subject, content, readcount, re_ref, re_lev, re_seq, date, ip, file, id) "
					+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?, ?, ?)";
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);
			ps.setString(2, ib.getName());
			ps.setString(3, ib.getPass());
			ps.setString(4, ib.getSubject());
			ps.setString(5, ib.getContent());
			ps.setInt(6, 0);	// 조회수
			ps.setInt(7, num);	// 그룹번호
			ps.setInt(8, 0);	// 들여쓰기 래밸
			ps.setInt(9, 0); 	// 답글 순서
			ps.setString(10, ib.getIp());
			ps.setString(11, ib.getFile());
			ps.setString(12, ib.getId());
			ps.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(ps != null) ps.close();
				if(con != null) con.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	// 게시글 갯수 구하기
	public int getCount() {
		
		int count = 0;
		try {
			con = getConnection();
			
			sql = "select count(*) as count from imageBoard";
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("count");
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(ps != null) ps.close();
				if(con != null) con.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return count;
	}

	// 게시글 갯수 구하기(검색)
	public int getCount(String search) {
		
		int count = 0;
		try {
			con = getConnection();
			
			sql = "select count(*) as count from imageBoard where subject like ?";
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
				if(rs != null) rs.close();
				if(ps != null) ps.close();
				if(con != null) con.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return count;
	}
	
	// 게시글 리스트 반환
	public List<ImageBean> getImageBoardList(int startRow, int pageSize) {
		
		List<ImageBean> list = new ArrayList<ImageBean>();
		
		try {
			con = getConnection();
			
			sql = "select * from imageBoard order by re_ref desc, re_seq asc limit ?, ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, startRow-1);
			ps.setInt(2, pageSize);
			rs = ps.executeQuery();
			
			ImageBean ib = null;
			while(rs.next()) {
				ib = new ImageBean();
				
				ib.setNum(rs.getInt("num"));
				ib.setName(rs.getString("name"));
				ib.setPass(rs.getString("pass"));
				ib.setSubject(rs.getString("subject"));
				ib.setContent(rs.getString("content"));
				ib.setReadcount(rs.getInt("readcount"));
				ib.setRe_ref(rs.getInt("re_ref"));
				ib.setRe_lev(rs.getInt("re_lev"));
				ib.setRe_seq(rs.getInt("re_seq"));
				ib.setDate(rs.getDate("date"));
				ib.setIp(rs.getString("ip"));
				ib.setFile(rs.getString("file"));
				ib.setId(rs.getString("id"));
				
				list.add(ib);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(ps != null) ps.close();
				if(con != null) con.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// 게시글 리스트 반환(검색)
		public List<ImageBean> getImageBoardList(int startRow, int pageSize, String search) {
			
			List<ImageBean> list = new ArrayList<ImageBean>();
			
			try {
				con = getConnection();
				
				sql = "select * from imageBoard where subject like ? order by re_ref desc, re_seq asc limit ?, ?";
				ps = con.prepareStatement(sql);
				ps.setString(1, "%"+search+"%");
				ps.setInt(2, startRow-1);
				ps.setInt(3, pageSize);
				rs = ps.executeQuery();
				
				ImageBean ib = null;
				while(rs.next()) {
					ib = new ImageBean();
					
					ib.setNum(rs.getInt("num"));
					ib.setName(rs.getString("name"));
					ib.setPass(rs.getString("pass"));
					ib.setSubject(rs.getString("subject"));
					ib.setContent(rs.getString("content"));
					ib.setReadcount(rs.getInt("readcount"));
					ib.setRe_ref(rs.getInt("re_ref"));
					ib.setRe_lev(rs.getInt("re_lev"));
					ib.setRe_seq(rs.getInt("re_seq"));
					ib.setDate(rs.getDate("date"));
					ib.setIp(rs.getString("ip"));
					ib.setFile(rs.getString("file"));
					ib.setId(rs.getString("id"));
					
					list.add(ib);
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				try {
					if(rs != null) rs.close();
					if(ps != null) ps.close();
					if(con != null) con.close();
				}catch(SQLException e) {
					e.printStackTrace();
				}
			}
			return list;
		}
	
	// 게시글 한개 반환
	public ImageBean getBoard(int num) {
		
		ImageBean ib = null;
		try {
			con = getConnection();
			
			sql = "select * from imageBoard where num = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				ib = new ImageBean();
				ib.setNum(rs.getInt("num"));
				ib.setName(rs.getString("name"));
				ib.setPass(rs.getString("pass"));
				ib.setSubject(rs.getString("subject"));
				ib.setContent(rs.getString("content"));
				ib.setReadcount(rs.getInt("readcount"));
				ib.setRe_ref(rs.getInt("re_ref"));
				ib.setRe_lev(rs.getInt("re_lev"));
				ib.setRe_seq(rs.getInt("re_seq"));
				ib.setDate(rs.getDate("date"));
				ib.setIp(rs.getString("ip"));
				ib.setFile(rs.getString("file"));
				ib.setId(rs.getString("id"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(ps != null) ps.close();
				if(con != null) con.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return ib;
	}
	
	// 조회수 증가
	public void updateReadCount(int num) {
		
		try {
			con = getConnection();
			
			sql = "update imageBoard set readcount=readcount+1 where num = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);
			
			ps.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(ps != null) ps.close();
				if(con != null) con.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	// 게시글 삭제
	public void deleteBoard(int num) {
		
		try {
			con = getConnection();
			
			sql = "delete from imageBoard where num = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);
			ps.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(ps != null) ps.close();
				if(con != null) con.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	// 게시글 수정
	public void updateBoard(ImageBean ib) {
		
		try {
			con = getConnection();
			
			sql = "update imageBoard set subject=?, name=?, file=?, content=?, ip=? where num = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, ib.getSubject());
			ps.setString(2, ib.getName());
			ps.setString(3, ib.getFile());
			ps.setString(4, ib.getContent());
			ps.setString(5,  ib.getIp());
			ps.setInt(6, ib.getNum());
			ps.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(ps != null) ps.close();
				if(con != null) con.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
}





























