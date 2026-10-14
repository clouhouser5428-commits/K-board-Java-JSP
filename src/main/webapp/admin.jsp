<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.board.dao.BoardDAO" %>
<%@ page import="com.board.dao.MemberDAO" %>
<%@ page import="com.board.dao.CommentDAO" %>
<%@ page import="com.board.dao.NotificationDAO" %>

<%
String loginId = (String) session.getAttribute("loginId");
String loginName = (String) session.getAttribute("loginName");
String loginRole = (String) session.getAttribute("loginRole");

if (loginId == null || !"ADMIN".equals(loginRole)) {
%>
<script>
    alert("관리자만 접근할 수 있습니다.");
    location.href = "list.jsp";
</script>
<%
    return;
}

BoardDAO boardDao = new BoardDAO();
MemberDAO memberDao = new MemberDAO();
CommentDAO commentDao = new CommentDAO();
NotificationDAO notificationDao = new NotificationDAO();

int boardCount = boardDao.getBoardCount("title", "");
int memberCount = memberDao.getMemberCount();
int commentCount = commentDao.getCommentCount();
int notificationCount = notificationDao.getNotificationCount();
%>

<html>
<head>
    <title>관리자 페이지</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>

<div class="header">
    <a href="list.jsp">K-board Admin</a>
</div>

<div class="top-menu">
    <%= loginName %> 관리자님 |
    <a href="list.jsp">게시판</a> |
    <a href="logout.jsp">로그아웃</a>
</div>

<div class="container">

    <h1>관리자 대시보드</h1>

    <table class="board-table">
        <tr>
            <th>항목</th>
            <th>개수</th>
        </tr>
        <tr>
            <td>전체 게시글</td>
            <td><%= boardCount %></td>
        </tr>
        <tr>
            <td>전체 회원</td>
            <td><%= memberCount %></td>
        </tr>
        <tr>
            <td>전체 댓글</td>
            <td><%= commentCount %></td>
        </tr>
        <tr>
            <td>전체 알림</td>
            <td><%= notificationCount %></td>
        </tr>
    </table>

    <div class="btn-area">
        <a class="btn" href="adminBoard.jsp">게시글 관리</a>
        <a class="btn" href="adminComment.jsp">댓글 관리</a>
        <a class="btn" href="adminMember.jsp">회원 관리</a>
        <a class="btn" href="adminReport.jsp">신고 관리</a>
    </div>

</div>

<div class="footer">
    Admin Page
</div>

</body>
</html>