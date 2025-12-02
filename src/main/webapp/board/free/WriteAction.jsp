<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.example.jsp_pr.dao.DBUtill" %>
<%--
    [주석 작성자] 최아라
    [파일 역할] 자유게시판 글 등록 처리(INSERT)
    [주요 기능]
      - Write.jsp에서 넘어온 제목/내용을 읽어서 DB(board_free)에 INSERT
      - 작성자(writer)는 화면에서 입력받지 않고 세션의 userId 사용
      - 로그인하지 않은 사용자는 글 등록 불가(로그인 페이지로 이동)
      - INSERT 성공 시 목록(List.jsp)으로 이동, 실패/오류 시 경고 후 이전 페이지로 이동
 --%>
<%
    // 한글 파라미터 깨짐 방지
    request.setCharacterEncoding("UTF-8");

    // 사용자가 폼에서 입력한 제목과 내용 파라미터를 읽어온다.
    String title = request.getParameter("title");
    String content = request.getParameter("content");

    // 로그인한 사용자 아이디를 세션에서 가져온다.
    // 화면에는 writer 입력란이 없고, 로그인 아이디를 그대로 작성자로 사용하는 구조.
    String writer = (String) session.getAttribute("userId");

    // 세션에 userId가 없거나 공백이면, 로그인하지 않은 상태이므로 글 등록을 막는다.
    if (writer == null || writer.trim().isEmpty()) {
        // 로그인 안 되어 있으면 로그인 페이지로 보냄
        out.println("<script>alert('로그인 후 이용 가능합니다.'); location.href='../../member/login.jsp';</script>");
        return;
    }

    String errMsg = ""; // 나중에 오류 메시지를 사용자에게 보여주기 위한 변수
    try {
        // 공통 DB 연결 유틸을 통해 Connection 객체 획득
        Connection conn = DBUtill.getConnection();

        // 자유게시판(board_free)에 새 게시글을 추가하는 SQL
        // regdate는 NOW()로 현재 시간 자동 입력, viewcnt는 0으로 초기화
        PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO board_free (title, content, writer, regdate, viewcnt) VALUES (?, ?, ?, NOW(), 0)"
        );
        ps.setString(1, title);
        ps.setString(2, content);
        ps.setString(3, writer);

        // executeUpdate()의 반환값은 영향을 받은 행(row)의 개수(보통 1이면 성공)
        int result = ps.executeUpdate();
        ps.close();
        conn.close();

        if (result > 0) {
            // 등록이 정상적으로 완료되면 사용자에게 알림을 주고, 목록 페이지로 이동시킨다.
            out.println("<script>alert('등록되었습니다.'); location.href='List.jsp';</script>");
            return;
        } else {
            // INSERT가 실패한 경우(0행 영향) 사용자에게 메시지 표시
            errMsg = "글 등록에 실패했습니다.";
        }
    } catch (Exception e) {
        // 예외가 발생하면 콘솔에 스택 트레이스를 출력하고, 사용자에게는 메시지로 보여준다.
        e.printStackTrace();
        errMsg = "오류: " + e.getMessage();
    }
%>

<% if (!errMsg.isEmpty()) { %>
<script>
    // errMsg에 작은따옴표가 포함된 경우 JS 문자열이 깨지지 않도록 이스케이프 처리
    alert('<%= errMsg.replace("'", "\\'") %>');
    history.back();// 이전 페이지(글쓰기 화면)로 돌아가기
</script>
<% } %>
