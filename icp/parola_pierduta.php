<?php

define('INCLUDE_CHECK',true);

require 'connect.php';
require 'functions.php';
require 'header.php';


// Those two files can be included only if INCLUDE_CHECK is defined
if($_POST['submit']=='Trimite')
{
	// If the Register form has been submitted
	
	$err = array();
	
	if(!checkEmail($_POST['email']))
	{
		$err[]='Adresa de email este invalida!';
	}
	
		$email=$_POST['email'];
		$command2="SELECT * FROM tz_members WHERE email = '$email'";
		$result2   = mysql_query($command2);
		while($row2 = mysql_fetch_array($result2))
		{
		$parola = $row2["password"];
		$user = $row2["auth"];
		}
		if (mysql_num_rows($result2) > 0)
		{
			$from = "infectati@yahoo.ro";
			$headers = "From:" . $from;
			
			$Body = "";
			$Body .= "Datele tale sunt urmatoarele, in cazul in care nu ai cerut sa iti fie amintite datele te rog sa nu iei in considerare acest e-mail.";
			$Body .= "\n";
			$Body .= "Nume de Utilizator: ";
			$Body .= $user;		
			$Body .= "\n";
			$Body .= "Parola: ";
			$Body .= $parola;
			$Body .= "\n";
			$Body .= "Echipa Infectati.ro";
			
			mail($email, "ICP Infect Control Panel - Informare parola", $Body, $headers);
			
			$_SESSION['msg']['reg-success']='A fost trimis un email cu noua ta parola!';
		}

	if(count($err))
	{
		$_SESSION['msg']['reg-err'] = implode('<br />',$err);
	}	
	
}
?>
<html>
<body>
<div class="pageContent">
    <div id="main">
      <div class="container">
        <h1>ICP</h1>
        <h2>Infect Control Panel</h2>
        </div>
        
				<?php require 'meniu.php'; ?>
		
        <div class="container">
				<form action="" method="post">
					<h1>Ai uitat numele de utilizator si parola? Retrimite-le!</h1><br>	
                    
                    <?php
						
						if($_SESSION['msg']['reg-err'])
						{
							echo '<div class="err">'.$_SESSION['msg']['reg-err'].'</div>';
							unset($_SESSION['msg']['reg-err']);
						}
						
						if($_SESSION['msg']['reg-success'])
						{
							echo '<div class="success">'.$_SESSION['msg']['reg-success'].'</div>';
							unset($_SESSION['msg']['reg-success']);
						}
					?>

					<label class="grey" for="email">Email:</label><br>
					<input class="field" type="text" name="email" id="email" size="23" /><br><br>
					<label>Numele de Utilizator si Parola vor fi trimise la adresa ta de email.</label><br><br>
					<input type="submit" name="submit" value="Trimite" class="buton_albastru" />
				</form>
				<br>
		<div class="clear"></div>
        </div>
        
	<?php
	require 'foother.php';
	?>	
    </div>
</div>

</body>
</html>
