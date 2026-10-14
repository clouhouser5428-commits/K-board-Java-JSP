package com.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.board.dto.MemberDTO;
import com.board.util.DBUtil;

public class MemberDAO {

    public int join(MemberDTO member) {
        int result = 0;

        String sql = "INSERT INTO member (user_id, user_pw, user_name, role, status) VALUES (?, ?, ?, 'USER', 'ACTIVE')";

        try {
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, member.getUserId());
            pstmt.setString(2, member.getUserPw());
            pstmt.setString(3, member.getUserName());

            result = pstmt.executeUpdate();

            pstmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public MemberDTO login(String userId, String userPw) {
        MemberDTO member = null;

        String sql = "SELECT id, user_id, user_pw, user_name, created_at, role, status "
                   + "FROM member "
                   + "WHERE user_id = ? AND user_pw = ?";

        try {
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, userId);
            pstmt.setString(2, userPw);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                member = new MemberDTO();

                member.setId(rs.getInt("id"));
                member.setUserId(rs.getString("user_id"));
                member.setUserPw(rs.getString("user_pw"));
                member.setUserName(rs.getString("user_name"));
                member.setCreatedAt(rs.getString("created_at"));
                member.setRole(rs.getString("role"));
                member.setStatus(rs.getString("status"));
            }

            rs.close();
            pstmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return member;
    }

    public int getMemberCount() {
        int count = 0;

        String sql = "SELECT COUNT(*) FROM member";

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

    public List<MemberDTO> selectList() {
        List<MemberDTO> list = new ArrayList<>();

        String sql = "SELECT id, user_id, user_pw, user_name, role, status, created_at "
                   + "FROM member "
                   + "ORDER BY id DESC";

        try {
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                MemberDTO member = new MemberDTO();

                member.setId(rs.getInt("id"));
                member.setUserId(rs.getString("user_id"));
                member.setUserPw(rs.getString("user_pw"));
                member.setUserName(rs.getString("user_name"));
                member.setRole(rs.getString("role"));
                member.setStatus(rs.getString("status"));
                member.setCreatedAt(rs.getString("created_at"));

                list.add(member);
            }

            rs.close();
            pstmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public int updateStatus(String userId, String status) {
        int result = 0;

        String sql = "UPDATE member SET status = ? WHERE user_id = ?";

        try {
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, status);
            pstmt.setString(2, userId);

            result = pstmt.executeUpdate();

            pstmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public int updateRole(String userId, String role) {
        int result = 0;

        String sql = "UPDATE member SET role = ? WHERE user_id = ?";

        try {
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, role);
            pstmt.setString(2, userId);

            result = pstmt.executeUpdate();

            pstmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public int deleteMember(String userId) {
        int result = 0;

        String sql = "DELETE FROM member WHERE user_id = ?";

        try {
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, userId);

            result = pstmt.executeUpdate();

            pstmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
}