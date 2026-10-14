<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.board.dto.MemberDTO" %>
<%@ page import="com.board.dao.MemberDAO" %>

<%
request.setCharacterEncoding("UTF-8");

String userId = request.getParameter("userId");
String userPw = request.getParameter("userPw");
String userName = request.getParameter("userName");

MemberDTO member = new MemberDTO();
member.setUserId(userId);
member.setUserPw(userPw);
member.setUserName(userName);

MemberDAO dao = new MemberDAO();
int result = dao.join(member);

if (result > 0) {
%>
    <script>
        alert("회원가입 성공");
        location.href = "login.jsp";
    </script>
<%
} else {
%>
    <script>
        alert("회원가입 실패. 이미 존재하는 아이디일 수 있습니다.");
        history.back();
    </script>
<%
}
%>