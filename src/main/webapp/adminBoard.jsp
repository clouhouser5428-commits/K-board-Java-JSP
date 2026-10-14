<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.board.dto.BoardDTO" %>
<%@ page import="com.board.dao.BoardDAO" %>

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

BoardDAO dao = new BoardDAO();
List<BoardDTO> list = dao.selectList();
%>

<html>
<head>
    <title>게시글 관리</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>

<div class="header">
    <a href="admin.jsp">관리자 페이지</a>
</div>

<div class="top-menu">
    게시글 관리
</div>

<div class="container">

<h1>전체 게시글 관리</h1>

<table class="board-table">

    <tr>
        <th>번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th>조회수</th>
        <th>관리</th>
    </tr>

<%
for (BoardDTO board : list) {
%>

    <tr>

        <td><%= board.getId() %></td>

        <td class="title">
            <a href="view.jsp?id=<%= board.getId() %>">
                <%= board.getTitle() %>
            </a>
        </td>

        <td><%= board.getWriter() %></td>

        <td><%= board.getViewCount() %></td>

        <td>
            <a class="btn"
               href="deleteProcess.jsp?id=<%= board.getId() %>"
               onclick="return confirm('삭제하시겠습니까?');">
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
    Admin Board Manager
</div>

</body>
</html>