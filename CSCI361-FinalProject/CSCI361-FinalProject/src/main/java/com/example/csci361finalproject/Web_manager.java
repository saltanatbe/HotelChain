package com.example.csci361finalproject;

import com.google.gson.Gson;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

import java.io.PrintWriter;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;
import java.util.concurrent.CopyOnWriteArrayList;

@WebServlet(name = "kanager", value = "/kanager")
public class Web_manager extends HttpServlet {


    private static final String db_url = "jdbc:postgresql://localhost/postgres";
    private static final String db_username = "postgres";
    private static final String db_password = "12345";
    private ResultSet rs;

    //private List<Employee> list = new CopyOnWriteArrayList<>();

    public Connection connect() {
        System.out.println("I was here motherfucker aasd");
        Connection con=null;
        System.out.println("I was here motherfucker a");
        try{
            Class.forName("org.postgresql.Driver");
        }catch(ClassNotFoundException e){
            e.printStackTrace();
            System.out.println(e.getMessage() + " error1");
        }
        System.out.println("I was here motherfucker b");
        try{
            con = DriverManager.getConnection(db_url, db_username, db_password);
        } catch(SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage() + " error2");
        }
        System.out.println("I was here motherfucker c");
        return con;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Show all available employees
        System.out.println("I was here motherfucker 1511316");

        Gson gson = new Gson();
        System.out.println("I was here motherfucker 1511316sssss");
        List<Employee> list = new CopyOnWriteArrayList<>();


        DB_connection db = new DB_connection();
        Connection con = db.connect();
        String query = "select employee_name, day, num_hours from employee where hotel_name='hotel_1'";
        try{
            PreparedStatement ps = con.prepareStatement(query);
            this.rs = ps.executeQuery();
            SimpleDateFormat format = new SimpleDateFormat("MMM dd,yyyy ", Locale.US);
            while(this.rs.next()){
                list.add(new Employee(this.rs.getString("employee_name"),
                                      format.format(this.rs.getDate("day")),
                                      this.rs.getInt("num_hours"),
                                      "hotel_1"));
            }


            String res = gson.toJson(list);
            System.out.println(res);
            PrintWriter out = response.getWriter();

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            out.print(res);
            out.flush();
        }catch(SQLException e){
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DB_connection db = new DB_connection();
        Connection con = db.connect();
        String query = "insert into employee values(?, ?, ?, 'hotel_1')";

        String input1 = request.getParameter("day");
        DateTimeFormatter f = DateTimeFormatter.ofPattern("uuuu-MM-dd");
        Date day = Date.valueOf(LocalDate.parse(input1, f));

        String employee_name = request.getParameter("employee_name");

        int num_hours = Integer.parseInt(request.getParameter("num_hours"));

        try{
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, employee_name);
            ps.setDate(2, day);
            ps.setInt(3, num_hours);
            ps.executeUpdate();
        }catch(SQLException e){
            e.printStackTrace();
        }
    }

    //@Override
    //protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    //}
}
