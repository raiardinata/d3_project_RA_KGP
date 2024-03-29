<!DOCTYPE html>
<html lang="en">

<head>
    <title>Traceability System Home</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--===============================================================================================-->
    <link rel="icon" type="image/png" href="../images/icons/favicon.ico" />
    <!-- Font Awesome icons (free version)-->
    <!-- <script src="../js/all.min.js" crossorigin="anonymous"></script> -->
    <script src="../vendor/jquery/jquery-3.5.1.min.js"></script>
    <script src="../js/d3_v5.js" charset="utf-8"></script>
    <!--===============================================================================================-->
    <!-- <link rel="stylesheet" rel="preload" as="style" onload="this.rel='stylesheet';this.onload=null" href="https://fonts.googleapis.com/css?family=Roboto:300,300italic,700,700italic">
    <link rel="stylesheet" rel="preload" as="style" onload="this.rel='stylesheet';this.onload=null" href="https://unpkg.com/normalize.css@8.0.0/normalize.css">
    <link rel="stylesheet" rel="preload" as="style" onload="this.rel='stylesheet';this.onload=null" href="https://unpkg.com/milligram@1.3.0/dist/milligram.min.css"> -->
    <link rel="stylesheet" type="text/css" href="../css/animated-menu.css">
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
    <link rel="stylesheet" type="text/css" href="../css/DataTables/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" type="text/css" href="../css/DataTables/buttons.dataTables.min.css">
    <link rel="stylesheet" rel="preload" as="style" onload="this.rel='stylesheet';this.onload=null"
        href="../css/milligram.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <!--===============================================================================================-->
    <script>
        $(document).ready(function(){
            var base_url = window.origin;
            document.getElementById("username").innerHTML = "Hello, " + sessionStorage.getItem("username");
            $('#signout').click(function (e) {
                sessionStorage.clear();
                window.location.replace(base_url + "/KGP_Test/d3_prototype/");
            });
            setInterval( function() {
                $.ajax({
                    url: base_url + "/KGP_Test/d3_prototype/php/acl_model.php",
                    async: false,
                    type: 'post',
                    dataType: 'text',
                    data: {
                        id: sessionStorage.getItem("sessionid")
                    },
                    success: function (jsonData) {
                        var jsonData = JSON.parse(jsonData);
                        if(jsonData.access != true) {
                            alert('Session function are not working properly. Please re-login. If this error happen continously please contact your system administrator for more info!');
                            sessionStorage.clear();
                            window.location.replace(base_url + "/KGP_Test/d3_prototype/");
                        }
                    }
                });
            }, 60 * 1000);
        });
    </script>
    <script type="text/javascript" charset="utf8" src="../js/DataTables/jquery.dataTables.min.js"></script>
    <script type="text/javascript" charset="utf8" src="../js/DataTables/dataTables.bootstrap4.min.js"></script>
    <script type="text/javascript" charset="utf8" src="../js/DataTables/dataTables.buttons.min.js"></script>
    <script type="text/javascript" charset="utf8" src="../js/DataTables/jszip.min.js"></script>
    <script type="text/javascript" charset="utf8" src="../js/DataTables/pdfmake.min.js"></script>
    <script type="text/javascript" charset="utf8" src="../js/DataTables/vfs_fonts.js"></script>
    <script type="text/javascript" charset="utf8" src="../js/DataTables/buttons.html5.min.js"></script>
    <script type="text/javascript" charset="utf8" src="../js/DataTables/buttons.print.min.js"></script>
    <script type="module" charset="utf8" src="../js/DataTables/buttons.print.min.js"></script>
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
            height: 200px;
        }
        .node {
            pointer-events: all;
            cursor: pointer;
            z-index: 1000;
        }
        .node text {
            font: 8px sans-serif;
        }
        .Blink {
            animation: blinker 1.5s cubic-bezier(.5, 0, 1, 1) infinite alternate;  
        }.BlinkL {
            animation: blinkerl 1.5s cubic-bezier(.5, 0, 1, 1) infinite alternate;  
        }
        @keyframes blinker {  
            from { opacity: 1; }
            to { opacity: 0.3; }
        }
        @keyframes blinkerl {  
            from { opacity: 1; }
            to { opacity: 0; }
        }
    </style>
