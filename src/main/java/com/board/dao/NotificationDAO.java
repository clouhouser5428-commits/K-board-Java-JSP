package com.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.board.dto.NotificationDTO;
import com.board.util.DBUtil;

public class NotificationDAO {

    public int insertNotification(NotificationDTO noti) {
        int result = 0;

        String sql = "INSERT INTO notification "
                   + "(receiver_id, sender_id, board_id, message) "
                   + "VALUES (?, ?, ?, ?)";

        try {
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, noti.getReceiverId());
            pstmt.setString(2, noti.getSenderId());
            pstmt.setInt(3, noti.getBoardId());
            pstmt.setString(4, noti.getMessage());

            result = pstmt.executeUpdate();

            pstmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public List<NotificationDTO> selectList(String receiverId) {
        List<NotificationDTO> list = new ArrayList<>();

        String sql = "SELECT id, receiver_id, sender_id, board_id, message, is_read, created_at "
                   + "FROM notification "
                   + "WHERE receiver_id = ? "
                   + "ORDER BY id DESC";

        try {
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, receiverId);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                NotificationDTO noti = new NotificationDTO();

                noti.setId(rs.getInt("id"));
                noti.setReceiverId(rs.getString("receiver_id"));
                noti.setSenderId(rs.getString("sender_id"));
                noti.setBoardId(rs.getInt("board_id"));
                noti.setMessage(rs.getString("message"));
                noti.setIsRead(rs.getString("is_read"));
                noti.setCreatedAt(rs.getString("created_at"));

                list.add(noti);
            }

            rs.close();
            pstmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public int getUnreadCount(String receiverId) {
        int count = 0;

        String sql = "SELECT COUNT(*) FROM notification "
                   + "WHERE receiver_id = ? AND is_read = 'N'";

        try {
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, receiverId);

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

    public int markAsRead(int id) {
        int result = 0;

        String sql = "UPDATE notification SET is_read = 'Y' WHERE id = ?";

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
    
    public int getNotificationCount() {
        int count = 0;

        String sql = "SELECT COUNT(*) FROM notification";

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
}