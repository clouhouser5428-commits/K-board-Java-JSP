<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.board.dto.CommentDTO" %>
<%@ page import="com.board.dao.CommentDAO" %>

<%
String loginRole = (String) session.getAttribute("loginRole");

if (!"ADMIN".equals(loginRole)) {
%>
<script>
    alert("관리자만 접근 가능합니다.");
    location.href = "list.jsp";
</script>
<%
    return;
}

CommentDAO dao = new CommentDAO();
List<CommentDTO> list = dao.selectAll();
%>

<html>
<head>
    <title>댓글 관리</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="header">
    <a href="admin.jsp">관리자 페이지</a>
</div>

<div class="top-menu">
    댓글 관리 |
    <a href="admin.jsp">대시보드</a> |
    <a href="list.jsp">게시판</a>
</div>

<div class="container">

<h1>댓글 관리</h1>

<table class="board-table">
    <tr>
        <th>번호</th>
        <th>게시글</th>
        <th>작성자</th>
        <th>내용</th>
        <th>작성일</th>
        <th>관리</th>
    </tr>

<%
for (CommentDTO comment : list) {
%>
    <tr>
        <td><%= comment.getId() %></td>
        <td>
            <a href="view.jsp?id=<%= comment.getBoardId() %>">
                <%= comment.getBoardId() %>번 글
            </a>
        </td>
        <td><%= comment.getWriter() %></td>
        <td><%= comment.getContent() %></td>
        <td><%= comment.getCreatedAt() %></td>
        <td>
            <a class="btn"
               href="commentDelete.jsp?id=<%= comment.getId() %>&boardId=<%= comment.getBoardId() %>"
               onclick="return confirm('댓글을 삭제하시겠습니까?');">
               삭제
            </a>
        </td>
    </tr>
<%
}
%>

</table>

<div class="btn-area">
    <a class="btn" href="admin.jsp">뒤로가기</a>
</div>

</div>

<div class="footer">
    Admin Comment Manager
</div>

</body>
</html>