<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.board.dao.NotificationDAO" %>

<%
String loginId = (String) session.getAttribute("loginId");

if (loginId == null) {
%>
<script>
    alert("로그인이 필요합니다.");
    location.href = "login.jsp";
</script>
<%
    return;
}

int id = Integer.parseInt(request.getParameter("id"));
int boardId = Integer.parseInt(request.getParameter("boardId"));

NotificationDAO dao = new NotificationDAO();
dao.markAsRead(id);
%>

<script>
    location.href = "view.jsp?id=<%= boardId %>";
</script>