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
                                    while (data.next()) {%><tr> <%
                                    for (int i = 1; i <= columnCount; i++) {
                                        String columnName = metaData.getColumnName(i);
                                %>
                                <td> <%= data.getString(columnName)%></td>
                                <%}%></tr><%}%>
                        </tbody>
                    </table>
                </div>
            </div>

        </main>
        <script src="script.js"></script>
    </body>

</html>