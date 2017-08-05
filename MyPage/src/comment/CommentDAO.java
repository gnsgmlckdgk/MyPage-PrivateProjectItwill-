package comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;

public class CommentDAO {
	
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	String sql = "";
	
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
	
	// 댓글 작성(저장)
	public void insertComment(CommentBean cb) {
		
		int num = 0;
		try {
			con = getConnection();
			
			// 게시글의 댓글 num 최대값 구하기
			sql = "select max(num) as max from comment where content_num = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, cb.getContent_num());
			rs = ps.executeQuery();
			if(rs.next()) {	// 게시글이 존재하면
				num = rs.getInt("max")+1;
			}
			
			// DB에 저장
			sql = "insert into comment(id, name, content, content_num, num, re_ref, re_lev, re_seq, date) "
					+ "values(?, ?, ?, ?, ?, ?, ?, ?, now())";
			ps = con.prepareStatement(sql);
			ps.setString(1, cb.getId());
			ps.setString(2, cb.getName());
			ps.setString(3, cb.getContent());
			ps.setInt(4, cb.getContent_num());
			ps.setInt(5, num);
			ps.setInt(6, num);	// re_ref
			ps.setInt(7, 0);	// re_lev
			ps.setInt(8, 0);	// re_seq
			ps.executeUpdate();
			
		}catch(MySQLIntegrityConstraintViolationException e) {	// 로그인을 안하고 DB에 값을 저장하려하면 id값(제약조건: not null)이 null이기 때문에 예외가 발생함
			System.out.println("로그인이 안되서 댓글 작성이 안됨");
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try{
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(con!=null) con.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		
	}
	
	// 댓글 총 개수 반환
	public int getCount(int content_num) {
		
		int count = 0;
		try {
			con = getConnection();
			
			sql = "select count(*) as count from comment where content_num = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, content_num);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("count");
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try{
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(con!=null) con.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return count;
	}
	
	// 댓글 리스트 반환
	public List<CommentBean> getCommentList(int content_num, int startRow, int pageSize) {
		
		List<CommentBean> list = new ArrayList<CommentBean>();
		try {
			con = getConnection();
			
			sql = "select * from comment where content_num = ? order by re_ref desc, re_seq asc limit ?, ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, content_num);
			ps.setInt(2, startRow-1);
			ps.setInt(3, pageSize);
			rs = ps.executeQuery();
			
			CommentBean cb;
			while(rs.next()) {
				cb =  new CommentBean();
				
				cb.setId(rs.getString("id"));
				cb.setName(rs.getString("name"));
				cb.setContent(rs.getString("content"));
				cb.setContent_num(content_num);
				cb.setNum(rs.getInt("num"));
				cb.setRe_ref(rs.getInt("re_ref"));
				cb.setRe_lev(rs.getInt("re_lev"));
				cb.setRe_seq(rs.getInt("re_seq"));
				cb.setDate(rs.getDate("date"));
				
				list.add(cb);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try{
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(con!=null) con.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// 댓글 삭제(하나씩 삭제)
	public void deleteComment(int num) {
		
		try {
			con = getConnection();
			
			sql = "delete from comment where num = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);
			ps.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try{
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(con!=null) con.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	// 댓글 삭제(게시글이 지워질때 같이 삭제)
		public void deleteAllComment(int content_num) {
			
			try {
				con = getConnection();
				
				sql = "delete from comment where content_num = ?";
				ps = con.prepareStatement(sql);
				ps.setInt(1, content_num);
				ps.executeUpdate();
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				try{
					if(rs!=null) rs.close();
					if(ps!=null) ps.close();
					if(con!=null) con.close();
				}catch(SQLException e) {
					e.printStackTrace();
				}
			}
		}
	
}
