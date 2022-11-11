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
            <td><%= bank.getId()%></td>
            <td id="name_<%= bank.getId()%>"><%= bank.getName()%></td>
            <td id="address_<%= bank.getId()%>"><%= bank.getAddress()%></td>
            <td id="iban_<%= bank.getId()%>"><%= bank.getIban()%></td>
            <td>
                <a class="btn btn-sm btn-warning" href="#" type='button' onclick='editBank(<%= bank.getId()%>)'> <i
                        class="fa-solid fa-pen-to-square"></i> </a>
                <a class="btn btn-sm btn-danger" href="#" type='button' onclick='deleteBank(<%= bank.getId()%>)'><i
                        class="fa fa-trash" aria-hidden="true"></i></a>
            </td>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
</div>
<div id="deleteModal" class="modal"
     style="width: 500px; height: 600px; margin-top: 200px;margin-left: 430px; text-align: center">
    <span onclick="document.getElementById('deleteModal').style.display='none'" class="close" title="Close Modal">&times;</span>
    <form class="modal-content" action="/bank" method="get">
        <div class="container">
            <h1>Delete Client</h1>
            <p>Are you sure you want to delete this client?</p>
            <div class="clearfix">
                <input type="hidden" id="bankId" name="bankId">
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
        <h1 style="color: black">Edit Bank</h1>
        <form action="/bank" method="post">
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">ID</label>
                <div class="col-sm-7">
                    <input readonly="readonly" type="text" class="form-control" id="id" name="id"
                           placeholder="Enter first name">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Name</label>
                <div class="col-sm-7">
                    <input type="text" class="form-control" id="editName" name="name"
                           placeholder="Enter name">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Address</label>
                <div class="col-sm-7">
                    <input type="text" class="form-control" id="editAddress" name="address"
                           placeholder="Enter last name">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Iban</label>
                <div class="col-sm-7">
                    <input type="text" class="form-control" id="editIban" name="iban"
                           placeholder="Enter last name">
                </div>
            </div>
            <button type="submit" id="edit" class="btn btn-primary" style="float: right">Edit Client</button>
        </form>
    </div>
</div>
<%@include file="includes/footer.jsp" %>

<script>
    function deleteBank(id) {
        console.log(id);
        document.getElementById('deleteModal').style.display = 'block';
        document.getElementById("bankId").value = id;
        document.getElementById("yes").type = 'submit';
    }

    function editBank(id) {
        document.getElementById('editModal').style.display = 'block';
        var name = document.getElementById('name_' + id).textContent;
        var address = document.getElementById('address_' + id).textContent;
        var iban = document.getElementById('iban_' + id).textContent;

        document.getElementById('id').value = id;
        document.getElementById('editName').value = name;
        document.getElementById('editAddress').value = address;
        document.getElementById('editIban').value = iban;

    }
</script>
</body>
</html>