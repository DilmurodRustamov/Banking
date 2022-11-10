
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.fido.model.User" %>
<%@ page import="uz.fido.model.Bank" %><%--
  Created by IntelliJ IDEA.
  User: Dilmurod
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User auth = (User) request.getSession().getAttribute("auth");
    if (auth != null) {
        response.sendRedirect("index.jsp");
    }
    ArrayList<Bank> cart_list = (ArrayList<Bank>) session.getAttribute("cart-list");
    List<Bank> banks = null;
    if (cart_list != null) {
        request.setAttribute("cart_list", cart_list);
    }
%>
<html>
<%@include file="includes/head.jsp" %>
<head>
    <title>Banking System</title>
</head>
<body>
<%@include file="includes/navbar.jsp" %>
<div class="container">
    <div class="panel-body">
        <div  class="alert alert-danger alert-dismissable">
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
            <span>Login failed</span>
        </div>
    <div class="card w-50 mx-auto my-5">
        <div class="card-header text-center">User login</div>
        <div class="card-body">
            <form action="login" method="post">
                <div class="form-group">
                    <label for="">Email Address</label>
                    <input type="email" class="form-control" name="email" placeholder="Enter your  name" required>
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" class="form-control" name="password" placeholder="Enter your password" required>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary">Login</button>
                </div>
            </form>
        </div>
    </div>
</div>
<%@include file="includes/footer.jsp" %>
</body>

</html>
