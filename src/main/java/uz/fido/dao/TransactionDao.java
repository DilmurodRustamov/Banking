package uz.fido.dao;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import uz.fido.enums.TransactionType;
import uz.fido.model.Transactions;
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
public class TransactionDao {
    private Connection con;
    private String query;
    private PreparedStatement preparedStatement;
    private ResultSet resultSet;

    public TransactionDao(Connection connection) {
        this.con = connection;
    }


    public List<Transactions> getAllTransaction() {
        List<Transactions> transactions = new ArrayList<>();
        try {
            query = "select * from transactions";
            preparedStatement = this.con.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Transactions transaction = new Transactions();
                transaction.setId(resultSet.getInt("id"));
                transaction.setAmount(Double.valueOf(resultSet.getString("amount")));
                transaction.setFrom_id(Integer.valueOf(resultSet.getString("from_id")));
                transaction.setDate((resultSet.getDate("date")));
                transaction.setTo_id(Integer.valueOf(resultSet.getString("to_id")));
                transaction.setType(TransactionType.valueOf(resultSet.getString("type")));
                transactions.add(transaction);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return transactions;
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
