package uz.fido.dao;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import uz.fido.model.Bank;
import uz.fido.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ClientDao {
    private Connection con;
    private String query;
    private PreparedStatement preparedStatement;
    private ResultSet resultSet;

    public ClientDao(Connection connection) {
        this.con = connection;
    }

    public boolean insertClient(String id, String firstName, String lastName, String email, String bank, String balance, String password) {
        boolean result = false;

        try {
            if (id != null) {
                query = "UPDATE users SET first_name=?,last_name=?, email=?,bank=?,balance=? WHERE id =" + Integer.parseInt(id);

            } else {
                query = "insert into users(first_name,last_name, email,bank,balance, password) values(?,?,?,?,?,?);";
            }
            preparedStatement = this.con.prepareStatement(query);
            preparedStatement.setString(1, firstName);
            preparedStatement.setString(2, lastName);
            preparedStatement.setString(3, email);
            preparedStatement.setString(4, bank);
            preparedStatement.setDouble(5, Double.parseDouble(balance));
            if (id == null)
                preparedStatement.setString(6, password);
            preparedStatement.executeUpdate();
            result = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public List<User> getAllUser() {
        List<User> users = new ArrayList<>();
        try {
            query = "select * from users";
            preparedStatement = this.con.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                User user = new User();
                user.setId(resultSet.getInt("id"));
                user.setFirstName(resultSet.getString("first_name"));
                user.setLastName(resultSet.getString("last_name"));
                user.setEmail(resultSet.getString("email"));
                user.setBank(resultSet.getString("bank"));
                user.setBalance(Double.valueOf(resultSet.getString("balance")));
                users.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
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

//    public List<Order> userOrders(int id) {
//        List<Order> orders = new ArrayList<>();
//        try {
//            query = "select * from orders where u_id=? order by orders.o_id desc";
//            preparedStatement = this.con.prepareStatement(query);
//            preparedStatement.setInt(1, id);
//            resultSet = preparedStatement.executeQuery();
//
//            while (resultSet.next()) {
//                Order order = new Order();
//                ProductDao productDao = new ProductDao(this.con);
//                int productId = resultSet.getInt("p_id");
//                Product product = productDao.getSingLeProduct(productId);
//                order.setOrderId(resultSet.getInt("o_id"));
//                order.setId(productId);
//                order.setName(product.getName());
//                order.setCategory(product.getCategory());
//                order.setPrice(product.getPrice() * resultSet.getInt("o_quantity"));
//                order.setQuantity(resultSet.getInt("o_quantity"));
//                order.setDate(resultSet.getString("o_date"));
//                orders.add(order);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//            return orders;
//    }
//
//    public void cancelOrder(int id){
//        try {
//            query = "select from orders where o_id=?";
//            preparedStatement = this.con.prepareStatement(query);
//            preparedStatement.setInt(1,id);
//            preparedStatement.execute();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//    }
}
