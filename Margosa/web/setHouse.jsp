<%--
    Document   : setHouse
    Created on : Jul 5, 2023, 10:16:53 AM
    Author     : Bernard
--%>
<%@page import="connection.SqlCon"%>
<%@page import="model.Family"%>
<%@page import="model.Resident"%>
<%@page import="dao.ResidentDao"%>
<%
    Resident resident = (Resident) request.getSession().getAttribute("resident");
    Family family = (Family) request.getSession().getAttribute("family");

    if (resident == null) {
        request.setAttribute("errorMessage", "You must be logged in");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    } else {
        // Check if resident's HID is more than 0
        if (resident.getHid() > 0) {
            // Resident is already assigned to a house
            request.setAttribute("errorMessage", "You have already been assigned a house");
            request.getRequestDispatcher("family.jsp").forward(request, response);
        } else {
            // Retrieve the resident's HID from the database
            ResidentDao residentDao = new ResidentDao(SqlCon.getConnection());
            Integer residentHID = residentDao.getResidentHID(resident.getRid());

            if (residentHID != null && residentHID > 0) {
                // Resident's HID is more than 0 in the database
                request.setAttribute("errorMessage", "You have already been assigned a house");
                request.getRequestDispatcher("home.jsp").forward(request, response);
            }
        }
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MyMargosaApp | Set House</title>
        <style>
            .wrapper {
                width: 360px;
                padding: 20px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="includes/navbar.jsp"/>
        <div class="container pt-5"></div>
        <div class="container pt-5"></div>  
        <div class="container">
            <div class="wrapper">
                <h1>Set House Address</h1>
                <!-- Display Error Message -->
                <% String errorMessage = (String) request.getAttribute("errorMessage");
                    if (errorMessage != null) {%>
                <div class="alert alert-danger" role="alert">
                    <%= errorMessage%>
                </div>
                <% }%>
                <form action="setHome" method="post" id="setHouseForm">
                    <div class="form-group">
                        <label>House Street</label>
                        <select name="houseStreet" class="form-control" required>
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

                    <div class="form-group pt-2">
                        <label>House Number</label>
                        <select name="houseNum" class="form-control" disabled>
                            <option value="">Please Select A Street First</option>
                        </select>
                        <span class="invalid-feedback"></span>
                    </div>

                    <div class="form-group pt-2">
                        <input type="submit" class="btn btn-primary" value="Set">
                    </div>
                </form>
            </div>
        </div>
        <jsp:include page="includes/footer.html"/>
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
                const houseStreetSelect = document.querySelector('select[name="houseStreet"]');
                const houseNumSelect = document.querySelector('select[name="houseNum"]');

                // Function to update the house numbers based on the selected street
                function updateHouseNumbers() {
                    const selectedStreet = houseStreetSelect.value;

                    // Clear the house numbers select options
                    houseNumSelect.innerHTML = '';

                    if (selectedStreet === '') {
                        // If no street is selected, disable the houseNum select and show the placeholder option
                        houseNumSelect.disabled = true;
                        // Set the houseNum input value and make it readonly
                        houseNumInput.value = numbers[0];
                        houseNumInput.readOnly = true;
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
                const setHouseForm = document.getElementById('setHouseForm');
                setHouseForm.addEventListener('submit', function (event) {
                    if (houseStreetSelect.value === '' || houseNumSelect.value === '') {
                        event.preventDefault();
                        alert('Please select a house street and house number.');
                    }
                });
            });
        </script>

    </body>
</html>

