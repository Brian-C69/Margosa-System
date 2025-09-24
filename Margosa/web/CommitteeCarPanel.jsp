<%--
    Document   : CommitteeCarPanel
    Created on : Jul 13, 2023, 9:57:19 PM
    Author     : Bernard
--%>
<%@page import="model.Committee"%>
<%@page import="connection.SqlCon"%>
<%@page import="java.util.List"%>
<%@page import="dao.CarDao"%>
<%@page import="model.Car"%>
<%@page import="dao.HouseDao"%>
<%@page import="model.House"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Committee committee = (Committee) request.getSession().getAttribute("committee");
    if (committee == null) {
        request.setAttribute("errorMessage", "You must be Logged In");
        request.getRequestDispatcher("committee.jsp").forward(request, response);
        return;
    }
    
    CarDao carDao = new CarDao(SqlCon.getConnection());
    HouseDao houseDao = new HouseDao(SqlCon.getConnection());
    List<Car> allCars = carDao.getAllCars();
%>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="includes/headers.html"/>
    <title>MyMargosaApp | Car Panel</title>
    <style>
        .sortable {
            cursor: pointer;
            user-select: none;
        }
        .wrapper{ width: 360px; padding: 20px; }
    </style>
    <script>
        function sortTable(columnIndex) {
            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
            table = document.getElementById("carTable");
            switching = true;
            dir = "asc";

            while (switching) {
                switching = false;
                rows = table.rows;

                for (i = 1; i < (rows.length - 1); i++) {
                    shouldSwitch = false;
                    x = rows[i].getElementsByTagName("td")[columnIndex];
                    y = rows[i + 1].getElementsByTagName("td")[columnIndex];

                    var xValue = x.innerText || x.textContent;
                    var yValue = y.innerText || y.textContent;

                    if (dir === "asc") {
                        if (xValue.toLowerCase() > yValue.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir === "desc") {
                        if (xValue.toLowerCase() < yValue.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    }
                }

                if (shouldSwitch) {
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    switchcount++;
                } else {
                    if (switchcount === 0 && dir === "asc") {
                        dir = "desc";
                        switching = true;
                    }
                }
            }
        }

        function searchTable() {
            var input, filter, table, tr, td, i, txtValue;
            input = document.getElementById("searchInput");
            filter = input.value.toLowerCase();
            table = document.getElementById("carTable");
            tr = table.getElementsByTagName("tr");

            for (i = 1; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td");
                var found = false;
                for (var j = 0; j < td.length; j++) {
                    if (td[j]) {
                        txtValue = td[j].textContent || td[j].innerText;
                        if (txtValue.toLowerCase().indexOf(filter) > -1) {
                            found = true;
                            break;
                        }
                    }
                }
                if (found) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    </script>
</head>
<body>
    <jsp:include page="includes/navbar.jsp"/>
    <div class="container pt-5"></div>
    <div class="container pt-5"></div>
    <div class="container pt-5 my-4 p-5 text-center rounded">
        <h1>All Cars</h1>
    </div>   
    <div class="container text-center">
        <p>
            <a href="CommitteeHome.jsp" class="btn btn-secondary">Back</a>
        </p>
    </div>
    <div class="container">
        <div class="wrapper">
            <input type="text" class="form-control" id="searchInput" placeholder="Search..." onkeyup="searchTable()">
        </div>
       
        <table id="carTable" class="table table-light">
            <thead>
                <tr>
                    <th scope="col" class="sortable" onclick="sortTable(0)">Index</th>
                    <th scope="col" class="sortable" onclick="sortTable(1)">Brand</th>
                    <th scope="col" class="sortable" onclick="sortTable(2)">Model</th>
                    <th scope="col" class="sortable" onclick="sortTable(3)">Color</th>
                    <th scope="col" class="sortable" onclick="sortTable(4)">Plate Number</th>
                    <th scope="col" class="sortable" onclick="sortTable(5)">Type</th>
                    <th scope="col" class="sortable" onclick="sortTable(6)">House</th>
                </tr>
            </thead>
            <tbody>
                <% int index = 1;
                for (Car car : allCars) {
                    List<House> houses = houseDao.getHousesByFamilyId(car.getFid()); // Get houses for the car's family
                %>
                    <tr>
                        <td scope="row"><%= index++ %></td>
                        <td><%= car.getCarBrand() %></td>
                        <td><%= car.getCarModel() %></td>
                        <td><%= car.getCarColor() %></td>
                        <td><%= car.getCarPlateNum() %></td>
                        <td><%= car.getCarType() %></td>
                        <td>
                            <ul>
                                <% for (House house : houses) { %>
                                    <li><%= house.getHouseNum() %> <%= house.getHouseStreet() %></li>
                                <% } %>
                            </ul>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <jsp:include page="includes/footer.html"/>
</body>
</html>
