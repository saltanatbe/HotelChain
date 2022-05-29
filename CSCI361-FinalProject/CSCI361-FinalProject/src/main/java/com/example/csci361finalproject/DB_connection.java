package com.example.csci361finalproject;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;
import java.util.concurrent.CopyOnWriteArrayList;


public class DB_connection {
    private static final String db_url = "jdbc:postgresql://localhost/postgres";
    private static final String db_username = "postgres";
    private static final String db_password = "12345";
    private ResultSet rs;


        public Connection connect() {
            Connection con=null;
            try{
                Class.forName("org.postgresql.Driver");
            }catch(ClassNotFoundException e){
                e.printStackTrace();
                System.out.println(e.getMessage() + " error1");
            }

            try{
                con = DriverManager.getConnection(db_url, db_username, db_password);
                System.out.println("Connected to database successfully :)");
            } catch(SQLException e) {
                e.printStackTrace();
                System.out.println(e.getMessage() + " error2");
            }
            return con;
        }

        public String insert(Member member){
            Connection con = this.connect();
            String result = "Data entered succesfully";
            String query = "insert into member values(?,?,?)";
            System.out.println(member.getUname());
            try{
                PreparedStatement ps = con.prepareStatement(query);
                ps.setString(1, member.getUname());
                ps.setString(2, member.getPassword());
                ps.setString(3, "guest");
                ps.executeUpdate();
            }catch(SQLException e){
                e.printStackTrace();
                result="Data not entered";
            }
            return result;
        }

        public String check_login_password(Member member){
            Connection con = this.connect();
            String query = "select position from member where username=? and password=?";
            String answer = "exists";

            try{
                PreparedStatement ps = con.prepareStatement(query);
                ps.setString(1, member.getUname());
                ps.setString(2, member.getPassword());
                this.rs = ps.executeQuery();
                if(!this.rs.next()){
                    answer = "not exists query";
                }else {
                    answer = rs.getString("position");
                }
            }catch(SQLException e){
                e.printStackTrace();
                answer = "not exists exception";
            }
            return answer;
        }

    public int getPrice(Date checkin,Date checkout, int hotelid, String roomtype) {
        int price = 0, result =0;
        Calendar start = Calendar.getInstance();
        start.setTime(checkin);
        Calendar end = Calendar.getInstance();
        end.setTime(checkout);
        Connection con = this.connect();
        String query = "select price from price_on_day where hotelid=? and roomtype=? and weekday=?";
        System.out.println("Before entering the loop");
        for(;start.before(end); start.add(Calendar.DATE, 1)) {
            int weekDay = start.get(Calendar.DAY_OF_WEEK);
            try {
                PreparedStatement ps = con.prepareStatement(query);
                ps.setInt(1, hotelid);
                ps.setString(2, roomtype);
                ps.setInt(3, weekDay);
                this.rs = ps.executeQuery();
                if(!this.rs.next()){
                    System.out.println("Stuck on the next()!");
                }else {
                    price = rs.getInt("price");
                }
            }catch(SQLException e){
                e.printStackTrace();
                System.out.println("Could not find the price on given day");
            }
            result = result + price;
        }

        return result;
    }

