<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.board.dto.MemberDTO" %>
<%@ page import="com.board.dao.MemberDAO" %>

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

MemberDAO dao = new MemberDAO();
List<MemberDTO> list = dao.selectList();
%>

<html>
<head>
    <title>회원 관리</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>

<div class="header">
    <a href="admin.jsp">관리자 페이지</a>
</div>

<div class="top-menu">
    회원 관리 |
    <a href="admin.jsp">대시보드</a> |
    <a href="list.jsp">게시판</a>
</div>

<div class="container">

<h1>회원 관리</h1>

<table class="board-table">
    <tr>
        <th>번호</th>
        <th>아이디</th>
        <th>이름</th>
        <th>권한</th>
        <th>상태</th>
        <th>가입일</th>
        <th>관리</th>
    </tr>

<%
for (MemberDTO member : list) {
%>
    <tr>
        <td><%= member.getId() %></td>
        <td><%= member.getUserId() %></td>
        <td><%= member.getUserName() %></td>
        <td><%= member.getRole() %></td>
        <td><%= member.getStatus() %></td>
        <td><%= member.getCreatedAt() %></td>

        <td>
            <a class="btn"
               href="adminMemberProcess.jsp?action=delete&userId=<%= member.getUserId() %>"
               onclick="return confirm('정말 회원을 삭제하시겠습니까?');">
               회원삭제
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
    Admin Member Manager
</div>

</body>
</html>