<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.board.dto.BoardDTO" %>
<%@ page import="com.board.dao.BoardDAO" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>

<%
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

String uploadPath = application.getRealPath("/upload");

int maxSize = 1024 * 1024 * 10;

MultipartRequest multi = new MultipartRequest(
    request,
    uploadPath,
    maxSize,
    "UTF-8",
    new DefaultFileRenamePolicy()
);

String title = multi.getParameter("title");
String writer = loginName;
String content = multi.getParameter("content");
String fileName = multi.getFilesystemName("uploadFile");
String category = multi.getParameter("category");

if (category == null || category.equals("")) {
    category = "FREE";
}

BoardDTO board = new BoardDTO();
board.setTitle(title);
board.setWriter(writer);
board.setContent(content);
board.setFileName(fileName);
board.setUserId(loginId);
board.setCategory(category);

BoardDAO dao = new BoardDAO();
int result = dao.insertBoard(board);

if (result > 0) {
%>
    <script>
        alert("게시글이 등록되었습니다.");
        location.href = "list.jsp";
    </script>
<%
} else {
%>
    <script>
        alert("게시글 등록 실패");
        history.back();
    </script>
<%
}
%>