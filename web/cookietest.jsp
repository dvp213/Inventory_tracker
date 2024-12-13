<%
    String loggedInUser = null;
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("loggedInUser")) {
                loggedInUser = cookie.getValue();
                break;
            }
        }
    }

    String savedUsername = null;
    String savedPassword = null;
    String savedRole = null;

    if (loggedInUser != null) {
        String[] userParts = loggedInUser.split(":");
        if (userParts.length == 3) {
            savedUsername = userParts[0];
            savedPassword = userParts[1];
            savedRole = userParts[2];
        }
    }
%>


<!DOCTYPE html>
<html>
<head>
    <title>Welcome</title>
</head>
<body>
    <h1>Welcome, <%= savedUsername %></h1>
    <p>Your role: <%= savedRole %></p>
</body>
</html>
