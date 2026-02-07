<?php

session_name('tzLogin');
// Starting the session

session_set_cookie_params(2*7*24*60*60);
// Making the cookie live for 2 weeks

session_start();
ob_start();

if(isset($_SESSION['id']) && !isset($_COOKIE['tzRemember']) && !$_SESSION['rememberMe'])
{
	// If you are logged in, but you don't have the tzRemember cookie (browser restart)
	// and you have not checked the rememberMe checkbox:

	$_SESSION = array();
	session_destroy();
	
	// Destroy the session
}


if(isset($_GET['logoff']))
{
	$_SESSION = array();
	session_destroy();
	
	header("Location: index.php");
	exit;
}

if($_POST['submit']=='Autentifica')
{
	// Checking whether the Login form has been submitted
	
	// Will hold our errors
	
	
	if(!$_POST['username'] || !$_POST['password'])
		$err[] = 'Toate campurile trebuie completate!';
	$row2 = mysql_fetch_assoc(mysql_query("SELECT id,auth,email,bantime,timp_ban FROM tz_members WHERE auth='{$_POST['username']}' AND password='{$_POST['password']}'"));
	$row555 = mysql_fetch_assoc(mysql_query("SELECT timp_ban FROM ban_ip WHERE ip = '".$_SERVER['REMOTE_ADDR']."'"));
		
		if($row2['bantime'] == "3000-01-01")
		{
			$err[]='Contul tau a fost banat permanent.';
		}
		else if($row2['bantime'] > date("Y-m-d", time()))
		{
			$err[]='Contul tau a fost banat pana la data de '.$row2['bantime'];
		}
		else if($row555['timp_ban'] > date("H:i:s", time()))
		{
			$err[]='Ai fost banat 2 ore pentru prea multe incercari';
		}
	if(!count($err))
	{
		$_POST['username'] = mysql_real_escape_string($_POST['username']);
		$_POST['password'] = mysql_real_escape_string($_POST['password']);
		$_POST['rememberMe'] = (int)$_POST['rememberMe'];
		
		// Escaping all input data

		$row = mysql_fetch_assoc(mysql_query("SELECT id,auth,email,bantime,ip_ultimul,ip_ultimul2,ip_ultimul3,ip_ultimul4,ip_ultimul5,numar_ip FROM tz_members WHERE auth='{$_POST['username']}' AND password='{$_POST['password']}'"));
		
		if($row['auth'])
		{
			// If everything is OK login
			
			$_SESSION['auth']=$row['auth'];
			$_SESSION['email']=$row['email'];
			$_SESSION['id'] = $row['id'];
			$_SESSION['rememberMe'] = $_POST['rememberMe'];
			
			if (($row['ip_ultimul'] !== $_SERVER['REMOTE_ADDR']) && ($row['numar_ip'] == "1"))
				mysql_query("	UPDATE tz_members
						SET				
							ip_ultimul = '".$_SERVER['REMOTE_ADDR']."',
							numar_ip = '2'
						WHERE id = '{$_SESSION['id']}'");
			else if (($row['ip_ultimul2'] !== $_SERVER['REMOTE_ADDR']) && ($row['numar_ip'] == "2"))
				mysql_query("	UPDATE tz_members
						SET				
							ip_ultimul2 = '".$_SERVER['REMOTE_ADDR']."',
							numar_ip = '3'
						WHERE id = '{$_SESSION['id']}'");
			else if (($row['ip_ultimul3'] !== $_SERVER['REMOTE_ADDR']) && ($row['numar_ip'] == "3"))
				mysql_query("	UPDATE tz_members
						SET				
							ip_ultimul3 = '".$_SERVER['REMOTE_ADDR']."',
							numar_ip = '4'
						WHERE id = '{$_SESSION['id']}'");
			else if (($row['ip_ultimul4'] !== $_SERVER['REMOTE_ADDR']) && ($row['numar_ip'] == "4"))
				mysql_query("	UPDATE tz_members
						SET				
							ip_ultimul4 = '".$_SERVER['REMOTE_ADDR']."',
							numar_ip = '5'
						WHERE id = '{$_SESSION['id']}'");
			else if (($row['ip_ultimul5'] !== $_SERVER['REMOTE_ADDR']) && ($row['numar_ip'] == "5"))
				mysql_query("	UPDATE tz_members
						SET				
							ip_ultimul5 = '".$_SERVER['REMOTE_ADDR']."',
							numar_ip = '1'
						WHERE id = '{$_SESSION['id']}'");
			
				mysql_query("DELETE FROM ban_ip WHERE ip = '".$_SERVER['REMOTE_ADDR']."'");
			// Store some data in the session
			
			setcookie('tzRemember',$_POST['rememberMe']);
		}
		else
		{
			if (mysql_num_rows(mysql_query("SELECT * FROM ban_ip WHERE ip = '".$_SERVER['REMOTE_ADDR']."'")) > "0")
			{
				$row55 = mysql_fetch_assoc(mysql_query("SELECT incercari FROM ban_ip WHERE ip = '".$_SERVER['REMOTE_ADDR']."'"));
				$nr_ban = $row55['incercari'] + "1";
				
				if ($nr_ban >= "5")
				{
					$nr_ban = "5";
					$timp_ban = date("H:i:s", strtotime("+ 2 hour"));
					$err_ban[]='Ai fost banat 2 ore pentru prea multe incercari esuate!';
					mysql_query("	UPDATE ban_ip
							SET				
								timp_ban = '$timp_ban'
							WHERE ip = '".$_SERVER['REMOTE_ADDR']."'");	
				}				
				else
				{
					mysql_query("	UPDATE ban_ip
						SET				
							incercari = '$nr_ban'
						WHERE ip = '".$_SERVER['REMOTE_ADDR']."'");	
					$err_ban[]='Incercari ramase: '.$nr_ban.'/5';
				}
			}
			else
			{
						mysql_query("	INSERT INTO ban_ip(ip,incercari)
							VALUES(
							
							'".$_SERVER['REMOTE_ADDR']."',
							'1'
							
						)");
						$err_ban[]='Incercari ramase: 1/5 ';
			}
			$err[]='Utilizator sau parola gresita!';
		}
	}
	
	if($err)
		$_SESSION['msg']['login-err'] = implode('<br />',$err);
	if($err_ban)
		$_SESSION['msg']['login-err_ban'] = implode('<br />',$err_ban);
	// Save the error messages in the session

	header("Location: index.php");
	exit;
}
else if($_POST['submit']=='Inregistreaza')
{
	// If the Register form has been submitted

	
	if(strlen($_POST['username'])<4 || strlen($_POST['username'])>32)
	{
		$err[]='Numele de utilizator trebuie sa contina intre 3 si 32 de caractere!';
	}
	
	if(!checkEmail($_POST['email']))
	{
		$err[]='Adresa de email este invalida!';
	}
	
	$emaildublu=$_POST['email'];
	$dublu = mysql_query("SELECT * FROM tz_members WHERE email = '$emaildublu'");
	if (mysql_num_rows($dublu) > 0)
	{
		$err[]='Adresa de email a mai fost utilizata!';
	}
	$emailuser=$_POST['username'];
	$dublu2 = mysql_query("SELECT * FROM tz_members WHERE auth = '$emailuser'");
	if (mysql_num_rows($dublu2) > 0)
	{
		$err[]='Acest nume de utilizator este deja utilizat!';
	}
	
	if (!$_POST['parola'])
	{
		$err[]='Nu ai completat campul Parola!';
	}
	if (!($_POST['parola'] == $_POST['parola2']))
	{
		$err[]='Parolele nu coincid!';
	}
	
	
	if(!count($err))
	{
		
		$password = $_POST['parola'];
		
		$_POST['email'] = mysql_real_escape_string($_POST['email']);
		$_POST['username'] = mysql_real_escape_string($_POST['username']);
		$_POST['access_cs'] = mysql_real_escape_string(z);
		$_POST['access_zm'] = mysql_real_escape_string(z);
		$_POST['flags'] = mysql_real_escape_string(a);
		$_POST['admin'] = mysql_real_escape_string(0);
		$_POST['balanta'] = mysql_real_escape_string(0.00);
		$_POST['password'] = mysql_real_escape_string($password);
		$_POST['nume'] = mysql_real_escape_string("Necompletat");
		$_POST['judet'] = mysql_real_escape_string("Necompletat");
		$_POST['oras'] = mysql_real_escape_string("Necompletat");
		$_POST['telefon'] = mysql_real_escape_string("Necompletat");
		// Escape the input data
		
		
		mysql_query("	INSERT INTO tz_members(auth,password,email,balanta,regIP,access_cs,access_zm,flags,nume,judet,oras,telefon,dt)
						VALUES(
						
							'".$_POST['username']."',
							'".$_POST['password']."',
							'".$_POST['email']."',
							'".$_POST['balanta']."',
							'".$_SERVER['REMOTE_ADDR']."',
							'".$_POST['access_cs']."',
							'".$_POST['access_zm']."',
							'".$_POST['flags']."',
							'".$_POST['nume']."',
							'".$_POST['judet']."',
							'".$_POST['oras']."',
							'".$_POST['telefon']."',
							NOW()
							
						)");
		mysql_query("	INSERT INTO zp_bank(auth,cantitate)
						VALUES(
						
							'".$_POST['username']."',
							'0'	
						)");
			$Email = $_POST['email'];
			$user = $_POST['username'];
			$from = "infectati@yahoo.ro";
			$headers = "From:" . $from;
			
			$Body = "";
			$Body .= "Salut ";
			$Body .= $user;					
			$Body .= "\n";
			$Body .= "Parola ta este ";
			$Body .= $password;					
			$Body .= "\n";
			$Body .= "Echipa Infectati.ro";
			
			mail($Email, "ICP Infect Control Panel - Noua ta parola", $Body, $headers);
			
			$_SESSION['msg']['reg-succes2']='Ai fost inregistrat cu success!';
	}

	if(count($err))
	{
		$_SESSION['msg']['reg-err'] = implode('<br />',$err);
	}	
	
	header("Location: index.php");
	exit;
}

$script = '';

if(isset($_SESSION['msg']) and $_SESSION['msg'])
{
	// The script below shows the sliding panel on page load
	
	$script = '
	<script type="text/javascript">
	
		$(function(){
		
			$("div#panel").show();
			$("#toggle a").toggle();
		});
	
	</script>';
	
}
		$query5555 = mysql_query("select count(*) as total from tz_members");
		$result5555 = mysql_fetch_array($query5555);
		
		$session=session_id();
		$time=time();
		$time_check=$time-100; //SET TIME 10 Minute
		
		$sql4="DELETE FROM user_online WHERE time<$time_check";
		$result4=mysql_query($sql4);
		
		$sql121="SELECT * FROM user_online WHERE session='$session'";
		$result1111=mysql_query($sql121);

		$count=mysql_num_rows($result1111);
		
		if($_SESSION['id'])
		{
		if($count=="0")
		{
			$sql1="INSERT INTO user_online(session, time, auth2)VALUES('$session', '$time', '{$_SESSION['id']}')";
			$result1=mysql_query($sql1);
		}
		else
		{
			$sql2="UPDATE user_online SET time='$time' WHERE session = '$session'";
			$result2=mysql_query($sql2);
		}
		}
		$sql3="SELECT * FROM user_online";
		$result3=mysql_query($sql3);

		$count_user_online=mysql_num_rows($result3);


$rip = $_SERVER['REMOTE_ADDR'];
$sd  = time();
$count = 1;

$file1 = "ip.txt";
$lines = file($file1);
$line2 = "";

foreach ($lines as $line_num => $line)
{
 //echo $line."";
 $fp = strpos($line,'****');
 $nam = substr($line,0,$fp);
 $sp = strpos($line,'++++');
 $val = substr($line,$fp+4,$sp-($fp+4));
 $diff = $sd-$val;
 if($diff < 300 && $nam != $rip)
 {
  $count = $count+1;
  $line2 = $line2.$line;
  //echo $line2;
 }
}

$my = $rip."****".$sd."++++\n";
$open1 = fopen($file1, "w");
fwrite($open1,"$line2");
fwrite($open1,"$my");
fclose($open1);


?>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ICP Infect Control Panel</title>
    
    <link rel="stylesheet" type="text/css" href="demo.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="login_panel/css/slide.css"/>
    
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
    
    <!-- PNG FIX for IE6 -->
    <!-- http://24ways.org/2007/supersleight-transparent-png-in-ie6 -->
    <!--[if lte IE 6]>
        <script type="text/javascript" src="login_panel/js/pngfix/supersleight-min.js"></script>
    <![endif]-->
    
    <script src="login_panel/js/slide.js" type="text/javascript"></script>
	
	<link rel='stylesheet' type='text/css' href='styles_menu.css' />

    
    <?php echo $script; ?>
</head>

<body>

<!-- Panel -->
<div id="toppanel">
	<div id="panel">
		<div class="content clearfix">
			<div class="left">
				<h1>ICP</h1>
				<h2>Infect Control Panel</h2>		
				<p class="grey">Cu ajutorul acestui sistem totul este mai simplu</p>
				<h2>Multumim...</h2>
				<p class="grey">Multumim Dezvolatatorului Serbu de la <a href="http://www.infectati.ro/contact.php"><font color="#d10000">Echipa Infectatilor</font></a> pentru creearea acestui sistem.</p>
			</div>
            
            
            <?php
			
			if(!$_SESSION['id']):
			
			?>
            
			<div class="left">
				<!-- Login Form -->
				<form class="clearfix" action="" method="post">
					<h1>Autentifica-te</h1>
                    
                    <?php
						
						if($_SESSION['msg']['login-err'])
						{
							echo '<div class="err">'.$_SESSION['msg']['login-err'].'</div>';
							unset($_SESSION['msg']['login-err']);
						}
						if($_SESSION['msg']['login-err_ban'])
						{
							echo '<div class="err">'.$_SESSION['msg']['login-err_ban'].'</div>';
							unset($_SESSION['msg']['login-err_ban']);
						}
					?>
					
					<label class="grey" for="username">Nume de utilizator:</label>
					<input class="field" type="text" name="username" id="username" value="" size="23" />
					<label class="grey" for="password">Parola:</label>
					<input class="field" type="password" name="password" id="password" size="23" /><br>
	            	<label><input name="rememberMe" id="rememberMe" type="checkbox" checked="checked" value="1" /> &nbsp;Tine-ma minte</label> 	<a href="parola_pierduta.php">Am uitat Numele de Utilizator si Parola</a><br>
        			<div class="clear"></div>
					<input type="submit" name="submit" value="Autentifica" class="bt_login" />
				</form>
			</div>
			<div class="left right">			
				<!-- Register Form -->
				<form action="" method="post">
					<h1>Nu esti un membru? Inregistreaza-te!</h1>		
                    
                    <?php
						
						if($_SESSION['msg']['reg-err'])
						{
							echo '<div class="err">'.$_SESSION['msg']['reg-err'].'</div>';
							unset($_SESSION['msg']['reg-err']);
						}
						
						if($_SESSION['msg']['reg-succes2'])
						{
							echo '<div class="succes2">'.$_SESSION['msg']['reg-succes2'].'</div>';
							unset($_SESSION['msg']['reg-succes2']);
						}
					?>
                    		
					<label class="grey" for="username">Nume de utilizator:</label>
					<input class="field" type="text" name="username" id="username" value="" size="23" />
					<label class="grey" for="email">Email:</label>
					<input class="field" type="text" name="email" id="email" size="23" />
					<label class="grey" for="parola">Parola:</label>
					<input class="field" type="password" name="parola" id="parola" size="23" /><br>
					<label class="grey" for="parola2">Rescrie Parola:</label>
					<input class="field" type="password" name="parola2" id="parola2" size="23" /><br>
					<h3>Sunt de acord cu <a href="termeni.php">Termenii si Conditiile</a></h3>
					<input type="submit" name="submit" value="Inregistreaza" class="bt_register" />
				</form>
			</div>
            
            <?php
			
			else:
			{
			?>
            
            <div class="left">
            
            <h1>Panoul Membrului</h1>
            <?php
			$command256="SELECT * FROM setari WHERE id = '1'";
			$results256 = mysql_query($command256);
			
			while($row256 = mysql_fetch_array($results256))
				$concurs = $row256["valuare"];
				
			$command266="SELECT * FROM setari WHERE id = '2'";
			$results266 = mysql_query($command266);
			
			while($row266 = mysql_fetch_array($results266))
				$linkus = $row266["valuare"];
			?>
            <p>Cateva unelte rapide</p>
			<a href="index.php">Acasa</a><br>
            <a href="cont.php">Contul meu</a><br>
			<a href="iaddfond.php">Adauga Fonduri</a><br>
			<a href="ics.php">Cs.infectati.ro</a><br>
			<a href="izm.php">Zm.infectati.ro</a><br>
			<?php if ($concurs == "da") { ?> <a href="concurs.php">Concurs</a><br> <?php } ?>
			<?php if ($linkus == "da") { ?> <a href="link.php">Link Unic</a><br> <?php } ?>
			<a href="info.php">Informatii</a><br><br>
			<a href="?logoff">Iesire</a>
            
            </div>
			<?php
			$command16="SELECT * FROM tz_members WHERE id = '{$_SESSION['id']}'";
			$results16 = mysql_query($command16);
			while($row16 = mysql_fetch_array($results16))
			{
				$adminu = $row16["admin"];								$dedicat = $row16["dedicat"];
				$access_cs = $row16["access_cs"];
				$zm_access = $row16["access_zm"];
				$aban = $row16["bantime"];
			}
			$da = "nu";
			if ($access_cs == "cdefijm")
			{
				$da = "da";
			}
			else if ($access_cs == "cdefgijmn")
			{
				$da = "da";
			}
			else if ($access_cs == "abcdefghijklmnopqrstu")
			{
				$da = "da";
			}
			else if ($access_cs == "bcefij")
			{
				$da = "da";
			}
			else if ($access_cs == "bcdefijm")
			{
				$da = "da";
			}
			else if ($access_cs == "bcdefgijmn")
			{
				$da = "da";
			}
			
			$vodka ="nu";
			
			if (($zm_access == "cefij") or ($zm_access == "cefijx"))
			{
				$vodka ="da";
			}
			else if (($zm_access == "cdefijm") or ($zm_access == "cdefijmx"))
			{
				$vodka ="da";
			}
			else if (($zm_access == "cdefgijmn") or ($zm_access == "cdefgijmnx"))
			{
				$vodka ="da";
			}
			else if (($zm_access == "abcdefghijklmnopqrstu") or ($zm_access == "abcdefghijklmnopqrstux"))
			{
				$vodka ="da";
			}	
			else if (($zm_access == "bcefij") or ($zm_access == "bcefijx"))
			{
				$vodka ="da";
			}
			else if (($zm_access == "bcdefijm") or ($zm_access == "bcdefijmx"))
			{
				$vodka ="da";
			}
			else if (($zm_access == "bcdefgijmn") or ($zm_access == "bcdefgijmnx"))
			{
				$vodka ="da";
			}
			else if (($zm_access == "abcdefghijklmnopqrstu") or ($zm_access == "abcdefghijklmnopqrstux"))
			{
				$vodka ="da";
			}
			if ($aban > date("Y-m-d", time()))
			{
				$_SESSION = array();
				session_destroy();
			}
			if ($adminu == "da")
			{
				$total_donatii = mysql_query("SELECT * FROM donatie WHERE rezultat = 'asteptare'");
			?>
            <div class="left right">
			<h1>Panoul Administratorului</h1>
			<p>Cateva unelte rapide de Admin</p>
            <a href="scont.php">Editeza Utilizator</a><br>
			<a href="tabel.php">Tabel Utilizatori</a><br>
			<a href="editpret.php">Editeza Preturi</a><br>
			<a href="addfond.php">Editeaza balanta unui utilizator</a><br>
			<a href="cavertisment.php">Adauga avertismente unui utilizator</a><br>
			<?php if ($concurs == "da") { ?> <a href="declara_concurs.php">Declara Castigator</a><br> <?php } ?>
			<a href="setari.php">Setari</a><br>
			<a href="pari_edit.php">Editeaza Pariuri clanuri</a><br>
			<a href="ban_server.php">Baneaza/Debaneaza un jucator</a><br>
			<a href="log-admin.php">Statistici Cumparari</a><br>
			<a href="log.php">Jurnal</a><br>						<?php			if ($dedicat == "da")			{			?>			<a href="dedicat-constanta.php">Server Dedicat Backup</a><br><br>
			<?php			}			if (mysql_num_rows($total_donatii) >= 1) { ?><font color="#d10000">Ai o noua donatie click </font><a href="activare_donatie.php">aici</a><font color="#d10000"> pentru a o activa</font><br> <?php } ?>
            </div>
            <?php
			}
			if ($adminu == "avertisment")
			{
			?>
            <div class="left right">
			<h1>Panoul Administratorului</h1>
			<p>Cateva unelte rapide de Admin</p>
			<a href="cavertisment.php">Adauga avertismente unui utilizator</a><br>
			<?php
			if (($da == "da") or ($vodka =="da"))
			{
			?>
			<a href="ban_server.php">Baneaza/Debaneaza un jucator</a><br>
			<?php
			}
			?>
            </div>
            <?php
			}
			
			if ((($da == "da") or ($vodka =="da")) and (($adminu == "nu") or ($adminu == ""))) 
			{
			?>
            <div class="left right">
			<h1>Panoul Administratorului</h1>
			<p>Cateva unelte rapide de Admin</p>
			<a href="ban_server.php">Baneaza/Debaneaza un jucator</a><br>
            </div>
            <?php
			}
			}
			endif;
			?>
		</div>
	</div> <!-- /login -->	

    <!-- The tab on top -->	
	<div class="tab">
		<ul class="login">
	    	<li class="left">&nbsp;</li>
	        <li>Salut, <?php echo $_SESSION['auth'] ? $_SESSION['auth'] : 'Vizitatorule';?>!</li>
			<li class="sep">|</li>
			<li id="toggle">
				<a id="open" class="open" href="#"><?php echo $_SESSION['id']?'Deschide panou':'Autentifica-te | Inregistreaza-te';?></a>
				<a id="close" style="display: none;" class="close" href="#">Inchide panou</a>			
			</li>
	    	<li class="right">&nbsp;</li>
		</ul> 
	</div> <!-- / top -->
	
</div> <!--panel -->
</body>
</html>