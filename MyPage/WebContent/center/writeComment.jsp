<%@page import="comment.CommentBean"%>
<%@page import="comment.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	// 세션값 가져오기
	String id = (String)session.getAttribute("id");
	if(id==null) {
		%>
		<script type="text/javascript">
		alert("로그인이 필요합니다.");
		history.back();
		</script>
		<%
	}
	String name = (String)session.getAttribute("name");
	
	// 파라미터값 가져오기
	String pageNum = request.getParameter("pageNum");
	// id, name은 세션값
	String content = request.getParameter("content");
	int content_num = Integer.parseInt(request.getParameter("content_num"));	// 댓글이 쓰여지는 게시글의 num
	// 빈에 담기
	CommentBean cb = new CommentBean();
	cb.setId(id);
	cb.setName(name);
	cb.setContent(content);
	cb.setContent_num(content_num);
	// 나머지는 DB작업에서 처리
	
	// DB작업
	CommentDAO cdao = new CommentDAO();
	cdao.insertComment(cb);
	
	// 이동
	/* response.sendRedirect("content_board.jsp?pageNum="+pageNum+"&num="+content_num); */

	%>
	<script type="text/javascript">
	location.href="content_board.jsp?pageNum=<%=pageNum %>&num=<%=content_num %>"
	</script>
	
</body>
</html>