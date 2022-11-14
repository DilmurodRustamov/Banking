package uz.fido.controller;

import uz.fido.dao.WithdrawDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/withdraw")
public class WithdrawController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String toTrx = req.getParameter("toTrx");
        String amountWithdraw = req.getParameter("amount");
        String fromTrx = req.getParameter("fromTrx");
        String clientBalance = req.getParameter("clientBalance");

        WithdrawDao withdrawDao = new WithdrawDao();
        withdrawDao.withdraw(toTrx, amountWithdraw, fromTrx,clientBalance);
        resp.sendRedirect("client_table.jsp");

    }
}
