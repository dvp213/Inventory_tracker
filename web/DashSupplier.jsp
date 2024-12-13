<%-- 
    Document   : newjsp
    Created on : Aug 5, 2023, 5:48:53 AM
    Author     : lakru
--%>

<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="app.classes.ItemData, app.classes.SpplierCls, app.classes.DBConector" %>

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
    SpplierCls sup = new SpplierCls();
    ResultSet data1 = sup.viewitems();
    ResultSet data2 = sup.viewitems();
    ResultSet data3 = sup.viewitems();
    ResultSet StID = sup.selectSK();
    String selectedItemID = "";

    String msj[] = {"", "Item Added Succfully", "Can't Add Item. Try Again",
        "Item Edited Succfully", "Can't Edit Item. Try Again",
        "Item Deleted Succfully", "Can't Delete Item. Try Again",
        "Item Sent Succfully", "Can't sent Item. Try Again", "Can't sent Item. Not Enough Space to Store"};
    String msjClr = null;
    String msjNum = null;
    String alt = null;
    msjNum = request.getParameter("m");

    if (msjNum != null && !msjNum.isEmpty()) {
        if (msjNum.equals("1") || msjNum.equals("3") || msjNum.equals("5") || msjNum.equals("7")) {
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
        <title>Supplier DashBoard</title>

        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
        <script type="module"src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <link rel="stylesheet" href="skcss.css" />

        <style>
            .alerts {
                padding: 20px;
                background-color: #36f443;
                color: white;
            }

            .alertu {
                padding: 20px;
                background-color: #f44336;
                color: white;
            }

            .closebtn__ {
                margin-left: 15px;
                color: white;
                font-weight: bold;
                float: right;
                font-size: 22px;
                line-height: 20px;
                cursor: pointer;
                transition: 0.3s;
            }

            .closebtn:hover {
                color: black;
            }
        </style>
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
                    window.location.href = 'DashSupplier.jsp';
                }
            </script>

            <!--Fist card row Start-->
            <div class="row">

                <div class="col-lg-3 col-md-4 col-sm-6 text-center p-3">
                    <div class="card cardsFirstAW mt-2 pt-2" style="width: 100%" type="button" data-bs-toggle="modal" data-bs-target="#add">
                        <div class="card-body">
                            <div class="iconInCard"><h1><i class="fa-solid fa-plus"></i></h1></div>
                            <h2>Add item</h2>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-6 text-center p-3">
                    <div class="card cardsFirstFW mt-2 pt-2" style="width: 100%" type="button" data-bs-toggle="modal" data-bs-target="#remove">
                        <div class="card-body">
                            <div class="iconInCard"><h1><i class="fa-solid fa-trash"></i></h1></div>
                            <h2>Remove item</h2>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-6 text-center p-3">
                    <div class="card cardsFirstTW mt-2 pt-2" style="width: 100%" type="button" data-bs-toggle="modal" data-bs-target="#edit">
                        <div class="card-body">
                            <div class="iconInCard"><h1><i class="fa-solid fa-pen-to-square"></i></h1></div>
                            <h2>Update item</h2>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-6 text-center p-3">
                    <a href="ShowSupp?actionSup=viewitems" style="text-decoration: none">
                        <div class="card cardsFirstTS mt-2 pt-2" style="width: 100%">
                            <div class="card-body">
                                <div class="iconInCard"><h1><i class="fa-solid fa-eye"></i></h1></div>
                                <h2>View all item</h2>
                            </div>
                        </div>
                    </a>
                </div>
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
                            <div class="iconInCard"><h1><i class="fa-solid fa-dolly"></i></h1></div>
                            <h2>Send item</h2>                            
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-6 text-center p-3">
                    <a href="ShowSupp?actionSup=RequestBySK" style="text-decoration: none">
                        <div class="card cardsFirstTW mt-2 pt-2" style="width: 100%">
                            <div class="card-body">
                                <div class="iconInCard"><h1><i class="fa-solid fa-magnifying-glass"></i></h1></div>
                                <h2>View Request</h2>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-6 text-center p-3">                    
                    <a href="ShowSupp?actionSup=TransferToSK" style="text-decoration: none">
                        <div class="card cardsFirstTW mt-2 pt-2" style="width: 100%">
                            <div class="card-body">
                                <div class="iconInCard"><h1><i class="fa-solid fa-plane-departure"></i></h1></div>
                                <h2>Transfer History</h2></div>
                        </div>
                    </a>
                </div>
            </div>

            <br><br>

            <!--model start-->
            <!--add Item-->
            <div class="modal fade" id="add" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" >
                    <div class="modal-content w-150">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5">Add Item</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>                        
                        <form class="was-validated" action="ControlSupp?actionSup=add" method="POST">
                            <div class="modal-body">
                                <div class="row">
                                    <div class="mb-2">
                                        <label class="form-label">Item Name</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" name="itemName" required>
                                        </div>
                                    </div>
                                </div>
                                <br><div class="row">
                                    <label class="form-label">Select type</label>
                                    <select class="form-select  mb-3" required name="category" required>            
                                        <option value="Product">Product</option>
                                        <option value="Raw material">Raw material</option>
                                    </select>
                                </div>
                                <br><div class="row">
                                    <div class="col-12">
                                        <label class="form-label">Unit Capacity</label>
                                        <div class="input-group mb-3">
                                            <input type="number" class="form-control" name="unitCap" required>
                                        </div>
                                    </div>
                                </div> 
                                <br><div class="row">
                                    <div class="col-12">
                                        <label class="form-label">Unit price</label>
                                        <div class="input-group mb-3">
                                            <input type="number" class="form-control" name="unitPrice" required>
                                            <span class="input-group-text">.00</span>
                                        </div>
                                    </div>
                                </div> 
                            </div>
                            <div class="modal-footer">
                                <button type="resrt" class="btn btn-secondary" data-bs-dismiss="modal" >Discard</button>
                                <button type="submit" name="addItembtn" Value="addItem" class="btn btn-primary">Add Item</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <!--add item-->

            <!--edit item-->
            <div class="modal fade" id="edit" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" >
                    <div class="modal-content w-150">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5">Update Item</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <form class="was-validated" action="ControlSupp?actionSup=edit" method="POST">
                            <div class="modal-body">
                                <div class="row">
                                    <label class="form-label">Select Item ID</label>
                                    <select class="form-select  mb-3" required name="id">
                                        <option>Select</option>
                                        <%while (data1.next()) {%>
                                        <option value="<%= data1.getString("itemID")%>"><%= data1.getString("itemID")%></option>
                                        <%}%>
                                    </select>
                                </div>                   
                                <br><div class="row">
                                    <div class="col-12">
                                        <label class="form-label">New Unit price</label>
                                        <div class="input-group mb-3">
                                            <input type="number" class="form-control" name="unitPrice" required>
                                            <span class="input-group-text">.00</span>
                                        </div>
                                    </div>
                                </div> 


                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Discard</button>
                                <button type="sumbit" class="btn btn-primary">Update</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <!--edit item-->  

            <!--delete item-->
            <div class="modal fade" id="remove" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" >
                    <div class="modal-content w-150">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5">Delete Item</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <form class="was-validated" action="ControlSupp?actionSup=delete" method="POST">
                            <div class="modal-body">
                                <div class="row">
                                    <label class="form-label">Select Item ID</label>
                                    <select class="form-select  mb-3" required name="id">
                                        <option>Select</option>
                                        <%while (data2.next()) {%>
                                        <option value="<%= data2.getString("itemID")%>"><%= data2.getString("itemID")%></option>
                                        <%}%>
                                    </select>
                                </div>                                

                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Discard</button>
                                <button type="submit" class="btn btn-primary">Delete</button>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
            <!--delete item-->  

            <!--Send item-->
            <div class="modal fade" id="send" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" >
                    <div class="modal-content w-150">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5">Send Item to Store Keeper</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <form class="was-validated" action="ControlSupp?actionSup=send" method="POST">
                            <div class="modal-body">
                                <div class="row">
                                    <label class="form-label">Select Product Name</label>
                                    <select class="form-select  mb-3" required name="iid">            
                                        <option>Select</option>
                                        <%while (data3.next()) {%>
                                        <option value="<%= data3.getString("itemID")%>"><%= data3.getString("itemID")%></option>
                                        <%}%>
                                    </select>
                                </div>
                                <div class="row">
                                    <label class="form-label">Select Store Keeper</label>
                                    <select class="form-select  mb-3" required name="skid">            
                                        <option>Select</option>
                                        <%while (StID.next()) {%>
                                        <option value="<%= StID.getString("SKID")%>"><%= StID.getString("SKID")%></option>
                                        <%}%>
                                    </select>
                                </div>
                                <br><div class="row">
                                    <div class="mb-2">
                                        <label class="form-label">Quantity</label>
                                        <div class="input-group">
                                            <input type="number" class="form-control" id="basic-url" name="qty" required>
                                        </div>
                                    </div>
                                </div>
                                <input type="hidden" name="sid" value="<%= U_ID%>" />
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Discard</button>
                                <button type="submit" class="btn btn-primary">Send</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <!--Send Item-->            
            <!--model end-->

            <!--Table Start-->
            <%
                ResultSet viewitemsl5 = sup.viewitemsl5();
                ResultSetMetaData metaData1 = viewitemsl5.getMetaData();
                int columnCount1 = metaData1.getColumnCount();
            %>
            <div class="row">
                <!--Recently Added Products Table Start-->
                <div class="col-md-6">
                    <div class="text-center mt-2">
                        <h4>Recently Added Items</h4>
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
                                        } // End of for loop
                                    %>
                            </tr>
                        </thead>
                            <tbody>
                                <%
                                while (viewitemsl5.next()) {%><tr class="table-light"> <%
                                        for (int i = 1; i <= columnCount1; i++) {
                                            String columnName = metaData1.getColumnName(i);
                                %>
                                <td> <%= viewitemsl5.getString(columnName)%></td>
                                <%}%></tr><%}%>
                        </tbody>
                    </table>
                </div>
                <!--Recently Added Products Table end-->

                <!--Recently Supplied Products Table Start-->                
                <div class="col-md-6">
                    <div class="text-center mt-2">
                        <h4>Recently Transfer Items</h4>
                    </div>
                    <%
                        ResultSet transferToSKl5 = sup.transferToSKl5();
                        ResultSetMetaData metaData2 = transferToSKl5.getMetaData();
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
                                        } // End of for loop
                                    %>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                    while (transferToSKl5.next()) {%><tr class="table-light"> <%
                                        for (int i = 1; i <= columnCount2; i++) {
                                            String columnName = metaData2.getColumnName(i);
                                %>
                                <td> <%= transferToSKl5.getString(columnName)%></td>
                                <%}%></tr><%}%>
                        </tbody>
                    </table>
                </div>
                <!--Recently Supplied Products Table Start-->
            </div>

        </div>
    </body>
</html>

