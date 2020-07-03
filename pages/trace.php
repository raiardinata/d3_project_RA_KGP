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
  <link rel="stylesheet" type="text/css" href="../css/accessible_menu.css">
  <!--===============================================================================================-->
  <script src="https://d3js.org/d3.v5.min.js" charset="utf-8"></script>
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script><!-- Load icon library -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <!--===============================================================================================-->
  <script>
    $(document).ready(function(){
        var base_url = window.origin;
        document.getElementById("username").innerHTML = sessionStorage.getItem("username") + " | ";

        $('#signout').click(function (e) {
            localStorage.clear();
            window.location.replace(base_url + "/KGP_Test/d3_prototype/");
        });
    });        
  </script>
</head>

<body>
  <!-- accessible menu -->
  <div class="viewport">
        <header class="header" role="banner">
            <label class="header-label" style="display: inline;">Traceability System - Home</label>
            <label class="header-user" style="display: inline;" id="username"></label>
            <nav id="nav" class="nav" role="navigation">

                <!-- ACTUAL NAVIGATION MENU -->
                <ul class="nav__menu" id="menu" tabindex="-1" aria-label="main navigation" hidden>
                    <li class="nav__item"><a href="home.php" class="nav__link">Home</a></li>
                    <li class="nav__item"><a href="trace.php" class="nav__link">Traceability</a></li>
                    <li class="nav__item"><a href="#" class="nav__link">Blog</a></li>
                    <li class="nav__item"><a href="#" class="nav__link">About</a></li>
                    <li class="nav__item"><a href="#" class="nav__link">Contact</a></li>
                    <li class="nav__item"><a href="#" class="nav__link" style="color: red;" id="signout">Sign out</a></li>
                </ul>

                <!-- MENU TOGGLE BUTTON -->
                <a href="#nav" class="nav__toggle" role="button" aria-expanded="false" aria-controls="menu">
                    <svg class="menuicon" xmlns="http://www.w3.org/2000/svg" width="50" height="50" viewBox="0 0 50 50">
                        <title>Toggle Menu</title>
                        <g>
                            <line class="menuicon__bar" x1="13" y1="16.5" x2="37" y2="16.5" />
                            <line class="menuicon__bar" x1="13" y1="24.5" x2="37" y2="24.5" />
                            <line class="menuicon__bar" x1="13" y1="24.5" x2="37" y2="24.5" />
                            <line class="menuicon__bar" x1="13" y1="32.5" x2="37" y2="32.5" />
                            <circle class="menuicon__circle" r="23" cx="25" cy="25" />
                        </g>
                    </svg>
                </a>

                <!-- ANIMATED BACKGROUND ELEMENT -->
                <div class="splash"></div>

            </nav>
        </header>
      <svg id="viz" width="100%" height="550px"></svg>
      <script src="../js/bundle.js"></script>
    </div>
    
    <script>
        let nav = document.querySelector('#nav');
        let menu = document.querySelector('#menu');
        let menuToggle = document.querySelector('.nav__toggle');
        let isMenuOpen = false;


        // TOGGLE MENU ACTIVE STATE
        menuToggle.addEventListener('click', e => {
            e.preventDefault();
            isMenuOpen = !isMenuOpen;

            // toggle a11y attributes and active class
            menuToggle.setAttribute('aria-expanded', String(isMenuOpen));
            menu.hidden = !isMenuOpen;
            nav.classList.toggle('nav--open');
        });


        // TRAP TAB INSIDE NAV WHEN OPEN
        nav.addEventListener('keydown', e => {
            // abort if menu isn't open or modifier keys are pressed
            if (!isMenuOpen || e.ctrlKey || e.metaKey || e.altKey) {
                return;
            }

            // listen for tab press and move focus
            // if we're on either end of the navigation
            let menuLinks = menu.querySelectorAll('.nav__link');
            if (e.keyCode === 9) {
                if (e.shiftKey) {
                    if (document.activeElement === menuLinks[0]) {
                        menuToggle.focus();
                        e.preventDefault();
                    }
                } else if (document.activeElement === menuToggle) {
                    menuLinks[0].focus();
                    e.preventDefault();
                }
            }
        });
    </script>
</body>

</html>