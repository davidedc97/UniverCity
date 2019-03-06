<html>
    <head></head>
    <body>
        <?php
        $dbconn = pg_connect("host=localhost port=5433 dbname=Progetto user=postgres password=lenzerini") or die('Could not connect: ' . pg_last_error());
        if(!(isset($_POST['registrationButton']))){
            header("Location: ../page/index.html");
        }
        else{
            $email = $_POST['inputEmail'];
            $q1="select * from utente where email= $1";
            $result=pg_query_params($dbconn, $q1, array($email));
            if($line=pg_fetch_array($result,null,PGSQL_ASSOC)){
                echo "<script type='text/javascript'>alert('Utente già registrato');</script>";
            }
        else{
            $nome=$_POST['name'];
            $cognome = $_POST['surname'];
            $password = md5($_POST['inputPassword']);
            $q2="insert into utente values ($1,$2,$3,$4)";
            $data=pg_query_params($dbconn,$q2,array($email,$nome,$cognome,$password));
            if($data){
				echo "<script type='text/javascript'>alert('Registration completed!');</script>";
                header("Location: ../paginaLogin/login.html");
            }
        }
    }
    ?>
    </body>
</html>
