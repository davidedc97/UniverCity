<?php
 header ('Location: feedback.html');
 $path = 'data.txt';
 if (isset($_POST['field1']) ) {
    $fh = fopen($path,"a");
    $string = $_POST['field1'];
    $conc=fread($path);
    $conc.="\n\n\n";
    $conc.=$string;
    fwrite($fh,$conc);
    fclose($fh); 
 }

function alert($msg) {
    echo "<script type='text/javascript'>alert('$msg');</script>";
}
 alert("Feedback sent, Thank you!");

?>
