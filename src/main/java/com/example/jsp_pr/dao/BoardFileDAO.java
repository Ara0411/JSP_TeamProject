package com.example.jsp_pr.dao;

import com.example.jsp_pr.dto.BoardFileDTO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BoardFileDAO {

    // 글 등록
    public int insert(BoardFileDTO dto) {
        String sql = "INSERT INTO board_file (title, content, writer, filename, filepath) "
                + "VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBUtill.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, dto.getTitle());
            ps.setString(2, dto.getContent());
            ps.setString(3, dto.getWriter());
            ps.setString(4, dto.getFilename());
            ps.setString(5, dto.getFilepath());

            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // 목록
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
                dto.setRegdate(rs.getString("regdate"));
                dto.setDownloadcnt(rs.getInt("downloadcnt"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 상세보기
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
        return null;
    }

    // 다운로드 수 증가
    public void increaseDownloadCnt(int id) {
        String sql = "UPDATE board_file SET downloadcnt = downloadcnt + 1 WHERE id = ?";
        try (Connection conn = DBUtill.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
