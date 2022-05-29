<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Guest</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        $(document).ready(function(){
            $("#search_btn").on("click", function(e){
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
                                " value=" + e + ">" + "<label for=" + id +">" + e + "</li>");
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
                    url:"guest_booking",
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
                        $("#bookings_select").append("<p>Success<p>");
                    }
                })
            })

            $("#delete_btn").on("click", function(e){
                let c_in = $("#check_in").val();
                let c_out = $("#check_out").val();
                let selected_h = $("#hotel_name").val();
                let room_type = $("#room_type").val();
                $.ajax({
                    url:'my_reservations',
                    method:"POST",
                    data:{
                        check_in_date:c_in,
                        check_out_date:c_out,
                        hotel_choice:selected_h,
                        room_choice:room_type,
                    },
                    datatype:"json",
                    success:function(r) {
                        $("#bookings_select").append("<p>Success<p>");
                    }

                })
            })
            /*$("#show").on("click", function(e){
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
            })*/
                $.ajax({
                    url:'my_reservations',
                    method:"GET",
                    datatype: "json",
                    success:function(r){
                        id2=15
                        $("#bookings_list").html("<tr><th>HotelId</th> <th>Check-in Date</th> <th>Check-out Date</th> <th>Room type</th> <th>Price</th></tr>")
                        r.forEach(function (e){
                            console.log(e);
                            $("#bookings_list").append("<tr id =" +id2+"' >" + "<label for=" + id2 +"> "
                                +"<td id='hotelid" + id2 +"'>"+e.hotelid+"</td><td id='c_in"+id2 +"'>"+e.c_in+"</td><td>"
                                +e.c_out+ "</td><td id='roomtype" +id2 + "'>" +e.roomtype+"</td><td>"+e.price+"</tr>");
                            id2 += 1;
                        })
                    }
                })


        var id = 1;






        })
    </script>
</head>
<body class="guest"> <!--Each guest has a unique guest id, also an
        identification type and number (e.g. US passport & number or driving license & number),
        an address and a home phone number and a mobile phone number. -->
<header class="project_holder">
    <div class="header_holder">
        <img class="header_logo" src="images/logo.png">
        <div style="font-size: 30px;">
            Hello, Dear Guest
        </div>
        <nav class="nav_holder">
            <a class="nav_item" href="#">
                My Profile
            </a>
        </nav>
    </div>
</header>
<section class="guest_holder">
    <div class="guest_left">
        <div class="guest_profile">
            <form class="guest_form_holder" method="post" action="update_profile"> <!--SEVERAL POSTS???????????-->
                <table style="width:100%; height: 100%;">
                    <tr>
                        <td>Guest ID</td>
                    </tr>
                    <tr>
                        <td>${login.guestid}</td>
                    </tr>
                    <tr>
                        <td>IDENTIFICATION TYPE</td>
                    </tr>
                    <tr>
                        <td>
                            <select name="id_type">
                                <option value="passport">passport</option>
                                <option value="driving license">driving license</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>ID Number
                        </td>
                    </tr>
                    <tr>
                        <td><input type="int" value ="${login.getIdnumber()}" name="idnumber"  style="width:100%;"></td>
                    </tr>
                    <tr>
                        <td>Address</td>
                    </tr>
                    <tr>
                        <td><input type="text" name="address" value="${login.getAddress()}"style="width:100%;"></td>
                    </tr>
                    <tr>
                        <td>Home Phone Number</td>
                    </tr>
                    <tr>
                        <td><input type="tel" name="homenumber" value ="${login.getHomenumber()}" style="width:100%;"></td>
                    </tr>
                    <tr>
                        <td>Mobile Phone Number</td>
                    </tr>
                    <tr>
                        <td><input type="tel" name="mobilenumber" value="${login.getMobilenumber()}" style="width:100%;"></td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                    <tr>
                        <td><button id="update"> Update Profile </button></td>
                    </tr>
                </table>
            </form>
        </div>
        <div class="guest_bookings">
            <div class="guest_bookings_title">
                Your Bookings:
                <ol id="my_bookings">

                </ol>
                <p id="bookings_delete"></p>
            </div>
            <ol class="bookings_list" id="bookings_list">
                <li>some booking</li>
            </ol>
        </div>
    </div>
    <div class="guest_book">
        <div class="guest_book_title">
            Book Your Next Visit
        </div>
        <div class="booking_form">
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
            <button id="search_btn" type="button"> Search</button>
            <button id="delete_btn" type="button"> Delete</button>
        </div>
        <div id="bookings_select" class="available_bookings">
            <ol id="booking_items" style="padding: 20px;">
                <li>

                </li>
            </ol>
            <button id="book_btn" style="display:none;">Book</button>
        </div>
    </div>
</section>

</body>
</html>