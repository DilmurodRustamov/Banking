package uz.fido.controller;

import uz.fido.connection.DbConnection;
import uz.fido.dao.ClientDao;
import uz.fido.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/transaction")
public class TransactionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User auth = (User) request.getSession().getAttribute("auth");
        if (auth != null) {
            response.sendRedirect("transactions.jsp");
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String email = req.getParameter("email");
        String bank = req.getParameter("bank");
        String balance = req.getParameter("balance");
        String password = req.getParameter("password");

        ClientDao clientDao = new ClientDao(DbConnection.getConnection());
        User user = new User();
        clientDao.insertClient(id, firstName, lastName, email, bank, balance, password);

        resp.sendRedirect("client_table.jsp");
    }
}
