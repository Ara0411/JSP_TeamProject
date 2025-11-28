package com.example.jsp_pr.dao;


import com.example.jsp_pr.dto.NoticeDTO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
// 공지사랑 게시판의 DB 작업을 전담하는 클래스
public class NoticeDAO {

    // 1. 공지사항 글쓰기 (INSERT)
    public void insertNotice(NoticeDTO dto) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        // 상단 고정 체크박스 값이 없으면 기본값 'N'으로 설정
        String fixed = (dto.getIs_fixed() == null) ? "N" : dto.getIs_fixed();
        //쿼리 준비: 제목, 내용, 작성자, 고정여부 (날짜 조회수 자동)
        String sql = "INSERT INTO board_notice (title, content, writer, is_fixed) VALUES (?, ?, ?, ?)";

        try {
            conn = DBUtill.getConnection(); // 공통 DB 연결 도구
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getTitle());
            pstmt.setString(2, dto.getContent());
            pstmt.setString(3, dto.getWriter());
            pstmt.setString(4, fixed);
            pstmt.executeUpdate(); //DB에 전송
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, pstmt, null); //자원 반납
        }
    }

    // 2. 공지사항 목록 조회 (SELECT)
    public List<NoticeDTO> getNoticeList() {
        List<NoticeDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // 중요 공지를 최상단에 먼저 보여주고 나머지 최신순 정렬
        String sql = "SELECT * FROM board_notice ORDER BY is_fixed DESC, id DESC";

        try {
            conn = DBUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            // 결과 반복문으로 돌려 리스트에 담음
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

            // 읽었으니 조회수 증가시키기
            String updateSql = "UPDATE board_notice SET viewcnt = viewcnt + 1 WHERE id = ?";
            pstmt = conn.prepareStatement(updateSql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
            pstmt.close(); // 쓰고 닫기

            // 진짜 글 내용 가져오기
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

    // 4. 공지사항 삭제 (DELETE)
    public int deleteNotice(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int result = 0;
        String sql = "DELETE FROM board_notice WHERE id = ?";

        try {
            conn = DBUtill.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            result = pstmt.executeUpdate(); //성공하면 1리턴
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