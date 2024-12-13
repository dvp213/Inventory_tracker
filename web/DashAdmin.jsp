<%-- 
    Document   : newjsp
    Created on : Aug 5, 2023, 5:48:53 AM
    Author     : lakru
--%>

<%@page import="java.net.URLDecoder"%>
<%@page import="app.classes.AdminCls"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    
    String msj[] = {"", "User Added Succfully", "Can't Add User. Try Again", "User Removed Succfully", "Can't Remove User. Try Again"};
    String msjClr = null;
    String msjNum = null;
    String alt = null;
    msjNum = request.getParameter("m");

    if (msjNum != null && !msjNum.isEmpty()) {
        if (msjNum.equals("1") || msjNum.equals("3")) {
            msjClr = "alert-success";
        } else {
            msjClr = "alert-danger";
        }
    }

    AdminCls Ad = new AdminCls();
    ResultSet data1 = Ad.viewsup();
    ResultSet data2 = Ad.viewSk();
    ResultSet data3 = Ad.viewMk();
    ResultSet data4 = Ad.viewAd();

%>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Admin DashBoard</title>

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
            
            <script>
                function redirectToPage() {
                    window.location.href = 'DashAdmin.jsp';
                }
            </script>

            <%= alt%>

            <br><br>
            <div class="row">
                <div class="col-lg-8">
                    <div class="row">
                        <h2>Manage System Users</h2><hr class="pt-0 pb-0">  
                        <div class="col-lg-6 col-md-6 col-sm-12 text-center p-3 px-4">
                            <div class="card cardsFirstAW mt-2 pt-2" style="width: 100%" type="button" data-bs-toggle="modal" data-bs-target="#add">
                                <div class="card-body">
                                    <div class="iconInCard"><h1><i class="fa-solid fa-plus"></i></h1></div>
                                    <h2>Add Member</h2>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12 text-center p-3 px-4">
                            <div class="card cardsFirstFW mt-2 pt-2" style="width: 100%" type="button" data-bs-toggle="modal" data-bs-target="#remove">
                                <div class="card-body">
                                    <div class="iconInCard"><h1><i class="fa-solid fa-trash"></i></h1></div>
                                    <h2>Remove Member</h2>
                                </div>
                            </div>
                        </div> 
                    </div>
                </div>


                <div class="col-lg-4">
                    <div class="row">
                        <h2>Manage Stores</h2><hr class="pt-0 pb-0">
                        <div class="col-lg-12 col-md-6 text-center p-3 px-4">
                            <a href="wareHouses.html" style="text-decoration: none">
                                <div class="card cardsFirstTS mt-2 pt-2" style="width: 100%" type="button">
                                    <div class="card-body">
                                        <div class="iconInCard"><h1><i class="fa-solid fa-store"></i></h1></div>
                                        <h2>Check store</h2>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!--model start-->
            <!--add member-->
            <div class="modal fade" id="add" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" >
                    <div class="modal-content w-150">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5">Add New Member</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <form class="was-validated" action="ControlAdmin?actionAd=add" method="POST">
                            <div class="modal-body">
                                <div class="row">
                                    <div class="mb-3">
                                        <label class="form-label">Create UserName</label>
                                        <div class="input-group">
                                            <span class="input-group-text" id="basic-addon3">UserName</span>
                                            <input type="text" class="form-control" name="uName" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="mb-3">
                                        <label class="form-label">Create Password</label>
                                        <div class="input-group">
                                            <span class="input-group-text" id="basic-addon3">Password</span>
                                            <input type="text" class="form-control" id="pWord" name="pWord" required>
                                        </div>
                                    </div>
                                </div>
                                <p id="password-error" style="color: red;"></p>
                                <script>
                                    const passwordInput = document.getElementById("pWord");
                                    const passwordError = document.getElementById("password-error");

                                    passwordInput.addEventListener("input", function () {
                                        const password = passwordInput.value;

                                        const hasLowerCase = /[a-z]/.test(password);
                                        const hasUpperCase = /[A-Z]/.test(password);
                                        const hasDigit = /\d/.test(password);
                                        const hasSpecialChar = /[!@#$%^&*()_+{}\[\]:;<>,.?~\-]/.test(password);
                                        const isLengthValid = password.length >= 8 && password.length <= 20;

                                        if (!isLengthValid) {
                                            passwordError.textContent = "Password must be between 8 and 20 characters.";
                                        } else if (!hasLowerCase) {
                                            passwordError.textContent = "Password must contain at least one lowercase letter.";
                                        } else if (!hasUpperCase) {
                                            passwordError.textContent = "Password must contain at least one uppercase letter.";
                                        } else if (!hasDigit) {
                                            passwordError.textContent = "Password must contain at least one digit.";
                                        } else if (!hasSpecialChar) {
                                            passwordError.textContent = "Password must contain at least one special character.";
                                        } else {
                                            passwordError.textContent = "";
                                        }
                                    });</script>
                                <div class="row">
                                    <div class="mb-3">
                                        <label class="form-label">Add e-mail</label>
                                        <div class="input-group">
                                            <input type="email" class="form-control" name="email" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="mb-3">
                                        <label class="form-label">Phone Number</label>
                                        <div class="input-group">
                                            <input type="number" class="form-control" name="pnum" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <label class="form-label">Select User</label>
                                    <div class="input-group">
                                        <select class="form-select  mb-3" required name="role">            
                                            <option value="1">Supplier</option>
                                            <option value="2">Store Keeper</option>
                                            <option value="3">Marketing Team Member</option>
                                            <option value="4">System Admin</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="reset" class="btn btn-secondary" data-bs-dismiss="modal">Discard</button>
                                <button type="submit" class="btn btn-primary">Add User</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <!--add member-->

            <!--remove member-->
            <div class="modal fade" id="remove" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" >
                    <div class="modal-content w-150">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5">Remove Member</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <form class="was-validated" action="ControlAdmin?actionAd=delete" method="POST">
                            <div class="modal-body">
                                <div class="row">
                                    <label class="form-label">Select User</label>
                                    <div class="input-group">
                                        <select class="form-select  mb-3" required name="id">            
                                            <option value="1">Select</option>
                                            <%while (data1.next()) {%>
                                            <option value="<%= data1.getString("SID")%>"><%= data1.getString("SID")%></option>
                                            <%}%>
                                            <%while (data2.next()) {%>
                                            <option value="<%= data2.getString("SKID")%>"><%= data2.getString("SKID")%></option>
                                            <%}%>
                                            <%while (data3.next()) {%>
                                            <option value="<%= data3.getString("MID")%>"><%= data3.getString("MID")%></option>
                                            <%}%>
                                            <%while (data4.next()) {%>
                                            <option value="<%= data4.getString("Aid")%>"><%= data4.getString("Aid")%></option>
                                            <%}%>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="reset" class="btn btn-secondary" data-bs-dismiss="modal">Discard</button>
                                <button type="submit" class="btn btn-primary">Remove User</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <!--remove member-->   
            <!--model end-->

            <br><br>
            <div class="row">
                <div class="col-lg-8">
                    <div class="row">

                        <h2>Manage Suppliers</h2><hr class="pt-0 pb-0">
                        <div class="col-lg-6 col-md-6 col-sm-12 text-center p-3 px-4">
                            <a href="ShowSupp?actionSup=viewitems" style="text-decoration: none">
                                <div class="card cardsFirstTS mt-2 pt-2" style="width: 100%">
                                    <div class="card-body">
                                        <div class="iconInCard"><h1><i class="fa-solid fa-eye"></i></h1></div>
                                        <h2>View all item</h2>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12 text-center p-3 px-4">
                            <a href="ShowSupp?actionSup=TransferToSK" style="text-decoration: none">
                                <div class="card cardsFirstTW mt-2 pt-2" style="width: 100%">
                                    <div class="card-body">
                                        <div class="iconInCard"><h1><i class="fa-solid fa-plane-departure"></i></h1></div>
                                        <h2>Transfer History</h2></div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="row">
                        <h2>Manage Marketing Team</h2><hr class="pt-0 pb-0">
                        <div class="col-lg-12 col-md-6 text-center p-3 px-4">
                            <div class="card cardsFirstTW mt-2 pt-2" style="width: 100%" type="button" data-bs-toggle="offcanvas" data-bs-target="#Transferm">
                                <div class="card-body">
                                    <div class="iconInCard"><h1><i class="fa-solid fa-plane-departure"></i></h1></div>
                                    <h2>Transfer History</h2>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>          


            </div>
        </div>
    </body>
</html>

