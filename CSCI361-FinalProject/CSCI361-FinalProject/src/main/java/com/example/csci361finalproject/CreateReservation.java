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
import java.util.concurrent.CopyOnWriteArrayList;

@WebServlet(name = "/create_reservation", value = "/create_reservation")
public class CreateReservation extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Show all available employees
//        System.out.println("I was here motherfucker 1511316");

        Gson gson = new Gson();
//        System.out.println("I was here motherfucker 1511316sssss");
        List<Booking> list = new CopyOnWriteArrayList<Booking>();

        DB_connection wr = new DB_connection();
        list = wr.showAllBookings();
        
        String res = gson.toJson(list);
        System.out.println(res);
        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        out.print(res);
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	String see_av_book = request.getParameter("see_available_bookings");
        String make_book = request.getParameter("make_book");
        String input1;
        String input2;
        int hotelid;
        String roomtype;
        int room_no;

        if (see_av_book != null) {
            System.out.println("1st");
            input1 = request.getParameter("check_in_date");
            DateTimeFormatter f = DateTimeFormatter.ofPattern("uuuu-MM-dd");
            Date check_in_d = Date.valueOf(LocalDate.parse(input1, f));

            input2 = request.getParameter("check_out_date");
            Date check_out_d = Date.valueOf(LocalDate.parse(input2, f));

            hotelid = Integer.parseInt(request.getParameter("hotel_choice"));

            roomtype = request.getParameter("room_choice");

            Booking booking = new Booking(hotelid, roomtype, check_in_d, check_out_d);
            System.out.println(booking);
            DB_connection wr = new DB_connection();
            List<String> result = wr.findifbooking(booking);
            System.out.println(result);

            Gson gson = new Gson();
            String res = gson.toJson(result);

            PrintWriter out = response.getWriter();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            out.print(res);
            out.flush();
        }

        if (make_book != null){
            input1 = request.getParameter("check_in_date");
            input2 = request.getParameter("check_out_date");
            hotelid = Integer.parseInt(request.getParameter("hotel_choice"));
            roomtype = request.getParameter("room_choice");
            room_no = Integer.parseInt(request.getParameter("room_no"));

            DateTimeFormatter f = DateTimeFormatter.ofPattern("uuuu-MM-dd");
            Date check_in_d = Date.valueOf(LocalDate.parse(input1, f));
            Date check_out_d = Date.valueOf(LocalDate.parse(input2, f));

            Booking booking = new Booking(hotelid, room_no, 1, roomtype, check_in_d, check_out_d);
            DB_connection wr = new DB_connection();
            wr.addnewbooking(booking);
            System.out.println("NICE");
        }
    }
}