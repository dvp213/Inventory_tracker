<%-- 
    Document   : newjsp
    Created on : Aug 5, 2023, 5:48:53 AM
    Author     : lakru
--%>

<%@page import="app.classes.MKTCls"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="app.classes.SpplierCls"%>
<%@page import="java.net.URLDecoder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    MKTCls mkt = new MKTCls();
    SpplierCls sup = new SpplierCls();
    ResultSet itemData = sup.viewitems();
    ResultSet skData = sup.selectSK();
    String selectedItemID = "";

    String msj[] = {"", "Request Added Succfully", "Request Added Succfully. But Item Not Available Now"};
    String msjClr = null;
    String msjNum = null;
    String alt = null;
    msjNum = request.getParameter("m");

    if (msjNum != null && !msjNum.isEmpty()) {
        if (msjNum.equals("1")) {
            msjClr = "alert-success";
        } else {
            msjClr = "alert-danger";
        }
    }

%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Marketing Team DashBoard</title>

        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
        <script type="module"src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <link rel="stylesheet" href="skcss.css" />
    </head>
    <body>
        <div class="container">

            <%if (msjNum != null && !msjNum.isEmpty()) {
                    alt = "<br><div class='alert " + msjClr + " alert-dismissible fade show' role='alert'>"
                            + "<strong>" + msj[Integer.parseInt(msjNum)] + "</strong>"
                            + "<button type='button' class='btn-close' data-bs-dismiss='alert' onclick='redirectToPage()'>"
                            + "</button></div><br>";
                } else {
                    alt = "<br>";
                }
            %>

            <%= alt%>

            <script>
                function redirectToPage() {
                    window.location.href = 'DashMkt.jsp';
                }
            </script>

            <div class="row">
                <div class="col-lg-3 col-md-4 col-sm-6 text-center p-3">
                    <a href="wareHouses.html" style="text-decoration: none">
                        <div class="card cardsFirstTS mt-2 pt-2" style="width: 100%" type="button">
                            <div class="card-body">
                                <div class="iconInCard"><h1><i class="fa-solid fa-store"></i></h1></div>
                                <h2>Check store</h2>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-6 text-center p-3">
                    <div class="card cardsFirstTW mt-2 pt-2" style="width: 100%" type="button" data-bs-toggle="modal" data-bs-target="#send">
                        <div class="card-body">
                            <div class="iconInCard"><h1><i class="fa-solid fa-paper-plane"></i></h1></div>
                            <h2>Send Request</h2>                            
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-6 text-center p-3">
                    <a href="ControlMkt?actionMkt=sendReqtoSk" style="text-decoration: none">
                        <div class="card cardsFirstTW mt-2 pt-2" style="width: 100%">
                            <div class="card-body">
                                <div class="iconInCard"><h1><i class="fa-solid fa-magnifying-glass"></i></h1></div>
                                <h2>Pending Request</h2>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-6 text-center p-3">
                    <a href="ControlMkt?actionMkt=TransferToSK" style="text-decoration: none">
                        <div class="card cardsFirstTW mt-2 pt-2" style="width: 100%">
                            <div class="card-body">
                                <div class="iconInCard"><h1><i class="fa-solid fa-plane-arrival"></i></h1></div>
                                <h2>Transfer History</h2>
                            </div>
                        </div>
                    </a>
                </div>

            </div>

            <br><br>

            <!--Table Start-->
            <div class="row">
                <%
                    ResultSet reqByM = mkt.requestByML10();
                    ResultSetMetaData metaData1 = reqByM.getMetaData();
                    int columnCount1 = metaData1.getColumnCount();
                %>            
                <div class="col-md-6">
                    <div class="text-center mt-2">
                        <h4>Recently Added Request</h4>
                    </div>

                    <table class="table text-center">
                        <thead>
                            <tr class="table-secondary">
                                <%
                                    for (int i = 1; i <= columnCount1; i++) {
                                        String columnName = metaData1.getColumnName(i);
                                %>
                                <th scope="col"> <%= columnName%></th>
                                    <%
                                        }
                                    %>
                            </tr>
                        </thead>
                            <tbody>
                                <%
                                while (reqByM.next()) {%><tr class="table-light"> <%
                                        for (int i = 1; i <= columnCount1; i++) {
                                            String columnName = metaData1.getColumnName(i);
                                %>
                                <td> <%= reqByM.getString(columnName)%></td>
                                <%}%></tr><%}%>
                        </tbody>
                    </table>
                </div>


                <div class="col-md-6">
                    <div class="text-center mt-2">
                        <h4>Recently Transfer Items</h4>
                    </div>
                    <%
                        ResultSet tfromSK = mkt.transferfromSKL10();
                        ResultSetMetaData metaData2 = tfromSK.getMetaData();
                        int columnCount2 = metaData2.getColumnCount();
                    %>

                    <table class="table text-center">
                        <thead>
                            <tr class="table-secondary">
                                <%
                                    for (int i = 1; i <= columnCount2; i++) {
                                        String columnName = metaData2.getColumnName(i);
                                %>
                                <th scope="col"> <%= columnName%></th>
                                    <%
                                        }
                                    %>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                    while (tfromSK.next()) {%><tr class="table-light"> <%
                                    for (int i = 1; i <= columnCount2; i++) {
                                        String columnName = metaData2.getColumnName(i);
                                %>
                                <td> <%= tfromSK.getString(columnName)%></td>
                                <%}%></tr><%}%>
                        </tbody>
                    </table>
                </div>
            </div>
            <!--table end-->


            <!--model start-->    
            <!--Send Request start-->
            <div class="modal fade" id="send" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" >
                    <div class="modal-content w-150">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5">Send Request to Store Keeper</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <form class="was-validated" action="ControlMkt?actionMkt=req" method="POST">
                            <div class="modal-body">
                                <div class="row">
                                    <label class="form-label">Select Item ID</label>
                                    <select class="form-select  mb-3" required name="itemID">            
                                        <%while (itemData.next()) {%>
                                        <option value="<%= itemData.getString("itemID")%>"><%= itemData.getString("itemID")%></option>
                                        <%}%>
                                    </select>
                                </div>
                                <div class="row">
                                    <label class="form-label">Select Store Keeper</label>
                                    <select class="form-select  mb-3" required name="SID">            
                                        <%while (skData.next()) {%>
                                        <option value="<%= skData.getString("SKID")%>"><%= skData.getString("SKID")%></option>
                                        <%}%>
                                    </select>
                                </div>
                                <br><div class="row">
                                    <div class="mb-2">
                                        <label class="form-label">Quantity</label>
                                        <div class="input-group">
                                            <input type="number" class="form-control" required name="qty">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" name="MID" value="<%= U_ID%>" />
                            <div class="modal-footer">
                                <button type="resrt" class="btn btn-secondary" data-bs-dismiss="modal" >Discard</button>
                                <button type="submit" name="sendReqtoSk" Value="sendReqtoSk" class="btn btn-primary">Send</button>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
            <!--Send Request end-->            
            <!--model end-->


        </div>
    </body>
</html>