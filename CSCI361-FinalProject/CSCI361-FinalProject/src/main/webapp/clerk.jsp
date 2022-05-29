<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Desk Clerk</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        $(document).ready(function(){

            $("#create").on("click", function(e){
                let c_in = $("#check_in").val();
                let c_out = $("#check_out").val();
                let selected_h = $("#hotel_name").val();
                let room_type = $("#room_type").val();
                let see_available_bookings = "true";

                $.ajax({
                    url:'guest_booking',
                    method:"POST",
                    data:{
                        check_in_date:c_in,
                        check_out_date:c_out,
                        hotel_choice:selected_h,
                        room_choice:room_type,
                        see_available_bookings:see_available_bookings
                    },
                    datatype:"json",
                    success:function(r) {
                        id=1;
                        $("#booking_items").html("")
                        r.forEach(function (e){
                            $("#booking_items").append("<li> <input type='radio' name='book_option' id ="+ id +
                                " value=" + e + ">" + "<label for=" + id +">" + e + " Clean</li>");
                            id += 1;
                        })
                        $("#book_btn").show();
                    }

                })
            })
            $("#book_btn").on("click", function(){
                let c_in = $("#check_in").val();
                let c_out = $("#check_out").val();
                let selected_h = $("#hotel_name").val();
                let room_no = $("input[type='radio'][name='book_option']:checked").val();
                let room_type = $("#room_type").val();
                let make_book = "true";
                $.ajax({
                    url:"create_reservation",
                    method:"POST",
                    data:{
                        room_no:room_no,
                        make_book:make_book,
                        check_in_date:c_in,
                        check_out_date:c_out,
                        hotel_choice:selected_h,
                        room_choice:room_type,
                    },
                    success:function(){
                        $("#available_bookings").append("<p>Success<p>");
                    }
                })
            })

            $("#delete").on("click", function(e){
                let g_id = $("#guestid").val();
                let c_in = $("#check_in").val();
                let c_out = $("#check_out").val();
                let selected_h = $("#hotel_name").val();
                let room_type = $("#room_type").val();
                $.ajax({
                    url:'delete_reservation',
                    method:"POST",
                    data:{
                        check_in_date:c_in,
                        check_out_date:c_out,
                        hotel_choice:selected_h,
                        room_choice:room_type,
                        guest_id:g_id
                    },
                    datatype:"json",
                    success:function(r) {
                        if(r)
                            $("#booking_items").html("<div>You successfully deleted reservation</div>")
                        else
                            $("#booking_items").html("<div>There is no such reservation to delete</div>")
                    }

                })
            })
            $("#change").on("click", function(e){
                let g_id = $("#guestid").val();
                let c_in = $("#check_in").val();
                let c_out = $("#check_out").val();
                let selected_h = $("#hotel_name").val();
                let room_type = $("#room_type").val();
                let c_in2 = $("#check_in2").val();
                let c_out2 = $("#check_out2").val();
                let selected_h2 = $("#hotel_name2").val();
                let room_type2 = $("#room_type2").val();
                $.ajax({
                    url:'change_reservation',
                    method:"POST",
                    data:{
                        check_in_date:c_in,
                        check_out_date:c_out,
                        hotel_choice:selected_h,
                        room_choice:room_type,
                        guest_id:g_id,
                        check_in_date2:c_in2,
                        check_out_date2:c_out2,
                        hotel_choice2:selected_h2,
                        room_choice2:room_type2
                    },
                    datatype:"json",
                    success:function(r) {
                        if(r)
                            $("#booking_items").html("<div>You successfully changed reservation</div>")
                        else
                            $("#booking_items").html("<div>There is no such reservation to change</div>")
                    }

                })
            })
            $("#show").on("click", function(e){
                $.ajax({
                    url:'create_reservation',
                    method:"GET",
                    datatype:"json",
                    success:function(r){
                        console.log("Success!");
                        $("#bookings_list").html("<tr><th>GuestId</th> <th>HotelId</th> <th>Check-in Date</th> <th>Check-out Date</th> <th>Room type</th> <th>Price</th></tr>");
                        r.forEach(function(e){
                            $("#bookings_list").append("<tr><th>"+e.guestid+"</th><th>"+e.hotelid+"</th><th>"+e.c_in+"</th><th>"+e.c_out+ "</th><th>"+e.roomtype+"</th><th>"+e.price+"</tr>");
                        })
                    }
                })
            })
        })
    </script>
</head>
<body class="clerk">
<header class="project_holder">
    <div class="header_holder">
        <img class="header_logo" src="images/logo.png">
        <div style="font-size: 30px;">
            Hello, Dear Clerk
        </div>
        <nav class="nav_holder">
            <a class="nav_item" href="#">
                My Profile
            </a>
        </nav>
    </div>
</header>
<section class="clerk_holder">
    <div class="clerk_left">
        <div class="clerk_title">
            Guest Bookings
        </div>
        <button id = "show" type = "button">
            Show all bookings
        </button>
        <table id="bookings_list">

        </table>
    </div>
    <div class="clerk_functions">
        <div class="clerk_functions_title">
            Managing System
        </div>
        <div class="functionalities_holder">
            Some functionalities
        </div>
        <div style="padding-left:20px; font-size:30px">Existing reservation:</div>
        <div style="padding-left:20px;">
            <div style="font-size:20px">GuestId</div>
            <input  id="guestid" name="guest_id" type="text">
        </div>
        <div class ="booking_form">
            <div>Check-in Date</div>
            <input id="check_in" class="booking_input" name="check_in_date" type="date">
            <div>Check-out Date</div>
            <input id="check_out" class="booking_input" name="check_out_date" type="date">
            <select id="hotel_name" name="hotel_choice">
                <option value="1">1</option>
                <option value="2">2</option>
            </select>
            <select id="room_type" name="room_choice">
                <option value="single">single</option>
                <option value="double">double</option>
            </select>
        </div>
        <div style="padding-left:20px;">
            <button id = "create" type = "button">Create reservation</button>
            <button id = "delete" type = "button">Delete reservation</button>
        </div>
        <div style="padding-left:20px; font-size:30px">New reservation if you want to change it:</div>
        <div class="booking_form">
            <div>Check-in Date</div>
            <input id="check_in2" class="booking_input" name="check_in_date2" type="date">
            <div>Check-out Date</div>
            <input id="check_out2" class="booking_input" name="check_out_date2" type="date">
            <select id="hotel_name2" name="hotel_choice2">
                <option value="1">1</option>
                <option value="2">2</option>
            </select>
            <select id="room_type2" name="room_choice2">
                <option value="single">single</option>
                <option value="double">double</option>
            </select>
        </div>
        <div style="padding-left:20px;">
            <button id = "change" type = "button">Change reservation</button>
        </div>
        <div class="available_bookings" id="available_bookings">
            <ol id="booking_items" style="padding: 20px;">
            </ol>
            <button id="book_btn" style="display:none;">Book</button>
        </div>
    </div>
</section>
</body>
</html>