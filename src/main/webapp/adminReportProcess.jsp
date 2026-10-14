<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="com.board.util.DBUtil" %>

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

String action = request.getParameter("action");
int id = Integer.parseInt(request.getParameter("id"));

if ("done".equals(action)) {
    String sql = "UPDATE report SET status = 'DONE' WHERE id = ?";

    try {
        Connection conn = DBUtil.getConnection();
        PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setInt(1, id);
        pstmt.executeUpdate();

        pstmt.close();
        conn.close();

    } catch (Exception e) {
        e.printStackTrace();
    }
}
%>

<script>
    alert("처리되었습니다.");
    location.href = "adminReport.jsp";
</script>