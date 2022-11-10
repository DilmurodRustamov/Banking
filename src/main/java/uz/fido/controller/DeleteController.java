package uz.fido.controller;


import uz.fido.dao.DeleteClientDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/table")
public class DeleteController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("client_table.jsp");
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
