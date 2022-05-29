package com.example.csci361finalproject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "/update_profile", value = "/update_profile")
public class update_profile extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("22");

        String identification = request.getParameter("id_type");

        int homenumber = Integer.parseInt(request.getParameter("homenumber"));

        long mobilenumber = Long.parseLong(request.getParameter("mobilenumber"));

        int idnumber = Integer.parseInt(request.getParameter("idnumber"));
        //System.out.println(idnumber);
        String address = request.getParameter("address");

        //Object o = request.getSession().getAttribute("login");
        DB_connection wr = new DB_connection();
        wr.updateGuest(1, mobilenumber, homenumber, idnumber, address, identification);
        response.sendRedirect("/success.jsp");
    }
}
