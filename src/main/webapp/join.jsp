<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
    <title>회원가입</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>

<div class="header">
    <a href="list.jsp">K-board</a>
</div>

<div class="top-menu">
    회원가입
</div>

<div class="container">

    <h1>회원가입</h1>

    <form action="joinProcess.jsp" method="post">

        아이디:
        <input type="text" name="userId">

        <br><br>

        비밀번호:
        <input type="password" name="userPw">

        <br><br>

        이름:
        <input type="text" name="userName">

        <br><br>

        <div class="btn-area">
            <input class="btn" type="submit" value="회원가입">
            <a class="btn" href="login.jsp">로그인</a>
            <a class="btn" href="list.jsp">목록으로</a>
        </div>

    </form>

</div>

<div class="footer">
    2670030 leehyun
</div>

</body>
</html>