<?php

  $user = $_POST['username'];

  $password = $_POST['pass'];



  $data = array(
        'username' => $user,

        'pass' => $password

    );


 $postvars = json_encode($data) ;

  $ch = curl_init();
  curl_setopt($ch, CURLOPT_URL, 'https://v1uu1cu9ld.execute-api.eu-west-1.amazonaws.com/alpha/userLog');
  curl_setopt($ch, CURLOPT_POSTFIELDS, $postvars);
  curl_setopt($ch, CURLOPT_HEADER, 1);
  //curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
  $server_output = curl_exec ($ch);
  $hs=curl_getinfo($ch, CURLINFO_HEADER_SIZE);
  $header=substr($server_output,0,$hs);
  $body=substr($server_output,$hs);
  header("Content-Type:text/plain; charset=UTF-8");
  curl_close ($ch);  
  echo 'header:';
  echo "\n";
  echo $header;
  echo "\n";
  echo 'body:';
  echo "\n";
  echo $body;


?>





 




