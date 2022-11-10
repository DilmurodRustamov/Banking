<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.util.List" %>
<%@ page import="uz.fido.dao.BankDao" %>
<%@ page import="uz.fido.connection.DbConnection" %>
<%@ page import="uz.fido.model.Bank" %>
<%@ page import="uz.fido.dao.ClientDao" %>
<%@ page import="uz.fido.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%
    ClientDao clientDao = new ClientDao(DbConnection.getConnection());
    List<User> users = clientDao.getAllUser();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Bank</title>
    <%@include file="includes/head.jsp" %>
</head>
<body >
<%@include file="includes/navbar.jsp" %>

<div class="container">
    <div class="card-header my-3">All Client</div>
    <a href="client" style="float: right; margin: 10px 20px">
        <button class="btn btn-primary" style="padding: 2px 6px;">Add Client</button>
    </a>
    <table class="table table-light table-striped">
        <thead>
        <tr>
            <th scope="col">ID</th>
            <th scope="col">First name</th>
            <th scope="col">Last name</th>
            <th scope="col">Balance</th>
            <th scope="col">Email</th>
            <th scope="col">Bank</th>
            <th scope="col">Type</th>
            <th scope="col" colspan="2">Action</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (users != null) {
                for (User user : users) {%>
        <tr>
            <td ><%= user.getId()%></td>
            <td id="first_name_<%=user.getId()%>"><%= user.getFirstName()%></td>
            <td id="last_name_<%=user.getId()%>"><%= user.getLastName()%></td>
            <td id="balance_<%=user.getId()%>"><%= user.getBalance()%></td>
            <td id="email_<%=user.getId()%>"><%= user.getEmail()%></td>
            <td id="bank_<%=user.getId()%>"><%= user.getBank()%></td>
            <td>
<%--                <a href='#' style='margin:0 10px'><button onclick='deposit(<%= user.getId()%>)' type='button' class='btn btn-outline-info waves-effect'>Deposit</button></a>--%>
                <a href='#' style='margin:0 10px'><button onclick='withdraw(<%= user.getId()%>,<%= user.getBalance()%>)' type='button' class='btn btn-outline-success  waves-effect'>Transaction</button></a></td>
            <td>
                <a class="btn btn-sm btn-warning" href="#" type='button' onclick='editClient(<%= user.getId()%>)'> <i class="fa-solid fa-pen-to-square"></i> </a>
                <a class="btn btn-sm btn-danger" href="#"  type='button' onclick='deleteClient(<%= user.getId()%>)'><i class="fa fa-trash" aria-hidden="true"></i></a>
            </td>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
</div>
<div id="deleteModal" class="modal" style="width: 500px; height: 600px; margin-top: 200px;margin-left: 430px; text-align: center">
    <span onclick="document.getElementById('deleteModal').style.display='none'" class="close" title="Close Modal">&times;</span>
    <form class="modal-content" action="/table" method="post">
        <div class="container">
            <h1>Delete Client</h1>
            <p>Are you sure you want to delete this client?</p>
            <div class="clearfix">
                <input type="hidden" id="clientId" name="clientId">
                <button type="button" style="margin: 10px 20px; width: 100px" class="btn btn-success"
                        onclick="saveCountry()" id="no">Cancel
                </button>
                <button type="button" style="margin: 10px 20px; width: 100px" class="btn btn-danger"
                        onclick="saveCountry()" id="yes">Delete
                </button>
            </div>
        </div>
    </form>
</div>


<div id="editModal" class="modal" style="margin-top: 100px">
    <div class="container jumbotron">
        <span onclick="document.getElementById('editModal').style.display='none'" class="close" title="Close Modal">&times;</span>
        <h1 style="color: black">Transaction</h1>
        <form action="/add" method="post">
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">ID</label>
                <div class="col-sm-7">
                    <input readonly="readonly" type="text" class="form-control" id="id" name="id"
                           placeholder="Enter first name">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">First
                    Name</label>
                <div class="col-sm-7">
                    <input type="text" class="form-control" id="firstName" name="firstName"
                           placeholder="Enter first name">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Last
                    Name</label>
                <div class="col-sm-7">
                    <input type="text" class="form-control" id="lastName" name="lastName"
                           placeholder="Enter last name">
                </div>
            </div>

            <div class=" form-group row">
                <label class="col-sm-2 col-form-label">Balance</label>
                <div class="col-sm-7">
                    <input type="text" class="form-control" id="balance" name="balance"
                           placeholder="Enter balance">
                </div>
            </div>

            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Bank</label>
                <div class="col-sm-7">
                    <%
                        BankDao bankService = new BankDao(DbConnection.getConnection());
                        List<Bank> banks = bankService.getAllBank();
                    %>
                    <select style="width: 100%" name="bank" id="bank">
                        <%
                            for (int i = 0; i < banks.size(); i++) {
                                out.print(
                                        "<option>" + banks.get(i).getName() + "</option>"
                                );
                            }
                        %>
                    </select>
                </div>
            </div>

            <button type="submit" id="edit" class="btn btn-primary" style="float: right">Edit Client</button>
        </form>
    </div>
</div>

<div id="depositModal" class="modal" style="margin-top: 50px">
    <div class="container jumbotron" style="border: black">
        <span onclick="document.getElementById('depositModal').style.display='none'" class="close" title="Close Modal">&times;</span>
        <h1 style="color: black">DEPOSIT</h1>
        <div class="card bg-transparent">
            <div class="card-body">
                <form action="/deposit" method="post">
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label">From Whom</label>
                        <div class="col-sm-7">
                            <input readonly="readonly" type="text" class="form-control" id="depositId" name="deposit"
                                   placeholder="Enter first id">
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label">To Whom</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" id="toDepositId" name="toDeposit"
                                   placeholder="Enter second id">
                        </div>
                    </div>
                    <div class=" form-group row">
                        <label class="col-sm-2 col-form-label">Amount</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" id="amount" name="amount"
                                   placeholder="Enter amount">
                        </div>
                    </div>
                    <div class=" form-group row">
                        <label class="col-sm-2 col-form-label">Your Balance</label>
                        <div class="col-sm-7">
                            <input readonly="readonly" type="text" id="depositBalance" class="form-control"
                                   name="depositBalance"
                                   placeholder="Your Balance">
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary" style="float: right">Send</button>
                </form>
            </div>
        </div>
    </div>
</div>

<div id="withdrawModal" class="modal" style="margin-top: 50px">
    <div class="container jumbotron">
        <span onclick="document.getElementById('withdrawModal').style.display='none'" class="close" title="Close Modal">&times;</span>
        <h1 style="color: black">Transaction</h1>
        <div class="card bg-transparent">
            <div class="card-body">
                <form action="/withdraw" method="post">
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label">To Whom</label>
                        <div class="col-sm-7">
                            <input type="text" readonly="readonly" class="form-control" id="fromTrx"
                                   name="fromTrx"
                                   placeholder="Enter first id">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label">From Whom</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" name="toTrx"
                                   placeholder="To">
                        </div>
                    </div>

                    <div class=" form-group row">
                        <label class="col-sm-2 col-form-label">Amount</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" name="amount"
                                   placeholder="Enter amount">
                        </div>
                    </div>
                    <div class=" form-group row">
                        <label class="col-sm-2 col-form-label">Your Balance</label>
                        <div class="col-sm-7">
                            <input readonly="readonly" type="text" id="withdraw" class="form-control"
                                   name="withdrawBalance"
                                   placeholder="Your Balance">
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary" style="float: right">Send</button>
                </form>
            </div>
        </div>
    </div>
</div>
<%@include file="includes/footer.jsp" %>
<script>

    function saveCountry() {
        document.getElementById("saveButton").type = 'submit';
        document.getElementById("no").type = 'submit';
    }

    function editClient(id) {
        document.getElementById('editModal').style.display = 'block';
        var firstName = document.getElementById('first_name_' + id).textContent;
        var lastName = document.getElementById('last_name_' + id).textContent;
        var balance = document.getElementById('balance_' + id).textContent;
        var bank = document.getElementById('bank_'+id).textContent;
        document.getElementById('id').value = id;
        document.getElementById('firstName').value = firstName;
        document.getElementById('lastName').value = lastName;
        document.getElementById('balance').value = balance;
        document.getElementById('bank').value = bank;
        console.log(name);
        console.log(id);
    }

    function deleteClient(id) {
        console.log(id);
        document.getElementById('deleteModal').style.display = 'block';
        document.getElementById("clientId").value = id;
        document.getElementById("yes").type = 'submit';
    }

    function deposit(id) {
        document.getElementById('depositModal').style.display = 'block';
        var depositBalance = document.getElementById(id).textContent;
        var depositBalance = document.getElementById('balance_' + id).textContent;
        document.getElementById('depositId').value = id;
        document.getElementById('depositBalance').value = depositBalance;
    }

    //TODO Add user find
    function withdraw(id,balance) {
        document.getElementById('withdrawModal').style.display = 'block';
        document.getElementById('fromTrx').value = id;
        document.getElementById('withdraw').value = balance;
    }
</script>
</body>
</html>