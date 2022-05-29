<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Authorization</title>
    <title>Insert title here</title>
</head>

<body>
<section class="login">
    <form class="form_holder" method="post" action="loginCheck">
        <table>
            <tr>
                <td>User Name</td>
            </tr>
            <tr>
                <td><input type="text" name="uname"></td>
            </tr>
            <tr>
                <td>Password</td>
            </tr>
            <tr>
                <td><input type="password" name="password"></td>
            </tr>
            <tr>
                <td></td>
            </tr>
            <tr>
                <td><input type="submit" value="login"></td>
            </tr>
        </table>
    </form>
    <form class="form_holder">
        <a class="nav_item" href="http://localhost:8080/web_registration">
            Registration
        </a>
    </form>
</section>
</body>

</html>
