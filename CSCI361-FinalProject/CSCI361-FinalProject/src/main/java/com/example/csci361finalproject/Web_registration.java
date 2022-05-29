package com.example.csci361finalproject;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.Objects;

@WebServlet(name = "web_registration", value = "/web_registration")
public class Web_registration extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("registration.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uname = request.getParameter("uname");
        String password = request.getParameter("password");

        Member member = new Member(uname, password);

        DB_connection wr = new DB_connection();
        String result = wr.insert(member);

        System.out.println(result);

        if(Objects.equals(result, "Data entered succesfully")){
            response.sendRedirect("guest.jsp");
        }else{
            response.getWriter().print(result);
        }
    }
}
