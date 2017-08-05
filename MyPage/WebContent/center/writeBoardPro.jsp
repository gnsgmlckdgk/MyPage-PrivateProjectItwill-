<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
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
	
	<h1>WriteBoardPro.jsp</h1>
	
	<%
	// 세션가져오기
	String id = (String)session.getAttribute("id");
	if(id==null) {
		response.sendRedirect("../member/login.jsp");
	}
	
	// 한글처리
	request.setCharacterEncoding("UTF-8");
	// 물리적 경고 가져오기
	String realPath = request.getRealPath("/upload/board");
	System.out.println("realPath: " + realPath);	// 경로 확인용
	// 파일 최대크기
	int maxSize = 5 * 1024 * 1024;	// 5MB
	// MultipartRequest 객체 생성
	MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
	
	// 파라미터 가져오기
	String subject = multi.getParameter("subject");
	String name = multi.getParameter("name");
	String file = multi.getFilesystemName("file");
	String content = multi.getParameter("content");
	
	String ip = request.getRemoteAddr();
	
	// 회원정보가져오기(pass 저장을 위해서)
	MemberDAO mdao = new MemberDAO();
	MemberBean mb = mdao.getInfo(id);
	
	String pass = mb.getPass();
	
	// 게시글 DB저장
	BoardBean bb = new BoardBean();
	bb.setSubject(subject);
	bb.setName(name);
	bb.setPass(pass);
	bb.setContent(content);
	bb.setIp(ip);
	bb.setFile(file);
	bb.setId(id);
	
	BoardDAO bdao = new BoardDAO();
	bdao.insertBoard(bb);
	
	// board.jsp로 이동
	response.sendRedirect("board.jsp");
	%>
	
</body>
</html>