<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.board.dto.MemberDTO" %>
<%@ page import="com.board.dao.MemberDAO" %>

<%
request.setCharacterEncoding("UTF-8");

String userId = request.getParameter("userId");
String userPw = request.getParameter("userPw");

MemberDAO dao = new MemberDAO();
MemberDTO member = dao.login(userId, userPw);

if (member != null) {
    session.setAttribute("loginId", member.getUserId());
    session.setAttribute("loginName", member.getUserName());
    session.setAttribute("loginRole", member.getRole());
%>
    <script>
        alert("로그인 성공");
        location.href = "list.jsp";
    </script>
<%
} else {
%>
    <script>
        alert("아이디 또는 비밀번호가 틀렸습니다.");
        history.back();
    </script>
<%
}
%>