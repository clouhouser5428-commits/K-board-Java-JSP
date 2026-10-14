package com.board.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * JDBC connection helper.
 * Credentials are supplied through environment variables, not source code.
 */
public class DBUtil {
    private static final String URL = System.getenv().getOrDefault(
            "KBOARD_DB_URL", "jdbc:mysql://localhost:3306/boarddb?serverTimezone=Asia/Seoul");

    public static Connection getConnection() {
        String user = System.getenv("KBOARD_DB_USER");
        String password = System.getenv("KBOARD_DB_PASSWORD");
        if (user == null || user.isBlank() || password == null || password.isBlank()) {
            throw new IllegalStateException(
                    "Set KBOARD_DB_USER and KBOARD_DB_PASSWORD before running K-board.");
        }
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, user, password);
        } catch (ClassNotFoundException | SQLException e) {
            throw new IllegalStateException("Database connection failed.", e);
        }
    }
}
