<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>  <%-- 페이지 인코딩 및 콘텐츠 타입 설정 --%>
<%@ page import="java.sql.*" %>                                          <%-- JDBC 관련 클래스 import --%>
<%@ page import="com.example.jsp_pr.dao.DBUtill" %>                      <%-- DB 연결 유틸 클래스 import --%>

<%
    // 자유게시판 목록 조회를 위한 DB 객체들 선언
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String sql = "SELECT id, title, writer, regdate, viewcnt FROM board_free ORDER BY id DESC"; // 게시글 목록 조회 SQL

    try {
        conn = DBUtill.getConnection();                      // DB 연결 얻기
        ps = conn.prepareStatement(sql);                     // SQL을 위한 PreparedStatement 생성
        rs = ps.executeQuery();                              // 쿼리 실행 후 결과 집합 가져오기
    } catch (Exception e) {
        e.printStackTrace();                                 // 오류 발생 시 콘솔에 출력
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>자유게시판</title>                                <!-- 브라우저 탭 제목 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"><!-- 공통 스타일시트 연결 -->
</head>
<body class="layout">

<%@ include file="/include/header.jsp" %>                    <%-- 공통 헤더 영역 포함 --%>

<div class="content-wrap">

    <%@ include file="/include/menu.jsp" %>                  <%-- 공통 메뉴 영역 포함 --%>

    <div class="main">

        <!-- 상단 카드: 제목 + 글쓰기 버튼 -->
        <div class="card" style="padding:22px; margin-bottom:16px;">
            <div style="display:flex; justify-content:space-between; align-items:center;">
                <h2 style="font-size:18px; font-weight:700;">📝 자유게시판</h2> <!-- 섹션 제목 -->
                <button class="btn-primary"
                        onclick="location.href='Write.jsp'"> <!-- 글쓰기 페이지로 이동 -->
                    글쓰기
                </button>
            </div>
            <p class="text-muted" style="margin-top:6px;">
                팀원들과 자유롭게 소통하는 공간입니다.       <!-- 보조 설명 문구 -->
            </p>
        </div>

        <!-- 목록 카드 -->
        <div class="card">
            <table style="width:100%; border-collapse:collapse; font-size:14px;"> <!-- 게시글 목록 테이블 -->
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
                    int rowNum = 0;                          // 조회된 게시글 수 카운트
                    if (rs != null) {
                        while (rs.next()) {                  // 결과가 있을 때마다 한 행씩 처리
                            rowNum++;
                            int id = rs.getInt("id");        // 글 번호
                            String title = rs.getString("title");   // 글 제목
                            String writer = rs.getString("writer"); // 작성자
                            int viewcnt = rs.getInt("viewcnt");     // 조회수
                            Timestamp date = rs.getTimestamp("regdate"); // 작성일시
                %>
                <tr style="border-bottom:1px solid #f3f4f6;">
                    <td style="padding:9px 8px; text-align:center;"><%= id %></td>
                    <td style="padding:9px 8px;">
                        <!-- 제목 클릭 시 상세 보기 페이지로 이동 -->
                        <a href="View.jsp?id=<%=id%>"
                           style="display:inline-block; max-width:100%; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">
                            <%= title %>
                        </a>
                    </td>
                    <td style="padding:9px 8px; text-align:center;"><%= writer %></td>
                    <td style="padding:9px 8px; text-align:center;"><%= date %></td>
                    <td style="padding:9px 8px; text-align:center;"><%= viewcnt %></td>
                    <td style="padding:9px 8px; text-align:center;">
                        <!-- 수정 버튼: Edit.jsp로 이동 -->
                        <button class="btn-outline"
                                style="font-size:12px; padding:4px 10px; margin-right:4px;"
                                onclick="location.href='Edit.jsp?id=<%=id%>'">
                            수정
                        </button>
                        <!-- 삭제 버튼: 확인 후 DeleteAction.jsp 호출 -->
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
                    if (rowNum == 0) {                       // 조회된 게시글이 하나도 없을 때
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

<%@ include file="/include/footer.jsp" %>                      <%-- 공통 푸터 영역 포함 --%>

</body>
</html>

<%
    // 사용한 JDBC 자원 정리
    if (rs != null) try { rs.close(); } catch (Exception ignore) {}
    if (ps != null) try { ps.close(); } catch (Exception ignore) {}
    if (conn != null) try { conn.close(); } catch (Exception ignore) {}
%>
