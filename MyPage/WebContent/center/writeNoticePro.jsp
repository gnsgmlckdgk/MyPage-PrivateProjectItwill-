<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="notice.NoticeDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="notice.NoticeBean"%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>writeNoticePro.jsp</h1>

	<%
	// 한글처리
	request.setCharacterEncoding("UTF-8");
	
	// 세션값 가져오기
	String id = (String)session.getAttribute("id");
	if(id==null)
		response.sendRedirect("../member/login.jsp");
	
	// 파라미터 값 가져오기
	String realPath = request.getRealPath("/upload/notice");
	int maxSize = 5 * 1024 * 1024;	// 5MB
	
	MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
	
	String subject = multi.getParameter("subject");
	String name = multi.getParameter("name");
	String content = multi.getParameter("content");
	String file = multi.getFilesystemName("file");
	String ip = request.getRemoteAddr();
	
	// 회원정보 가져오기
	MemberDAO mdao = new MemberDAO();
	MemberBean mb = mdao.getInfo(id);
	
	// NoticeBean에 값들 담기
	NoticeBean nb = new NoticeBean();
	nb.setName(name);
	nb.setPass(mb.getPass());
	nb.setSubject(subject);
	nb.setContent(content);
	nb.setFile(file);
	nb.setIp(ip);
	
	// DB작업
	NoticeDAO ndao = new NoticeDAO();
	ndao.insertNotice(nb);
	
	response.sendRedirect("notice.jsp");
	%>

</body>
</html>