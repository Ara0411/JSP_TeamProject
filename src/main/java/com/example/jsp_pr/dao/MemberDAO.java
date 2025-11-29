package com.example.jsp_pr.dao;

import com.example.jsp_pr.dto.MemberDTO;
import java.sql.*;
// 회원 관련 DB 작업(로그인, 회원가입)을 전담하는 DAO 클래스
// - JSP에서 지저분한 SQL 코드를 분리하기 위해 따로 만듦.
public class MemberDAO {
    // 로그인 처리(아이디와 비밀번호를 받아서, 일치하는 회원이 있으면 정보를 담은 DTO를 반환함)
    public MemberDTO login(String id, String pass) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        MemberDTO dto = null;// 로그인 실패 시 null 반환

        // 아이디와 비밀번호가 둘 다 맞는 행을 찾는 쿼리
        String sql = "SELECT * FROM member WHERE id = ? AND pass = ?";

        try {
            conn = DBUtill.getConnection(); // DB 연결
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, pass);
            rs = pstmt.executeQuery(); // 쿼리 실행
            // 결과가 있다면 (로그인 성공)
            if (rs.next()) {
                dto = new MemberDTO();
                dto.setId(rs.getString("id"));
                dto.setName(rs.getString("name"));
                dto.setRole(rs.getString("role")); // 관리자 여부 확인을 위해 권한 정보도 가져옴
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 자원 해제
            try { if(rs!=null) rs.close(); if(pstmt!=null) pstmt.close(); if(conn!=null) conn.close(); } catch(Exception e){}
        }
        return dto; // 결과 배달 (성공하면 DTO, 실패하면 null)
    }

    // 회원가입 처리(사용자가 입력한 정보를 DB에 저장 (성공하면 1, 실패하면 0 반환))
    public int join(MemberDTO dto) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int result = 0;
        // 신규 회원은 기본적으로 권한을 'USER'(일반)로 설정함
        String sql = "INSERT INTO member (id, pass, name, role) VALUES (?, ?, ?, 'USER')";

        try {
            conn = DBUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            // DTO에 담겨온 데이터를 쿼리에 세팅
            pstmt.setString(1, dto.getId());
            pstmt.setString(2, dto.getPass());
            pstmt.setString(3, dto.getName());
            result = pstmt.executeUpdate();// DB에 반영 (Insert)
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if(pstmt!=null) pstmt.close(); if(conn!=null) conn.close(); } catch(Exception e){}
        }
        return result;
    }
}