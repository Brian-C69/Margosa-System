<%@page import="model.Committee"%>
<%@page import="model.Guard"%>
<%@page import="model.Resident"%>
<%@page import="model.Admin"%>
<!-- Navbar for logged out users -->
<div id="navbar-logged-out">
<nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top">
    <div class="container-xxl">
        
        <a class="navbar-brand" href="index.jsp"><i class="bi bi-house-heart"></i> MyMSBSApp</a>
        
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
        <span class="navbar-toggler-icon"></span>
      </button>

          <div class="collapse navbar-collapse" id="collapsibleNavbar">
              <ul class="navbar-nav me-auto">
                  <li class="nav-item">
                      <a class="nav-link" href="about.jsp">About</a>
                  </li>
              </ul>
              <ul class="navbar-nav nav">
                  <a href="login.jsp" class="btn btn-primary">Login</a>  
              </ul>
          </div>        
    </div>
</nav>
</div>

<!-- Navbar for logged in residents -->
<div id="navbar-logged-in-resident" style="display: none;">
<nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top">
    <div class="container-xxl">
        
        <a class="navbar-brand" href="index.jsp"><i class="bi bi-house-heart"></i> MyMSBSApp</a>
        
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
        <span class="navbar-toggler-icon"></span>
      </button>

          <div class="collapse navbar-collapse" id="collapsibleNavbar">
              <ul class="navbar-nav me-auto">
                  <li class="nav-item">
                      <a class="nav-link" href="about.jsp">About</a>
                  </li>
                  <li class="nav-item">
                      <a class="nav-link" href="home.jsp">Home</a>
                  </li>
              </ul>
              <ul class="navbar-nav nav">
                  <a href="ResidentLogoutServlet" class="btn btn-danger">Logout</a>  
              </ul>
          </div>        
    </div>
</nav>
</div>

<!-- Navbar for logged in admin -->
<div id="navbar-logged-in-admin" style="display: none;">
<nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top">
    <div class="container-xxl">
        
        <a class="navbar-brand" href="index.jsp"><i class="bi bi-house-heart"></i> MyMSBSApp</a>
        
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
        <span class="navbar-toggler-icon"></span>
      </button>

          <div class="collapse navbar-collapse" id="collapsibleNavbar">
              <ul class="navbar-nav me-auto">
                  <li class="nav-item">
                      <a class="nav-link" href="about.jsp">About</a>
                  </li>
                  <li class="nav-item">
                      <a class="nav-link" href="AdminPanel.jsp">Panel</a>
                  </li>
              </ul>
              <ul class="navbar-nav nav">
                  <a href="AdminLogoutServlet" class="btn btn-danger">Logout</a>  
              </ul>
          </div>        
    </div>
</nav>
</div>

<!-- Navbar for logged in guard -->
<div id="navbar-logged-in-guard" style="display: none;">
<nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top">
    <div class="container-xxl">
        
        <a class="navbar-brand" href="index.jsp"><i class="bi bi-house-heart"></i> MyMSBSApp</a>
        
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
        <span class="navbar-toggler-icon"></span>
      </button>

          <div class="collapse navbar-collapse" id="collapsibleNavbar">
              <ul class="navbar-nav me-auto">
                  <li class="nav-item">
                      <a class="nav-link" href="about.jsp">About</a>
                  </li>
                  <li class="nav-item">
                      <a class="nav-link" href="GuardHome.jsp">Home</a>
                  </li>
              </ul>
              <ul class="navbar-nav nav">
                  <a href="GuardLogoutServlet" class="btn btn-danger">Logout</a>  
              </ul>
          </div>        
    </div>
</nav>
</div>

<!-- Navbar for logged in committee -->
<div id="navbar-logged-in-committee" style="display: none;">
<nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top">
    <div class="container-xxl">
        
        <a class="navbar-brand" href="index.jsp"><i class="bi bi-house-heart"></i> MyMSBSApp</a>
        
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
        <span class="navbar-toggler-icon"></span>
      </button>

          <div class="collapse navbar-collapse" id="collapsibleNavbar">
              <ul class="navbar-nav me-auto">
                  <li class="nav-item">
                      <a class="nav-link" href="about.jsp">About</a>
                  </li>
                  <li class="nav-item">
                      <a class="nav-link" href="CommitteeHome.jsp">Home</a>
                  </li>
              </ul>
              <ul class="navbar-nav nav">
                  <a href="CommitteeLogoutServlet" class="btn btn-danger">Logout</a>  
              </ul>
          </div>        
    </div>
</nav>
</div>

<script>
    // Check if user is logged in
    <% Resident resident = (Resident) request.getSession().getAttribute("resident");
       Admin admin = (Admin) request.getSession().getAttribute("admin");
       Guard guard = (Guard) request.getSession().getAttribute("guard");
       Committee committee = (Committee) request.getSession().getAttribute("committee");
       if (resident != null) { %>
        // If logged in as resident, display the logged-in resident navbar and hide the other navbars
        document.getElementById("navbar-logged-in-resident").style.display = "block";
        document.getElementById("navbar-logged-out").style.display = "none";
        document.getElementById("navbar-logged-in-admin").style.display = "none";
        document.getElementById("navbar-logged-in-guard").style.display = "none";
        document.getElementById("navbar-logged-in-committee").style.display = "none";
    <% } else if (admin != null) { %>
        // If logged in as admin, display the logged-in admin navbar and hide the other navbars
        document.getElementById("navbar-logged-in-admin").style.display = "block";
        document.getElementById("navbar-logged-out").style.display = "none";
        document.getElementById("navbar-logged-in-resident").style.display = "none";
        document.getElementById("navbar-logged-in-guard").style.display = "none";
        document.getElementById("navbar-logged-in-committee").style.display = "none";
    <% } else if (guard != null) { %>
        // If logged in as guard, display the logged-in guard navbar and hide the other navbars
        document.getElementById("navbar-logged-in-guard").style.display = "block";
        document.getElementById("navbar-logged-out").style.display = "none";
        document.getElementById("navbar-logged-in-resident").style.display = "none";
        document.getElementById("navbar-logged-in-admin").style.display = "none";
        document.getElementById("navbar-logged-in-committee").style.display = "none";
    <% } else if (committee != null) { %>
        // If logged in as committee, display the logged-in committee navbar and hide the other navbars
        document.getElementById("navbar-logged-in-committee").style.display = "block";
        document.getElementById("navbar-logged-out").style.display = "none";
        document.getElementById("navbar-logged-in-resident").style.display = "none";
        document.getElementById("navbar-logged-in-admin").style.display = "none";
        document.getElementById("navbar-logged-in-guard").style.display = "none";
    <% } else { %>
        // If logged out, display the logged-out navbar and hide the other navbars
        document.getElementById("navbar-logged-out").style.display = "block";
        document.getElementById("navbar-logged-in-resident").style.display = "none";
        document.getElementById("navbar-logged-in-admin").style.display = "none";
        document.getElementById("navbar-logged-in-guard").style.display = "none";
        document.getElementById("navbar-logged-in-committee").style.display = "none";
    <% } %>
</script>

