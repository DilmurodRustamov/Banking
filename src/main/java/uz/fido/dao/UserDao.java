package uz.fido.dao;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import uz.fido.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserDao {
    private Connection con;
    private String query;
    private PreparedStatement preparedStatement;
    private ResultSet resultSet;

    public UserDao(Connection connection) {
        this.con = connection;
    }

    public User userLogin(String email, String password) {
        User user = null;
        try {
            String query = "SELECT * FROM users WHERE email=? AND password=?";
            preparedStatement = this.con.prepareStatement(query);
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                user = new User();
                user.setId(resultSet.getInt("id"));
                user.setFirstName(resultSet.getString("first_name"));
                user.setLastName(resultSet.getString("last_name"));
                user.setEmail(resultSet.getString("email"));
                user.setBank(resultSet.getString("bank"));
                user.setBalance(resultSet.getDouble("balance"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.print(e.getMessage());
        }
        return user;
    }
}
