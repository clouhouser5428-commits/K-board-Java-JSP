<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.board.dao.CommentDAO" %>

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

CommentDAO dao = new CommentDAO();
int result = dao.deleteComment(id);

if (result > 0) {
%>
<script>
    alert("댓글이 삭제되었습니다.");
    location.href = "view.jsp?id=<%= boardId %>";
</script>
<%
} else {
%>
<script>
    alert("댓글 삭제 실패");
    history.back();
</script>
<%
}
%>