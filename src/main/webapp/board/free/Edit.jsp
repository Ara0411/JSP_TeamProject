<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.example.jsp_pr.dao.DBUtill" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
<%
    String userId = (String) session.getAttribute("userId");
    if(userId == null){
        response.sendRedirect("../member/login.jsp");
        return;
    }
%>

<%
    String errMsg = "";
    String title = "", content = "", writer = "";
    int id = 0;
    try {
        id = Integer.parseInt(request.getParameter("id"));
        Connection conn = DBUtill.getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM board_free WHERE id=?");
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            title = rs.getString("title");
            content = rs.getString("content");
            writer = rs.getString("writer");
        } else {
            errMsg = "글 정보를 찾을 수 없습니다.";
        }
        rs.close(); ps.close(); conn.close();
    } catch(Exception e){
        errMsg = "오류: " + e.getMessage();
    }
%>

<%@ include file="../../include/header.jsp" %>

<main class="main">
    <% if(!errMsg.isEmpty()){ %>
    <div style="color:red;text-align:center; margin-top:60px;"><%=errMsg%></div>
    <% } else { %>
    <section class="free-edit-card">
        <h2>게시글 수정</h2>
        <form action="EditAction.jsp" method="post" class="free-edit-form">
            <input type="hidden" name="id" value="<%=id%>">

            <label for="title">제목</label>
            <input type="text" id="title" name="title" value="<%=title%>" required>

            <label for="content">내용</label>
            <textarea id="content" name="content" required><%=content%></textarea>

            <label for="writer">작성자</label>
            <input type="text" id="writer" name="writer" value="<%=writer%>" required>

            <div class="free-edit-btns">
                <button type="submit" class="edit-btn-primary">수정 완료</button>
                <a href="../free/List.jsp" class="edit-btn-outline">취소</a>
            </div>
        </form>
    </section>
    <% } %>
</main>

<%@ include file="../../include/footer.jsp" %>
