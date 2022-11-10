
<%@ page import="java.util.ArrayList" %>
<%@ page import="uz.fido.model.User" %>
<%@ page import="uz.fido.connection.DbConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%--%>
<%--    User auth = (User) request.getSession().getAttribute("auth");--%>
<%--//    List<Product> products = null;--%>
<%--    if (auth != null) {--%>
<%--        request.setAttribute("auth", auth);--%>
<%--//        response.sendRedirect("index.jsp");--%>
<%--    }--%>
<%--    ProductDao productDao = new ProductDao(DbConnection.getConnection());--%>
<%--    List<Product> products = productDao.getAllProduct();--%>

<%--    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");--%>
<%--    List<Cart> cartProduct = null;--%>
<%--    if (cart_list != null) {--%>
<%--        request.setAttribute("cart_list", cart_list);--%>
<%--    }--%>
<%--%>--%>
<html>
<head>
    <title> Banking System </title>
    <%@include file="includes/head.jsp" %>
</head>
<body>

<%@include file="includes/navbar.jsp" %>
<div class="container">
    <div class="card-header my-3">Main page</div>
</div>
<%--    <div class="row">--%>
<%--        <%--%>
<%--            if (!products.isEmpty()) {--%>
<%--                for (Product product : products) {%>--%>
<%--        <div class="col-md-3">--%>
<%--            <div class="card w-100" style="width: 18rem;">--%>
<%--                <img class="card-img-top" src="product-images/<%= product.getImage()%>" alt="Card image cap">--%>
<%--                <div class="card-body">--%>
<%--                    <h5 class="card-title"><%= product.getName()%>--%>
<%--                    </h5>--%>
<%--                    <h6 class="price">$<%= product.getPrice()%>--%>
<%--                    </h6>--%>
<%--                    <h6 class="category"><%= product.getCategory()%>--%>
<%--                    </h6>--%>
<%--                    <div class="mt-3 d-flex justify-content-between">--%>
<%--                        <a href="add-to-cart?id=<%= product.getId()%>" class="btn btn-dark">Add to card</a>--%>
<%--                        <a href="order-now?quantity=1&id=<%=product.getId()%>" class="btn btn-primary">Buy now</a>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <%--%>
<%--                }--%>
<%--            }--%>
<%--        %>--%>

<%--    </div>--%>
<%--</div>--%>
<%@include file="includes/footer.jsp" %>
</body>
</html>
