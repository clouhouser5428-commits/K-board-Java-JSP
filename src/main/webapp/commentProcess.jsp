<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.board.dto.CommentDTO" %>
<%@ page import="com.board.dao.CommentDAO" %>
<%@ page import="com.board.dto.BoardDTO" %>
<%@ page import="com.board.dao.BoardDAO" %>
<%@ page import="com.board.dto.NotificationDTO" %>
<%@ page import="com.board.dao.NotificationDAO" %>

<%
request.setCharacterEncoding("UTF-8");

String loginId = (String) session.getAttribute("loginId");
String loginName = (String) session.getAttribute("loginName");

if (loginId == null) {
%>
<script>
    alert("로그인이 필요합니다.");
    location.href = "login.jsp";
</script>
<%
    return;
}

int boardId = Integer.parseInt(request.getParameter("boardId"));
String content = request.getParameter("content");

String parentIdParam = request.getParameter("parentId");
int parentId = 0;

if (parentIdParam != null && !parentIdParam.equals("")) {
    parentId = Integer.parseInt(parentIdParam);
}

CommentDTO comment = new CommentDTO();
comment.setBoardId(boardId);
comment.setUserId(loginId);
comment.setWriter(loginName);
comment.setContent(content);
comment.setParentId(parentId);

CommentDAO commentDao = new CommentDAO();
int result = commentDao.insertComment(comment);

if (result > 0) {

    NotificationDAO notificationDao = new NotificationDAO();

    if (parentId == 0) {
        BoardDAO boardDao = new BoardDAO();
        BoardDTO board = boardDao.selectOne(boardId);

        if (board != null && board.getUserId() != null && !board.getUserId().equals(loginId)) {
            NotificationDTO noti = new NotificationDTO();

            noti.setReceiverId(board.getUserId());
            noti.setSenderId(loginId);
            noti.setBoardId(boardId);
            noti.setMessage(loginName + "님이 내 게시글에 댓글을 남겼습니다.");

            notificationDao.insertNotification(noti);
        }

    } else {
        CommentDTO parentComment = commentDao.selectOne(parentId);

        if (parentComment != null && parentComment.getUserId() != null && !parentComment.getUserId().equals(loginId)) {
            NotificationDTO noti = new NotificationDTO();

            noti.setReceiverId(parentComment.getUserId());
            noti.setSenderId(loginId);
            noti.setBoardId(boardId);
            noti.setMessage(loginName + "님이 내 댓글에 답글을 남겼습니다.");

            notificationDao.insertNotification(noti);
        }
    }
%>
<script>
    alert("댓글이 등록되었습니다.");
    location.href = "view.jsp?id=<%= boardId %>";
</script>
<%
} else {
%>
<script>
    alert("댓글 등록 실패");
    history.back();
</script>
<%
}
%>