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

    public boolean withdraw(String toTrx, String amountWithdraw, String fromTrx) {
        try {
            Connection connection = DbConnection.getConnection();
            Statement statement = connection.createStatement();
            query = "select * from users where id=" + Integer.valueOf(toTrx);
            ResultSet resultSet = statement.executeQuery(query);
            Integer id = null;
            while (resultSet.next()) {
                id = resultSet.getInt("id");
            }
            if (id != null) {
                if (Integer.valueOf(toTrx) == Integer.valueOf(fromTrx)) {
                    query = "UPDATE users SET balance = balance - " + Integer.valueOf(amountWithdraw) + " WHERE id = " + Integer.valueOf(fromTrx) + "";
                    statement.executeUpdate(query);
                    query = "INSERT INTO transactions (type,amount,date,from_id,to_id)" + " VALUES('" + TransactionType.DEPOSIT + "'," + Integer.valueOf(amountWithdraw) + ",'" + new Date() + "'," + Integer.valueOf(toTrx) + "," + Integer.valueOf(fromTrx) + ");";
                    statement.executeUpdate(query);
                } else {
                    query = "UPDATE users SET balance = balance + " + Double.valueOf(amountWithdraw) + " WHERE id = " + Integer.parseInt(toTrx) + "";
                    statement.executeUpdate(query);
                    query = "UPDATE users SET balance = balance - " + Double.valueOf(amountWithdraw) + " WHERE id = " + Integer.parseInt(fromTrx) + "";
                    statement.executeUpdate(query);
                    query = "INSERT INTO transactions (type,amount,date,from_id,to_id)" + " VALUES ('" + TransactionType.PAYMENT + "'," + Double.valueOf(amountWithdraw) + ",'" + new Date() + "'," + Integer.valueOf(toTrx) + "," + Integer.valueOf(fromTrx) + ");";
                    statement.executeUpdate(query);
                }
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return true;
    }
}
