package com.example.jsp_pr.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtill {
    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/teamdb?serverTimezone=Asia/Seoul",
                    "root", "1234"
            );
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}
