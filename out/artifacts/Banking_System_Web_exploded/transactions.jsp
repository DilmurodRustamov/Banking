<%@ page import="uz.fido.dao.TransactionDao" %>
<%@ page import="uz.fido.model.Transactions" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.fido.connection.DbConnection" %><%--
  Created by IntelliJ IDEA.
  User: hpProbook
  Date: 9/30/2021
  Time: 5:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<%@include file="includes/head.jsp" %>
<head>
    <title>All Transactions</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="//cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css">
</head>
<%@include file="includes/navbar.jsp" %>
<body>

<%--<nav class="navbar navbar-expand-lg navbar-light bg-light" >--%>
<%--    <a class="navbar-brand" href="#">Banking</a>--%>
<%--    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"--%>
<%--            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">--%>
<%--        <span class="navbar-toggler-icon"></span>--%>
<%--    </button>--%>

<%--    <div class="collapse navbar-collapse" id="navbarSupportedContent">--%>
<%--        <ul class="navbar-nav mr-auto">--%>
<%--            <li class="nav-item active">--%>
<%--                <a class="nav-link" href="#" style="color: black; margin: 0 15px">Home<span class="sr-only">(current)</span></a>--%>
<%--            </li>--%>
<%--            <li class="nav-item">--%>
<%--                <a class="nav-link" href="client_table.jsp" style="color: black; margin: 0 15px">Client</a>--%>
<%--            </li>--%>
<%--            <li class="nav-item">--%>
<%--                <a class="nav-link" href="bank.jsp" style="color: black; margin: 0 15px">Bank</a>--%>
<%--            </li>--%>
<%--            <li class="nav-item">--%>
<%--                <a class="nav-link" href="transactions.jsp" style="color: black; margin: 0 15px">--%>
<%--                    Transactions--%>
<%--                </a>--%>
<%--            </li>--%>
<%--        </ul>--%>
<%--    </div>--%>
<%--    <a class="nav-link" href="login.jsp">--%>
<%--        <button type="button" class="btn btn-outline-success waves-effect" style="padding: 2px 10px;">Log out</button>--%>
<%--    </a>--%>
<%--</nav>--%>

<h3 style="text-align: center">All Transacion</h3>
<div class="container-fluid" style="margin-top: 10px">
    <table class="table table-bordered table-hover table-striped" border="1" cellpadding="10" id="transactions">
        <thead class="thead-dark">
        <tr>
            <th>Tr</th>
            <th>ID</th>
            <th>Type</th>
            <th>Amount</th>
            <th>Date</th>
            <th>From Whom</th>
            <th>To Whom</th>
        </tr>
        </thead>
        <tbody>
        <%
            TransactionDao transactionService = new TransactionDao(DbConnection.getConnection());
            List<Transactions> transactions = transactionService.getAllTransaction();
            for (int i = 0; i < transactions.size(); i++) {
                out.print(
                        "<tr>" +
                                "<td>" + (i + 1) + "</td>" +
                                "<td>" + transactions.get(i).getId() + "</td>" +
                                "<td id='type_" + transactions.get(i).getId() + "'>" + (transactions.get(i).getType()) + "</td>" +
                                "<td id='amount_" + transactions.get(i).getId() + "'>$" + (transactions.get(i).getAmount()) + "</td>" +
                                "<td id='date_" + transactions.get(i).getId() + "'>" + (transactions.get(i).getDate()) + "</td>" +
                                "<td id='from_" + transactions.get(i).getId() + "'>" + (transactions.get(i).getTo_id()) + "</td>" +
                                "<td id='to_" + transactions.get(i).getId() + "'>" + (transactions.get(i).getFrom_id()) + "</td>" +
                                "<tr>"
                );
            }
        %>
        </tbody>
    </table>
</div>
<%@include file="includes/footer.jsp" %>
</body>
</html>

