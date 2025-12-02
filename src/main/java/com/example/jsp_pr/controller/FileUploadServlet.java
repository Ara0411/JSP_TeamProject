package com.example.jsp_pr.controller;

import com.example.jsp_pr.dao.BoardFileDAO;
import com.example.jsp_pr.dto.BoardFileDTO;
import com.example.jsp_pr.dao.DBUtill;

import jakarta.servlet.http.HttpSession;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

@WebServlet("/board/file/upload")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,      // 1MB 메모리 임계값
        maxFileSize = 10 * 1024 * 1024L,     // 파일 하나 최대 10MB
        maxRequestSize = 50 * 1024 * 1024L   // 요청 전체 최대 50MB
)
public class FileUploadServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String title = request.getParameter("title");
        String content = request.getParameter("content");

        // 🔹 세션에서 로그인한 사용자 아이디 가져오기
        HttpSession session = request.getSession(false);
        String writer = null;
        if (session != null) {
            // ⬇⬇ 여기 "userId"는 네가 로그인할 때 setAttribute에 쓰는 이름으로 바꿔야 한다
            writer = (String) session.getAttribute("userId");
        }

        if (writer == null || writer.trim().isEmpty()) {
            // 로그인 안 돼 있으면 로그인 페이지로 보내거나 알림 띄우기
            sendAlert(response, "로그인 후 이용 가능합니다.", request.getContextPath() + "/member/login.jsp");
            return;
        }
        Part filePart = request.getPart("uploadFile");  // form name="uploadFile"

        if (filePart == null || filePart.getSize() == 0) {
            sendAlert(response, "파일을 선택해 주세요.", "fileWrite.jsp");
            return;
        }

        // 원본 파일 이름
        String originalFileName = getFileName(filePart);
        if (originalFileName == null || originalFileName.isEmpty()) {
            sendAlert(response, "파일 이름을 읽을 수 없습니다.", "fileWrite.jsp");
            return;
        }

        // 확장자 검사
        String lowerName = originalFileName.toLowerCase();
        boolean allowed = lowerName.endsWith(".jpg") || lowerName.endsWith(".jpeg")
                || lowerName.endsWith(".png") || lowerName.endsWith(".gif")
                || lowerName.endsWith(".pdf") || lowerName.endsWith(".zip");

        if (!allowed) {
            sendAlert(response, "허용되지 않는 파일 형식입니다. (jpg, png, gif, pdf, zip만 가능)", "fileWrite.jsp");
            return;
        }

        // 실제 업로드 경로 (webapp/upload/file)
        String uploadPath = request.getServletContext().getRealPath("/upload/file");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // 중복 방지용 저장 파일명 (시간 + 원본이름)
        String savedFileName = System.currentTimeMillis() + "_" + originalFileName;
        File saveFile = new File(uploadDir, savedFileName);

        // 파일 저장
        filePart.write(saveFile.getAbsolutePath());

        // 웹에서 접근할 경로
        String fileWebPath = request.getContextPath() + "/upload/file/" + savedFileName;

        // DTO에 담아서 DB에 저장
        BoardFileDTO dto = new BoardFileDTO();
        dto.setTitle(title);
        dto.setWriter(writer);
        dto.setContent(content);
        dto.setFilename(savedFileName);
        dto.setFilepath(fileWebPath);

        BoardFileDAO dao = new BoardFileDAO();
        int result = dao.insert(dto);

        if (result > 0) {
            sendAlert(response, "등록되었습니다.", "fileList.jsp");
        } else {
            // 실패 시, 실제 업로드된 파일 삭제
            if (saveFile.exists()) saveFile.delete();
            sendAlert(response, "DB 저장 중 오류가 발생했습니다.", "fileWrite.jsp");
        }
    }

    // part에서 파일 이름 추출
    private String getFileName(Part part) {
        String header = part.getHeader("content-disposition");
        if (header == null) return null;

        for (String cd : header.split(";")) {
            cd = cd.trim();
            if (cd.startsWith("filename")) {
                String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                // IE 경로 제거
                return fileName.substring(fileName.lastIndexOf(File.separator) + 1);
            }
        }
        return null;
    }

    private void sendAlert(HttpServletResponse response, String msg, String location) throws IOException {
        response.setContentType("text/html; charset=UTF-8");
        response.getWriter().println(
                "<script>alert('" + msg + "'); location.href='" + location + "';</script>"
        );
    }
}
