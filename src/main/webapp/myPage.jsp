<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>

<%@ page import="com.board.dto.BoardDTO" %>
<%@ page import="com.board.dto.CommentDTO" %>

<%@ page import="com.board.dao.BoardDAO" %>
<%@ page import="com.board.dao.CommentDAO" %>

<%
String loginId =
    (String)session.getAttribute("loginId");

String loginName =
    (String)session.getAttribute("loginName");

if(loginId == null){
%>

<script>
alert("로그인이 필요합니다.");
location.href="login.jsp";
</script>

<%
return;
}

BoardDAO boardDao = new BoardDAO();
CommentDAO commentDao = new CommentDAO();

List<BoardDTO> myBoardList =
    boardDao.selectMyBoardList(loginId);

List<CommentDTO> myCommentList =
    commentDao.selectMyCommentList(loginId);

List<BoardDTO> likeBoardList =
    boardDao.selectLikeBoardList(loginId);
%>

<html>

<head>

<title>마이페이지</title>

<link rel="stylesheet" href="style.css">

</head>

<body>

<div class="header">
<a href="list.jsp">K-board</a>
</div>

<div class="top-menu">

<%= loginName %>님 마이페이지

|

<a href="list.jsp">게시판</a>

|

<a href="logout.jsp">로그아웃</a>

</div>

<div class="container">

<h1>마이페이지</h1>

<h2>내가 쓴 글</h2>

<table class="board-table">

<tr>
<th>번호</th>
<th>제목</th>
<th>작성일</th>
</tr>

<%
for(BoardDTO board : myBoardList){
%>

<tr>

<td><%= board.getId() %></td>

<td class="title">

<a href="view.jsp?id=<%= board.getId() %>">

<%= board.getTitle() %>

</a>

</td>

<td><%= board.getCreatedAt() %></td>

</tr>

<%
}
%>

</table>

<br><br>

<h2>내가 쓴 댓글</h2>

<table class="board-table">

<tr>
<th>게시글</th>
<th>댓글</th>
<th>작성일</th>
</tr>

<%
for(CommentDTO comment : myCommentList){
%>

<tr>

<td>

<a href="view.jsp?id=<%= comment.getBoardId() %>">

바로가기

</a>

</td>

<td><%= comment.getContent() %></td>

<td><%= comment.getCreatedAt() %></td>

</tr>

<%
}
%>

</table>

<br><br>

<h2>좋아요 누른 글</h2>

<table class="board-table">

<tr>
<th>번호</th>
<th>제목</th>
<th>작성자</th>
</tr>

<%
for(BoardDTO board : likeBoardList){
%>

<tr>

<td><%= board.getId() %></td>

<td class="title">

<a href="view.jsp?id=<%= board.getId() %>">

<%= board.getTitle() %>

</a>

</td>

<td><%= board.getWriter() %></td>

</tr>

<%
}
%>

</table>

</div>

<div class="footer">

My Page

</div>

</body>

</html>