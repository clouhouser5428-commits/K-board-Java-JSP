package com.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.board.dto.BoardDTO;
import com.board.util.DBUtil;

public class BoardDAO {

    public int insertBoard(BoardDTO board) {
        int result = 0;

        String sql = "INSERT INTO board "
                   + "(title, writer, content, file_name, user_id, category) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";

        try {
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, board.getTitle());
            pstmt.setString(2, board.getWriter());
            pstmt.setString(3, board.getContent());
            pstmt.setString(4, board.getFileName());
            pstmt.setString(5, board.getUserId());
            pstmt.setString(6, board.getCategory());

            result = pstmt.executeUpdate();

            pstmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public List<BoardDTO> selectList() {
        List<BoardDTO> list = new ArrayList<>();

        String sql = "SELECT id, title, writer, content, view_count, created_at, file_name, user_id, category "
                   + "FROM board "
                   + "ORDER BY CASE WHEN category = 'NOTICE' THEN 0 ELSE 1 END, id DESC";

        try {
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                BoardDTO board = new BoardDTO();

                board.setId(rs.getInt("id"));
                board.setTitle(rs.getString("title"));
                board.setWriter(rs.getString("writer"));
                board.setContent(rs.getString("content"));
                board.setViewCount(rs.getInt("view_count"));
                board.setCreatedAt(rs.getString("created_at"));
                board.setFileName(rs.getString("file_name"));
                board.setUserId(rs.getString("user_id"));
                board.setCategory(rs.getString("category"));

                list.add(board);
            }

            rs.close();
            pstmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public BoardDTO selectOne(int id) {
        BoardDTO board = null;

        String sql = "SELECT id, title, writer, content, view_count, created_at, file_name, user_id, category "
                   + "FROM board WHERE id = ?";

        try {
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, id);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                board = new BoardDTO();

                board.setId(rs.getInt("id"));
                board.setTitle(rs.getString("title"));
                board.setWriter(rs.getString("writer"));
                board.setContent(rs.getString("content"));
                board.setViewCount(rs.getInt("view_count"));
                board.setCreatedAt(rs.getString("created_at"));
                board.setFileName(rs.getString("file_name"));
                board.setUserId(rs.getString("user_id"));
                board.setCategory(rs.getString("category"));
            }

            rs.close();
            pstmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return board;
    }

    public void increaseViewCount(int id) {
        String sql = "UPDATE board SET view_count = view_count + 1 WHERE id = ?";

        try {
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, id);
            pstmt.executeUpdate();

            pstmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int updateBoard(BoardDTO board) {
        int result = 0;

        String sql = "UPDATE board "
                   + "SET title = ?, writer = ?, content = ?, file_name = ?, category = ? "
                   + "WHERE id = ?";

        try {
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, board.getTitle());
            pstmt.setString(2, board.getWriter());
            pstmt.setString(3, board.getContent());
            pstmt.setString(4, board.getFileName());
            pstmt.setString(5, board.getCategory());
            pstmt.setInt(6, board.getId());

            result = pstmt.executeUpdate();

            pstmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public int deleteBoard(int id) {
        int result = 0;

        String sql = "DELETE FROM board WHERE id = ?";

        try {
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, id);

            result = pstmt.executeUpdate();

            pstmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public List<BoardDTO> selectListPaging(String searchType, String keyword, int startRow, int pageSize) {
        List<BoardDTO> list = new ArrayList<>();

        String sql = "";

        if (keyword == null || keyword.trim().equals("")) {
            sql = "SELECT id, title, writer, content, view_count, created_at, file_name, user_id, category "
                + "FROM board "
                + "ORDER BY CASE WHEN category = 'NOTICE' THEN 0 ELSE 1 END, id DESC "
                + "LIMIT ?, ?";
        } else {
            if ("writer".equals(searchType)) {
                sql = "SELECT id, title, writer, content, view_count, created_at, file_name, user_id, category "
                    + "FROM board "
                    + "WHERE writer LIKE ? "
                    + "ORDER BY CASE WHEN category = 'NOTICE' THEN 0 ELSE 1 END, id DESC "
                    + "LIMIT ?, ?";
            } else if ("content".equals(searchType)) {
                sql = "SELECT id, title, writer, content, view_count, created_at, file_name, user_id, category "
                    + "FROM board "
                    + "WHERE content LIKE ? "
                    + "ORDER BY CASE WHEN category = 'NOTICE' THEN 0 ELSE 1 END, id DESC "
                    + "LIMIT ?, ?";
            } else {
                sql = "SELECT id, title, writer, content, view_count, created_at, file_name, user_id, category "
                    + "FROM board "
                    + "WHERE title LIKE ? "
                    + "ORDER BY CASE WHEN category = 'NOTICE' THEN 0 ELSE 1 END, id DESC "
                    + "LIMIT ?, ?";
            }
        }

        try {
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);

            if (keyword == null || keyword.trim().equals("")) {
                pstmt.setInt(1, startRow);
                pstmt.setInt(2, pageSize);
            } else {
                pstmt.setString(1, "%" + keyword + "%");
                pstmt.setInt(2, startRow);
                pstmt.setInt(3, pageSize);
            }

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                BoardDTO board = new BoardDTO();

                board.setId(rs.getInt("id"));
                board.setTitle(rs.getString("title"));
                board.setWriter(rs.getString("writer"));
                board.setContent(rs.getString("content"));
                board.setViewCount(rs.getInt("view_count"));
                board.setCreatedAt(rs.getString("created_at"));
                board.setFileName(rs.getString("file_name"));
                board.setUserId(rs.getString("user_id"));
                board.setCategory(rs.getString("category"));

                list.add(board);
            }

            rs.close();
            pstmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public int getBoardCount(String searchType, String keyword) {
        int count = 0;

        String sql = "";

        if (keyword == null || keyword.trim().equals("")) {
            sql = "SELECT COUNT(*) FROM board";
        } else {
            if ("writer".equals(searchType)) {
                sql = "SELECT COUNT(*) FROM board WHERE writer LIKE ?";
            } else if ("content".equals(searchType)) {
                sql = "SELECT COUNT(*) FROM board WHERE content LIKE ?";
            } else {
                sql = "SELECT COUNT(*) FROM board WHERE title LIKE ?";
            }
        }

        try {
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);

            if (!(keyword == null || keyword.trim().equals(""))) {
                pstmt.setString(1, "%" + keyword + "%");
            }

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

            rs.close();
            pstmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public int getLikeCount(int boardId) {
        int count = 0;

        String sql = "SELECT COUNT(*) FROM board_like WHERE board_id = ?";

        try {
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, boardId);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

            rs.close();
            pstmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public boolean isLiked(int boardId, String userId) {
        boolean result = false;

        String sql = "SELECT COUNT(*) FROM board_like WHERE board_id = ? AND user_id = ?";

        try {
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, boardId);
            pstmt.setString(2, userId);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                result = true;
            }

            rs.close();
            pstmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public int toggleLike(int boardId, String userId) {
        int result = 0;

        try {
            Connection conn = DBUtil.getConnection();

            if (isLiked(boardId, userId)) {
                String deleteSql = "DELETE FROM board_like WHERE board_id = ? AND user_id = ?";
                PreparedStatement pstmt = conn.prepareStatement(deleteSql);

                pstmt.setInt(1, boardId);
                pstmt.setString(2, userId);

                result = pstmt.executeUpdate();

                pstmt.close();
            } else {
                String insertSql = "INSERT INTO board_like (board_id, user_id) VALUES (?, ?)";
                PreparedStatement pstmt = conn.prepareStatement(insertSql);

                pstmt.setInt(1, boardId);
                pstmt.setString(2, userId);

                result = pstmt.executeUpdate();

                pstmt.close();
            }

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
    
    public List<BoardDTO> selectMyBoardList(String userId) {

        List<BoardDTO> list = new ArrayList<>();

        String sql =
            "SELECT id, title, writer, view_count, created_at " +
            "FROM board " +
            "WHERE user_id = ? " +
            "ORDER BY id DESC";

        try {

            Connection conn = DBUtil.getConnection();

            PreparedStatement pstmt =
                conn.prepareStatement(sql);

            pstmt.setString(1, userId);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {

                BoardDTO board = new BoardDTO();

                board.setId(rs.getInt("id"));
                board.setTitle(rs.getString("title"));
                board.setWriter(rs.getString("writer"));
                board.setViewCount(rs.getInt("view_count"));
                board.setCreatedAt(rs.getString("created_at"));

                list.add(board);
            }

            rs.close();
            pstmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public List<BoardDTO> selectLikeBoardList(String userId) {

        List<BoardDTO> list = new ArrayList<>();

        String sql =
            "SELECT b.id, b.title, b.writer, b.created_at " +
            "FROM board_like bl " +
            "JOIN board b ON bl.board_id = b.id " +
            "WHERE bl.user_id = ? " +
            "ORDER BY bl.id DESC";

        try {

            Connection conn = DBUtil.getConnection();

            PreparedStatement pstmt =
                conn.prepareStatement(sql);

            pstmt.setString(1, userId);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {

                BoardDTO board =
                    new BoardDTO();

                board.setId(rs.getInt("id"));
                board.setTitle(rs.getString("title"));
                board.setWriter(rs.getString("writer"));
                board.setCreatedAt(rs.getString("created_at"));

                list.add(board);
            }

            rs.close();
            pstmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
}