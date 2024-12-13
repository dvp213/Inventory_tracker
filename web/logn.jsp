<%@page import ="java.sql.*" %>
<%@page import ="app.classes.DBConector" %>
<%@page import ="java.sql.PreparedStatement" %>
<%
    int set = 0;
    if (request.getParameter("login") != null) {
        String username = request.getParameter("uname");
        String password = request.getParameter("password");
        String role = request.getParameter("btnradio");
        String id = null;

        //out.print(username + "\n");
        //out.print(password + "\n");
        //out.print(role + "\n");
        if (role.equals("admin")) {
            id = "Aid";
        } else if (role.equals("supplier")) {
            id = "SID";
        } else if (role.equals("stockkeeper")) {
            id = "SKID";
        } else if (role.equals("marketingteam")) {
            id = "MID";
        } 

        Connection con = DBConector.getConnection();
        String query = "SELECT password,"+id+" FROM " + role + " WHERE username=?";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, username);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {

            if (password.equals(rs.getString("password"))) {

                Cookie UID = new Cookie("U_ID", rs.getString(id));
                response.addCookie(UID);

                if (role.equals("admin")) {
                    response.sendRedirect("DashAdmin.jsp");
                } else if (role.equals("supplier")) {

                    response.sendRedirect("DashSupplier.jsp");

                } else if (role.equals("stockkeeper")) {
                    response.sendRedirect("DashSK.jsp");
                } else if (role.equals("marketingteam")) {
                    response.sendRedirect("DashMkt.jsp");
                } else {
                    response.sendRedirect("Login.jsp");
                }
                /*Cookie userCookie = new Cookie("loggedInUser", username);
                userCookie.setMaxAge(999999999);
                response.addCookie(userCookie);*/
            } else {
                //out.print("user name or password incorrect");
                set = 1;
            }
        } else {
            //out.print("user name or password incorrect");
            set = 1;
        }
    }


%>


<!DOCTYPE html>
<html data-bs-theme="light" lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
        <title>login</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/login.css">
        <style>
            .txt-sze{
                font-size: 10px !important;
            }
        </style>
    </head>

    <body><!-- Start: Login Form Basic -->
        <section class="position-relative py-4 py-xl-5">
            <div class="container">
                <div class="row mb-5">
                    <div class="col-md-8 col-xl-6 text-center mx-auto"><img src="img/logo-no-background.png"
                                                                            style="width: 150px;"></div>
                </div>
                <div class="row d-flex justify-content-center">
                    <div class="col-md-6 col-xl-4">
                        <div class="card mb-5">
                            <div class="card-body d-flex flex-column align-items-center">
                                <h2>Log In</h2>
                                <div class="bs-icon-xl bs-icon-circle bs-icon-primary bs-icon my-4"><svg
                                        xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" fill="currentColor" viewBox="0 0 16 16"
                                        class="bi bi-person">
                                    <path
                                        d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6Zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0Zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4Zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10Z">
                                    </path>
                                    </svg></div>
                                <form class="text-center" method="post">
                                    <div class="mb-3"><input class="form-control" type="text" name="uname" placeholder="Username"></div>
                                    <div class="mb-3"><input class="form-control" type="password" name="password" placeholder="Password">
                                    </div>
                                    <div class="btn-group" role="group" aria-label="Basic radio toggle button group">
                                        <input type="radio" class="btn-check" name="btnradio" id="btnradio1" value="admin" checked>
                                        <label class="btn btn-outline-primary txt-sze" for="btnradio1">Admin</label>

                                        <input type="radio" class="btn-check" name="btnradio" id="btnradio2" value="supplier">
                                        <label class="btn btn-outline-primary txt-sze" for="btnradio2">Supplier</label>

                                        <input type="radio" class="btn-check" name="btnradio" id="btnradio3" value="stockkeeper">
                                        <label class="btn btn-outline-primary txt-sze" for="btnradio3">Stock keeper</label>

                                        <input type="radio" class="btn-check" name="btnradio" id="btnradio4" value="marketingteam">
                                        <label class="btn btn-outline-primary txt-sze" for="btnradio4">Marketing Team</label>
                                    </div>  
                                    <div class="mb-3"><button class="btn btn-primary d-block w-100 mt-4" type="submit" name="login">Login</button></div>
                                    <% if (set == 1) {%>

                                    <div class="alert alert-primary d-flex align-items-center" id="error" role="alert" style="background-color: white; border-color: white">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="bi bi-exclamation-triangle-fill flex-shrink-0 me-2" width="20px" height="20px" viewBox="0 0 16 16" role="img" aria-label="Warning:">
                                        <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
                                        </svg>
                                        <div style="color: red">
                                            Incorrect username or password
                                        </div>
                                    </div>
                                    <% }%>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section><!-- End: Login Form Basic -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>