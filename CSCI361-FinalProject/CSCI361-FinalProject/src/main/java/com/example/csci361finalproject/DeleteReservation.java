package com.example.csci361finalproject;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.time.*;
import java.sql.SQLException;
import java.time.format.DateTimeFormatter;
import java.util.List;

import com.google.gson.Gson;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.Objects;

@WebServlet(name = "/delete_reservation", value = "/delete_reservation")
public class DeleteReservation extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        getServletContext().getRequestDispatcher("/guest.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
        String input1 = request.getParameter("check_in_date");
        DateTimeFormatter f = DateTimeFormatter.ofPattern( "uuuu-MM-dd" ) ;
        Date check_in_d = Date.valueOf( LocalDate.parse( input1 , f ) );

        String input2 = request.getParameter("check_out_date");
        Date check_out_d = Date.valueOf(LocalDate.parse( input2 , f ));

        int hotelid = Integer.parseInt(request.getParameter("hotel_choice"));

        String roomtype = request.getParameter("room_choice");
        int guestid = Integer.parseInt(request.getParameter("guest_id"));
        Booking booking = new Booking(hotelid, roomtype, check_in_d, check_out_d, 1);
        System.out.println(booking);
        DB_connection wr = new DB_connection();
        boolean result = wr.deleteBooked(booking, guestid);
        System.out.println(result);
        Gson gson = new Gson();
        String res = gson.toJson(result);
        PrintWriter out = response.getWriter();

        response.setContentType("application/json");

        response.setCharacterEncoding("UTF-8");
        out.print(res);
        out.flush();
    }
}