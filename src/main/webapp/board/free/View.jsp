<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>  <%-- 페이지 인코딩 및 콘텐츠 타입 설정 --%>
<%@ page import="java.sql.*, com.example.jsp_pr.dao.DBUtill" %>          <%-- JDBC 클래스와 DB 연결 유틸 import --%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css"> <%-- 공통 스타일시트 연결 --%>

<%
    Connection conn = null;
    PreparedStatement ps = null, ps2 = null, cps = null;        // 게시글/댓글 조회용 PreparedStatement들
    ResultSet rs = null, crs = null;                            // 게시글/댓글 ResultSet
    String errorMsg = "";                                       // 오류 메시지 저장용 변수
    try {
        int id = Integer.parseInt(request.getParameter("id"));  // 요청 파라미터에서 글 id를 정수로 변환
        conn = DBUtill.getConnection();                         // DB 연결 얻기

        // 조회수 1 증가
        ps = conn.prepareStatement("UPDATE board_free SET viewcnt=viewcnt+1 WHERE id=?");
        ps.setInt(1, id);
        ps.executeUpdate();

        // 게시글 상세 정보 조회
        ps2 = conn.prepareStatement("SELECT * FROM board_free WHERE id=?");
        ps2.setInt(1, id);
        rs = ps2.executeQuery();
        rs.next();                                              // 결과 한 행으로 이동
        String writer = rs.getString("writer");                 // 작성자 이름 미리 저장
%>

<%@ include file="../../include/header.jsp" %>                  <%-- 공통 헤더 포함 --%>

<main class="main">
    <section class="free-view-card">
        <%-- 글 제목 --%>
        <h2 class="free-view-title"><%=rs.getString("title")%></h2>

        <%-- 작성자 / 날짜 / 조회수 표시 --%>
        <div class="free-view-meta">
            작성자: <span><%=writer%></span> ｜ 날짜: <span><%=rs.getString("regdate")%></span> ｜ 조회수: <span><%=rs.getInt("viewcnt")%></span>
        </div>

        <%-- 글 내용 본문 --%>
        <div class="free-view-content"><%=rs.getString("content")%></div>

        <%-- 댓글 영역 전체 박스 --%>
        <div class="free-view-comment-box">
            <h3 style="margin:0 0 10px 0;font-size:1.07em;">댓글</h3>

            <%-- 새 댓글 작성 폼: 현재 글 id를 hidden 값으로 전송 --%>
            <form action="CommentAction.jsp" method="post" class="free-comment-form" style="margin-bottom:12px;">
                <input type="hidden" name="board_id" value="<%=id%>">
                <textarea name="content" required placeholder="댓글 작성"></textarea>
                <button type="submit" class="cmt-btn-primary">등록</button>
            </form>

            <%-- 댓글 목록 출력 영역 --%>
            <div class="comment-list">
                <% try {
                    // 현재 글에 달린 댓글들을 최신 순으로 조회
                    cps = conn.prepareStatement("SELECT * FROM board_comment WHERE board_id=? ORDER BY comment_id DESC");
                    cps.setInt(1, id);
                    crs = cps.executeQuery();
                    while (crs.next()) { %>
                <div class="comment-item">
                    <b><%=crs.getString("writer")%></b>              <%-- 댓글 작성자 --%>
                    <span class="date"><%=crs.getString("regdate")%></span> <%-- 댓글 작성일 --%>
                    <div class="comment-content"><%=crs.getString("content")%></div> <%-- 댓글 내용 --%>
                </div>

                <%  }
                } catch(Exception e) { e.printStackTrace(); }       // 댓글 조회 중 예외는 콘솔에만 출력
                %>
            </div>
        </div>
    </section>
</main>

<%@ include file="../../include/footer.jsp" %>                  <%-- 공통 푸터 포함 --%>

<%
    } catch (Exception e) {                                      // 전체 조회 중 예외 처리
        errorMsg = "<div style='color:red'>" + e.getMessage() + "</div>";
        e.printStackTrace();
    } finally {
        // 사용한 JDBC 자원 정리
        try { if(crs!=null) crs.close(); } catch(Exception e){ e.printStackTrace(); }
        try { if(cps!=null) cps.close(); } catch(Exception e){ e.printStackTrace(); }
        try { if(rs!=null) rs.close(); } catch(Exception e){ e.printStackTrace(); }
        try { if(ps2!=null) ps2.close(); } catch(Exception e){ e.printStackTrace(); }
        try { if(ps!=null) ps.close(); } catch(Exception e){ e.printStackTrace(); }
        try { if(conn!=null) conn.close(); } catch(Exception e){ e.printStackTrace(); }
    }
%>

<%= errorMsg %>  <%-- 예외 발생 시 화면 하단에 오류 메시지 출력 --%>
