<%-- 
    Document   : login
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
%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | Login</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary: #2f7afe;
                --primary-dark: #1e4bb8;
                --bg-gradient: linear-gradient(135deg, rgba(47, 122, 254, 0.12), rgba(30, 75, 184, 0.15));
                --surface: #ffffff;
                --text-dark: #1a1f36;
                --text-muted: #5f6b8a;
                --success: #2fdd92;
                --danger: #ff6b6b;
            }

            body {
                font-family: 'Poppins', sans-serif;
                background: var(--bg-gradient);
                color: var(--text-dark);
                min-height: 100vh;
                display: flex;
                flex-direction: column;
            }

            .auth-wrapper {
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 120px 24px 80px;
            }

            .auth-card {
                background: var(--surface);
                border-radius: 28px;
                box-shadow: 0 30px 60px rgba(15, 23, 42, 0.12);
                overflow: hidden;
                max-width: 960px;
                width: 100%;
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            }

            .auth-highlight {
                background: radial-gradient(circle at top left, rgba(47, 122, 254, 0.25), transparent 55%),
                            radial-gradient(circle at bottom right, rgba(47, 122, 254, 0.2), transparent 60%),
                            #0f172a;
                color: #f8fbff;
                padding: 48px;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .auth-highlight h2 {
                font-size: 32px;
                font-weight: 700;
                margin-bottom: 16px;
            }

            .auth-highlight p {
                font-size: 16px;
                color: rgba(248, 251, 255, 0.76);
                margin-bottom: 24px;
            }

            .auth-benefits {
                display: grid;
                gap: 14px;
            }

            .auth-benefit {
                display: flex;
                align-items: center;
                gap: 12px;
                font-weight: 500;
            }

            .auth-benefit span {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 32px;
                height: 32px;
                border-radius: 50%;
                background: rgba(248, 251, 255, 0.16);
                color: #f8fbff;
                font-size: 18px;
            }

            .auth-form {
                padding: 48px;
            }

            .auth-form h1 {
                font-size: 30px;
                font-weight: 600;
                margin-bottom: 12px;
            }

            .auth-form .subheading {
                color: var(--text-muted);
                margin-bottom: 32px;
                font-size: 16px;
            }

            .auth-form .form-group label {
                font-weight: 500;
                color: var(--text-dark);
            }

            .form-control {
                border-radius: 14px;
                border: 1px solid rgba(15, 23, 42, 0.12);
                padding: 12px 16px;
                transition: border 0.2s ease, box-shadow 0.2s ease;
                font-size: 15px;
            }

            .form-control:focus {
                border-color: rgba(47, 122, 254, 0.65);
                box-shadow: 0 0 0 4px rgba(47, 122, 254, 0.18);
            }

            .btn-primary {
                background: var(--primary);
                border: none;
                border-radius: 16px;
                padding: 14px 22px;
                font-weight: 600;
                letter-spacing: 0.01em;
                transition: transform 0.2s ease, box-shadow 0.2s ease, background 0.2s ease;
                width: 100%;
            }

            .btn-primary:hover {
                background: var(--primary-dark);
                transform: translateY(-1px);
                box-shadow: 0 14px 28px rgba(47, 122, 254, 0.25);
            }

            .form-footer {
                margin-top: 28px;
                text-align: center;
                color: var(--text-muted);
            }

            .form-footer a {
                color: var(--primary);
                font-weight: 600;
            }

            .alert {
                border-radius: 14px;
                padding: 14px 16px;
                font-weight: 500;
            }

            .alert-danger {
                background: rgba(255, 107, 107, 0.12);
                color: var(--danger);
                border: none;
            }

            .alert-success {
                background: rgba(47, 221, 146, 0.12);
                color: var(--success);
                border: none;
            }

            @media (max-width: 767px) {
                .auth-wrapper {
                    padding: 96px 16px 64px;
                }

                .auth-highlight {
                    padding: 36px 28px;
                }

                .auth-form {
                    padding: 36px 28px;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="includes/navbar.jsp"/>
        <div class="auth-wrapper">
            <div class="auth-card">
                <div class="auth-highlight">
                    <p class="badge rounded-pill text-uppercase mb-3" style="background: rgba(248, 251, 255, 0.16); color: #f8fbff; letter-spacing: 0.08em; font-size: 12px; padding: 6px 12px; width: fit-content;">Resident access</p>
                    <h2>Sign in to stay connected</h2>
                    <p>Manage visitor passes, stay informed on community notices, and access your household tools in one secure space.</p>
                    <div class="auth-benefits">
                        <div class="auth-benefit"><span>✓</span> View real-time gate activity</div>
                        <div class="auth-benefit"><span>✓</span> Approve visitors instantly</div>
                        <div class="auth-benefit"><span>✓</span> Receive important updates</div>
                    </div>
                </div>
                <div class="auth-form">
                    <h1>Welcome back</h1>
                    <p class="subheading">Enter your credentials to continue to your Margosa resident dashboard.</p>
                    <!-- Display Error Message -->
                    <% String errorMessage = (String) request.getAttribute("errorMessage");
                        if (errorMessage != null) {%>
                    <div class="alert alert-danger" role="alert">
                        <%= errorMessage%>
                    </div>
                    <% }%>
                    <!-- Display Success Message -->
                    <% String successMessage = (String) request.getAttribute("successMessage");
                        if (successMessage != null) {%>
                    <div class="alert alert-success" role="alert">
                        <%= successMessage%>
                    </div>
                    <% }%>
                    <form action="ResidentLoginServlet" method="post">
                        <div class="form-group mb-3">
                            <label>Username or Email</label>
                            <input type="text" name="input" class="form-control" required>
                            <span class="invalid-feedback"></span>
                        </div>

                        <div class="form-group mb-4">
                            <label>Password</label>
                            <input type="password" name="password" class="form-control" required>
                            <span class="invalid-feedback"></span>
                        </div>

                        <div class="form-group">
                            <input type="submit" class="btn btn-primary" value="Login">
                        </div>
                    </form>
                    <div class="form-footer">
                        Don't have an account? <a href="register.jsp">Create one now</a>.
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="includes/footer.html"/>
    </body>
</html>
