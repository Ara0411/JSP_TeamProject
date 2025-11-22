package com.example.jsp_pr.dao;


import com.example.jsp_pr.dto.NoticeDTO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NoticeDAO {

    // 1. 공지사항 글쓰기 (INSERT)
    public void insertNotice(NoticeDTO dto) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        // is_fixed가 null이면 'N'으로 처리
        String fixed = (dto.getIs_fixed() == null) ? "N" : dto.getIs_fixed();

        String sql = "INSERT INTO board_notice (title, content, writer, is_fixed) VALUES (?, ?, ?, ?)";

        try {
            conn = DBUtill.getConnection(); // 기존 팀장님 코드(DBUtill) 사용
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getTitle());
            pstmt.setString(2, dto.getContent());
            pstmt.setString(3, dto.getWriter());
            pstmt.setString(4, fixed); // 상단 고정 여부 ('Y' or 'N')
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, pstmt, null);
        }
    }

    // 2. 공지사항 목록 조회 (SELECT) - 중요 공지(Y)가 먼저 나오고, 나머지는 최신순
    public List<NoticeDTO> getNoticeList() {
        List<NoticeDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // 정렬 핵심: is_fixed 내림차순(Y가 N보다 큼) -> 그 다음 글번호 내림차순
        String sql = "SELECT * FROM board_notice ORDER BY is_fixed DESC, id DESC";

        try {
            conn = DBUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                NoticeDTO dto = new NoticeDTO();
                dto.setId(rs.getInt("id"));
                dto.setTitle(rs.getString("title"));
                dto.setWriter(rs.getString("writer"));
                dto.setViewcnt(rs.getInt("viewcnt"));
                dto.setRegdate(rs.getTimestamp("regdate"));
                dto.setIs_fixed(rs.getString("is_fixed")); // 고정 여부 가져오기
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, pstmt, rs);
        }
        return list;
    }

    // 3. 공지사항 상세보기 (SELECT ONE)
    public NoticeDTO getNoticeDetail(int id) {
        NoticeDTO dto = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM board_notice WHERE id = ?";

        try {
            conn = DBUtill.getConnection();

            // 조회수 증가 먼저 실행
            String updateSql = "UPDATE board_notice SET viewcnt = viewcnt + 1 WHERE id = ?";
            pstmt = conn.prepareStatement(updateSql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
            pstmt.close(); // 쓰고 닫기

            // 상세 내용 가져오기
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                dto = new NoticeDTO();
                dto.setId(rs.getInt("id"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content"));
                dto.setWriter(rs.getString("writer"));
                dto.setViewcnt(rs.getInt("viewcnt"));
                dto.setRegdate(rs.getTimestamp("regdate"));
                dto.setIs_fixed(rs.getString("is_fixed"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, pstmt, rs);
        }
        return dto;
    }

    // 4. 공지사항 삭제 (DELETE) - 이 부분이 빠져있어서 500 에러가 났던 겁니다!
    public int deleteNotice(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int result = 0;
        String sql = "DELETE FROM board_notice WHERE id = ?";

        try {
            conn = DBUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, pstmt, null);
        }
        return result;
    }
    // 5. 자원 해제 (close) - 반복되니까 메소드로 뺌
    private void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}