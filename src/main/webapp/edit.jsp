<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.board.dto.BoardDTO" %>
<%@ page import="com.board.dao.BoardDAO" %>

<%
int id = Integer.parseInt(request.getParameter("id"));

BoardDAO dao = new BoardDAO();
BoardDTO board = dao.selectOne(id);
%>

<html>
<head>
    <title>게시글 수정</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="header">
    <a href="list.jsp">2670030 leehyun</a>
</div>

<div class="top-menu">
    게시글 수정
</div>

<div class="container">

<h1>게시글 수정</h1>

<form action="updateProcess.jsp" method="post" enctype="multipart/form-data">

    <input type="hidden" name="id" value="<%= board.getId() %>">

    <input type="hidden"
    name="oldFileName"
    value="<%= board.getFileName() %>">

    제목:
    <input type="text"
    name="title"
    value="<%= board.getTitle() %>">

    <br><br>

    작성자:
    <input type="text"
    name="writer"
    value="<%= board.getWriter() %>">

    <br><br>

    내용:<br>

    <textarea name="content"
    rows="10"
    cols="60"><%= board.getContent() %></textarea>

    <br><br>

    현재 파일:

<%
if (board.getFileName() != null) {
%>

    <%= board.getFileName() %>

<%
} else {
%>

    첨부파일 없음

<%
}
%>

    <br><br>

    새 파일:
    <input type="file" name="uploadFile">

    <br><br>

    <input class="btn"
    type="submit"
    value="수정 완료">

</form>

<br>

<a class="btn" href="list.jsp">
    목록으로
</a>

</div>

<div class="footer">
    2670030 leehyun
</div>

</body>
</html>