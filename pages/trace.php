<!DOCTYPE html>
<html>

<head>
  <title>Traceability System - D3</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!--===============================================================================================-->
  <link rel="icon" type="image/png" href="../images/icons/favicon.ico" />
  <!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="../vendor/bootstrap/css/bootstrap.min.css">
  <!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="../fonts/font-awesome-4.7.0/css/font-awesome.min.css">
  <!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="../fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
  <!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="../vendor/animate/animate.css">
  <!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="../vendor/css-hamburgers/hamburgers.min.css">
  <!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="../vendor/animsition/css/animsition.min.css">
  <!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="../vendor/select2/select2.min.css">
  <!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="../vendor/daterangepicker/daterangepicker.css">
  <!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="../css/util.css">
  <link rel="stylesheet" type="text/css" href="../css/main.css">
  <!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="../css/styles.css">
  <link rel="stylesheet" type="text/css" href="../css/animated-menu.css">
  <!--===============================================================================================-->
  <script src="https://d3js.org/d3.v5.min.js" charset="utf-8"></script>
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script><!-- Load icon library -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <!--===============================================================================================-->
  <script>
    $(document).ready(function(){
        var base_url = window.origin;
        document.getElementById("username").innerHTML = sessionStorage.getItem("username") + " | ";

        $('#logoutform').submit(function (e) {
            localStorage.clear();
            window.location.replace(base_url + "KGP_Test/d3_prototype/pages/home.php");
        });
    });        
  </script>
</head>

<body>
  <div class="header">
    <label class="header-label" style="display: inline;">Traceability System - D3</label>
    <g style="right: 2%; font-size: 1em; color: white; position: absolute;">
        <label class="header-label" style="display: inline;" id="username"></label>
        <form id="logoutform" method="post" action=".." style="display: inline;">
            <label style="display: inline;">
                <input class="header-label" name="logoutBtn" type="submit" id="logoutBtn" value="Sign Out"
                    style="background-color: #24292e;
                    border: none;
                    color: rgba(255, 67, 54, 1);
                    text-decoration: none;
                    cursor: pointer;">
            </label>
        </form>
    </g>
  </div>
  <div id="filter" class="filterPanel">
    <form>
      <label class="labelStyle">Product</label>
      <input type="text" id="1" placeholder="Product" />
      <button type="submit"><i class="fa fa-search"></i></button>
    </form>
  </div>
  <svg id="viz"></svg>
  <script src="../js/d3_force.js"></script>
</body>

</html>