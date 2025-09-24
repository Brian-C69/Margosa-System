<%-- 
    Document   : joinFamily.jsp
    Created on : Jul 2, 2023, 2:31:22 AM
    Author     : Bernard
--%>
<%@page import="model.Resident"%>
<%
    Resident resident = (Resident) request.getSession().getAttribute("resident");
    if (resident == null || resident.getFid() != 0) {
        request.setAttribute("errorMessage", "You must be Logged In");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | Join Family</title>
        <style>.wrapper{
                width: 360px;
                padding: 20px;
            }</style>
        <script>
            function limitInputLength(input, maxLength) {
                if (input.value.length > maxLength) {
                    input.value = input.value.slice(0, maxLength); // Truncate the input to the maximum length
                }
            }
        </script>
    </head>
    <body>
        <jsp:include page="includes/navbar.jsp"/>
        <div class="container pt-5"></div>
        <div class="container pt-5"></div>
        <div class="container">
            <div class="wrapper">
                <h1>Join an <br>Existing Family</h1>
                <p>Please enter the Family ID and Family PIN to join a family:</p>
                <% String errorMessage = (String) request.getAttribute("errorMessage");
                    if (errorMessage != null) {%>
                <div class="alert alert-danger" role="alert">
                    <%= errorMessage%>
                </div>
                <% }%>
                <form action="JoinFamilyServlet" method="post">
                    <div class="form-group">
                        <label for="fid">Family ID</label>
                        <input type="text" class="form-control" id="fid" name="fid" value="<%= (request.getAttribute("fidInput") != null) ? request.getAttribute("fidInput") : ""%>" required>
                    </div>

                    <div class="form-group pt-2">
                        <label for="pin">Family PIN</label>
                        <input type="password" pattern="[0-9]*" inputmode="numeric" class="form-control" id="pin" name="pin" required oninput="limitInputLength(this, 6)">
                    </div>
                    <div class="form-group pt-2">
                        <button type="submit" class="btn btn-primary">Join Family</button>
                        <a href="joinOrCreateFamily.jsp" class="btn btn-danger">Back</a>
                        <p class="pt-3">Don't have an Existing Family? <a href="createFamily.jsp">Create New Family</a>.</p>
                    </div>
                </form>
            </div>
        </div>

        <jsp:include page="includes/footer.html"/>
    </body>
</html>
