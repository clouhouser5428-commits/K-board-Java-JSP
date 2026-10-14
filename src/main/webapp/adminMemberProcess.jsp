<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

String action = request.getParameter("action");
String userId = request.getParameter("userId");

MemberDAO dao = new MemberDAO();

if ("ban".equals(action)) {
    dao.updateStatus(userId, "BAN");
} else if ("active".equals(action)) {
    dao.updateStatus(userId, "ACTIVE");
} else if ("admin".equals(action)) {
    dao.updateRole(userId, "ADMIN");
} else if ("user".equals(action)) {
    dao.updateRole(userId, "USER");
} else if ("delete".equals(action)) {
    dao.deleteMember(userId);
}
%>

<script>
    alert("처리되었습니다.");
    location.href = "adminMember.jsp";
</script>