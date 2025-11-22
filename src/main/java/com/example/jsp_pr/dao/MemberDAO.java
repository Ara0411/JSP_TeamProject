package com.example.jsp_pr.dao;

import com.example.jsp_pr.dto.MemberDTO;
import java.sql.*;

public class MemberDAO {
    // 로그인 체크 (성공하면 이름과 권한 반환, 실패하면 null)
    public MemberDTO login(String id, String pass) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        MemberDTO dto = null;

        String sql = "SELECT * FROM member WHERE id = ? AND pass = ?";

        try {
            conn = DBUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, pass);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                dto = new MemberDTO();
                dto.setId(rs.getString("id"));
                dto.setName(rs.getString("name"));
                dto.setRole(rs.getString("role")); // 관리자 여부 확인용
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 자원 해제 (간략화)
            try { if(rs!=null) rs.close(); if(pstmt!=null) pstmt.close(); if(conn!=null) conn.close(); } catch(Exception e){}
        }
        return dto;
    }

    // 회원가입
    public int join(MemberDTO dto) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int result = 0;
        String sql = "INSERT INTO member (id, pass, name, role) VALUES (?, ?, ?, 'USER')";

        try {
            conn = DBUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getId());
            pstmt.setString(2, dto.getPass());
            pstmt.setString(3, dto.getName());
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if(pstmt!=null) pstmt.close(); if(conn!=null) conn.close(); } catch(Exception e){}
        }
        return result;
    }
}