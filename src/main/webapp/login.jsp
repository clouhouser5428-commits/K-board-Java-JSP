<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
    <title>로그인</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>

<div class="header">
    <a href="list.jsp">2670030 leehyun</a>
</div>

<div class="top-menu">
    로그인
</div>

<div class="container">

    <h1>로그인</h1>

    <form action="loginProcess.jsp" method="post">

        아이디:
        <input type="text" name="userId">

        <br><br>

        비밀번호:
        <input type="password" name="userPw">

        <br><br>

        <div class="btn-area">
            <input class="btn" type="submit" value="로그인">
            <a class="btn" href="join.jsp">회원가입</a>
            <a class="btn" href="list.jsp">목록으로</a>
        </div>

    </form>

</div>

<div class="footer">
    2670030 leehyun
</div>

</body>
</html>