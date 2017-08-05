package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	
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
	
	// 게시글 갯수 구하기
	public int getCount() {
		
		int count = 0;
		try {
			con = getConnection();
		
			sql = "select count(*) as count from board";
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

	// 게시글 갯수 구하기(검색)
	public int getCount(String search) {
			
			int count = 0;
			try {
				con = getConnection();
			
				sql = "select count(*) as count from board where subject like ?";
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
	
	// 게시글 리스트 반환
	public List<BoardBean> getBoardList(int startRow, int pageSize) {
		
		List<BoardBean> listBoard = new ArrayList<BoardBean>();
		BoardBean bb = null;
		try {
			con = getConnection();
			
			sql = "select * from board order by re_ref desc, re_seq asc limit ?, ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, startRow-1);
			ps.setInt(2, pageSize);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				bb =new BoardBean();
				
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setDate(rs.getDate("date"));
				bb.setIp(rs.getString("ip"));
				bb.setFile(rs.getString("file"));
				bb.setId(rs.getString("id"));
				
				listBoard.add(bb);
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
		return listBoard;
	}
		
	// 게시글 리스트 반환(검색)
	public List<BoardBean> getBoardList(int startRow, int pageSize, String search) {
			
			List<BoardBean> listBoard = new ArrayList<BoardBean>();
			BoardBean bb = null;
			try {
				con = getConnection();
				
				sql = "select * from board where subject like ? order by re_ref desc, re_seq asc limit ?, ?";
				ps = con.prepareStatement(sql);
				ps.setString(1, "%"+search+"%");
				ps.setInt(2, startRow-1);
				ps.setInt(3, pageSize);
				rs = ps.executeQuery();
				
				while(rs.next()) {
					bb =new BoardBean();
					
					bb.setNum(rs.getInt("num"));
					bb.setName(rs.getString("name"));
					bb.setPass(rs.getString("pass"));
					bb.setSubject(rs.getString("subject"));
					bb.setContent(rs.getString("content"));
					bb.setReadcount(rs.getInt("readcount"));
					bb.setRe_ref(rs.getInt("re_ref"));
					bb.setRe_lev(rs.getInt("re_lev"));
					bb.setRe_seq(rs.getInt("re_seq"));
					bb.setDate(rs.getDate("date"));
					bb.setIp(rs.getString("ip"));
					bb.setFile(rs.getString("file"));
					bb.setId(rs.getString("id"));
					
					listBoard.add(bb);
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
			return listBoard;
		}

	// 조회수 증가
	public void updateReadCount(int num) {
		
		try {
			con = getConnection();
			
			sql = "update board set readCount = readCount+1 where num = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);
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
	
	// 게시글 반환
	public BoardBean getBoard(int num) {
		BoardBean bb = new BoardBean();
		try {
			con = getConnection();
			
			sql="select * from board where num = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setDate(rs.getDate("date"));
				bb.setIp(rs.getString("ip"));
				bb.setFile(rs.getString("file"));
				bb.setId(rs.getString("id"));
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
		return bb;
	}
	
	// 게시글 작성
	public void insertBoard(BoardBean bb) {
		
		int num = 0;
		try {
			con = getConnection();
			// 글번호 구하기
			sql = "select max(num) as max from board";
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {
				num = rs.getInt("max")+1;
			}
			
			// 게시글 DB저장
			sql = "insert into board(num, name, pass, subject, content, readcount, re_ref, re_lev, re_seq, date, ip, file, id) "
					+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?, ?, ?)";
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);
			ps.setString(2, bb.getName());
			ps.setString(3, bb.getPass());
			ps.setString(4, bb.getSubject());
			ps.setString(5, bb.getContent());
			ps.setInt(6, 0);	
			ps.setInt(7, num);	// re_ref
			ps.setInt(8, 0);	// re_lev
			ps.setInt(9, 0);	// re_seq
			ps.setString(10, bb.getIp());
			ps.setString(11, bb.getFile());
			ps.setString(12, bb.getId());
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

	// 게시글 답글
	public void reInsertBoard(BoardBean bb) {
		
		int num = 0;
		try {
			con = getConnection();
			
			// num에 들어갈 값 구하기
			sql = "select max(num) as max from board";
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {
				num = rs.getInt("max") + 1;
			}
			
			// re_seq값 증가
			sql = "update board set re_seq = re_seq+1 where re_ref=? and re_seq > ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, bb.getRe_ref());
			ps.setInt(2, bb.getRe_seq());
			ps.executeUpdate();
			
			// 답글 저장
			sql = "insert into board(num, name, pass, subject, content, readcount, re_ref, re_lev, re_seq, date, ip, file, id) "
					+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?, ?, ?)";
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);
			ps.setString(2, bb.getName());
			ps.setString(3, bb.getPass());
			ps.setString(4, bb.getSubject());
			ps.setString(5, bb.getContent());
			ps.setInt(6, 0);	// readcount
			ps.setInt(7, bb.getRe_ref());
			ps.setInt(8, bb.getRe_lev()+1);
			ps.setInt(9, bb.getRe_seq()+1);
			ps.setString(10, bb.getIp());
			ps.setString(11, bb.getFile());
			ps.setString(12, bb.getId());
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
	
	// 게시글 삭제
	public void deleteBoard(int num) {	// 유저가 글을 쓴후 비밀번호를 변경하면 삭제가 안됨, 구현안함
		
		try {
			con = getConnection();
			
			sql = "delete from board where num=?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);
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
	
	// 게시글 수정
	public void updateBoard(BoardBean bb, int num) {
		
		try {
			con = getConnection();
			
			sql = "update board set subject=?, name=?, file=?, content=?, ip=? where num=?";
			ps = con.prepareStatement(sql);
			ps.setString(1, bb.getSubject());
			ps.setString(2, bb.getName());
			ps.setString(3, bb.getFile());
			ps.setString(4, bb.getContent());
			ps.setString(5, bb.getIp());
			ps.setInt(6, num);
			ps.executeUpdate();
			
		}catch(Exception e) {
			
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














