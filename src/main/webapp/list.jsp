<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.board.dto.BoardDTO" %>
<%@ page import="com.board.dao.BoardDAO" %>
<%@ page import="com.board.dao.NotificationDAO" %>

<%
request.setCharacterEncoding("UTF-8");

String loginId = (String) session.getAttribute("loginId");
String loginName = (String) session.getAttribute("loginName");

int unreadCount = 0;

if (loginId != null) {
    NotificationDAO notiDao = new NotificationDAO();
    unreadCount = notiDao.getUnreadCount(loginId);
}

String searchType = request.getParameter("searchType");
String keyword = request.getParameter("keyword");

if (searchType == null) {
    searchType = "title";
}

if (keyword == null) {
    keyword = "";
}

int pageSize = 5;

String pageNumParam = request.getParameter("pageNum");

int pageNum = 1;

if (pageNumParam != null) {
    pageNum = Integer.parseInt(pageNumParam);
}

int startRow = (pageNum - 1) * pageSize;

BoardDAO dao = new BoardDAO();

int totalCount = dao.getBoardCount(searchType, keyword);

List<BoardDTO> list = dao.selectListPaging(searchType, keyword, startRow, pageSize);

int totalPage = 0;

if (totalCount > 0) {
    totalPage = (int)Math.ceil((double)totalCount / pageSize);
}
%>

<html>
<head>
    <title>게시글 목록</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>

<div class="header">
    <a href="list.jsp">2670030 leehyun</a>
</div>

<div class="top-menu">
<%
if (loginName == null) {
%>
    <a href="login.jsp">로그인</a>
    |
    <a href="join.jsp">회원가입</a>

<%
} else {
%>
    <%= loginName %>님 환영합니다
    |
    <a href="notification.jsp">알림 <%= unreadCount %>개</a>
    <%
if ("ADMIN".equals((String)session.getAttribute("loginRole"))) {
%>
    |
    <a href="admin.jsp">관리자</a>
<%
}
%>
    |
    <a href="myPage.jsp">마이페이지</a>
    |
    <a href="logout.jsp">로그아웃</a>
<%
}
%>
</div>

<div class="container">

    <h1>자유게시판</h1>

    <p class="board-desc">
        자유롭게 글을 작성할 수 있는 게시판입니다.
    </p>

    <form action="list.jsp" method="get" style="margin-bottom:20px;">

        <select name="searchType">
            <option value="title" <%= "title".equals(searchType) ? "selected" : "" %>>제목</option>
            <option value="writer" <%= "writer".equals(searchType) ? "selected" : "" %>>작성자</option>
            <option value="content" <%= "content".equals(searchType) ? "selected" : "" %>>내용</option>
        </select>

        <input type="text"
               name="keyword"
               value="<%= keyword %>"
               style="width:300px;">

        <input class="btn" type="submit" value="검색">

        <a class="btn" href="list.jsp">전체보기</a>

    </form>

    <table class="board-table">

        <tr>
            <th>번호</th>
            <th>분류</th>
            <th>제목</th>
            <th>작성자</th>
            <th>조회수</th>
            <th>작성일</th>
        </tr>

<%
if (list.size() == 0) {
%>

        <tr>
            <td colspan="6">
                게시글이 없습니다.
            </td>
        </tr>

<%
} else {
    for (BoardDTO board : list) {
%>

  <tr <%= "NOTICE".equals(board.getCategory()) ? "style='background:#fff3f3; font-weight:bold;'" : "" %>>
    <td><%= board.getId() %></td>

    <td>
<%
if ("NOTICE".equals(board.getCategory())) {
%>
        공지
<%
} else if ("QNA".equals(board.getCategory())) {
%>
        질문
<%
} else {
%>
        자유
<%
}
%>
    </td>

    <td class="title">

<%
if ("NOTICE".equals(board.getCategory())) {
%>
        <span style="background:#c62828; color:white; padding:2px 6px; border-radius:4px; font-size:12px; margin-right:6px;">
            공지
        </span>
<%
}
%>

        <a href="view.jsp?id=<%= board.getId() %>">
            <%= board.getTitle() %>
        </a>
    </td>

            <td><%= board.getWriter() %></td>

            <td><%= board.getViewCount() %></td>

            <td><%= board.getCreatedAt() %></td>
        </tr>

<%
    }
}
%>

    </table>

    <div style="text-align:center; margin-top:20px;">

<%
if (totalPage > 0) {
    for (int i = 1; i <= totalPage; i++) {
        if (i == pageNum) {
%>

        <strong>[<%= i %>]</strong>

<%
        } else {
%>

        <a href="list.jsp?pageNum=<%= i %>&searchType=<%= searchType %>&keyword=<%= keyword %>">
            [<%= i %>]
        </a>

<%
        }
    }
}
%>

    </div>

    <div class="btn-area">
        <a class="btn" href="write.jsp">글쓰기</a>
    </div>

</div>

<div class="footer">
    2670030 leehyun
</div>

</body>
</html>