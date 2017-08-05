<%@page import="notice.NoticeDAO"%>
<%@page import="notice.NoticeBean"%>
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
	<%
	// 세션값 가져오기
	String id = (String)session.getAttribute("id");
	if(id==null) {
		response.sendRedirect("../member/login.jsp");
	}
	// 한글처리
	request.setCharacterEncoding("UTF-8");
	
	// 멀티파트리퀘스트 객체 생성
	String realPath = request.getRealPath("/upload/notice");
	int maxSize = 5 * 1024 * 1024;	// 5MB
	MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
	
	// 파라미터 값 가져오기
	String pageNum = multi.getParameter("pageNum");
	int num = Integer.parseInt(multi.getParameter("num"));
	String search = multi.getParameter("search");
	
	String subject = multi.getParameter("subject");
	String name = multi.getParameter("name");
	String file;
	if(multi.getFilesystemName("file")!=null) {
		file = multi.getFilesystemName("file");
	}else {
		file = multi.getParameter("file2");
	}
	String content = multi.getParameter("content");
	
	String ip = request.getRemoteAddr();
	
	// 빈에 담기
	NoticeBean nb = new NoticeBean();
	nb.setSubject(subject);
	nb.setName(name);
	nb.setFile(file);
	nb.setContent(content);
	nb.setIp(ip);
	
	// DB수정 작업
	NoticeDAO ndao = new NoticeDAO();
	ndao.updateNotice(nb, num);		// 조건에 맞지 않으면 버튼이 안보여서 따로 반환값 없음
	
	// 게시글로 이동
	/* response.sendRedirect("content_notice.jsp?pageNum="+pageNum+"&num="+num+"&search="+search); */
	%>
	<script type="text/javascript">
	location.href = "content_notice.jsp?pageNum=<%=pageNum %>&num=<%=num %>&search=<%=search %>";
	</script>
</body>
</html>