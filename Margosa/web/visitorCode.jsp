<%@page import="com.google.zxing.client.j2se.MatrixToImageWriter"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="com.google.zxing.common.BitMatrix"%>
<%@page import="com.google.zxing.BarcodeFormat"%>
<%@page import="com.google.zxing.qrcode.QRCodeWriter"%>
<%@page import="java.util.Base64"%>
<%@page import="javax.servlet.jsp.PageContext"%>
<%@page import="model.Visitor"%>
<%@page import="dao.VisitorDao"%>

<%
    String visitorIdParam = request.getParameter("vid");
    if (visitorIdParam == null || visitorIdParam.isEmpty()) {
        response.sendRedirect("residentVisitor.jsp");
        return;
    }

    int visitorId = Integer.parseInt(visitorIdParam);
    VisitorDao visitorDao = new VisitorDao(connection.SqlCon.getConnection());
    Visitor visitor = visitorDao.getVisitorById(visitorId);

    if (visitor == null) {
        response.sendRedirect("residentVisitor.jsp");
        return;
    }

    String visitorDetails = "VID:" + visitor.getVid()
            + "|Name:" + visitor.getVisitorName()
            + "|Phone Number:" + visitor.getVisitorPhoneNum()
            + "|Vehicle Number:" + visitor.getVisitorVehicleNum()
            + "|House Number:" + session.getAttribute("houseNumber")
            + "|House Street:" + session.getAttribute("houseStreet");

    // Generate QR code
    QRCodeWriter qrCodeWriter = new QRCodeWriter();
    BitMatrix bitMatrix = qrCodeWriter.encode(visitorDetails, BarcodeFormat.QR_CODE, 1200, 1200);

    // Convert the BitMatrix to a byte array
    ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
    MatrixToImageWriter.writeToStream(bitMatrix, "PNG", byteArrayOutputStream);
    byte[] qrCodeBytes = byteArrayOutputStream.toByteArray();

    // Set the QR code image bytes as a page attribute
    pageContext.setAttribute("qrCodeBytes", qrCodeBytes);
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | Visitor QR Code</title>
        <style>.wrapper{ width: 360px; padding: 20px; }</style>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.3.2/html2canvas.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/dom-to-image/2.6.0/dom-to-image.min.js"></script>
    </head>
    <body>
        <jsp:include page="includes/navbar.jsp"/>
        <div class="container pt-5"></div>
        <div class="container pt-5"></div>
        <div class="container pt-5"></div>
        
        <div class="container">
            <div class="wrapper">
                <h1>Visitor QR Code</h1>

                <div class="card text-center bg-light" style="width: 18rem;" id="card">
                    <% 
                        if (qrCodeBytes != null) {
                            String base64Image = Base64.getEncoder().encodeToString(qrCodeBytes);
                    %>
                        <img src="data:image/png;base64, <%= base64Image %>" class="card-img-top" alt="Visitor QR Code">
                        <div class="card-body">
                            <h3 class="card-title"><%= visitor.getVisitorName() %></h3>
                            <h4 class="card-text"><strong><%= visitor.getVisitorVehicleNum() %></strong></h4>
                            <p class="card-text">Visitor</p>
                            <p class="card-text"><%= visitor.getVisitorAddedDate() %> <%= visitor.getVisitorAddedTime() %></p>
                            <p class="card-text"><i class="bi bi-house-heart"></i> MyMSBSApp</p>
                        </div>
                    <% } %>
                </div>
                <p>This QR Code is only VALID for 24 Hours from the date of Creation</p>
                <a href="residentVisitor.jsp" class="btn btn-secondary">Back</a>
                <button class="btn btn-success" id="downloadButton">Download</button>
                <button class="btn btn-primary" id="shareButton">Share</button>
            </div>
        </div>
        <jsp:include page="includes/footer.html"/>

<script>
    document.getElementById("downloadButton").addEventListener("click", function () {
        html2canvas(document.getElementById("card")).then(function (canvas) {
            // Create a temporary link element
            var link = document.createElement('a');
            link.href = canvas.toDataURL();
            link.target = '_blank';
            link.download = 'Visitor_QR_Code.png';

            // Programmatically click the link to open it in a new window and trigger the download
            link.click();
        });
    });
</script>


<script>
    document.getElementById("shareButton").addEventListener("click", function () {
        html2canvas(document.getElementById("card")).then(function (canvas) {
            // Create a data URL for the captured image
            var imageDataURL = canvas.toDataURL();

            // Create a new image element
            var image = new Image();
            image.src = imageDataURL;

            // Open a new window and write the image element to it
            var newWindow = window.open();
            newWindow.document.write('<html><body></body></html>');
            newWindow.document.body.appendChild(image);
        });
    });
</script>
    </body>
</html>







