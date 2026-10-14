<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.board.dao.BoardDAO" %>

<%
int id = Integer.parseInt(request.getParameter("id"));

BoardDAO dao = new BoardDAO();
int result = dao.deleteBoard(id);

if (result > 0) {
%>
    <script>
        alert("게시글이 삭제되었습니다.");
        location.href = "list.jsp";
    </script>
<%
} else {
%>
    <script>
        alert("게시글 삭제 실패");
        history.back();
    </script>
<%
}
%>