package com.example.csci361finalproject;

public class Hotels {
    public  int hotelid;
    public String hotelname, address;

    public Hotels(){
        super();
    }
    public Hotels(int hotelid, String hotelname, String address){
        super();
        this.hotelid = hotelid;
        this.hotelname = hotelname;
        this.address = address;
    }


    public int getHotelid() {
        return hotelid;
    }

    public String getAddress() {
        return address;
    }

    public String getHotelname() {
        return hotelname;
    }

}
