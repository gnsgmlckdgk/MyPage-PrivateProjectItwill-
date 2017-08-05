<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>rewriteBoardPro.jsp</h1>
	<%
	// 한글처리
	request.setCharacterEncoding("UTF-8");
	
	// 세션 값 가져오기
	String id = (String)session.getAttribute("id");
	if(id==null) {
		response.sendRedirect("../member/login.jsp");
	}
	
	// 멀티파트리퀘스트 객체 생성
	String realPath = request.getRealPath("/upload/board");
	int maxSize = 5 * 1024 * 1024;

	MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
	
	// 회원정보가져오기(pass 저장을 위해서)
	MemberDAO mdao = new MemberDAO();
	MemberBean mb = mdao.getInfo(id);
		
	String pass = mb.getPass();
	
	// 파라미터 값 가져오기
	String pageNum = multi.getParameter("pageNum");
	String search = multi.getParameter("search");
	if(search == null) {
		search = "";
	}
	int num = Integer.parseInt(multi.getParameter("num"));
	
	// 빈에 담기
	BoardBean bb = new BoardBean();
	
	bb.setNum(Integer.parseInt(multi.getParameter("num")));
	bb.setName(multi.getParameter("name"));
	bb.setPass(pass);
	bb.setSubject(multi.getParameter("subject"));
	bb.setContent(multi.getParameter("content"));
	bb.setRe_ref(Integer.parseInt(multi.getParameter("re_ref")));
	bb.setRe_lev(Integer.parseInt(multi.getParameter("re_lev")));
	bb.setRe_seq(Integer.parseInt(multi.getParameter("re_seq")));
	bb.setIp(request.getRemoteAddr());
	bb.setFile(multi.getFilesystemName("file"));
	bb.setId(id);
	
	// DB저장
	BoardDAO bdao = new BoardDAO();
	bdao.reInsertBoard(bb);
	
	// 이동
	/* response.sendRedirect("board.jsp?pageNum="+pageNum+"&search="+search); */
	%>
	<script type="text/javascript">
	location.href="board.jsp?pageNum=<%=pageNum %>&search=<%=search %>";
	</script>
</body>
</html>