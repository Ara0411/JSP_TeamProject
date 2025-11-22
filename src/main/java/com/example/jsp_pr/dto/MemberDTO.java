package com.example.jsp_pr.dto;

public class MemberDTO {
    private String id;
    private String pass;
    private String name;
    private String role; // "ADMIN" or "USER"

    public MemberDTO() {}

    // Getter & Setter
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getPass() { return pass; }
    public void setPass(String pass) { this.pass = pass; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}