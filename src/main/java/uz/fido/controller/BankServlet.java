package uz.fido.controller;

import uz.fido.connection.DbConnection;
import uz.fido.dao.BankDao;
import uz.fido.dao.UserDao;
import uz.fido.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet("/bank")
public class BankServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
        String bankId = request.getParameter("bankId");
        if (bankId != null) {
            BankDao bankDao = new BankDao(DbConnection.getConnection());
            bankDao.deleteBank(bankId);
        }

        User auth = (User) request.getSession().getAttribute("auth");
        if (auth != null) {
            resp.sendRedirect("bank.jsp");
        } else {
            resp.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF=8");
        try (PrintWriter out = response.getWriter()) {
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String iban = request.getParameter("iban");
            BankDao bankDao = new BankDao(DbConnection.getConnection());
            boolean saved = bankDao.insertBank(id, name, address, iban);
            if (saved) {
                response.sendRedirect("bank.jsp");
            } else {
                out.print("user login failed");
            }
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String id = request.getParameter("id");
            if (id != null) {
                BankDao bankDao = new BankDao(DbConnection.getConnection());
                bankDao.deleteBank(id);
            } else {
                response.sendRedirect("bank.jsp");
            }
        }
    }
}
