<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.example.jsp_pr.dao.DBUtill" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>DB 연결 테스트</title>
</head>
<body>
<%
    Connection conn = null;
    try {
        conn = DBUtill.getConnection();
        if (conn != null) {
            out.println("<h3>DB 연결 성공 ✅</h3>");
        } else {
            out.println("<h3>DB 연결 실패 ❌</h3>");
        }
    } catch (Exception e) {
        out.println(e.getMessage());
    } finally {
        if (conn != null) conn.close();
    }
%>
</body>
</html>
