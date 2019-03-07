<?php

  $usern = $_POST['user'];
  $nome = $_POST['name'];
  $cognome = $_POST['surname'];
  $password = $_POST['pass'];
  $uni = $_POST['university'];
  $fac = $_POST['faculty'];
  $ema=$_POST['email'];


  $data = array(
        'username' => $usern,
        'name' => $nome,
        'surname' => $cognome,
        'email' => $ema,
        'pass' => $password,
        'faculty' => $fac

    );


  $postvars = json_encode($data) ;

  $ch = curl_init();
  curl_setopt($ch, CURLOPT_URL, 'https://v1uu1cu9ld.execute-api.eu-west-1.amazonaws.com/alpha/userReg');
  curl_setopt($ch, CURLOPT_POSTFIELDS, $postvars);
  //curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);


  $server_output = curl_exec ($ch);

  curl_close ($ch);  
header("Location: ../paginaLogin/login.html");
?>

