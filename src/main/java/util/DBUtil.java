package util;

import java.sql.*;

public class DBUtil {
    public static Connection getConnection() throws Exception {
        String url = System.getenv().getOrDefault(
            "MOMONET_DB_URL",
            "jdbc:mysql://localhost:3306/momonet?serverTimezone=Asia/Seoul"
        );
        String user = System.getenv().getOrDefault("MOMONET_DB_USER", "root");
        String pw = System.getenv().getOrDefault("MOMONET_DB_PASSWORD", "YOUR_DB_PASSWORD");

        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, user, pw);
    }
}
