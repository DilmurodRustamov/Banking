package uz.fido.controller;


import uz.fido.dao.DeleteClientDao;
import uz.fido.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/table")
public class DeleteController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User auth = (User) request.getSession().getAttribute("auth");
        if (auth != null) {
            response.sendRedirect("client_table.jsp");
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String firstName = req.getParameter("firstName");
        String clientId = req.getParameter("clientId");
        String balance = req.getParameter("balance");

        DeleteClientDao deleteClientDao = new DeleteClientDao();
        deleteClientDao.deleteClient(clientId);


        resp.sendRedirect("client_table.jsp");
    }
}
