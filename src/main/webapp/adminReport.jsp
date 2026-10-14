<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
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
%>

<html>
<head>
    <title>신고 관리</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="header">
    <a href="admin.jsp">관리자 페이지</a>
</div>

<div class="top-menu">
    신고 관리 |
    <a href="admin.jsp">대시보드</a> |
    <a href="list.jsp">게시판</a>
</div>

<div class="container">

<h1>신고 관리</h1>

<table class="board-table">
    <tr>
        <th>번호</th>
        <th>게시글</th>
        <th>신고자</th>
        <th>사유</th>
        <th>상태</th>
        <th>신고일</th>
        <th>관리</th>
    </tr>

<%
String sql = "SELECT id, board_id, reporter_id, reason, status, created_at "
           + "FROM report ORDER BY id DESC";

try {
    Connection conn = DBUtil.getConnection();
    PreparedStatement pstmt = conn.prepareStatement(sql);
    ResultSet rs = pstmt.executeQuery();

    while (rs.next()) {
%>
    <tr>
        <td><%= rs.getInt("id") %></td>
        <td>
            <a href="view.jsp?id=<%= rs.getInt("board_id") %>">
                <%= rs.getInt("board_id") %>번 글
            </a>
        </td>
        <td><%= rs.getString("reporter_id") %></td>
        <td><%= rs.getString("reason") %></td>
        <td><%= rs.getString("status") %></td>
        <td><%= rs.getString("created_at") %></td>
        <td>
            <a class="btn"
               href="adminReportProcess.jsp?action=done&id=<%= rs.getInt("id") %>"
               onclick="return confirm('처리 완료로 변경하시겠습니까?');">
               처리
            </a>

            <a class="btn"
               href="deleteProcess.jsp?id=<%= rs.getInt("board_id") %>"
               onclick="return confirm('신고된 게시글을 삭제하시겠습니까?');">
               글삭제
            </a>
        </td>
    </tr>
<%
    }

    rs.close();
    pstmt.close();
    conn.close();

} catch (Exception e) {
    e.printStackTrace();
}
%>

</table>

<div class="btn-area">
    <a class="btn" href="admin.jsp">뒤로가기</a>
</div>

</div>

<div class="footer">
    Admin Report Manager
</div>

</body>
</html>