package com.example.jsp_pr.dto;

// 회원(Member) 테이블의 데이터를 담아 나르는 객체
// - DB의 'member' 테이블에 있는 데이터를 자바에서 쓰기 편하게 변수로 담아두는 역할
// - 아이디, 비번, 이름, 권한 정보를 가지고 다님
public class MemberDTO {
    // DB 테이블 컬럼과 1:1로 매칭되는 변수들
    private String id;
    private String pass;
    private String name;
    private String role; // "ADMIN" or "USER"
    // 기본 생성자
    public MemberDTO() {}

    // Getter & Setter (데이터 넣고 빼기 위한 메서드)
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getPass() { return pass; }
    public void setPass(String pass) { this.pass = pass; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}