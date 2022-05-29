package com.example.csci361finalproject;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import java.util.Objects;

@WebServlet(name = "loginCheck", value = "/loginCheck")
public class LoginCheck extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uname = request.getParameter("uname");
        String password = request.getParameter("password");
        System.out.println(uname);
        Member member = new Member(uname, password);

        DB_connection wr = new DB_connection();
        String result = wr.check_login_password(member);

        if(Objects.equals(result, "guest")){
            Guest guest = wr.getGuest(uname);
            List<Booking> bookings=  wr.getBookingsGuestid(guest.getGuestid());
            request.setAttribute("bookings", bookings);
            request.setAttribute("login", guest);
            String requestVar = request.getParameter("/test");
            request.setAttribute("user", requestVar);
            RequestDispatcher dispatch = request.getRequestDispatcher("/guest.jsp");
            dispatch.forward(request, response);
        }else if(Objects.equals(result, "manager")){
            response.sendRedirect("kanager.jsp");
        }else if(Objects.equals(result, "clerk")){
            response.sendRedirect("clerk.jsp");
        }
        else{

            response.getWriter().print(result);
        }


        ///////////
        //request.getSession().setAttribute("user", member);
        //request.getRequestDispatcher("guest_booking").forward(request, response);
       /* request.setAttribute("uname", uname);
        forward the request to Servlet2
        RequestDispatcher reqDispatcher = request.getRequestDispatcher("/guest_booking");
        reqDispatcher.forward(request, res);*/
    }
}