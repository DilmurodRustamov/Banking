package uz.fido.controller;

import uz.fido.connection.DbConnection;
import uz.fido.dao.UserDao;
import uz.fido.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User auth = (User) request.getSession().getAttribute("auth");
        if (auth != null) {
            response.sendRedirect("home.jsp");
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF=8");
        try (PrintWriter out = response.getWriter()) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            UserDao userDao = new UserDao(DbConnection.getConnection());
            User user = userDao.userLogin(email, password);
            if (user != null) {
                request.getSession().setAttribute("auth", user);
                response.sendRedirect("home.jsp");
            } else {
                request.getSession().setAttribute("errorMessage", "Invalid username or password");
                response.sendRedirect("login.jsp");
            }
        }
    }

}
