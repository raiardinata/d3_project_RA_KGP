<?php 
   include "config.php";
?>
<!doctype html>
<html>
  <head>
    <!-- CSS -->
    <link href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" rel="preload" as="style" onload="this.rel='stylesheet';this.onload=null" href="../../css/milligram.min.css">
    <!-- Script -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js' type='text/javascript'></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  </head>
  <body >
    <div class="container" >
      <!-- Modal -->
      <div class="modal fade" id="empModal" role="dialog" target="_blank">
        <div class="modal-dialog">
          <!-- Modal content-->
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title" style="display: inline;">Barcode Scanning</h4>
              <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div style="text-align: center;">
              <main class="wrapper" style="padding-top:2em;">
                <section class="container" id="demo-content">
                  <div>
                    <button type="submit" id="startButton"><i class="fa fa-camera fa-lg"></i></button>
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
              <button id="action" type="button" class="btn btn-default" data-dismiss="modal">Bind</button>
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
          </div>
        </div>
      </div>
      <br/>
      <table border='1' style='border-collapse: collapse;'>
        <tr>
          <th>Field</th>
          <th>Alias</th>
          <th>&nbsp;</th>
        </tr>
        <tr>
          <td>
            <input type="text" id="inputMaterialcode" name="fname" placeholder="Material Code" style="width: 150px;">
          </td>
          <td>
            <input type="text" id="inputBatch" name="fname" placeholder="Batch" style="width: 150px;">
          </td>
          <td>
            <button data-id='1' class='userinfo'>Info</button>
          </td>
        </tr>
        <!-- <?php 
            $query = "select * from mstr_query";
            $result = mysqli_query($con,$query);
            while($row = mysqli_fetch_array($result)){
              $id = $row['Step_ID'];
              $field = $row['Filed'];
              $alias = $row['Alias'];
            
              echo "<tr>";
              echo "<td>".$field."</td>";
              echo "<td>".$alias."</td>";
              echo "<td><button data-id='".$id."' class='userinfo'>Info</button></td>";
              echo "</tr>";
            }
        ?> -->
      </table>
    </div>
  </body>
  <script>
    $(document).ready(function(){
      $('.userinfo').click(function(){
        var userid = $(this).data('id');
        // Display Modal
        $('#empModal').modal('show'); 
      });
      $('#action').click(function() {
        $('#inputMaterialcode').val($('#result').text());
      });
    });
  </script>
  <script type="text/javascript" src="https://unpkg.com/@zxing/library@0.17.1/umd/index.min.js"></script>
  <script type="text/javascript">
    window.addEventListener('load', function () {
      setInterval(function(){
        codeReader.reset();
        document.getElementById('result').textContent = '';
        console.log('Reset.');
      }, 300 * 1000);
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
        document.getElementById('startButton').addEventListener('click', () => {
          codeReader.decodeFromVideoDevice(selectedDeviceId, 'video', (result, err) => {
            if (result) {
              console.log(result);
              document.getElementById('result').textContent = result.text;
              $('#inputMaterialcode').val(result.text);
            }
            if (err && !(err instanceof ZXing.NotFoundException)) {
              console.error(err)
              document.getElementById('result').textContent = err
            }
          })
          console.log(`Started continous decode from camera with id ${selectedDeviceId}`)
        })
        document.getElementById('resetButton').addEventListener('click', () => {
          codeReader.reset()
          document.getElementById('result').textContent = '';
          console.log('Reset.')
        })
      })
      .catch((err) => {
        console.error(err)
      })
    })
  </script>
</html>