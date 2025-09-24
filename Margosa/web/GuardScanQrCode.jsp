<%-- 
    Document   : GuardScanQrCode
    Created on : Jul 31, 2023, 8:14:09 PM
    Author     : Bernard
--%>

<%@page import="model.Guard"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Guard guard = (Guard) request.getSession().getAttribute("guard");
    if (guard == null) {
        request.setAttribute("errorMessage", "You must be Logged In");
        request.getRequestDispatcher("guard.jsp").forward(request, response);
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | Scan QR Code</title>
        <!-- Include the necessary libraries for QR code scanning -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html5-qrcode/2.0.3/html5-qrcode.min.js"></script>
    </head>

    <body>
        <jsp:include page="includes/navbar.jsp"/>
        <div class="container pt-5"></div>
        <div class="container pt-5"></div>
        <div class="container pt-5 my-4 p-5 text-center rounded">
            <h1>Exited Visitors</h1>
        </div>

        <div class="container text-center">
            <p>
                <a href="GuardHome.jsp" class="btn btn-secondary">Back</a>
                <a href="GuardScanQrCode.jsp" class="btn btn-success">Scan</a>
                <a href="GuardAddVisitor.jsp" class="btn btn-warning">Add Visitor</a>
                <a href="GuardCreatedVisitors.jsp" class="btn btn-primary">Pending Visitor</a>
                <a href="GuardEnteredVisitors.jsp" class="btn btn-primary">Entered Visitor</a>
                <a href="GuardExitedVisitors.jsp" class="btn btn-primary">Exited Visitor</a>
            </p>
        </div>

        <div class="container text-center">
            <!-- Container to display the QR code scanner -->
            <div id="qrCodeScannerContainer" style="max-width: 500px; margin: auto;"></div>
        </div>

        <jsp:include page="includes/footer.html"/>

        <script>
            // Function to handle the QR code scanning success
            function onScanSuccess(qrCodeMessage) {
                // Find the position of "VID:" in the message
                var vidIndex = qrCodeMessage.indexOf("VID:");

                // If "VID:" is not found or it's at the end of the message, show an error and return
                if (vidIndex === -1 || vidIndex === qrCodeMessage.length - 4) {
                    alert("Invalid QR code. Please make sure it contains 'VID:'.");
                    return;
                }

                // Extract the visitor's VID from the QR code message (starting from after "VID:")
                var vidEndIndex = qrCodeMessage.indexOf("|", vidIndex);
                var visitorIdStr = qrCodeMessage.substring(vidIndex + 4, vidEndIndex).trim();

                // Redirect to the GuardVisitorEnteredServlet with the extracted VID value
                window.location.href = "GuardVisitorEnteredServlet?vid=" + visitorIdStr;
            }

            // Function to handle the QR code scanning failure
            function onScanFailure(error) {
                console.error("QR code scanning failed:", error);
                alert("Failed to scan the QR code. Please try again.");
            }

            // Initialize the QR code scanner
            var html5QrCodeScanner = new Html5QrcodeScanner(
                    "qrCodeScannerContainer", {fps: 10, qrbox: 250}
            );
            html5QrCodeScanner.render(onScanSuccess, onScanFailure);
        </script>
    </body>
</html>