    public List<String> findifbooking(Booking booking){
        Connection con = this.connect();
        String query = "select r.roomnumber from rooms r where ?=r.hotelid and ?=r.roomtype and  r.roomnumber not in " +
                "(select b.roomnumber from reservation b where ?=b.hotelid and ?=b.roomtype and " +
                "( (?>b.checkin and ?<b.checkout) or (?>b.checkin and ?<b.checkout) or "+
                "(?>b.checkin and ?<b.checkin) or (?>b.checkout and ?<b.checkout)))";

        List<String> answer =new ArrayList<String>();

        int price = getPrice(booking.getCheckin(),booking.getCheckout(),booking.getHotelid(),booking.getRoomtype());
        System.out.println("Here is a price: " + price);
        try{
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, booking.getHotelid());
            ps.setString(2, booking.getRoomtype());
            ps.setInt(3, booking.getHotelid());
            ps.setString(4, booking.getRoomtype());
            ps.setDate(5, booking.getCheckin());
            ps.setDate(6, booking.getCheckin());
            ps.setDate(7, booking.getCheckout());
            ps.setDate(8, booking.getCheckout());
            ps.setDate(9, booking.getCheckout());
            ps.setDate(10, booking.getCheckin());
            ps.setDate(11, booking.getCheckout());
            ps.setDate(12, booking.getCheckin());

            this.rs = ps.executeQuery();
            while(this.rs.next()){
                answer.add(rs.getString(1)+" $"+price);
            }
        }catch(SQLException e){
            e.printStackTrace();
            answer.add("There are no available rooms\n Sorry!");
        }
        return answer;
    }


        public boolean deleteBooked(Booking booking, int guestid){
            Connection con = this.connect();
            String query = "delete from reservation r where r.hotelid=? and r.roomtype=? and r.guestid=? and r.checkin=? and r.checkout=?";
            System.out.println("I am on delete function");
            try{
                PreparedStatement ps = con.prepareStatement(query);
                ps.setInt(1, booking.getHotelid());
                ps.setString(2, booking.getRoomtype());
                ps.setInt(3, guestid);
                ps.setDate(4, booking.getCheckin());
                ps.setDate(5, booking.getCheckout());

                ps.executeQuery();

            }catch(SQLException e){
                e.printStackTrace();
                System.out.println(e);
                System.out.println("There are no available rooms \nSorry!");
                return false;
            }
            return true;
        }


        public boolean changeBooked(Booking booking, Booking booking2, int guestid){
            Connection con = this.connect();
            String query = "update reservation set hotelid=?, roomtype=?, guestid=?, checkin=?, checkout=? where hotelid=? and roomtype=? and guestid=? and checkin=? and checkout=?";

            boolean answer = true;
            try{
                PreparedStatement ps = con.prepareStatement(query);
                ps.setInt(1, booking2.getHotelid());
                ps.setString(2, booking2.getRoomtype());
                ps.setInt(3, guestid);
                ps.setDate(4, booking2.getCheckin());
                ps.setDate(5, booking2.getCheckout());
                ps.setInt(6, booking.getHotelid());
                ps.setString(7, booking.getRoomtype());
                ps.setInt(8, guestid);
                ps.setDate(9, booking.getCheckin());
                ps.setDate(10, booking.getCheckout());

                ps.execute();

            }catch(SQLException e){
                e.printStackTrace();
                System.out.println("Could not change the reservation!");
                answer = false;
            }
            return answer;
        }


    public List<Booking> getBookingsGuestid(Integer guestid){
        Connection con = this.connect();
        String query = "select * from reservation where guestid=?";


        List<Booking> answer =new ArrayList<Booking>();
        try{
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, guestid);

            this.rs = ps.executeQuery();
            SimpleDateFormat format = new SimpleDateFormat("MMM dd,yyyy ", Locale.US);
            while(this.rs.next()){

                //int price = getPrice( rs.getDate("checkin"),rs.getDate("checkout"),rs.getInt("hotelid"),rs.getString("roomtype"));
                answer.add(new Booking(rs.getInt("hotelid"),
                        rs.getString("roomtype"),
                        format.format(this.rs.getDate("checkin")),
                        format.format(this.rs.getDate("checkout")), rs.getInt("guestid"), rs.getInt("price")
                        ));
                answer.get(0).setRoomnumber(rs.getInt("roomnumber"));
            }
        }catch(SQLException e){
            e.printStackTrace();
            System.out.println("There are no bookings\n Sorry!");
        }
        if (!answer.isEmpty()){
            Booking booking = answer.get(0);
        }

        return answer;
    }



    public Guest getGuest(String email){
            System.out.println(email);
        Connection con = this.connect();
        String query = "select g.guestid, g.homenumber,g.mobilenumber, g.idnumber, " +
                "g.name, g.surname, g.address, g.identification from guest g where g.email=?";


        List<Guest> guest = new ArrayList<Guest>();
        try{
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            this.rs = ps.executeQuery();
            while(this.rs.next()){
                guest.add(new Guest(rs.getInt("guestid"),
                        rs.getInt("homenumber"),rs.getLong("mobilenumber"),
                        rs.getInt("idnumber"), email,
                        rs.getString("name"), rs.getString("surname"),
                        rs.getString("address"), rs.getString("identification") ));
            }

        }catch(SQLException e){
            e.printStackTrace();
            System.out.println("\n Sorry!");
        }
        return guest.get(0);
    }

    public void updateGuest(int guestid, long mobilenumber, int homenumber, int idnumber, String address,String identification){
        Connection con = this.connect();
        String query = "update guest set mobilenumber=?, homenumber=?, idnumber=?, address=?, identification=?  where guestid=?";

        try{
            PreparedStatement ps = con.prepareStatement(query);
            ps.setLong(1, mobilenumber);
            ps.setInt(2,homenumber);
            ps.setInt(3,idnumber);
            ps.setString(4, address);
            ps.setString(5, identification);

            ps.setInt(6, guestid);
            ps.executeUpdate();
        }catch(SQLException e){
            e.printStackTrace();
            System.out.println("\n SoSoSorry!");
        }
    }

    public void addnewbooking(Booking booking){
        Connection con = this.connect();
        int price = getPrice(booking.getCheckin(),booking.getCheckout(),booking.getHotelid(),booking.getRoomtype());
        String query = "insert into reservation (hotelid, roomnumber, guestid, roomtype, checkin, checkout, price)" +
                "values (?,?,1,?,?,?,?)";

        try{
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, booking.getHotelid());
            ps.setInt(2, booking.getRoomnumber());
            ps.setString(3, booking.getRoomtype());
            ps.setDate(4, booking.getCheckin());
            ps.setDate(5, booking.getCheckout());
            ps.setInt(6,price);


            ps.execute();

        }catch(SQLException e){
            e.printStackTrace();
        }
    }
    public List <Booking> showAllBookings (){
        Connection con = this.connect();
        String query = "select* from reservation";
        List<Booking> list = new CopyOnWriteArrayList<Booking>();
        try{
            PreparedStatement ps = con.prepareStatement(query);
            this.rs = ps.executeQuery();
            SimpleDateFormat format = new SimpleDateFormat("MMM dd,yyyy ", Locale.US);
            while(this.rs.next()){
                list.add(new Booking(this.rs.getInt("hotelid"),
                        this.rs.getString("roomtype"),
                        format.format(this.rs.getDate("checkin")),
                        format.format(this.rs.getDate("checkout")),
                        this.rs.getInt("guestid"),
                        this.rs.getInt("price")));
            }

        }catch(SQLException e) {
            e.printStackTrace();
            System.out.println("Error with printing all bookings");
        }
        return list;
    }

}