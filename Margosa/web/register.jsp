<%--
    Document   : register
    Created on : Jun 29, 2023, 5:13:07 PM
    Author     : Bernard
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="connection.SqlCon"%>
<%@page import="model.Resident"%>
<% 
    Resident resident = (Resident) request.getSession().getAttribute("resident");
    if (resident != null) {
        response.sendRedirect("home.jsp");
    }

    // Get the stored values from request attributes
    String storedFirstname = (String) request.getAttribute("storedFirstname");
    String storedLastname = (String) request.getAttribute("storedLastname");
    String storedGender = (String) request.getAttribute("storedGender");
    String storedEmail = (String) request.getAttribute("storedEmail");
    String storedPhone = (String) request.getAttribute("storedPhone");
    String storedUsername = (String) request.getAttribute("storedUsername");
    String storedBirthday = (String) request.getAttribute("storedBirthday");

    // Set default values if stored values are null
    storedFirstname = (storedFirstname != null) ? storedFirstname : "";
    storedLastname = (storedLastname != null) ? storedLastname : "";
    storedGender = (storedGender != null) ? storedGender : "";
    storedEmail = (storedEmail != null) ? storedEmail : "";
    storedPhone = (storedPhone != null) ? storedPhone : "";
    storedUsername = (storedUsername != null) ? storedUsername : "";
    storedBirthday = (storedBirthday != null) ? storedBirthday : "";
%>

<!DOCTYPE html>
<html>
<head>
    <jsp:include page="includes/headers.html"/>
    <title>MyMargosaApp | Register</title>
    <style>.wrapper{ width: 360px; padding: 20px; }</style>
</head>
<body>
    <jsp:include page="includes/navbar.jsp"/>
    <div class="container pt-5"></div>
    <div class="container pt-5"></div>
    <div class="container pt-5 pb-5">
        <h1>Register</h1>
    </div>
    
    <div class="container">
        <div class="wrapper">
            <% String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) {%>
            <div class="alert alert-danger" role="alert">
                <%= errorMessage%>
            </div>
            <% }%>
            <form action="ResidentRegisterServlet" method="post">
                <div class="form-group">
                    <label>First Name</label>
                    <input type="text" name="firstname" class="form-control" value="<%= storedFirstname %>" required>
                    <span class="invalid-feedback"></span>
                </div>
                
                <div class="form-group pt-2">
                    <label>Last Name</label>
                    <input type="text" name="lastname" class="form-control" value="<%= storedLastname %>" required>
                    <span class="invalid-feedback"></span>
                </div>

                <div class="form-group pt-2">
                    <label>Gender</label>
                    <select name="gender" class="form-control" required>
                        <option value="" disabled selected>Please select</option>
                        <option value="Male" <%= (storedGender.equals("Male")) ? "selected" : "" %>>Male</option>
                        <option value="Female" <%= (storedGender.equals("Female")) ? "selected" : "" %>>Female</option>
                    </select>
                    <span class="invalid-feedback">Please select a gender.</span>
                </div>
                
                <div class="form-group pt-2">
                    <label>Birthday</label>
                    <input type="date" name="birthday" class="form-control" value="<%= storedBirthday %>" required>
                    <span class="invalid-feedback"></span>
                </div>    
                    
                <div class="form-group pt-2">
                    <label>Email</label>
                    <input type="email" name="email" class="form-control" value="<%= storedEmail %>" required>
                    <span class="invalid-feedback"></span>
                </div>
                
                <div class="form-group pt-2">
                    <label>Phone Number</label>
                    <input type="text" name="phone" class="form-control" value="<%= storedPhone %>" required>
                    <span class="invalid-feedback"></span>
                </div>
                
                <div class="form-group pt-2">
                    <label>Username</label>
                    <input type="text" name="username" class="form-control" value="<%= storedUsername %>" required>
                    <span class="invalid-feedback"></span>
                </div>
                
                <div class="form-group pt-2">
                    <label>Password</label>
                    <input type="password" name="password" class="form-control" required>
                    <span class="invalid-feedback"></span>
                </div>
                
                <div class="form-group pt-2">
                    <label>Confirm Password</label>
                    <input type="password" name="confirm_password" class="form-control" required>
                    <span class="invalid-feedback"></span>
                </div>
                
                <div class="form-group pt-2">
                    <input type="submit" class="btn btn-primary" value="Sign Up">
                </div>
                <p class="pt-3">Already have an account? <a href="login.jsp">Login here</a>.</p>
            </form>
        </div>
    </div>
    <jsp:include page="includes/footer.html"/>
</body>
</html>
