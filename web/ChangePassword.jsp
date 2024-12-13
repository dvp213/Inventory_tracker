<%-- 
    Document   : ChangePassword
    Created on : Aug 10, 2023, 2:30:22 AM
    Author     : lakru
--%>
<%@page import="java.net.URLDecoder"%>
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
<!DOCTYPE html>
<html data-bs-theme="light" lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
        <title>Change Password</title>
        link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
        <script type="module"src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="css/login.css">
        <style>
            .txt-sze {
                font-size: 10px !important;
            }
        </style>
    </head>

    <body>
        
        <%
            String alt = null;
            String m = request.getParameter("m");
            if (m != null && !m.isEmpty()) {
                    alt = "<br><div class='alert alert-danger alert-dismissible fade show' role='alert'>"
                            + "<strong>Something went wrong. Try again </strong>"
                            + "<button type='button' class='btn-close' data-bs-dismiss='alert' onclick='redirectToPage()'>"
                            + "</button></div><br>";
                } else {
                    alt = "<br>";
                }
        %>
            <script>
                function redirectToPage() {
                    window.location.href = 'ChangePassword.jsp';
                }
            </script>

        <%= alt%>
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
                                <h2>Change Password</h2>
                                <div class="bs-icon-xl bs-icon-circle bs-icon-primary bs-icon my-4"><i
                                        class="fa-solid fa-unlock fa-l"></i></div>
                                <form class="text-center" method="post" onsubmit="return validateForm();" action='ChangePassword'>
                                    
                                    <div class="input-group mb-3">
                                            <input type="password" class="form-control" id="pWord" name="pWord" placeholder="Enter Password">
                                            <span class="input-group-text"><i id="toggleButton" onclick="togglePasswordVisibility()">Show</i></span>
                                    </div>
                                    <div class="input-group mb-3">
                                            <input type="password" class="form-control" id="password2" name="password2" placeholder="Re-enter Password">
                                            <span class="input-group-text"><i id="toggleButton2" onclick="togglePasswordVisibility2()">Show</i></span>                                 
                                    </div>
                                    <input type="hidden" name="id" value="<%= U_ID%>" />
                                    <p id="password-error" style="color: red;"></p>
                                    <div class="mb-3"><button class="btn btn-primary d-block w-100 mt-4" type="submit" name="login">Change Password</button></div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <script>
            const passwordInput = document.getElementById("pWord");
            const passwordConfirmationInput = document.getElementById("password2");
            const passwordError = document.getElementById("password-error");

            passwordInput.addEventListener("input", validatePassword);

            function validatePassword() {
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
            }

            function validateForm() {
                const password = passwordInput.value;
                const passwordConfirmation = passwordConfirmationInput.value;

                if (password !== passwordConfirmation) {
                    passwordError.textContent = "Passwords do not match.";
                    return false; // Prevent form submission
                }

                // If all validation passes, clear any existing error messages and allow form submission
                passwordError.textContent = "";
                return true;
            }

            function togglePasswordVisibility() {
                var passwordField = document.getElementById("pWord");
                var toggleButton = document.getElementById("toggleButton");

                if (passwordField.type === "password") {
                    passwordField.type = "text";
                    toggleButton.textContent = "Hide";
                } else {
                    passwordField.type = "password";
                    toggleButton.textContent = "Show";
                }
            }
            
            function togglePasswordVisibility2() {
                var passwordField = document.getElementById("password2");
                var toggleButton2 = document.getElementById("toggleButton2");

                if (passwordField.type === "password") {
                    passwordField.type = "text";
                    toggleButton2.textContent = "Hide";
                } else {
                    passwordField.type = "password";
                    toggleButton2.textContent = "Show";
                }
            }
        </script>



        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>
