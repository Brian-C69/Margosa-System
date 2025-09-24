<%-- 
    Document   : GuardAddVisitor
    Created on : Jul 23, 2023, 5:16:12 PM
    Author     : Bernard
--%>
<%@page import="model.Guard"%>
<%
    Guard guard = (Guard) request.getSession().getAttribute("guard");
    if (guard == null) {
        request.setAttribute("errorMessage", "You must be Logged In");
        request.getRequestDispatcher("guard.jsp").forward(request, response);
        return;
    }
    
    // Retrieve the stored form values if an error occurred
    String visitorName = (String) request.getAttribute("storedVisitorName");
    String visitorPhoneNum = (String) request.getAttribute("storedVisitorPhoneNum");
    String visitorVehicleNum = (String) request.getAttribute("storedVisitorVehicleNum");
    
    // Check for null values and set them to empty strings
    visitorName = (visitorName != null) ? visitorName : "";
    visitorPhoneNum = (visitorPhoneNum != null) ? visitorPhoneNum : "";
    visitorVehicleNum = (visitorVehicleNum != null) ? visitorVehicleNum : "";

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | Add Visitor</title>
        <style>.wrapper{
                width: 360px;
                padding: 20px;
            }</style>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const houseNumbers = {
                    'Jalan Margosa SD10/1A': ['1', '2', '3', '3A', '5', '6', '7', '8', '9'],
                    'Jalan Margosa SD10/1B': ['1', '2', '3', '3A', '5', '6', '7', '8', '9', '10', '11', '12', '12A', '14', '15', '16', '17', '18', '19', '20'],
                    'Jalan Margosa SD10/1C': ['1', '2', '3', '3A', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20'],
                    'Jalan Margosa SD10/1D': ['1', '2', '3', '3A', '5', '6', '7', '8', '9', '10', '11', '12', '11A', '12A', '15', '16', '17', '18', '19', '20', '22'],
                    'Jalan Margosa SD10/1E': ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
                    'Jalan Margosa SD10/2': ['1', '2', '3', '3A', '5', '6', '7', '8', '9', '10', '11', '12', '13', '13A', '15', '16', '17', '18', '19', '20', '21', '22', '23', '23A', '25', '26', '27', '28', '29', '30', '31', '32', '33', '33A', '35', '36', '37', '38', '39', '40', '41', '42', '43', '43A', '45'],
                    'Jalan Margosa SD10/3': ['1', '2', '3', '3A', '5', '6', '7', '8', '9', '10', '11', '12', '13', '13A', '15', '16', '17', '18', '19', '20', '21', '22', '23', '23A'],
                    'Jalan Margosa SD10/3A': ['1', '2', '3', '3A', '5', '6', '7', '8', '9', '10', '11', '12', '13']
                };

                // Get the houseStreet and houseNum select elements
                const houseStreetSelect = document.getElementById('houseStreetSelect');
                const houseNumSelect = document.getElementById('houseNumSelect');

                // Function to update the house numbers based on the selected street
                function updateHouseNumbers() {
                    const selectedStreet = houseStreetSelect.value;

                    // Clear the house numbers select options
                    houseNumSelect.innerHTML = '';

                    if (selectedStreet === '') {
                        // If no street is selected, disable the houseNum select and show the placeholder option
                        houseNumSelect.disabled = true;
                        const placeholderOption = document.createElement('option');
                        placeholderOption.value = '';
                        placeholderOption.textContent = 'Please Select A Street First';
                        houseNumSelect.appendChild(placeholderOption);
                    } else {
                        // If a street is selected, enable the houseNum select and add the house numbers options
                        houseNumSelect.disabled = false;

                        const numbers = houseNumbers[selectedStreet];
                        for (let i = 0; i < numbers.length; i++) {
                            const option = document.createElement('option');
                            option.value = numbers[i];
                            option.textContent = numbers[i];
                            houseNumSelect.appendChild(option);
                        }
                    }
                }

                // Call the updateHouseNumbers function when the houseStreet selection changes
                houseStreetSelect.addEventListener('change', updateHouseNumbers);

                // Call the updateHouseNumbers function on page load to disable the houseNum select and show the placeholder option
                updateHouseNumbers();

                // Form validation
                const addVisitorForm = document.getElementById('addVisitorForm');
                addVisitorForm.addEventListener('submit', function (event) {
                    if (houseStreetSelect.value === '' || houseNumSelect.value === '') {
                        event.preventDefault();
                        alert('Please select a house street and house number.');
                    }
                });
            });
        </script>
    </head>

    <body>
        <jsp:include page="includes/navbar.jsp"/>
        <div class="container pt-5"></div>
        <div class="container pt-5"></div>
        <div class="container pt-5 pb-5">
            <h1>Guard Register Visitor</h1>
        </div>

        <div class="container">
            <div class="wrapper">
                <% String errorMessage = (String) request.getAttribute("errorMessage");
                    if (errorMessage != null) {%>
                <div class="alert alert-danger" role="alert">
                    <%= errorMessage%>
                </div>
                <% }%>
                <form action="GuardAddVisitorServlet" method="post">
                    <div class="form-group">
                        <label>Visitor Name</label>
                        <input type="text" name="visitorName" class="form-control" value="<%= visitorName %>" required>
                    </div>    

                    <div class="form-group">
                        <label>Phone Number</label>
                        <input type="text" name="visitorPhoneNum" class="form-control" value="<%= visitorPhoneNum %>" required>
                    </div>                  

                    <div class="form-group">
                        <label>Vehicle Number</label>
                        <input type="text" name="visitorVehicleNum" class="form-control" value="<%= visitorVehicleNum %>" required>
                    </div> 

                    <div class="form-group">
                        <label>Visiting House Street</label>
                        <select name="houseStreet" class="form-control" id="houseStreetSelect" required>
                            <option value="" selected disabled>Please Select</option>
                            <option value="Jalan Margosa SD10/1A">Jalan Margosa SD10/1A</option>
                            <option value="Jalan Margosa SD10/1B">Jalan Margosa SD10/1B</option>
                            <option value="Jalan Margosa SD10/1C">Jalan Margosa SD10/1C</option>
                            <option value="Jalan Margosa SD10/1D">Jalan Margosa SD10/1D</option>
                            <option value="Jalan Margosa SD10/1E">Jalan Margosa SD10/1E</option>
                            <option value="Jalan Margosa SD10/2">Jalan Margosa SD10/2</option>
                            <option value="Jalan Margosa SD10/3">Jalan Margosa SD10/3</option>
                            <option value="Jalan Margosa SD10/3A">Jalan Margosa SD10/3A</option>
                        </select>
                        <span class="invalid-feedback"></span>
                    </div>

                    <div class="form-group">
                        <label>Visiting House Number</label>
                        <select name="houseNum" class="form-control" id="houseNumSelect" required>
                            <option value="" selected disabled>Please Select A Street First</option>
                        </select>
                        <span class="invalid-feedback"></span>
                    </div>

                    <div class="form-group pt-2">
                        <input type="submit" class="btn btn-primary" value="Add">
                        <a href="GuardCreatedVisitors.jsp" class="btn btn-secondary">Back</a>
                    </div>
                </form>
            </div>
        </div>
        <jsp:include page="includes/footer.html"/>
    </body>
</html>
