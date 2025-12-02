<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.example.jsp_pr.dao.DBUtill" %>

<%
    request.setCharacterEncoding("UTF-8");

    String title = request.getParameter("title");
    String content = request.getParameter("content");

    // 🔹 로그인한 사용자 아이디를 세션에서 꺼냄
    //    로그인할 때 session.setAttribute("userId", 로그인아이디); 이런 식으로 넣었다고 가정
    String writer = (String) session.getAttribute("userId");

    if (writer == null || writer.trim().isEmpty()) {
        // 로그인 안 되어 있으면 로그인 페이지로 보냄
        out.println("<script>alert('로그인 후 이용 가능합니다.'); location.href='../../member/login.jsp';</script>");
        return;
    }

    String errMsg = "";
    try {
        Connection conn = DBUtill.getConnection();
        PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO board_free (title, content, writer, regdate, viewcnt) VALUES (?, ?, ?, NOW(), 0)"
        );
        ps.setString(1, title);
        ps.setString(2, content);
        ps.setString(3, writer);

        int result = ps.executeUpdate();
        ps.close();
        conn.close();

        if (result > 0) {
            out.println("<script>alert('등록되었습니다.'); location.href='List.jsp';</script>");
            return;
        } else {
            errMsg = "글 등록에 실패했습니다.";
        }
    } catch (Exception e) {
        e.printStackTrace();
        errMsg = "오류: " + e.getMessage();
    }
%>

<% if (!errMsg.isEmpty()) { %>
<script>
    alert('<%= errMsg.replace("'", "\\'") %>');
    history.back();
</script>
<% } %>
