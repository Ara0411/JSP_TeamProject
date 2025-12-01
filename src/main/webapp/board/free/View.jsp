<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.example.jsp_pr.dao.DBUtill" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
<%
    Connection conn = null;
    PreparedStatement ps = null, ps2 = null, cps = null;
    ResultSet rs = null, crs = null;
    String errorMsg = "";
    try {
        int id = Integer.parseInt(request.getParameter("id"));
        conn = DBUtill.getConnection();
        ps = conn.prepareStatement("UPDATE board_free SET viewcnt=viewcnt+1 WHERE id=?");
        ps.setInt(1, id);
        ps.executeUpdate();

        ps2 = conn.prepareStatement("SELECT * FROM board_free WHERE id=?");
        ps2.setInt(1, id);
        rs = ps2.executeQuery();
        rs.next();
        String writer = rs.getString("writer");
%>
<%@ include file="../../include/header.jsp" %>
<main class="main">
    <section class="free-view-card">
        <h2 class="free-view-title"><%=rs.getString("title")%></h2>
        <div class="free-view-meta">
            작성자: <span><%=writer%></span> ｜ 날짜: <span><%=rs.getString("regdate")%></span> ｜ 조회수: <span><%=rs.getInt("viewcnt")%></span>
        </div>
        <div class="free-view-content"><%=rs.getString("content")%></div>

        <div class="free-view-comment-box">
            <h3 style="margin:0 0 10px 0;font-size:1.07em;">댓글</h3>
            <form action="CommentAction.jsp" method="post" class="free-comment-form" style="margin-bottom:12px;">
                <input type="hidden" name="board_id" value="<%=id%>">
                <textarea name="content" required placeholder="댓글 작성"></textarea>
                <button type="submit" class="cmt-btn-primary">등록</button>
            </form>
            <div class="comment-list">
                <% try {
                    cps = conn.prepareStatement("SELECT * FROM board_comment WHERE board_id=? ORDER BY comment_id DESC");
                    cps.setInt(1, id);
                    crs = cps.executeQuery();
                    while (crs.next()) { %>
                <div class="comment-item">
                    <b><%=crs.getString("writer")%></b>
                    <span class="date"><%=crs.getString("regdate")%></span>
                    <div class="comment-content"><%=crs.getString("content")%></div>
                </div>

                <%  }
                } catch(Exception e) { e.printStackTrace(); }
                %>
            </div>
        </div>
    </section>
</main>

<%@ include file="../../include/footer.jsp" %>
<%
    } catch (Exception e) {
        errorMsg = "<div style='color:red'>" + e.getMessage() + "</div>";
        e.printStackTrace();
    } finally {
        try { if(crs!=null) crs.close(); } catch(Exception e){ e.printStackTrace(); }
        try { if(cps!=null) cps.close(); } catch(Exception e){ e.printStackTrace(); }
        try { if(rs!=null) rs.close(); } catch(Exception e){ e.printStackTrace(); }
        try { if(ps2!=null) ps2.close(); } catch(Exception e){ e.printStackTrace(); }
        try { if(ps!=null) ps.close(); } catch(Exception e){ e.printStackTrace(); }
        try { if(conn!=null) conn.close(); } catch(Exception e){ e.printStackTrace(); }
    }
%>
<%= errorMsg %>
