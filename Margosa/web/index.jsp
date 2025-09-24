<%-- 
    Document   : index
    Created on : Jun 28, 2023, 1:47:36 AM
    Author     : Bernard
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMSBSApp | Home</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="includes/navbar.jsp"/>
        <div class="container pt-5"></div>
        
        <div class="container pt-5 my-4 p-5 text-center rounded">
            <h1>Welcome to <i class="bi bi-house-heart"></i> MyMSBSApp</h1>
            <h5>Connecting Margosa Community, Together!</h5>
        </div>
        
        <div class="container p-4 my-5 bg-dark text-center text-white">
            <h1>Key Features</h1>
        </div>
        
        <div class="container my-4 rounded">
            <p><b>Visitor Management:</b> Say goodbye to manual visitor registration and tracking. Our user-friendly interface allows you to effortlessly register and manage your guests, ensuring a smooth and secure experience for both residents and visitors.</p>
            <p><b>House and Family Management:</b> Keep your household information organized in one place. Update and manage details such as house number, street name, family members, and emergency contacts easily, ensuring accurate and up-to-date information for efficient community management.</p>
            <p><b>Vehicle Registration:</b> Simplify the process of registering and managing vehicles associated with your family. Keep track of vehicle details, including make, model, and plate number, for seamless access control and enhanced security within the community.</p>
            <p><b>Community Notifications:</b> Stay informed about important community updates, events, and security alerts. Receive timely notifications and alerts directly on your MyMargosaApp dashboard, ensuring you never miss out on any crucial information.</p>
        </div>
       
        <div class="container p-4 my-5 bg-dark text-center text-white">
            <h1>Our Vision</h1>
        </div>
        
        <div class="container my-4 rounded">
            <p>At MyMSBSApp, our vision is to foster a vibrant and engaged community. We believe in creating a sense of belonging and connection among residents, encouraging interaction, collaboration, and mutual support. By providing a secure and efficient platform, we aim to facilitate a harmonious living environment where everyone feels valued and connected</p>
        </div>
        
        <div class="container p-4 my-5 bg-dark text-center text-white">
            <h1>Join MyMSBSApp Today</h1>
        </div>
        
        <div class="container my-4 rounded">
            <p>We invite you to join the MyMSBSApp community and experience the numerous benefits our platform has to offer. Register for an account today to unlock the full potential of our features and stay connected with your neighbors. Take advantage of the convenience, security, and community engagement opportunities that MyMargosaApp brings to Margosa community.</p>
            <p>Welcome to MyMSBSApp, your gateway to a seamless and empowered living experience in Margosa!</p>            
        </div>
        
        <jsp:include page="includes/footer.html"/>
    </body>
</html>
