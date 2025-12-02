package com.example.jsp_pr.dto;

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
