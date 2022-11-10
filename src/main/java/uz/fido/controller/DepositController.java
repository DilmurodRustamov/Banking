//package uz.fido.controller;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import java.io.IOException;
//
//@WebServlet("/deposit")
//public class DepositController extends HttpServlet {
//
//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String toDeposit = req.getParameter("toDeposit");
//        String amount = req.getParameter("amount");
//        String deposit = req.getParameter("deposit");
//        String depositBalance = req.getParameter("depositBalance");
//        DepositService depositService = new DepositService();
//        depositService.deposit(toDeposit,amount,deposit,depositBalance);
//
//        resp.sendRedirect("client_table.jsp");
//
//    }
//}
