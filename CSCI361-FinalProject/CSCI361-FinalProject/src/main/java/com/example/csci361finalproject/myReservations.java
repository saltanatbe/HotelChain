package com.example.csci361finalproject;

import com.google.gson.Gson;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet(name = "my_reservations", value = "/my_reservations")
public class myReservations extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DB_connection wr = new DB_connection();
        List<Booking> bookings = wr.getBookingsGuestid(1);
        Gson gson = new Gson();
        String js = gson.toJson(bookings);
        System.out.println(js);
        PrintWriter out = response.getWriter();

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        out.print(js);
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("deleting      wda");

        String input1 = request.getParameter("check_in_date");
        DateTimeFormatter f = DateTimeFormatter.ofPattern( "uuuu-MM-dd" ) ;
        Date check_in_d = Date.valueOf( LocalDate.parse( input1 , f ) );

        String input2 = request.getParameter("check_out_date");
        Date check_out_d = Date.valueOf(LocalDate.parse( input2 , f ));

        int hotelid = Integer.parseInt(request.getParameter("hotel_choice"));

        String roomtype = request.getParameter("room_choice");
        Booking booking = new Booking(hotelid, roomtype, check_in_d, check_out_d, 1);
        System.out.println("b:     " + booking);
        DB_connection wr = new DB_connection();
        wr.deleteBooked(booking, 1);


    }
}
