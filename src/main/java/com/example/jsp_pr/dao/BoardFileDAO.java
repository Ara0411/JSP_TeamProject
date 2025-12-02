package com.example.jsp_pr.dao;

import com.example.jsp_pr.dto.BoardFileDTO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * [주석 작성자] 최아라
 * [클래스 역할] 자료실(board_file) DAO
 * [주요 기능]
 *   - 파일형 게시글(board_file)에 대한 CRUD 중 일부(등록, 목록, 상세조회, 다운로드 수 증가)를 담당
 *   - DB 연결은 공통 유틸(DBUtill)을 사용
 */

public class BoardFileDAO {

    /**
     * 파일형 게시글 등록
     *
     * @param dto 화면/서블릿에서 채워온 BoardFileDTO (title, content, writer, filename, filepath)
     * @return executeUpdate() 결과값 (1 이상이면 성공)
     */
    public int insert(BoardFileDTO dto) {
        String sql = "INSERT INTO board_file (title, content, writer, filename, filepath) "
                + "VALUES (?, ?, ?, ?, ?)";

        // try-with-resources로 Connection과 PreparedStatement를 자동으로 close
        try (Connection conn = DBUtill.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, dto.getTitle());
            ps.setString(2, dto.getContent());
            ps.setString(3, dto.getWriter());
            ps.setString(4, dto.getFilename());
            ps.setString(5, dto.getFilepath());

            return ps.executeUpdate();// 영향받은 행 수 반환
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;// 실패 시 0 반환
    }

    /**
     * 자료실 전체 목록 조회
     *
     * @return BoardFileDTO 리스트 (최신 순서로 정렬)
     */
    public List<BoardFileDTO> getList() {
        List<BoardFileDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM board_file ORDER BY id DESC";

        try (Connection conn = DBUtill.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                BoardFileDTO dto = new BoardFileDTO();
                dto.setId(rs.getInt("id"));
                dto.setTitle(rs.getString("title"));
                dto.setWriter(rs.getString("writer"));
                dto.setFilename(rs.getString("filename"));
                dto.setFilepath(rs.getString("filepath"));
                // regdate는 datetime이지만 DTO에서는 String으로 받도록 설계
                dto.setRegdate(rs.getString("regdate"));
                dto.setDownloadcnt(rs.getInt("downloadcnt"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * 특정 id의 자료 상세 조회
     *
     * @param id board_file의 PK
     * @return 해당 id의 BoardFileDTO, 없으면 null
     */
    public BoardFileDTO getById(int id) {
        String sql = "SELECT * FROM board_file WHERE id = ?";
        try (Connection conn = DBUtill.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    BoardFileDTO dto = new BoardFileDTO();
                    dto.setId(rs.getInt("id"));
                    dto.setTitle(rs.getString("title"));
                    dto.setContent(rs.getString("content"));
                    dto.setWriter(rs.getString("writer"));
                    dto.setFilename(rs.getString("filename"));
                    dto.setFilepath(rs.getString("filepath"));
                    dto.setRegdate(rs.getString("regdate"));
                    dto.setDownloadcnt(rs.getInt("downloadcnt"));
                    return dto;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // 해당 id의 데이터가 없을 경우
    }

    // 다운로드 수 증가
    public void increaseDownloadCnt(int id) {
        String sql = "UPDATE board_file SET downloadcnt = downloadcnt + 1 WHERE id = ?";
        try (Connection conn = DBUtill.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();// 반환값은 따로 사용하지 않음 (실패 시 예외 발생)
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
