package uz.fido.dao;

import uz.fido.connection.DbConnection;
import uz.fido.enums.TransactionType;

import java.sql.*;
import java.util.Date;

public class WithdrawDao {
    //    private Connection con;
    private String query;
//    private PreparedStatement preparedStatement;
//    private ResultSet resultSet;

//    public WithdrawDao(Connection connection) {
//        this.con = connection;
//    }

    public boolean withdraw(String toTrx, String trxAmount, String fromTrx, String clientBalance) {
        try {
            Connection connection = DbConnection.getConnection();
            Statement statement = connection.createStatement();
            query = "select * from users where id=" + Integer.valueOf(toTrx);
            ResultSet resultSet = statement.executeQuery(query);
            Integer id = null;
            Double balance = null;
            while (resultSet.next()) {
                id = resultSet.getInt("id");
                balance = resultSet.getDouble("balance");
            }
            if (id != null) {
                if (Integer.valueOf(toTrx) == Integer.valueOf(fromTrx)) {
                    query = "UPDATE users SET balance = balance - " + Integer.valueOf(trxAmount) + " WHERE id = " + Integer.valueOf(fromTrx) + "";
                    statement.executeUpdate(query);
                    query = "INSERT INTO transactions (type,amount,date,from_id,to_id)" + " VALUES('" + TransactionType.DEPOSIT + "'," + Integer.valueOf(trxAmount) + ",'" + new Date() + "'," + Integer.valueOf(toTrx) + "," + Integer.valueOf(fromTrx) + ");";
                    statement.executeUpdate(query);
                } else if (Double.parseDouble(clientBalance) > Double.parseDouble(trxAmount)) {
                    query = "UPDATE users SET balance = balance + " + Double.valueOf(trxAmount) + " WHERE id = " + Integer.parseInt(toTrx) + "";
                    statement.executeUpdate(query);
                    query = "UPDATE users SET balance = balance - " + Double.valueOf(trxAmount) + " WHERE id = " + Integer.parseInt(fromTrx) + "";
                    statement.executeUpdate(query);
                    query = "INSERT INTO transactions (type,amount,date,from_id,to_id)" + " VALUES ('" + TransactionType.PAYMENT + "'," + Double.valueOf(trxAmount) + ",'" + new Date() + "'," + Integer.valueOf(toTrx) + "," + Integer.valueOf(fromTrx) + ");";
                    statement.executeUpdate(query);
                }
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return true;
    }
}
