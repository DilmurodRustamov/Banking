package uz.fido.controller;

import uz.fido.connection.DbConnection;
import uz.fido.dao.ClientDao;
import uz.fido.dao.UserDao;
import uz.fido.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/client")
public class ClientServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("client.jsp");
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
        clientDao.insertClient(id,firstName,lastName,email,bank,balance,password);

        resp.sendRedirect("client_table.jsp");
    }
}
