<%--
  Created by IntelliJ IDEA.
  User: akadilkalimoldayev
  Date: 07.12.2021
  Time: 00:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registration</title>
</head>
<body>
    <form action="web_registration" method="post">
        <table>
            <tr>
                <td>User Name</td>
                <td><input type="text" name="uname"></td>
            </tr>
            <tr>
                <td>Password</td>
                <td><input type="text" name="password"></td>
            </tr>
            <tr>
                <td></td>
                <td><input type="submit" name="register"></td>
            </tr>
        </table>
    </form>
</body>
</html>
