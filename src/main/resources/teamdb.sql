/* ============================================== */
/* [1] DB 초기화 (기존 거 삭제 후 새로 생성)        */
/* ============================================== */
DROP DATABASE IF EXISTS teamdb;
CREATE DATABASE teamdb DEFAULT CHARACTER SET utf8mb4;
USE teamdb;

/* ============================================== */
/* [2] 테이블 생성 (자바 DTO와 이름 일치시킴)       */
/* ============================================== */

/* 1. 회원 테이블 (관리자 구분용 role 추가) */
CREATE TABLE member (
                        id          VARCHAR(50) PRIMARY KEY COMMENT '아이디',
                        pass        VARCHAR(50) NOT NULL    COMMENT '비밀번호',
                        name        VARCHAR(50) NOT NULL    COMMENT '이름',
                        email       VARCHAR(100)            COMMENT '이메일',
                        role        VARCHAR(10) DEFAULT 'USER' COMMENT '역할(ADMIN:관리자, USER:일반)',
                        regdate     DATETIME DEFAULT NOW()  COMMENT '가입일'
);

/* 2. 공지사항 (관리자용, 상단고정 기능) - id 컬럼 사용 */
CREATE TABLE board_notice (
                              id          INT AUTO_INCREMENT PRIMARY KEY COMMENT '글번호',
                              title       VARCHAR(200) NOT NULL   COMMENT '제목',
                              content     TEXT NOT NULL           COMMENT '내용',
                              writer      VARCHAR(50) NOT NULL    COMMENT '작성자(관리자ID)',
                              viewcnt     INT DEFAULT 0           COMMENT '조회수',
                              regdate     DATETIME DEFAULT NOW()  COMMENT '작성일',
                              is_fixed    CHAR(1) DEFAULT 'N'     COMMENT '상단고정(Y/N)'
);

/* 3. 자유게시판 (회원용) */
CREATE TABLE board_free (
                            id          INT AUTO_INCREMENT PRIMARY KEY COMMENT '글번호',
                            title       VARCHAR(200) NOT NULL   COMMENT '제목',
                            content     TEXT NOT NULL           COMMENT '내용',
                            writer      VARCHAR(50) NOT NULL    COMMENT '작성자',
                            viewcnt     INT DEFAULT 0           COMMENT '조회수',
                            regdate     DATETIME DEFAULT NOW()  COMMENT '작성일'
);

/* 4. 자료실 (파일 업로드용) */
CREATE TABLE board_file (
                            id          INT AUTO_INCREMENT PRIMARY KEY COMMENT '글번호',
                            title       VARCHAR(200) NOT NULL   COMMENT '제목',
                            content     TEXT NOT NULL           COMMENT '내용',
                            writer      VARCHAR(50) NOT NULL    COMMENT '작성자',
                            viewcnt     INT DEFAULT 0           COMMENT '조회수',
                            regdate     DATETIME DEFAULT NOW()  COMMENT '작성일',
                            org_file    VARCHAR(200)            COMMENT '원본 파일명',
                            save_file   VARCHAR(200)            COMMENT '저장된 파일명',
                            downcnt     INT DEFAULT 0           COMMENT '다운로드 횟수'
);

/* 5. 댓글 테이블 (자유게시판용) */
CREATE TABLE board_comment (
                               comment_id  INT AUTO_INCREMENT PRIMARY KEY COMMENT '댓글번호',
                               board_id    INT NOT NULL            COMMENT '게시글번호(FK)',
                               writer      VARCHAR(50) NOT NULL    COMMENT '작성자',
                               content     VARCHAR(500) NOT NULL   COMMENT '댓글내용',
                               regdate     DATETIME DEFAULT NOW()  COMMENT '작성일',
                               FOREIGN KEY (board_id) REFERENCES board_free(id) ON DELETE CASCADE
);

/* ============================================== */
/* [3] 기초 데이터 입력 (테스트용)                 */
/* ============================================== */

/* 관리자 계정 (아이디: admin / 비번: 1234) */
INSERT INTO member (id, pass, name, role) VALUES ('admin', '1234', '관리자', 'ADMIN');
/* 일반 계정 (아이디: user1 / 비번: 1234) */
INSERT INTO member (id, pass, name, role) VALUES ('user1', '1234', '홍길동', 'USER');

/* 공지사항 샘플 글 */
INSERT INTO board_notice (title, content, writer, is_fixed)
VALUES ('🔥 [필독] 프로젝트 진행 일정 안내', '이번 주까지 DB 설계 완료 바랍니다.', 'admin', 'Y');
INSERT INTO board_notice (title, content, writer, is_fixed)
VALUES ('주차별 역할 분담표', '첨부파일 확인하세요.', 'admin', 'N');

/* 자유게시판 샘플 글 */
INSERT INTO board_free (title, content, writer)
VALUES ('JSP 너무 어렵네요ㅠㅠ', '다들 어떻게 하고 계신가요?', 'user1');

COMMIT;