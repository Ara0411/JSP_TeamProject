<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.example.jsp_pr.dao.DBUtill" %>
<%@ include file="../../include/header.jsp" %>
<%@ include file="../../include/menu.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">

<main class="main">
    <section class="welcome-section free-board-card">


        <a href="../free/Write.jsp"
           class="btn-primary"
           style="display:block; margin:30px auto 24px auto; max-width:180px; text-align:center; font-size:1.2em;">
            글쓰기
        </a>
        <h2 style="margin-top:0px;">자유게시판</h2>

        <table style="width:100%;border-collapse:collapse;">
            <tr style="background:#eef2ff;">
                <th style="padding:8px; text-align:center;">번호</th>
                <th style="padding:8px; text-align:center;">제목</th>
                <th style="padding:8px; text-align:center;">작성자</th>
                <th style="padding:8px; text-align:center;">날짜</th>
                <th style="padding:8px; text-align:center;">조회수</th>
                <th style="padding:8px; text-align:center;">관리</th>
            </tr>
            <% String errorMsg = ""; %>
            <%
                try{
                    Connection conn = DBUtill.getConnection();
                    Statement st = conn.createStatement();
                    ResultSet rs = st.executeQuery("SELECT * FROM board_free ORDER BY id DESC");
                    while(rs.next()){
            %>
            <tr>
                <td style="padding:8px; text-align:center;"><%=rs.getInt("id")%></td>
                <td style="padding:8px; text-align:center;">
                    <a href="View.jsp?id=<%=rs.getInt("id")%>"><%=rs.getString("title")%></a>
                </td>
                <td style="padding:8px; text-align:center;"><%=rs.getString("writer")%></td>
                <td style="padding:8px; text-align:center;"><%=rs.getString("regdate")%></td>
                <td style="padding:8px; text-align:center;"><%=rs.getInt("viewcnt")%></td>
                <td style="padding:8px; text-align:center;">
                    <a href="Edit.jsp?id=<%=rs.getInt("id")%>" class="btn-outline" style="color:black; margin-right:5px;">수정</a>
                    <a href="DeleteAction.jsp?id=<%=rs.getInt("id")%>" class="btn-outline" style="color:black"
                       onclick="return confirm('정말로 삭제하시겠습니까?')">삭제</a>
                </td>
            </tr>
            <%
                    }
                    rs.close(); st.close(); conn.close();
                }catch(Exception e){
                    errorMsg = "<tr><td colspan='6' style='color:red;'>오류:" + e.getMessage() + "</td></tr>";
                }
            %>
            <%=errorMsg%>
        </table>
    </section>
</main>
<%@ include file="../../include/footer.jsp" %>
