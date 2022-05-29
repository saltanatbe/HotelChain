<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Manager profile</title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>

        $(function () {
            $("#show").on("click", function (e) {
                $.ajax({
                    url: 'kanager',
                    method: "GET",
                    datatype: "json",
                    success: function (r) {
                        $("#e_h").html("");
                        r.forEach(function (e) {
                            $("#e_h").append("<li>" + e.employee_name + " " + e.day + " " + e.num_hours + "</li>");
                        })

                    }
                })
            })
        })

        $(function () {
            $("#add_hours").on("click", function (e) {
                let name_a = $("#name").val();
                let date_a = $("#date").val();
                let hours_a = $("#hours").val();

                $.ajax({
                    url: 'kanager',
                    method: "POST",
                    data: {
                        employee_name: name_a,
                        day: date_a,
                        num_hours: hours_a,
                    },
                    datatype: "json",
                    success: function () {
                        alert("successful!");
                    }
                })
            })
        })
    </script>
</head>

<body class="manager">
<header class="project_holder">
    <div class="header_holder">
        <img class="header_logo" src="images/logo.png">
        <div style="font-size: 30px;">
            Hello, Dear Management
        </div>
        <nav class="nav_holder">
            <a class="nav_item" href="#">
                My Profile
            </a>
        </nav>
    </div>
</header>

<section class="manager_holder">
    <div class="manager_title">
        <div>Management profile</div>
    </div>
    <div class="manager_form">
        <div class="manager_subtitle">
            Adjust hours
        </div>
        <div class="manager_input">
            <p>name:<input type="text" id="name"></p>
            <p>date:<input type="date" id="date"></p>
            <p>hours:<input type="number" id="hours"></p>
            <button id="add_hours">Add!</button>
        </div>
        <div class="manager_subtitle">
            Employee work hours
        </div>
        <button id="show">Show schedule</button>
        <ul id="e_h"></ul>
    </div>
</section>
</body>

</html>