<%-- 
    Document   : error404
    Created on : Jun 28, 2023, 10:45:27 PM
    Author     : Bernard
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | Home</title>
    </head>
    <body>
        <jsp:include page="includes/navbar.html"/>
        <div class="container pt-5"></div>
        <div class="container p-5 my-5 bg-dark text-white">
            <h1>ERROR 404</h1>
            <p>File not found</p>
        </div>
        <jsp:include page="includes/footer.html"/>
    </body>
</html>
