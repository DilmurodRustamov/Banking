<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.util.List" %>
<%@ page import="uz.fido.dao.BankDao" %>
<%@ page import="uz.fido.connection.DbConnection" %>
<%@ page import="uz.fido.model.Bank" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%
    BankDao bankDao = new BankDao(DbConnection.getConnection());
    List<Bank> banks = bankDao.getAllBank();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Bank</title>
    <%@include file="includes/head.jsp" %>
</head>
<body>
<%@include file="includes/navbar.jsp" %>
<div class="container">
    <div class="card-header my-3">All Banks</div>
    <form action="bank" method="post">
        <div class="row">
            <div class="col-sm-4 col-md-4">
                <div class="form-group">
                    <label>Name</label>
                    <input type="text" class="form-control input-lg" id="bankName" name="name"
                           placeholder="Enter bank name" required>
                </div>
            </div>
            <div class="col-sm-4 col-md-4">
                <div class="form-group">
                    <label>Address</label>
                    <input type="text" class="form-control input-lg" id="address" name="address"
                           placeholder="Enter bank address" required>
                </div>
            </div>
            <div class="col-sm-4 col-md-4">
                <div class="form-group">
                    <label>Iban</label>
                    <input type="text" class="form-control input-lg" id="iban" name="iban"
                           placeholder="Enter bank address" required>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <div class="from-group" style="float: right;">
                    <button type="submit" class="btn btn-primary" style="float: right">Add Bank</button>
                </div>
            </div>
        </div>
    </form>
    <br>
    <table class="table table-light table-striped">
        <thead>
        <tr>
            <th scope="col">Tr</th>
            <th scope="col">ID</th>
            <th scope="col">Name</th>
            <th scope="col">Address</th>
            <th scope="col">Iban</th>
            <th scope="col">Action</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (banks != null) {
                int i = 0;
                for (Bank bank : banks) {
                    i++;%>
        <tr>
            <td><%= i%>
            </td>
            <td><%= bank.getId()%>
            </td>
            <td><%= bank.getName()%>
            </td>
            <td><%= bank.getAddress()%>
            </td>
            <td><%= bank.getIban()%>
            </td>
            <td>
                <a class="btn btn-sm btn-warning" href="bank?id=<%= bank.getId()%>"> <i class="fa-solid fa-pen-to-square"></i> </a>
                <a class="btn btn-sm btn-danger" href="bank?id=<%= bank.getId()%>"><i class="fa fa-trash" aria-hidden="true"></i></a>
            </td>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
</div>
<%@include file="includes/footer.jsp" %>
</body>
</html>