package com.example.jsp_pr.dto;

import java.sql.Timestamp;

public class NoticeDTO {
    // 1. 변수 (DB 테이블 컬럼과 똑같이!)
    private int id;             // 글 번호
    private String title;       // 제목
    private String content;     // 내용
    private String writer;      // 작성자
    private int viewcnt;        // 조회수
    private Timestamp regdate;  // 작성일
    private String is_fixed;    // 🔥 핵심: 상단 고정 여부 ('Y' or 'N')

    // 2. 기본 생성자
    public NoticeDTO() {}

    // 3. Getter & Setter (자동 생성된 코드)
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getWriter() { return writer; }
    public void setWriter(String writer) { this.writer = writer; }

    public int getViewcnt() { return viewcnt; }
    public void setViewcnt(int viewcnt) { this.viewcnt = viewcnt; }

    public Timestamp getRegdate() { return regdate; }
    public void setRegdate(Timestamp regdate) { this.regdate = regdate; }

    public String getIs_fixed() { return is_fixed; }
    public void setIs_fixed(String is_fixed) { this.is_fixed = is_fixed; }
}