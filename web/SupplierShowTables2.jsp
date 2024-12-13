<%@page import="java.net.URLDecoder"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSetMetaData"%>
<!DOCTYPE html>

<%
    javax.servlet.http.Cookie[] cookies = request.getCookies();
    String U_ID = null;

    if (cookies != null) {
        for (javax.servlet.http.Cookie cookie : cookies) {
            if ("U_ID".equals(cookie.getName())) {
                U_ID = URLDecoder.decode(cookie.getValue(), "UTF-8");
                break;
            }
        }
    }else{
        response.sendRedirect("logn.jsp");
    }
%>

<html lang="en" title="Coding design">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">

        <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>

        <link rel="stylesheet" href="css/marketingTeamDash.css">
        <title>Marketing Team Dashboard</title>
    </head>

    <body>
        <%
            ResultSet data = (ResultSet) request.getSession().getAttribute("Data");
            String title = (String) request.getSession().getAttribute("title");

            ResultSetMetaData metaData = data.getMetaData();
            int columnCount = metaData.getColumnCount();
        %>
        <main>
            <div class="table">
                <div class="table__header">
                    <h1><%=title%></h1>
                    <div class="input-group">
                        <input type="search" placeholder="Search Data...">
                        <img src="img/search.png" alt="">
                    </div>

                </div>
                <div class="table__body">
                    <table>
                        <thead>
                            <tr>
                                <%
                                    for (int i = 1; i <= columnCount; i++) {
                                        String columnName = metaData.getColumnName(i);
                                %>
                                <th> <%= columnName%><span class="icon-arrow">&UpArrow;</span></th>
                                    <%
                                        } // End of for loop
                                    %>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                String columnName = null;
                                while (data.next()) {%><tr> <%
                                    for (int i = 1; i <= columnCount; i++) {
                                        if (i == columnCount) {
                                            String temp = metaData.getColumnName(i);
                                            if (data.getString(temp).equals("Pending")) {
                                                if (U_ID.equals(data.getString("SID"))) {
                                                    columnName = "<a href='ShowSupp?actionSup=reqbtn&"
                                                            + "&RID=" + data.getString("RID")
                                                            + "&SupplyID=" + data.getString("SID")
                                                            + "&SID=" + data.getString("SID")
                                                            + "&SKID=" + data.getString("SKID")
                                                            + "&itemID=" + data.getString("itemID")
                                                            + "&Quantity=" + data.getString("Quantity") + "'>"
                                                            + "<p class='status delivered'> Send Item </p></a>";
                                                } else {
                                                    columnName = "<p class='status delivered'> Send Item </p>";
                                                }
                                            } else if (data.getString(temp).equals("Sent")) {
                                                columnName = "<p class='status pending'> Complete </p>";
                                            } else if (data.getString(temp).equals("Cancelled")) {
                                                columnName = "<p class='status cancelled'> Cancelled </p>";
                                            } else{
                                                columnName = "<p class='status cancelled'> Error </p>";
                                            }
                                        } else {
                                            columnName = metaData.getColumnName(i);
                                        }
                                %>
                                <td> <% if (i == columnCount) {%>
                                    <%= columnName%>
                                    <%} else {%>
                                    <%= data.getString(columnName)%>
                                    <%}%>
                                </td>
                                <%}%></tr><%}%>
                        </tbody>
                    </table>
                </div>
            </div>

        </main>
        <script src="script.js"></script>
    </body>

</html>