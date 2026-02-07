<?php
define('INCLUDE_CHECK',true);

require 'config.php';

function checkEmail($str)
{
	return preg_match("/^[\.A-z0-9_\-\+]+[@][A-z0-9_\-]+([.][A-z0-9_\-]+)+[A-z]{1,4}$/", $str);
}

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
if($_POST['submit']=='Autentifica-te')
{
	// Checking whether the Login form has been submitted
	
	// Will hold our errors
	
	
	if(!$_POST['username'] || !$_POST['password'])
		$err[] = 'Toate campurile trebuie completate!';
	$row2 = mysql_fetch_assoc(mysql_query("SELECT id,auth,email,bantime,timp_ban FROM users WHERE name='{$_POST['username']}' AND password='{$_POST['password']}'"));
	
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

		$row = mysql_fetch_assoc(mysql_query("SELECT id,name,email,bantime,ip_1,ip_2,ip_3,ip_4,5,nr_ip FROM users WHERE name='{$_POST['username']}' AND password='{$_POST['password']}'"));
		
		if($row['name'])
		{
			// If everything is OK login
			
			$_SESSION['name']=$row['name'];
			$_SESSION['email']=$row['email'];
			$_SESSION['id'] = $row['id'];
			$_SESSION['rememberMe'] = $_POST['rememberMe'];
			
			if (($row['ip_1'] !== $_SERVER['REMOTE_ADDR']) && ($row['nr_ip'] == "1"))
				mysql_query("	UPDATE tz_members
						SET				
							ip_1 = '".$_SERVER['REMOTE_ADDR']."',
							nr_ip = '2'
						WHERE id = '{$_SESSION['id']}'");
			else if (($row['ip_2'] !== $_SERVER['REMOTE_ADDR']) && ($row['nr_ip'] == "2"))
				mysql_query("	UPDATE tz_members
						SET				
							ip_2 = '".$_SERVER['REMOTE_ADDR']."',
							nr_ip = '3'
						WHERE id = '{$_SESSION['id']}'");
			else if (($row['ip_3'] !== $_SERVER['REMOTE_ADDR']) && ($row['nr_ip'] == "3"))
				mysql_query("	UPDATE tz_members
						SET				
							ip_3 = '".$_SERVER['REMOTE_ADDR']."',
							nr_ip = '4'
						WHERE id = '{$_SESSION['id']}'");
			else if (($row['ip_4'] !== $_SERVER['REMOTE_ADDR']) && ($row['nr_ip'] == "4"))
				mysql_query("	UPDATE tz_members
						SET				
							ip_4 = '".$_SERVER['REMOTE_ADDR']."',
							nr_ip = '5'
						WHERE id = '{$_SESSION['id']}'");
			else if (($row['ip_5'] !== $_SERVER['REMOTE_ADDR']) && ($row['nr_ip'] == "5"))
				mysql_query("	UPDATE tz_members
						SET				
							ip_5 = '".$_SERVER['REMOTE_ADDR']."',
							nr_ip = '1'
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

}
else if($_POST['submit']=='Inregistreaza-te')
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
	
	if (!$_POST['password'])
	{
		$err[]='Nu ai completat campul Parola!';
	}
	if (!($_POST['paswword'] == $_POST['re_password']))
	{
		$err[]='Parolele nu coincid!';
	}
	
	
	if(!count($err))
	{
		
		$password = $_POST['password'];
		
		$_POST['email'] = mysql_real_escape_string($_POST['email']);
		$_POST['username'] = mysql_real_escape_string($_POST['username']);
		$_POST['password'] = mysql_real_escape_string($password);
		$_POST['name_surname'] = mysql_real_escape_string($_POST['name_surname']);
		$_POST['county'] = mysql_real_escape_string($_POST['county']);
		$_POST['city'] = mysql_real_escape_string($_POST['city']);
		$_POST['address'] = mysql_real_escape_string($_POST['address']);
		
		
		mysql_query("	INSERT INTO users(name,password,email,regIP,name_surname,county,city,address,dt)
						VALUES(
						
							'".$_POST['username']."',
							'".$_POST['password']."',
							'".$_POST['email']."',
							'".$_SERVER['REMOTE_ADDR']."',
							'".$_POST['name_surname']."',
							'".$_POST['county']."',
							'".$_POST['city']."',
							'".$_POST['address']."',
							NOW()
							
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
	
}

$script = '';

if($_SESSION['msg'])
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

?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0" />
	<title><?php $nume_site = mysql_fetch_assoc(mysql_query("SELECT * FROM settings WHERE name = 'site_name'")); echo $nume_site['value']; ?></title>
	<link rel="shortcut icon" type="image/x-icon" href="css/images/favicon.ico" />
	<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
	<link href='http://fonts.googleapis.com/css?family=Coda' rel='stylesheet' type='text/css' />
	<link href='http://fonts.googleapis.com/css?family=Jura:400,500,600,300' rel='stylesheet' type='text/css' />

	<script src="js/jquery-1.8.0.min.js" type="text/javascript"></script>
	<script src="js/jquery.touchwipe.1.1.1.js" type="text/javascript"></script>
	<script src="js/jquery.carouFredSel-5.5.0-packed.js" type="text/javascript"></script>
	<!--[if lt IE 9]>
		<script src="js/modernizr.custom.js"></script>
	<![endif]-->
	<script src="js/functions.js" type="text/javascript"></script>
</head>
<body>
	<!-- wrapper -->
	<div class="wrapper">
		<!-- header -->
		<header class="header">
			<div class="shell">
			<?php require 'menu.php'; ?>
			</div>
		</header>
		<!-- end of header -->
		<!-- shell -->
		<div class="shell">
			<!-- main -->
			<div class="main">

				<section class="content">
				<div id="left">
				<h2>Autentifica-te</h2>
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
<div id="contact"> 
        <div class="input_label user"> 
            <label for="name"> 
                Nume</label></div> 
        <input name="name" type="text" id="name" class="name" size="30" value=""> 
    </div> 
<br> 
<div id="contact"> 
        <div class="input_label user"> 
            <label for="name"> 
                Parola</label></div> 
        <input name="name" type="text" id="name" class="name" size="30" value=""> 
    </div> 
<br>
<h1> <input type="submit" name="submit" value="Autentifica-te" class="buton_albastru" />&nbsp;&nbsp;&nbsp; <input name="rememberMe" id="rememberMe" type="checkbox" checked="checked" value="1" /> &nbsp;Tine-ma minte</h1>
				</div>
				
				<div id="right" >
				<h2>Inregistreaza-te</h2>
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
<form name="form2" method="post"  action="">
<h3>Nume de utilizator <input class="textbox" type="text" name="username"></h3>
<br>
<h3>Adresa de email <input class="textbox" type="text" name="email"></h3>
<br>
<h3>Parola <input class="textbox" type="password" name="password"></h3>
<br>
<h3>Rescriere Parola <input class="textbox" type="password" name="re_password"></h3>
<br>
<h3>Nume si Prenume <input class="textbox" type="text" name="name_surname"></h3>
<br>
<h3>Adresa <input class="textbox" type="text" name="address"></h3>
<br>
<h3>Oras <input class="textbox" type="text" name="city"></h3>
<br>
<h3>Judet <input class="textbox" type="text" name="county"></h3>
<br>
<h3>Sunt de acord cu <a href="termeni.php">Termenii si Conditiile</a></h3>

<input type="submit" name="submit" value="Inregistreaza-te" class="buton_albastru" />
</form>
				</div>
				</section>

			</div>
			<!-- end of main -->
		</div>
		<!-- end of shell -->	
		<?php require 'footer.php'; ?>
	</div>
	<!-- end of wrapper -->
</body>
</html>