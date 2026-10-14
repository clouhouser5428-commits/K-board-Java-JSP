<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.board.dto.BoardDTO" %>
<%@ page import="com.board.dao.BoardDAO" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>

<%
String uploadPath = application.getRealPath("/upload");
int maxSize = 1024 * 1024 * 10;

MultipartRequest multi = new MultipartRequest(
    request,
    uploadPath,
    maxSize,
    "UTF-8",
    new DefaultFileRenamePolicy()
);

int id = Integer.parseInt(multi.getParameter("id"));
String title = multi.getParameter("title");
String writer = multi.getParameter("writer");
String content = multi.getParameter("content");

String oldFileName = multi.getParameter("oldFileName");
String newFileName = multi.getFilesystemName("uploadFile");

String fileName;

if (newFileName == null || newFileName.equals("")) {
    fileName = oldFileName;
} else {
    fileName = newFileName;
}

BoardDTO board = new BoardDTO();
board.setId(id);
board.setTitle(title);
board.setWriter(writer);
board.setContent(content);
board.setFileName(fileName);

BoardDAO dao = new BoardDAO();
int result = dao.updateBoard(board);

if (result > 0) {
%>
<script>
    alert("게시글이 수정되었습니다.");
    location.href = "view.jsp?id=<%= id %>";
</script>
<%
} else {
%>
<script>
    alert("게시글 수정 실패");
    history.back();
</script>
<%
}
%>