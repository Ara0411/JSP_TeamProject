package com.example.jsp_pr.dto;
/**
 * [주석 작성자] 최아라
 * [클래스 역할] 자료실 게시글(board_file) 한 건을 표현하는 DTO
 * [주요 필드]
 *   - id         : PK
 *   - title      : 글 제목
 *   - content    : 글 내용
 *   - writer     : 작성자 (로그인 아이디)
 *   - filename   : 서버에 실제 저장된 파일명
 *   - filepath   : 웹에서 접근 가능한 파일 경로 (/upload/file/...)
 *   - regdate    : 등록일(문자열 형태로 보관)
 *   - downloadcnt: 다운로드 횟수
 */

public class BoardFileDTO {
    private int id;
    private String title;
    private String content;
    private String writer;
    private String filename;  // 서버 저장 파일명
    private String filepath;  // /upload/file/xxx
    private String regdate;
    private int downloadcnt;

    // getter / setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getWriter() { return writer; }
    public void setWriter(String writer) { this.writer = writer; }

    public String getFilename() { return filename; }
    public void setFilename(String filename) { this.filename = filename; }

    public String getFilepath() { return filepath; }
    public void setFilepath(String filepath) { this.filepath = filepath; }

    public String getRegdate() { return regdate; }
    public void setRegdate(String regdate) { this.regdate = regdate; }

    public int getDownloadcnt() { return downloadcnt; }
    public void setDownloadcnt(int downloadcnt) { this.downloadcnt = downloadcnt; }
}
