<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.jsp_pr.dao.NoticeDAO" %>
<%@ page import="com.example.jsp_pr.dto.NoticeDTO" %>

<%
    // 1. 일꾼(DAO)을 부른다.
    NoticeDAO dao = new NoticeDAO();

    // 2. 일꾼한테 "공지사항 목록 다 가져와!" 라고 시킨다.
    // (DAO가 알아서 '상단고정' 글을 맨 위로 정렬해서 가져옴)
    List<NoticeDTO> list = dao.getNoticeList();
%>

<!DOCTYPE html>
<html>
<head>
    <title>공지사항 게시판</title>
    <style>
        /* 디자인: 깔끔한 표 스타일 */
        body { font-family: sans-serif; padding: 20px; }
        h2 { border-bottom: 2px solid #333; padding-bottom: 10px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
        th { background-color: #f4f4f4; }

        /* 제목은 왼쪽 정렬 */
        td.title { text-align: left; }

        /* 🔥 상단 고정(중요) 글 전용 스타일 (빨간 배경) */
        tr.fixed { background-color: #fff0f0; font-weight: bold; color: #d9534f; }

        .btn-write {
            float: right;
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
        }
    </style>
</head>
<body>

<h2>📢 공지사항</h2>

<a href="write.jsp" class="btn-write">글쓰기</a>

<table>
    <thead>
    <tr>
        <th width="50">번호</th>
        <th>제목</th>
        <th width="100">작성자</th>
        <th width="150">작성일</th>
        <th width="80">조회수</th>
    </tr>
    </thead>
    <tbody>
    <%
        if (list.isEmpty()) {
    %>
    <tr>
        <td colspan="5">등록된 공지사항이 없습니다.</td>
    </tr>
    <%
    } else {
        for (NoticeDTO n : list) {
            // 상단 고정 글이면 'fixed' 클래스 적용 (배경색 변경)
            String rowClass = "Y".equals(n.getIs_fixed()) ? "fixed" : "";
            String icon = "Y".equals(n.getIs_fixed()) ? "🔥 " : "";
    %>
    <tr class="<%= rowClass %>">
        <td><%= n.getId() %></td>
        <td class="title">
            <a href="view.jsp?id=<%= n.getId() %>" style="color: inherit; text-decoration: none;">
                <%= icon %> <%= n.getTitle() %>
            </a>
        </td>
        <td><%= n.getWriter() %></td>
        <td><%= n.getRegdate() %></td>
        <td><%= n.getViewcnt() %></td>
    </tr>
    <%
            }
        }
    %>
    </tbody>
</table>

</body>
</html>