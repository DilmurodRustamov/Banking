package uz.fido.dao;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import uz.fido.model.Bank;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BankDao {
    private Connection con;
    private String query;
    private PreparedStatement preparedStatement;
    private ResultSet resultSet;

    public BankDao(Connection connection) {
        this.con = connection;
    }

    public boolean insertBank(String id, String name, String address, String iban) {
        boolean result = false;

        try {
            if (id != null) {
                query = "UPDATE bank SET name=?,address=?,iban=? where id=" + Integer.parseInt(id);
            } else {
                query = "insert into bank(name,address,iban) values(?,?,?)";
            }
            preparedStatement = this.con.prepareStatement(query);
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, address);
            preparedStatement.setString(3, iban);
            preparedStatement.executeUpdate();
            result = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public List<Bank> getAllBank() {
        List<Bank> banks = new ArrayList<>();
        try {
            query = "select * from bank";
            preparedStatement = this.con.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Bank bank = new Bank();
                bank.setId(resultSet.getInt("id"));
                bank.setName(resultSet.getString("name"));
                bank.setAddress(resultSet.getString("address"));
                bank.setIban(resultSet.getString("iban"));
                banks.add(bank);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return banks;
    }

    public boolean deleteBank(String id) {
        boolean result = false;
        try {
            query = "delete from bank where id=" + Integer.valueOf(id) + "";
            preparedStatement = this.con.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();
            result = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

}
