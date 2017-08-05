<%@page import="image.ImageBean"%>
<%@page import="image.ImageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FunWeb - ImageBoard</title>

<link href="../css/default.css?ver=16" rel="stylesheet" type="text/css">
<link href="../css/subpage.css?ver=11" rel="stylesheet" type="text/css">

<!-- 추가해서 넣은 css -->
<link href="../css/background_image.css?ver=12" rel="stylesheet" type="text/css">
<link href="../css/content_board_notice.css?ver=13" rel="stylesheet" type="text/css">

<style type="text/css">
	td {
		border: 1px solid #f0f0f0;
	}

	.img_td {
		width: 640px;
		height: 400px;
	}
	
</style>

<script type="text/javascript">
	function deleteBoard(pageNum, num) {
		if(confirm("게시글을 삭제하시겠습니까?")) {
			location.href="deleteImageBoard.jsp?pageNum="+pageNum+"&num="+num;
		}
	}
</script>

</head>
<body>
	<div id="wrap">
		<!-- 헤더들어가는 곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더들어가는 곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문메인이미지 -->
		<div id="sub_img_center"></div>
		<!-- 본문메인이미지 -->
		<!-- 왼쪽메뉴 -->
		<nav id="sub_menu">
		<ul>
		<li><a href="notice.jsp">공지</a></li>
		<li><a href="board.jsp">자유게시판</a></li>
		<li><a href="imageBoard.jsp">이미지게시판</a></li>
		</ul>
		</nav>
		<!-- 왼쪽메뉴 -->
		<!-- 본문내용 -->
		<%
			// 한글처리
			request.setCharacterEncoding("UTF-8");
		
			// 세션값 가져오기
			String id = (String)session.getAttribute("id");
			if(id==null) {	// 밑의 if문에서 id가 null일때 NullPointerException이 뜨는것을 방지
				id = "null";
			}
			
			// 파라미터 값 가져오기
			String pageNum = request.getParameter("pageNum");
			if(pageNum==null) {
				pageNum="1";
			}
			int num = Integer.parseInt(request.getParameter("num"));
			String search = request.getParameter("search");
			if(search==null) {
				search="";
			}
			
			// imageDAO 객체 생성
			ImageDAO idao =new ImageDAO();
			
			// 조회수 증가
			idao.updateReadCount(num);	
			
			// 빈에 담기
			ImageBean ib = idao.getBoard(num);
			
			// content 개행을 <br>로 바꾸기
			String content = "";
			if(ib.getContent()!=null) {
				content = ib.getContent().replaceAll("\r\n", "<br>");
			}
			
		%>	
		<article>
		<h1>ImageBoard</h1>
		<div>
			<table>
				<tr>
					<td>제목</td> <td><%=ib.getSubject() %></td> <td><%=ib.getReadcount() %></td>
				</tr>
				<tr>
					<td>작성자</td> <td><%=ib.getId() %></td> <td><%=ib.getDate() %></td>
				</tr>
				<tr>
					<td>이미지 파일 이름</td>
					<%if(ib.getFile()!=null) {
						%>
						<td colspan="2"><%=ib.getFile() %></td>
						<%
					}else {
						%>
						<td colspan="2">첨부파일 없음</td>
						<%
					}
					%>
				</tr>
				<tr>
					<td>이미지 내용</td> <td colspan="2"><%=content %></td>
				</tr>
				<tr>
					<td colspan="3" class="img_td"><a href="../upload/image/<%=ib.getFile() %>" target="_blank"><img src="../upload/image/<%=ib.getFile() %>" width="640px" height="400px"></a></td>
				</tr>
			</table>
		</div>
		<div class="btn_div">
			<%
			// 아이디 비교
			if(id.equals(ib.getId())) {	// 로그인 한 ID가 작성자 ID이면
				%>
				<input type="button" value="수정" class="btn greenBtn" onclick ="location.href='updateImageBoard.jsp?pageNum=<%=pageNum %>&num=<%=num%>&search=<%=search %>'">
				<input type="button" value="삭제" class="btn redBtn" onclick= "deleteBoard(<%=pageNum %>,<%=num %>)">
				<%
			} else if(id.equals("admin")) {	// 관리자 id이면
				%>
				<input type="button" value="삭제" class="btn redBtn" onclick="deleteBoard(<%=pageNum %>,<%=num %>)">
				<%
			}
			%>
			<input type="button" value="목록" class="btn blueBtn" onclick ="location.href='imageBoard.jsp?pageNum=<%=pageNum %>&search=<%=search %>'">
		</div>
		</article>
		<!-- 본문내용 -->
		<!-- 본문들어가는 곳 -->

		<div class="clear"></div>
		<!-- 푸터들어가는 곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터들어가는 곳 -->
	</div>

</body>
</html>