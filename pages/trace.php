<!DOCTYPE html>
<html lang="en">

<head>
    <title>Traceability System Home</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--===============================================================================================-->
    <link rel="icon" type="image/png" href="../images/icons/favicon.ico" />
    <!-- Font Awesome icons (free version)-->
    <script src="../js/all.min.js" crossorigin="anonymous"></script>
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="../css/animated-menu.css">
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
    <!--===============================================================================================-->
    <script src="../vendor/jquery/jquery-3.2.1.min.js"></script>
    <script src="../js/d3_v5.js" charset="utf-8"></script>
    <script>
        $(document).ready(function(){
            var base_url = window.origin;
            document.getElementById("username").innerHTML = "Hello, " + sessionStorage.getItem("username");

            $('#signout').click(function (e) {
                sessionStorage.clear();
                window.location.replace(base_url + "/KGP_Test/d3_prototype/");
            });
        });
    </script>
    <!--===============================================================================================-->
    <style>
        .flex-container {
            --link-size: calc(var(--base-grid)*20);
            color: var(--colour-black);
            display: flex;
            flex-direction: row;
            flex-wrap: wrap;
            flex-shrink: 3;
            flex-basis: auto;
            justify-content: center;
            position: relative;
            width: auto;
            min-width: 100%;
            align-items: center;
            align-content: center;
        }
        .flex-container > div {
            /* background-color: #f1f1f1; */
            width: var(--link-size);
            height: var(--link-size);
            margin: 5px 7px;
        }
        svg {
            width: 100%;
            height: 300px;
        }
        .node {
            pointer-events: all;
            cursor: pointer;
            z-index: 1000;
        }
        .node text {
            font: 8px sans-serif;
        }
    </style>
</head>

<body id="page-top">
    <nav class="navbar navbar-expand-lg bg-secondary fixed-top" id="mainNav" style="border-bottom: solid; border-bottom-color: #00be71; position: relative;">
        <div class="container"><a class="navbar-brand js-scroll-trigger" href="#page-top" style="color: #31a073;">Traceability System</a>
            <button class="navbar-toggler navbar-toggler-right font-weight-bold bg-primary text-white rounded" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">Menu <i class="fas fa-bars"></i></button>
            <div class="collapse navbar-collapse" id="navbarResponsive">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item mx-0 mx-lg-1"><label class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#" id="username" style="padding: 16px; color: #5f5f5f;"></label>
                    </li>
                    <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="home.php" style="color: #5f5f5f;">Home</a>
                    </li>
                    <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="trace.php" style="color: #5f5f5f;">Traceability</a>
                    </li>
                    <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#" style="color: red;" id="signout">Sign Out</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>


    <header class="masthead bg-primary text-white text-center" style="background-color: white; padding: 0px">
        <div style="width: 100%; height: 100%;">
            <table width="100%" height="20%">
                <tr>
                    <td style="text-align: left; padding-left: 50px; width: 50%;">
                        <label style="width: 150px; color: #5F5F60">Material Code</label>
                        <input type="text" id="inputMaterialcode" name="fname" placeholder="Material Code" value="121001055" style="width: 150px;">
                        <button type="submit" id="btnSearch"><i class="fa fa-search"></i></button>
                    </td>
                    <td rowspan="2" style="text-align: left; padding-left: 50px; width: 50%; border: solid;">
                        <label style="width: 150px; color: #5F5F60">Detail Material and Batch Panel</label>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left; padding-left: 50px; width: 50%;">
                        <label style="width: 150px; color: #5F5F60">Batch</label>
                        <input type="text" id="inputBatch" name="fname" placeholder="Batch" value="20191003" style="width: 150px;">
                        <button type="submit" id="dummy" style="visibility: hidden;"><i class="fa fa-search"></i></button>
                    </td>
                </tr>
            </table>
        </div>
    </header>

    <section>
        <div class="container" style="padding-left: 0; padding-right: 0; margin-left: 0; margin-right: 0; max-width: 100%;">
            <div class="row" style="margin-right: 0px;">
                <!-- Trace-->
                <div class="col-lg-4 mb-5 mb-lg-0" style="flex:0 0 100%;max-width: 100%; padding-top: 10px; padding-bottom: 10px;">
                    <svg id="viz" width="100%" height="300px" style="background-image: url(../images/Backgroud_ind.png);"></svg>
                    <script src="../js/index.js"></script>
                </div>
                <!-- Detail panel-->
                <div class="col-lg-4 mb-5 mb-lg-0" style="flex:0 0 100%; max-width: 100%; padding-right: 0px;">
                    <div id="detailTable" style="width: 100%; height: 400px; overflow-y: scroll;">
                        
                    </div>
                </div>
            </div>
        </div>
    </section>
<!--
    <footer class="footer text-center">
        <div class="container">
            <div class="row">
                Footer Location
                <div class="col-lg-4 mb-5 mb-lg-0">
                    <h4 class="mb-4">SUPPORT</h4>
                    <p class="pre-wrap lead mb-0">DKI Jakarta, Jakarta Timur, <?php echo "\n"; ?>Mobile: 080989999</p>
                </div>
                Footer Social Icons
                <div class="col-lg-4 mb-5 mb-lg-0">
                    <h4 class="mb-4">AROUND THE WEB</h4><a class="btn btn-outline-light btn-social mx-1" href="#"><i class="fab fa-fw fa-facebook-f"></i></a><a class="btn btn-outline-light btn-social mx-1" href="#"><i class="fab fa-fw fa-twitter"></i></a><a class="btn btn-outline-light btn-social mx-1" href="#"><i class="fab fa-fw fa-linkedin-in"></i></a><a class="btn btn-outline-light btn-social mx-1" href="#"><i class="fab fa-fw fa-dribbble"></i></a>
                </div>
                Footer About Text
                <div class="col-lg-4">
                    <h4 class="mb-4">ABOUT TRACEABILITY</h4>
                    <p class="pre-wrap lead mb-0">Traceability System is tracking system solution for your real time guidance.</p>
                </div>
            </div>
        </div>
    </footer>
-->
    <footer style="position: relative; left: 0; bottom: 0; width: 100%; text-align: center;">
        <!-- Copyright Section-->
        <section class="copyright py-4 text-center text-white">
            <div class="container"><small class="pre-wrap" style="font-weight: bold;">Copyright © Traceability System 2020</small></div>
        </section>
    </footer>

    <!-- Scroll to Top Button (Only visible on small and extra-small screen sizes)-->
    <div class="scroll-to-top d-lg-none position-fixed"><a class="js-scroll-trigger d-block text-center text-white rounded" href="#page-top"><i class="fa fa-chevron-up"></i></a></div>
    <!-- Bootstrap core JS-->
    <script src="../js/jquery-3.5.1.min.js"></script>
    <script src="../js/bootstrap.bundle.min.js"></script>
    <!-- Third party plugin JS-->
    <script src="../js/jquery.easing.min.js"></script>
    <!-- Contact form JS-->
    <script src="../assets/mail/jqBootstrapValidation.js"></script>
    <script src="../assets/mail/contact_me.js"></script>
    <!-- Core theme JS-->
    <script src="../js/scripts.js"></script>
</body>

</html>