<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.example.jsp_pr.dao.DBUtill" %>
<%--
    [주석 작성자] 최아라
    [파일 역할] 자유게시판 목록 페이지
    [주요 기능]
      - board_free 테이블에서 최신 글 목록을 조회하여 화면에 표 형태로 표시
      - 카드형 레이아웃(UI) 적용으로 메인/자료실과 디자인 통일
      - 각 글 제목 클릭 시 View.jsp로 이동, 수정/삭제 버튼 제공
 --%>
<%
    // 자유게시판 목록 조회
    // DB 연결 및 게시글 목록 조회를 위한 기본 객체 선언
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // 자유게시판의 id, title, writer, regdate, viewcnt 컬럼을 id 내림차순(최신글 우선)으로 조회
    String sql = "SELECT id, title, writer, regdate, viewcnt FROM board_free ORDER BY id DESC";

    try {
        conn = DBUtill.getConnection();
        ps = conn.prepareStatement(sql);
        rs = ps.executeQuery();
    } catch (Exception e) {
        e.printStackTrace(); // 문제 발생 시 서버 콘솔에 에러 출력
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>자유게시판</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="layout">

<%@ include file="/include/header.jsp" %>

<div class="content-wrap">

    <%@ include file="/include/menu.jsp" %>

    <div class="main">

        <!-- 상단 카드: 제목 + 글쓰기 버튼 -->
        <div class="card" style="padding:22px; margin-bottom:16px;">
            <div style="display:flex; justify-content:space-between; align-items:center;">
                <h2 style="font-size:18px; font-weight:700;">📝 자유게시판</h2>
                <%-- 글쓰기 버튼: 같은 디렉터리의 Write.jsp로 이동 --%>
                <button class="btn-primary"
                        onclick="location.href='Write.jsp'">
                    글쓰기
                </button>
            </div>
            <p class="text-muted" style="margin-top:6px;">
                팀원들과 자유롭게 소통하는 공간입니다.
            </p>
        </div>

        <%-- 게시글 목록 카드 --%>
        <div class="card">
            <table style="width:100%; border-collapse:collapse; font-size:14px;">
                <thead>
                <tr style="background:#eef2ff; border-bottom:1px solid #e5e7eb;">
                    <th style="padding:10px 8px; text-align:center; width:70px;">번호</th>
                    <th style="padding:10px 8px; text-align:left;">제목</th>
                    <th style="padding:10px 8px; text-align:center; width:140px;">작성자</th>
                    <th style="padding:10px 8px; text-align:center; width:160px;">날짜</th>
                    <th style="padding:10px 8px; text-align:center; width:80px;">조회수</th>
                    <th style="padding:10px 8px; text-align:center; width:120px;">관리</th>
                </tr>
                </thead>
                <tbody>
                <%
                    int rowNum = 0; // 게시글이 하나도 없는 경우를 판단하기 위한 카운터
                    if (rs != null) {
                        while (rs.next()) {
                            rowNum++;
                            int id = rs.getInt("id");
                            String title = rs.getString("title");
                            String writer = rs.getString("writer");
                            int viewcnt = rs.getInt("viewcnt");
                            Timestamp date = rs.getTimestamp("regdate");
                %>
                <tr style="border-bottom:1px solid #f3f4f6;">
                    <td style="padding:9px 8px; text-align:center;"><%= id %></td>
                    <td style="padding:9px 8px;">
                        <%-- 제목 클릭 시 View.jsp로 이동하면서 id를 쿼리스트링으로 전달 --%>
                        <a href="View.jsp?id=<%=id%>"
                           style="display:inline-block; max-width:100%; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">
                            <%= title %>
                        </a>
                    </td>
                    <td style="padding:9px 8px; text-align:center;"><%= writer %></td>
                    <td style="padding:9px 8px; text-align:center;"><%= date %></td>
                    <td style="padding:9px 8px; text-align:center;"><%= viewcnt %></td>
                    <td style="padding:9px 8px; text-align:center;">
                        <%-- 수정 버튼: 해당 글의 Edit.jsp로 이동 --%>
                        <button class="btn-outline"
                                style="font-size:12px; padding:4px 10px; margin-right:4px;"
                                onclick="location.href='Edit.jsp?id=<%=id%>'">
                            수정
                        </button>
                        <%-- 삭제 버튼: DeleteAction.jsp 호출 전 confirm으로 한번 더 확인 --%>
                        <button class="btn-outline"
                                style="font-size:12px; padding:4px 10px;"
                                onclick="if(confirm('삭제하시겠습니까?')) location.href='DeleteAction.jsp?id=<%=id%>';">
                            삭제
                        </button>
                    </td>
                </tr>
                <%
                        }
                    }
                    // rowNum이 0이면 rs.next()가 한 번도 돌지 않았다는 뜻 = 게시글이 하나도 없음
                    if (rowNum == 0) {
                %>
                <tr>
                    <td colspan="6" style="padding:16px; text-align:center; color:#6b7280;">
                        등록된 게시글이 없습니다.
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>

    </div>

</div>

<%@ include file="/include/footer.jsp" %>

</body>
</html>

<%
    // ResultSet, PreparedStatement, Connection 순서대로 안전하게 자원 해제
    if (rs != null) try { rs.close(); } catch (Exception ignore) {}
    if (ps != null) try { ps.close(); } catch (Exception ignore) {}
    if (conn != null) try { conn.close(); } catch (Exception ignore) {}
%>