</head>

<body id="page-top">
    <nav class="navbar navbar-expand-lg bg-secondary fixed-top" id="mainNav" style="border-bottom: solid; border-bottom-color: #00be71; position: relative;">
        <div class="container"><a class="navbar-brand js-scroll-trigger" href="#page-top" style="color: #31a073;">Traceability System</a>
            <button class="navbar-toggler navbar-toggler-right font-weight-bold bg-primary text-white rounded" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation" style="color: #5f5f5f!important;">Menu <i class="fa fa-bars"></i></button>
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
    
    <!-- Modal -->
    <div class="modal fade" id="empModal" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" style="display: inline;">Barcode Scanning</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div style="text-align: center;">
                <main class="wrapper" style="padding-top:0.5em;">
                <section class="container" id="demo-content">
                    <div>
                    <button type="submit" id="stopButton"><i class="fa fa-stop fa-lg"></i></button>
                    <button type="submit" id="resetButton"><i class="fa fa-refresh fa-lg"></i></button>
                    </div>
                    <div>
                    <video id="video" width="300" height="200" style="border: 1px solid gray"></video>
                    </div>
                    <div id="sourceSelectPanel" style="display:none">
                    <label for="sourceSelect" style="color: #5f5f5f;">Change video source:</label>
                    <select id="sourceSelect" style="max-width:400px">
                    </select>
                    </div>
                    <label style="color: #5f5f5f; float: left;">Result:</label>
                    <pre><code id="result"></code></pre>
                </section>
                </main>
            </div>
            <div class="modal-footer">
                <button id="action" type="button" data-dismiss="modal">Bind</button>
                <button type="button" data-dismiss="modal">Close</button>
            </div>
            </div>
        </div>
    </div>

    <header class="masthead bg-primary text-white text-center" style="background-color: white; padding: 0px">
        <div style="width: 100%; height: 100%;">
            <table width="100%" height="20%">
                <tr>
                    <td style="text-align: left; width: 9%; padding-left: 20px">
                        <label style="width: 110px; color: #5F5F60">Material Code</label>
                        <input type="text" id="inputMaterialcode" name="fname" placeholder="Material Code" style="width: 150px;">
                        <button id="btnSearch" style="padding: 0px 15px 0px 15px; width: 45px;"><i class="fa fa-search"></i></button>
                        <br/>
                        <label style="width: 110px; color: #5F5F60">Batch</label>
                        <input type="text" id="inputBatch" name="fname" placeholder="Batch" style="width: 150px;">
                        <button class='userinfo' style="padding: 0px 15px 0px 15px; width: 45px;"><i class="fa fa-camera"></i></button>
                    </td>
                    <!-- <td style="text-align: left; width: 15%;">
                        <button type="submit" id="btnSearch" style="padding: 0px 15px 0px 15px;"><i class="fa fa-search"></i></button>
                        <button class='userinfo' style="padding: 0px 15px 0px 15px;"><i class="fa fa-camera"></i></button>
                    </td> -->
                    <td rowspan="2" style="text-align: right; border: solid; width: 25%;">
                        <label style="width: auto; color: #5F5F60" id="lblMtcd" style="white-space: nowrap;"></label><br/>
                        <label style="width: auto; color: #5F5F60" id="lblDesc" style="white-space: nowrap;"></label>
                    </td>
                    <td id=imageColumn rowspan="2" style="text-align: left; border: solid; width: 1%;">
                        
                    </td>
                </tr>
            </table>
        </div>
    </header>

    <section>
        <div class="container" style="padding-left: 0; padding-right: 0; margin-left: 0; margin-right: 0; min-width: 100%; width: 100%;">
            <div class="row" style="margin-right: 0px; width: 100%;">
                <!-- Trace-->
                <div class="col-lg-4 mb-5 mb-lg-0" style="flex:0 0 100%;min-width: 100%; padding-top: 10px; padding-bottom: 10px;">
                    <svg id="viz" width="100%" height="200px" style="background-image: url(../images/Backgroud_ind.png);"></svg>
                    <script src="../js/index.js"></script>
                </div>
                <div id="button" style="padding-left: 25px;"></div>
                <!-- Detail panel-->
                <div class="col-lg-4 mb-5 mb-lg-0" style="flex:0 0 100%; min-width: 100%; padding-right: 0px; min-height: 400px;">
                    <div id="detailTable" style="min-width: 100%; height: 500px; overflow: scroll; padding-left: 10px;">
                        <font size="2" id="font">
                        </font>
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
    <footer style="position: relative; left: 0; bottom: 0; min-width: 100%; text-align: center;">
        <!-- Copyright Section-->
        <section class="copyright py-4 text-center text-white">
            <div class="container"><small class="pre-wrap" style="font-weight: bold;">Copyright © Traceability System 2020</small></div>
        </section>
    </footer>

    <!-- Scroll to Top Button (Only visible on small and extra-small screen sizes)-->
    <div class="scroll-to-top d-lg-none position-fixed"><a class="js-scroll-trigger d-block text-center text-white rounded" href="#page-top"><i class="fa fa-chevron-up"></i></a></div>
    <!-- Bootstrap core JS-->
    <script src="../js/bootstrap.bundle.min.js"></script>
    <!-- Third party plugin JS-->
    <script src="../js/jquery.easing.min.js"></script>
    <!-- Contact form JS-->
    <script src="../assets/mail/jqBootstrapValidation.js"></script>
    <script src="../assets/mail/contact_me.js"></script>
    <!-- Core theme JS-->
    <script src="../js/scripts.js"></script>
