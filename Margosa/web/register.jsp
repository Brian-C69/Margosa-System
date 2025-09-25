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
            border-radius: 32px;
            box-shadow: 0 30px 60px rgba(15, 23, 42, 0.12);
            overflow: hidden;
            max-width: 1080px;
            width: 100%;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(340px, 1fr));
        }

        .auth-highlight {
            background: radial-gradient(circle at top left, rgba(47, 122, 254, 0.25), transparent 55%),
                        radial-gradient(circle at bottom right, rgba(47, 122, 254, 0.2), transparent 60%),
                        #0f172a;
            color: #f8fbff;
            padding: 52px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .auth-highlight h2 {
            font-size: 34px;
            font-weight: 700;
            margin-bottom: 18px;
        }

        .auth-highlight p {
            font-size: 16px;
            color: rgba(248, 251, 255, 0.76);
            margin-bottom: 28px;
        }

        .onboarding-steps {
            display: grid;
            gap: 18px;
        }

        .onboarding-step {
            display: grid;
            grid-template-columns: auto 1fr;
            gap: 16px;
            align-items: start;
        }

        .onboarding-step span {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 42px;
            height: 42px;
            border-radius: 14px;
            background: rgba(248, 251, 255, 0.16);
            color: #f8fbff;
            font-weight: 600;
            font-size: 16px;
        }

        .onboarding-step strong {
            display: block;
            font-weight: 600;
            margin-bottom: 6px;
        }

        .auth-form {
            padding: 52px 48px 48px;
        }

        .auth-form h1 {
            font-size: 32px;
            font-weight: 600;
            margin-bottom: 12px;
        }

        .auth-form .subheading {
            color: var(--text-muted);
            margin-bottom: 36px;
            font-size: 16px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
        }

        .form-group label {
            font-weight: 500;
            color: var(--text-dark);
        }

        .form-control,
        .form-select {
            border-radius: 14px;
            border: 1px solid rgba(15, 23, 42, 0.12);
            padding: 12px 16px;
            transition: border 0.2s ease, box-shadow 0.2s ease;
            font-size: 15px;
        }

        .form-control:focus,
        .form-select:focus {
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
            margin-top: 8px;
        }

        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-1px);
            box-shadow: 0 14px 28px rgba(47, 122, 254, 0.25);
        }

        .form-footer {
            margin-top: 32px;
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

        @media (max-width: 767px) {
            .auth-wrapper {
                padding: 96px 16px 64px;
            }

            .auth-highlight {
                padding: 40px 32px;
            }

            .auth-form {
                padding: 40px 28px 36px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="includes/navbar.jsp"/>
    <div class="auth-wrapper">
        <div class="auth-card">
            <div class="auth-highlight">
                <p class="badge rounded-pill text-uppercase mb-3" style="background: rgba(248, 251, 255, 0.16); color: #f8fbff; letter-spacing: 0.08em; font-size: 12px; padding: 6px 12px; width: fit-content;">Create your access</p>
                <h2>Join the Margosa community</h2>
                <p>Set up your resident profile to unlock streamlined visitor management, community alerts, and collaborative tools for your household.</p>
                <div class="onboarding-steps">
                    <div class="onboarding-step">
                        <span>1</span>
                        <div>
                            <strong>Tell us about yourself</strong>
                            Complete your personal details so we can link you with the right home and community updates.
                        </div>
                    </div>
                    <div class="onboarding-step">
                        <span>2</span>
                        <div>
                            <strong>Secure your account</strong>
                            Create login credentials that keep your resident dashboard and visitor approvals protected.
                        </div>
                    </div>
                    <div class="onboarding-step">
                        <span>3</span>
                        <div>
                            <strong>Get connected</strong>
                            Access digital passes, family coordination tools, and real-time gate visibility from day one.
                        </div>
                    </div>
                </div>
            </div>
            <div class="auth-form">
                <h1>Create your resident account</h1>
                <p class="subheading">We just need a few details to personalize your Margosa Smart Barangay System experience.</p>
                <% String errorMessage = (String) request.getAttribute("errorMessage");
                    if (errorMessage != null) {%>
                <div class="alert alert-danger" role="alert">
                    <%= errorMessage%>
                </div>
                <% }%>
                <form action="ResidentRegisterServlet" method="post">
                    <div class="form-grid">
                        <div class="form-group">
                            <label>First Name</label>
                            <input type="text" name="firstname" class="form-control" value="<%= storedFirstname %>" required>
                            <span class="invalid-feedback"></span>
                        </div>
                        <div class="form-group">
                            <label>Last Name</label>
                            <input type="text" name="lastname" class="form-control" value="<%= storedLastname %>" required>
                            <span class="invalid-feedback"></span>
                        </div>
                        <div class="form-group">
                            <label>Gender</label>
                            <select name="gender" class="form-select" required>
                                <option value="" disabled <%= storedGender.isEmpty() ? "selected" : "" %>>Please select</option>
                                <option value="Male" <%= (storedGender.equals("Male")) ? "selected" : "" %>>Male</option>
                                <option value="Female" <%= (storedGender.equals("Female")) ? "selected" : "" %>>Female</option>
                            </select>
                            <span class="invalid-feedback">Please select a gender.</span>
                        </div>
                        <div class="form-group">
                            <label>Birthday</label>
                            <input type="date" name="birthday" class="form-control" value="<%= storedBirthday %>" required>
                            <span class="invalid-feedback"></span>
                        </div>
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" name="email" class="form-control" value="<%= storedEmail %>" required>
                            <span class="invalid-feedback"></span>
                        </div>
                        <div class="form-group">
                            <label>Phone Number</label>
                            <input type="text" name="phone" class="form-control" value="<%= storedPhone %>" required>
                            <span class="invalid-feedback"></span>
                        </div>
                        <div class="form-group">
                            <label>Username</label>
                            <input type="text" name="username" class="form-control" value="<%= storedUsername %>" required>
                            <span class="invalid-feedback"></span>
                        </div>
                        <div class="form-group">
                            <label>Password</label>
                            <input type="password" name="password" class="form-control" required>
                            <span class="invalid-feedback"></span>
                        </div>
                        <div class="form-group">
                            <label>Confirm Password</label>
                            <input type="password" name="confirm_password" class="form-control" required>
                            <span class="invalid-feedback"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <input type="submit" class="btn btn-primary" value="Sign Up">
                    </div>
                </form>
                <div class="form-footer">
                    Already have an account? <a href="login.jsp">Log in instead</a>.
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="includes/footer.html"/>
</body>
</html>
