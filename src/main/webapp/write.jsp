<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>

    <title>게시글 작성</title>

    <link rel="stylesheet" href="style.css">

</head>

<body>

<%
String loginId = (String) session.getAttribute("loginId");
String loginName = (String) session.getAttribute("loginName");

if (loginId == null) {
%>
    <script>
        alert("로그인 후 글쓰기가 가능합니다.");
        location.href = "login.jsp";
    </script>
<%
    return;
}
%>


<div class="header">
    <a href="list.jsp">2670030 leehyun</a>
</div>

<div class="top-menu">
    게시글 작성
</div>

<div class="container">

    <h1>게시글 작성</h1>

    <p class="board-desc">
        자유롭게 게시글을 작성할 수 있습니다.
    </p>

    <form action="writeProcess.jsp"
          method="post"
          enctype="multipart/form-data">

카테고리:
<select name="category">
    <option value="FREE">자유</option>
    <option value="QNA">질문</option>

<%
String loginRole = (String) session.getAttribute("loginRole");

if ("ADMIN".equals(loginRole)) {
%>
    <option value="NOTICE">공지사항</option>
<%
}
%>
</select>

<br><br>


        제목:
        <input type="text" name="title">

        <br><br>

        작성자:
        <input type="text"
       name="writer"
       value="<%= loginName %>"
       readonly>

        <br><br>

        내용:
        <br>

        <textarea name="content"
                  rows="10"
                  cols="50"></textarea>

        <br><br>

        파일 첨부:
        <input type="file" name="uploadFile">

        <br><br>

        <div class="btn-area">

            <input class="btn"
                   type="submit"
                   value="등록">

            <a class="btn"
               href="list.jsp">
               목록으로
            </a>

        </div>

    </form>

</div>

<div class="footer">
    2670030 leehyun
</div>

</body>
</html>