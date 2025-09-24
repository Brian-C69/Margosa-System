<%--
    Document   : GuardExitedVisitors
    Created on : Jul 15, 2023, 4:01:47 PM
    Author     : Bernard
--%>
<%@page import="model.Guard"%>
<%@page import="model.Visitor"%>
<%@page import="connection.SqlCon"%>
<%@page import="java.util.List"%>
<%@page import="dao.VisitorDao"%>
<%@page import="dao.HouseDao"%>
<%@page import="model.House"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Guard guard = (Guard) request.getSession().getAttribute("guard");
    if (guard == null) {
        request.setAttribute("errorMessage", "You must be Logged In");
        request.getRequestDispatcher("guard.jsp").forward(request, response);
        return;
    }

    VisitorDao visitorDao = new VisitorDao(SqlCon.getConnection());
    HouseDao houseDao = new HouseDao(SqlCon.getConnection());
    List<Visitor> exitedVisitors = visitorDao.getExitedVisitors();
%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | Exited Visitors</title>
        <style>
            .sortable {
                cursor: pointer;
                user-select: none;
            }
            .wrapper{
                width: 360px;
                padding: 20px;
            }
        </style>
        <script src="calculateDuration.js"></script>
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
                <a href="GuardScanQrCode.jsp" class="btn btn-info">Scan</a>
                <a href="GuardAddVisitor.jsp" class="btn btn-warning">Add Visitor</a>
                <a href="GuardCreatedVisitors.jsp" class="btn btn-primary">Pending Visitor</a>
                <a href="GuardEnteredVisitors.jsp" class="btn btn-primary">Entered Visitor</a>
                <a href="GuardExitedVisitors.jsp" class="btn btn-success">Exited Visitor</a>
                
            </p>
        </div>
        <div class="container">
            <div class="wrapper">
                <input type="text" id="searchInput" class="form-control" placeholder="Search..." onkeyup="searchTable()">
            </div>
            <table id="exitedVisitorsTable" class="table table-light">
                <thead>
                    <tr>
                        <th scope="col" class="sortable" onclick="sortTable(0)">#</th>
                        <th scope="col" class="sortable" onclick="sortTable(1)">VID</th>
                        <th scope="col" class="sortable" onclick="sortTable(2)">Visitor Name</th>
                        <th scope="col" class="sortable" onclick="sortTable(3)">Phone Number</th>
                        <th scope="col" class="sortable" onclick="sortTable(4)">Vehicle Number</th>
                        <th scope="col" class="sortable" onclick="sortTable(5)">House</th>
                        <th scope="col" class="sortable" onclick="sortTable(6)">Entry Date</th>
                        <th scope="col" class="sortable" onclick="sortTable(7)">Entry Time</th>
                        <th scope="col" class="sortable" onclick="sortTable(8)">Exit Date</th>
                        <th scope="col" class="sortable" onclick="sortTable(9)">Exit Time</th>
                        <th scope="col" class="sortable" onclick="sortTable(10)">Duration</th>
                    </tr>
                </thead>
                <tbody>
                    <% int index = 1;
                        for (Visitor visitor : exitedVisitors) {
                    %>
                    <tr>
                        <td><%= index++%></td>
                        <td><%= visitor.getVid()%></td>
                        <td><%= visitor.getVisitorName()%></td>
                        <td><%= visitor.getVisitorPhoneNum()%></td>
                        <td><%= visitor.getVisitorVehicleNum()%></td>
                        <td>
                            <ul>
                                <% if (visitor.getFid() > 0) { // Visitor has a valid FID, use the House objects
                            List<House> houses = houseDao.getHousesByFamilyId(visitor.getFid());
                            for (House house : houses) {%>
                                <li><%= house.getHouseNum()%> <%= house.getHouseStreet()%></li>
                                    <% }
                                    } else { // Visitor does not have a valid FID, use the visitor's house details
                                        String houseNum = visitor.getHouseNum();
                                        String houseStreet = visitor.getHouseStreet();
                                        if (houseNum != null && houseStreet != null) {%>
                                <li><%= houseNum%> <%= houseStreet%></li>
                                    <% }
                                        }%>
                            </ul>
                        </td>
                        <td><%= visitor.getVisitorEntryDate()%></td>
                        <td><%= visitor.getVisitorEntryTime()%></td>
                        <td><%= visitor.getVisitorExitDate()%></td>
                        <td><%= visitor.getVisitorExitTime()%></td>
                        <td><script>document.write(calculateDuration('<%= visitor.getVisitorEntryDate()%>', '<%= visitor.getVisitorEntryTime()%>', '<%= visitor.getVisitorExitDate()%>', '<%= visitor.getVisitorExitTime()%>'));</script></td>
                    </tr>
                    <% }%>
                </tbody>

            </table>
        </div>
        <jsp:include page="includes/footer.html"/>
        <script>
            function sortTable(n) {
                var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
                table = document.getElementById("exitedVisitorsTable");
                switching = true;
                dir = "asc";

                while (switching) {
                    switching = false;
                    rows = table.getElementsByTagName("tr");

                    for (i = 1; i < (rows.length - 1); i++) {
                        shouldSwitch = false;
                        x = rows[i].getElementsByTagName("td")[n];
                        y = rows[i + 1].getElementsByTagName("td")[n];

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
                table = document.getElementById("exitedVisitorsTable");
                tr = table.getElementsByTagName("tr");

                for (i = 0; i < tr.length; i++) {
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
    </body>
</html>
