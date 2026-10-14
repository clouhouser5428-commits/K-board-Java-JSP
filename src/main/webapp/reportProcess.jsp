<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="com.board.util.DBUtil" %>

<%
request.setCharacterEncoding("UTF-8");

String loginId = (String) session.getAttribute("loginId");

if (loginId == null) {
%>
<script>
    alert("로그인 후 신고할 수 있습니다.");
    location.href = "login.jsp";
</script>
<%
    return;
}

int boardId = Integer.parseInt(request.getParameter("boardId"));
String reason = request.getParameter("reason");

int result = 0;

String sql = "INSERT INTO report (board_id, reporter_id, reason) VALUES (?, ?, ?)";

try {
    Connection conn = DBUtil.getConnection();
    PreparedStatement pstmt = conn.prepareStatement(sql);

    pstmt.setInt(1, boardId);
    pstmt.setString(2, loginId);
    pstmt.setString(3, reason);

    result = pstmt.executeUpdate();

    pstmt.close();
    conn.close();

} catch (Exception e) {
    e.printStackTrace();
}

if (result > 0) {
%>
<script>
    alert("신고가 접수되었습니다.");
    location.href = "view.jsp?id=<%= boardId %>";
</script>
<%
} else {
%>
<script>
    alert("신고 접수 실패");
    history.back();
</script>
<%
}
%>