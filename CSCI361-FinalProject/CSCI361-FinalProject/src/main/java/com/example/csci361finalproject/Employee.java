package com.example.csci361finalproject;

import java.sql.Date;

public class Employee {

    public String employee_name;
    public String day;
    public int num_hours;
    public String hotel_name;

    public Employee(){
        super();
    }

    public Employee(String employee_name, String day, int num_hours, String hotel_name){
        this.employee_name = employee_name;
        this.day = day;
        this.num_hours = num_hours;
        this.hotel_name = hotel_name;
    }

    public String getEmployee_name(){
        return employee_name;
    }

    public String getDay(){
        return day;
    }

    public int getNum_hours(){
        return num_hours;
    }

    public String getHotel_name(){
        return hotel_name;
    }

}
