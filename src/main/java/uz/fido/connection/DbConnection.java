package uz.fido.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConnection {

    private static final String url = "jdbc:postgresql://localhost:5432/banking_system";
    private static final String dbDriver = "org.postgresql.Driver";
    private static final String userName = "postgres";
    private static final String password = "root";

    public static Connection getConnection() {
        try {
            Class.forName(dbDriver);
            Connection connection = DriverManager.getConnection(url, userName, password);
            return connection;
        } catch (SQLException | ClassNotFoundException throwables) {
            throwables.printStackTrace();
        }
        return null;
    }
}
