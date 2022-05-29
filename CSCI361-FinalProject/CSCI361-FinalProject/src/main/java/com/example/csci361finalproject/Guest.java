package com.example.csci361finalproject;

import java.math.BigInteger;

public class Guest {
    private int guestid, homenumber, idnumber;
    private long mobilenumber;
    private String email, name, surname, address, identification;


    Guest(int guestid, int homenumber, long mobilenumber, int idnumber,
          String email, String name, String surname, String address, String idetification){
        super();
        this.email = email;
        this.guestid = guestid;
        this.homenumber = homenumber;
        this.mobilenumber = mobilenumber;
        this.identification = idetification;
        this.idnumber = idnumber;
        this.name = name;
        this.surname = surname;
        this.address = address;
    }

    public int getIdnumber() {
        return idnumber;
    }

    public long getMobilenumber() {
        return mobilenumber;
    }

    public int getHomenumber() {
        return homenumber;
    }

    public String getAddress() {
        return address;
    }

    public int getGuestid() {
        return guestid;
    }

    public String getEmail() {
        return email;
    }

    public String getIdentification() {
        return identification;
    }

    public String getName() {
        return name;
    }

}
