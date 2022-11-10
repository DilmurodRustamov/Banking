package uz.fido.dao;

import uz.fido.connection.DbConnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DeleteClientDao {

    private Connection con;
    private String query;

    public boolean delete(String firstName, String clientId) {
        try {
            Connection connection = DbConnection.getConnection();
            Statement statement = connection.createStatement();
            String query = clientId == null && clientId != null ? "delete from users where id=" + Integer.valueOf(clientId)
                    : "update users set first_name='" + firstName + "' wwhere id=" + Integer.valueOf(clientId);
            boolean execute = statement.execute(query);
            System.out.println(execute);
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteClient(String clientId) {
        try {
            Connection connection = DbConnection.getConnection();
            Statement statement = connection.createStatement();
            String query = "delete from users where id=" + Integer.valueOf(clientId) + "";
            boolean execute = statement.execute(query);
            System.out.println(execute);
            return true;
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return false;
    }
}
