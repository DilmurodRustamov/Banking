
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="uz.fido.model.User" %>
<%@ page import="uz.fido.dao.BankDao" %>
<%@ page import="uz.fido.model.Bank" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.fido.connection.DbConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    DecimalFormat decimalFormat = new DecimalFormat("#.##");
    request.setAttribute("decimalFormat", decimalFormat);
    User auth = (User) request.getSession().getAttribute("auth");
    if (auth != null) {
        request.setAttribute("auth", auth);
    }

%>


<html>
<head>
    <title>Title</title>
    <%@include file="includes/head.jsp" %>
</head>
<body>
<%@include file="includes/navbar.jsp" %>
<style type="text/css">
    .table tbody td {
        vertical-align: middle;
    }

    .btn-incre, .btn-decre {
        box-shadow: none;
        font-size: 25px;
    }
</style>
<div class="container">
    <div class="card-header my-3">Add new bank</div>
    <form action="/client" method="post">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">First
                Name</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" name="firstName"
                       placeholder="Enter first name" required>
            </div>
        </div>

        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Last
                Name</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" name="lastName"
                       placeholder="Enter last name" required>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Email</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" name="email"
                       placeholder="Enter last name" required>
            </div>
        </div>

        <div class=" form-group row">
            <label class="col-sm-2 col-form-label">Balance</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" name="balance"
                       placeholder="Enter balance" required>
            </div>
        </div>

        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Password</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" name="password"
                       placeholder="Enter Password" required>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Bank</label>
            <div class="col-sm-7">
                <%
                    BankDao bankDao = new BankDao(DbConnection.getConnection());
                    List<Bank> banks = bankDao.getAllBank();
                    System.out.println("banks:"+banks);
                %>
                <select style="width: 100%" name="bank" id="name" class="form-control" >
                    <%
                        for (Bank bank : banks) {
                            out.print(
                                    "<option>" + bank.getName() + "</option>"
                            );
                        }
                    %>
                </select>
            </div>
        </div>
        <button type="submit" class="btn btn-primary" style="float: right">Add Client</button>
    </form>
</div>
<%@include file="includes/footer.jsp" %>
</body>
</html>
