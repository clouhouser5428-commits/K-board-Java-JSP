<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.board.dto.BoardDTO" %>
<%@ page import="com.board.dao.BoardDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.board.dto.CommentDTO" %>
<%@ page import="com.board.dao.CommentDAO" %>

<%
int id = Integer.parseInt(request.getParameter("id"));

BoardDAO dao = new BoardDAO();
dao.increaseViewCount(id);
BoardDTO board = dao.selectOne(id);

String loginId = (String) session.getAttribute("loginId");
String loginName = (String) session.getAttribute("loginName");
String loginRole = (String) session.getAttribute("loginRole");

int likeCount = dao.getLikeCount(id);
boolean liked = false;

if (loginId != null) {
    liked = dao.isLiked(id, loginId);
}

CommentDAO commentDao = new CommentDAO();
List<CommentDTO> commentList = commentDao.selectCommentList(id);
%>

<html>
<head>
    <title>게시글 상세보기</title>
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
    <a href="logout.jsp">로그아웃</a>
<%
}
%>
</div>

<div class="container">

<h1>게시글 상세보기</h1>

<%
if (board != null) {
%>

    <p><strong>번호:</strong> <%= board.getId() %></p>
    <p><strong>제목:</strong> <%= board.getTitle() %></p>
    <p><strong>작성자:</strong> <%= board.getWriter() %></p>
    <p><strong>조회수:</strong> <%= board.getViewCount() %></p>
    <p><strong>작성일:</strong> <%= board.getCreatedAt() %></p>

    <p><strong>내용:</strong></p>

    <div class="content-box">
        <%= board.getContent() %>
    </div>

    <div style="margin-top:20px; margin-bottom:20px;">
        <a class="btn" href="likeProcess.jsp?boardId=<%= board.getId() %>">
            <%= liked ? "좋아요 취소" : "좋아요" %> (<%= likeCount %>)
        </a>
    </div>

    <p><strong>첨부파일:</strong></p>

<%
if (board.getFileName() != null && !board.getFileName().equals("")) {
%>

    <a href="upload/<%= board.getFileName() %>" download>
        <%= board.getFileName() %>
    </a>

    <br><br>

    <img src="upload/<%= board.getFileName() %>" width="300">

<%
} else {
%>

    첨부파일 없음

<%
}
%>

    <div class="btn-area">

<%
if (loginId != null && loginId.equals(board.getUserId())) {
%>

        <a class="btn" href="edit.jsp?id=<%= board.getId() %>">수정</a>

<%
}

if (loginId != null && (loginId.equals(board.getUserId()) || "ADMIN".equals(loginRole))) {
%>

        <a class="btn"
           href="deleteProcess.jsp?id=<%= board.getId() %>"
           onclick="return confirm('정말 삭제하시겠습니까?');">
           삭제
        </a>

<%
}
%>
<a class="btn" href="report.jsp?boardId=<%= board.getId() %>">신고</a>

        <a class="btn" href="list.jsp">목록으로</a>

    </div>

    <div class="comment-section">

        <h2>댓글</h2>

<%
if (loginId != null) {
%>

        <form class="comment-form" action="commentProcess.jsp" method="post">
            <input type="hidden" name="boardId" value="<%= board.getId() %>">
            <input type="hidden" name="parentId" value="0">

            <textarea name="content" placeholder="댓글을 입력하세요"></textarea>

            <div class="btn-area">
                <input class="btn" type="submit" value="댓글 등록">
            </div>
        </form>

<%
} else {
%>

        <p>댓글을 작성하려면 로그인해야 합니다.</p>

<%
}
%>

<%
if (commentList.size() == 0) {
%>

        <p>등록된 댓글이 없습니다.</p>

<%
} else {
    for (CommentDTO comment : commentList) {
%>

        <div class="comment-item <%= comment.getParentId() != 0 ? "reply-comment" : "" %>">

            <div class="comment-meta">
                <span class="comment-writer">
                    <%= comment.getWriter() %>
                </span>

                <span>
                    <%= comment.getCreatedAt() %>
                </span>
            </div>

            <div class="comment-content">
                <%= comment.getContent() %>
            </div>

<%
        if (loginId != null && comment.getParentId() == 0) {
%>

            <form class="reply-form" action="commentProcess.jsp" method="post">
                <input type="hidden" name="boardId" value="<%= board.getId() %>">
                <input type="hidden" name="parentId" value="<%= comment.getId() %>">

                <textarea name="content" placeholder="답글을 입력하세요"></textarea>

                <div class="btn-area">
                    <input class="btn comment-delete" type="submit" value="답글 등록">
                </div>
            </form>

<%
        }
%>

<%
        if (loginId != null &&
            (loginId.equals(comment.getUserId()) || "ADMIN".equals(loginRole))) {
%>

            <div class="comment-actions">
                <a class="btn comment-delete"
                   href="commentDelete.jsp?id=<%= comment.getId() %>&boardId=<%= board.getId() %>"
                   onclick="return confirm('댓글을 삭제하시겠습니까?');">
                   삭제
                </a>
            </div>

<%
        }
%>

        </div>

<%
    }
}
%>

    </div>

<%
} else {
%>

    <p>게시글을 찾을 수 없습니다.</p>

    <div class="btn-area">
        <a class="btn" href="list.jsp">목록으로</a>
    </div>

<%
}
%>

</div>

<div class="footer">
    2670030 leehyun
</div>

</body>
</html>