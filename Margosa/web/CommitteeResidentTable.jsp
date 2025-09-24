<%--
    Document   : CommitteeResidentTable
    Created on : Jul 13, 2023, 9:57:19 PM
    Author     : Bernard
--%>
<%@page import="java.time.Period"%>
<%@page import="java.time.LocalDate"%>
<%@page import="model.Committee"%>
<%@page import="connection.SqlCon"%>
<%@page import="java.util.List"%>
<%@page import="dao.ResidentDao"%>
<%@page import="model.Resident"%>
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
    
    ResidentDao residentDao = new ResidentDao(SqlCon.getConnection());
    HouseDao houseDao = new HouseDao(SqlCon.getConnection());
    List<Resident> allResidents = residentDao.getAllResidents();
%>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="includes/headers.html"/>
    <title>MyMargosaApp | Resident Panel</title>
    <style>
        .sortable {cursor: pointer; user-select: none;}
        .wrapper{ width: 360px; padding: 20px; }
    </style>
    <script>
        function sortTable(columnIndex) {
            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
            table = document.getElementById("residentTable");
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
            table = document.getElementById("residentTable");
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
        <h1>All Residents</h1>
    </div>   
    <div class="container text-center">
        <p>
            <a href="ResidentPanel.jsp" class="btn btn-secondary">Back</a>
        </p>
    </div>
    <div class="container">
        <div class="wrapper"><input type="text" class="form-control" id="searchInput" placeholder="Search..." onkeyup="searchTable()"></div>
       
        <table id="residentTable" class="table table-light">
            <thead>
                <tr>
                    <th scope="col" class="sortable" onclick="sortTable(0)">Index</th>
                    <th scope="col" class="sortable" onclick="sortTable(1)">First Name</th>
                    <th scope="col" class="sortable" onclick="sortTable(2)">Last Name</th>
                    <th scope="col" class="sortable" onclick="sortTable(3)">Gender</th>
                    <th scope="col" class="sortable" onclick="sortTable(4)">Birthday</th>
                    <th scope="col" class="sortable" onclick="sortTable(5)">Age</th>
                    <th scope="col" class="sortable" onclick="sortTable(6)">Email</th>
                    <th scope="col" class="sortable" onclick="sortTable(7)">Phone Number</th>
                    <th scope="col" class="sortable" onclick="sortTable(8)">Username</th>
                    <th scope="col" class="sortable" onclick="sortTable(9)">Address</th>
                </tr>
            </thead>
            <tbody>
                <% int index = 1;
                for (Resident resident : allResidents) {
                    LocalDate birthday = resident.getBirthday().toLocalDate();
                    LocalDate currentDate = LocalDate.now();
                    Period age = Period.between(birthday, currentDate);
                    House house = houseDao.getHouseByHID(resident.getHid()); // Get house details using HID
                %>
                    <tr>
                        <td scope="row"><%= index++ %></td>
                        <td><%= resident.getFirstName() %></td>
                        <td><%= resident.getLastName() %></td>
                        <td><%= resident.getGender() %></td>
                        <td><%= resident.getBirthday() %></td>
                        <td><%= age.getYears() %></td>
                        <td><%= resident.getEmail() %></td>
                        <td><%= resident.getPhoneNum() %></td>
                        <td><%= resident.getUsername() %></td>
                        <td><%= house != null ? house.getHouseNum() + ' ' + house.getHouseStreet() : "N/A" %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <jsp:include page="includes/footer.html"/>
</body>
</html>
