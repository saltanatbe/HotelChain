package com.example.csci361finalproject;

import java.sql.Date;

public class Booking {
    public String hotelname, roomtype, c_in, c_out;
    private Date checkin, checkout;
    private int hotelid, guestid, roomnumber;
    private int price;

    public Booking( int hotelid, String roomtype, Date checkin, Date checkout){
        super();
        this.hotelid = hotelid;
        this.roomtype = roomtype;
        this.checkin = checkin;
        this.checkout = checkout;
    }

    public Booking( int hotelid, int roomnumber, int guestid, String roomtype, Date checkin, Date checkout){
        super();
        this.roomnumber=roomnumber;
        this.guestid=guestid;
        this.hotelid = hotelid;
        this.roomtype = roomtype;
        this.checkin = checkin;
        this.checkout = checkout;
    }
    public Booking( int hotelid, String roomtype, Date checkin, Date checkout, int guestid){
        super();
        this.hotelid = hotelid;
        this.roomtype = roomtype;
        this.checkin = checkin;
        this.checkout = checkout;
        this.guestid = guestid;
    }
    public Booking( int hotelid, String roomtype, String checkin, String checkout, int guestid, int price){
        super();
        this.hotelid = hotelid;
        this.roomtype = roomtype;
        this.c_in = checkin;
        this.c_out = checkout;
        this.guestid = guestid;
        this.price = price;
    }


    public String getRoomtype() {
        return roomtype;
    }

    public Date getCheckin() {
        return checkin;
    }

    public Date getCheckout() {
        return checkout;
    }

    public int getGuestid() {
        return guestid;
    }

    public int getRoomnumber() {
        return roomnumber;
    }

    public String getHotelname() {
        return hotelname;
    }

    public void setCheckout(Date checkout) {
        this.checkout = checkout;
    }

    public void setRoomnumber(int roomnumber) {
        this.roomnumber = roomnumber;
    }

    public int getHotelid() {
        return hotelid;
    }
}
