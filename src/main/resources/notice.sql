/* 이거 꼭 실행! */
USE teamdb;

CREATE TABLE IF NOT EXISTS board_notice (
                                            id INT AUTO_INCREMENT PRIMARY KEY COMMENT '글 번호',
                                            title VARCHAR(200) NOT NULL COMMENT '제목',
                                            content TEXT NOT NULL COMMENT '내용',
                                            writer VARCHAR(50) NOT NULL COMMENT '작성자',
                                            viewcnt INT DEFAULT 0 COMMENT '조회수',
                                            regdate DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '작성일',
                                            is_fixed CHAR(1) DEFAULT 'N' COMMENT '상단고정(Y/N)'
);

INSERT INTO board_notice (title, content, writer, is_fixed) VALUES ('테스트 공지', '내용', 'admin', 'N');
COMMIT;