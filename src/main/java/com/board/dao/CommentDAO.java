package com.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.board.dto.CommentDTO;
import com.board.util.DBUtil;

public class CommentDAO {

    public int insertComment(CommentDTO comment) {
        int result = 0;

        String sql = "INSERT INTO comment (board_id, user_id, writer, content, parent_id) VALUES (?, ?, ?, ?, ?)";
        try {
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, comment.getBoardId());
            pstmt.setString(2, comment.getUserId());
            pstmt.setString(3, comment.getWriter());
            pstmt.setString(4, comment.getContent());
            pstmt.setInt(5, comment.getParentId());

            result = pstmt.executeUpdate();

            pstmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public List<CommentDTO> selectCommentList(int boardId) {
        List<CommentDTO> list = new ArrayList<>();

        String sql = "SELECT id, board_id, user_id, writer, content, created_at, parent_id "
                + "FROM comment "
                + "WHERE board_id = ? "
                + "ORDER BY "
                + "CASE WHEN parent_id = 0 THEN id ELSE parent_id END ASC, "
                + "parent_id ASC, "
                + "id ASC";

        try {
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, boardId);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                CommentDTO comment = new CommentDTO();

                comment.setId(rs.getInt("id"));
                comment.setBoardId(rs.getInt("board_id"));
                comment.setUserId(rs.getString("user_id"));
                comment.setWriter(rs.getString("writer"));
                comment.setContent(rs.getString("content"));
                comment.setCreatedAt(rs.getString("created_at"));
                comment.setParentId(rs.getInt("parent_id"));

                list.add(comment);
            }

            rs.close();
            pstmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public int deleteComment(int id) {
        int result = 0;

        String sql = "DELETE FROM comment WHERE id = ?";

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
    
    public CommentDTO selectOne(int id) {
        CommentDTO comment = null;

        String sql = "SELECT id, board_id, user_id, writer, content, created_at, parent_id "
                   + "FROM comment WHERE id = ?";

        try {
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, id);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                comment = new CommentDTO();

                comment.setId(rs.getInt("id"));
                comment.setBoardId(rs.getInt("board_id"));
                comment.setUserId(rs.getString("user_id"));
                comment.setWriter(rs.getString("writer"));
                comment.setContent(rs.getString("content"));
                comment.setCreatedAt(rs.getString("created_at"));
                comment.setParentId(rs.getInt("parent_id"));
            }

            rs.close();
            pstmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return comment;
    }
    
    public int getCommentCount() {
        int count = 0;

        String sql = "SELECT COUNT(*) FROM comment";

        try {
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
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
    
    public List<CommentDTO> selectAll() {
        List<CommentDTO> list = new ArrayList<>();

        String sql = "SELECT id, board_id, user_id, writer, content, created_at, parent_id "
                   + "FROM comment "
                   + "ORDER BY id DESC";

        try {
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                CommentDTO comment = new CommentDTO();

                comment.setId(rs.getInt("id"));
                comment.setBoardId(rs.getInt("board_id"));
                comment.setUserId(rs.getString("user_id"));
                comment.setWriter(rs.getString("writer"));
                comment.setContent(rs.getString("content"));
                comment.setCreatedAt(rs.getString("created_at"));
                comment.setParentId(rs.getInt("parent_id"));

                list.add(comment);
            }

            rs.close();
            pstmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public List<CommentDTO> selectMyCommentList(String userId) {

        List<CommentDTO> list = new ArrayList<>();

        String sql =
            "SELECT id, board_id, content, created_at " +
            "FROM comment " +
            "WHERE user_id = ? " +
            "ORDER BY id DESC";

        try {

            Connection conn = DBUtil.getConnection();

            PreparedStatement pstmt =
                conn.prepareStatement(sql);

            pstmt.setString(1, userId);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {

                CommentDTO comment =
                    new CommentDTO();

                comment.setId(rs.getInt("id"));
                comment.setBoardId(rs.getInt("board_id"));
                comment.setContent(rs.getString("content"));
                comment.setCreatedAt(rs.getString("created_at"));

                list.add(comment);
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