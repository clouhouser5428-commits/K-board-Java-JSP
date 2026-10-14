<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.board.dao.BoardDAO" %>

<%
String loginId = (String) session.getAttribute("loginId");

if (loginId == null) {
%>
<script>
    alert("로그인 후 좋아요를 누를 수 있습니다.");
    location.href = "login.jsp";
</script>
<%
    return;
}

int boardId = Integer.parseInt(request.getParameter("boardId"));

BoardDAO dao = new BoardDAO();
dao.toggleLike(boardId, loginId);
%>

<script>
    location.href = "view.jsp?id=<%= boardId %>";
</script>