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

@WebServlet(name = "/change_reservation", value = "/change_reservation")
public class ChangeReservation extends HttpServlet {
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
        
        String input21 = request.getParameter("check_in_date2");
        Date check_in_d2 = Date.valueOf( LocalDate.parse( input21 , f ) );
        String input22 = request.getParameter("check_out_date2");
        Date check_out_d2 = Date.valueOf(LocalDate.parse( input22 , f ));
        int hotelid2 = Integer.parseInt(request.getParameter("hotel_choice2"));
        String roomtype2 = request.getParameter("room_choice2");
        
        int guestid = Integer.parseInt(request.getParameter("guest_id"));
        Booking booking = new Booking(hotelid, roomtype, check_in_d, check_out_d,1);
        Booking booking2 = new Booking(hotelid2, roomtype2, check_in_d2, check_out_d2,1);
        DB_connection wr = new DB_connection();
        boolean result = wr.changeBooked(booking, booking2, guestid);
        System.out.println(result);
        
        Gson gson = new Gson();
        System.out.println(result);
        String res = gson.toJson(result);
        System.out.println(result);

        PrintWriter out = response.getWriter();

        response.setContentType("application/json");

        response.setCharacterEncoding("UTF-8");
        out.print(res);
        System.out.println(res);
        out.flush();
    }
}