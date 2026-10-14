<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.board.dto.NotificationDTO" %>
<%@ page import="com.board.dao.NotificationDAO" %>

<%
String loginId = (String) session.getAttribute("loginId");
String loginName = (String) session.getAttribute("loginName");

if (loginId == null) {
%>
<script>
    alert("로그인이 필요합니다.");
    location.href = "login.jsp";
</script>
<%
    return;
}

NotificationDAO dao = new NotificationDAO();
List<NotificationDTO> list = dao.selectList(loginId);
%>

<html>
<head>
    <title>알림</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>

<div class="header">
    <a href="list.jsp">2670030 leehyun</a>
</div>

<div class="top-menu">
    <%= loginName %>님 환영합니다 |
    <a href="logout.jsp">로그아웃</a>
</div>

<div class="container">

    <h1>알림 목록</h1>

<%
if (list.size() == 0) {
%>

    <p>알림이 없습니다.</p>

<%
} else {
    for (NotificationDTO noti : list) {
%>

    <div class="content-box" style="min-height:auto; margin-bottom:10px;">
        <p>
            <strong>
            <%
            if ("N".equals(noti.getIsRead())) {
            %>
                [새 알림]
            <%
            } else {
            %>
                [읽음]
            <%
            }
            %>
            </strong>
            <%= noti.getMessage() %>
        </p>

        <p style="color:#777; font-size:13px;">
            <%= noti.getCreatedAt() %>
        </p>

        <a class="btn"
           href="notificationRead.jsp?id=<%= noti.getId() %>&boardId=<%= noti.getBoardId() %>">
            게시글로 이동
        </a>
    </div>

<%
    }
}
%>

    <div class="btn-area">
        <a class="btn" href="list.jsp">목록으로</a>
    </div>

</div>

<div class="footer">
    2670030 leehyun
</div>

</body>
</html>