</body>


    <script type="text/javascript" src="https://unpkg.com/@zxing/library@0.17.1/umd/index.min.js"></script>
    <script type="text/javascript">
        window.addEventListener('load', function () {
            let selectedDeviceId;
            const codeReader = new ZXing.BrowserMultiFormatReader();
            console.log('ZXing code reader initialized');
            codeReader.listVideoInputDevices()
            .then((videoInputDevices) => {
                const sourceSelect = document.getElementById('sourceSelect');
                selectedDeviceId = videoInputDevices[0].deviceId;
                if (videoInputDevices.length >= 1) {
                    videoInputDevices.forEach((element) => {
                        const sourceOption = document.createElement('option');
                        sourceOption.text = element.label;
                        sourceOption.value = element.deviceId;
                        sourceSelect.appendChild(sourceOption);
                    })
                    sourceSelect.onchange = () => {
                        selectedDeviceId = sourceSelect.value;
                    };
                    const sourceSelectPanel = document.getElementById('sourceSelectPanel')
                    sourceSelectPanel.style.display = 'block'
                }
                function renderCamera() {
                    codeReader.decodeFromVideoDevice(selectedDeviceId, 'video', (result, err) => {
                        if (result) {
                            console.log(result);
                            document.getElementById('result').textContent = result.text;
                            $('#inputMaterialcode').val(result.text);
                            stopCamera();
                            $('#empModal').modal('toggle');
                        }
                        if (err && !(err instanceof ZXing.NotFoundException)) {
                            console.error(err)
                            document.getElementById('result').textContent = err
                        }
                    })
                    console.log(`Started continous decode from camera with id ${selectedDeviceId}`)
                }
                function stopCamera() {
                    codeReader.reset();
                    document.getElementById('result').textContent = '';
                    console.log('Reset.');
                }
                document.getElementById('stopButton').addEventListener('click', () => {
                    stopCamera();
                });
                $('.userinfo').click(function(){
                    // Display Modal
                    $('#empModal').modal('show');
                    renderCamera();
                });
                document.getElementById('resetButton').addEventListener('click', () => {
                    $("#sourceSelect > option:selected")
                    .prop("selected", false)
                    .next()
                    .prop("selected", true);
                    selectedDeviceId = sourceSelect.value;
                    stopCamera();
                    renderCamera();
                });
                setInterval(function(){
                    stopCamera();
                }, 300 * 1000);
                $('#empModal').on('hidden.bs.modal', function () {
                    stopCamera();
                });
            })
            .catch((err) => {
                console.error(err)
            })
        })
    </script>
    <script>
        $(document).ready(function(){
            $('#action').click(function() {
                $('#inputMaterialcode').val($('#result').text());
            });
        });
    </script>

</html>