<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
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
%>

<html>
<head>
    <title>게시글 신고</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="header">
    <a href="list.jsp">K-board</a>
</div>

<div class="top-menu">
    게시글 신고
</div>

<div class="container">

<h1>게시글 신고</h1>

<form action="reportProcess.jsp" method="post">
    <input type="hidden" name="boardId" value="<%= boardId %>">

    신고 사유:
    <textarea name="reason" rows="8" placeholder="신고 사유를 입력하세요"></textarea>

    <div class="btn-area">
        <input class="btn" type="submit" value="신고하기">
        <a class="btn" href="view.jsp?id=<%= boardId %>">취소</a>
    </div>
</form>

</div>

<div class="footer">
    Report
</div>

</body>
</html>