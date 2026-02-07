<?php

define('INCLUDE_CHECK',true);

require 'connect.php';
require 'functions.php';
require 'header.php';
// Those two files can be included only if INCLUDE_CHECK is defined



?>

<html>
<head>
<script type="text/javascript">
function load()
{
	window.open("http://www.infectati.ro", "infectati","status=yes, toolbar=yes, menubar=yes, location=yes"); 
}
</script>
</head>
<body onload="load()">
<div class="pageContent">
    <div id="main">
      <div class="container">
        <h1>ICP</h1>
        <h2>Infect Control Panel</h2>
        </div>	
		<?php
			$command256="SELECT * FROM setari WHERE id = '2'";
			$results256 = mysql_query($command256);
			
			while($row256 = mysql_fetch_array($results256))
				$link = $row256["valuare"];
			if ($link == "da") 
			{
			require 'meniu.php';
			?>
			<div class="container">
			<?php
			setcookie('test', 1, time()+3600);
			if(count($_COOKIE) > 0)
			{
				
				$command2="SELECT * FROM tz_members WHERE id = '{$_GET["id"]}'";
				$results2 = mysql_query($command2);
				if (mysql_num_rows($results2) > "0")
				{
				while($row2 = mysql_fetch_array($results2))
				{
					$auth = $row2["auth"];
					$balanta = $row2["balanta"];
				}
				$expiry = date("Y-m-d h:i", time() + 24*60*60 );

				$ip = getVisitorIP();
				
				$sql4="DELETE FROM anti_hack WHERE NOW() >= time";
				$result4=mysql_query($sql4);
?>    
				<h1>Adaugare fonduri unui utilizator cu ajutorul link-ului</h1><br>
				<?php
				$sql121="SELECT * FROM anti_hack WHERE ip='$ip' AND for_auth='$auth'";
				$result1111=mysql_query($sql121);
				
				
				if(!isset($_COOKIE['voturi'.$auth]) and (mysql_num_rows($result1111) == "0"))
				{
					setcookie('voturi'.$auth, $auth, time() + 24*60*60);
					
					mysql_query("INSERT INTO anti_hack(ip,time,for_auth) VALUES ('$ip','$expiry','$auth')");
					$balanta = $balanta + "0.01";
					mysql_query("	UPDATE tz_members
						SET				
							balanta = '$balanta'
						WHERE id = '{$_GET["id"]}'");
				 ?>
				<h3>Pentru ca ai accesat acest link <?php echo $auth; ?> a primit 0.01 Euro. Da si tu acest link mai departe si <?php echo $auth; ?> poate strange si mai multi bani :)</h3><br>
				
<?php		
				}
				else
				{
				?>
				<h3> Deja l-ai votat pe <?php echo $auth; ?> o mai poti face peste odata peste 24 de ore. </h3>
				<?php
				}
			}
			else
			{
			?>
			<h3>Link Invalid</h3>
			<?php
			}
		}
		else
		{
		?>
		<h3>ICP.Infectati.ro foloseste Cookies, pentru a proteja anti-spam-ul, te rog activeaza-ti cookie-urile si apoi revino.</h3>
		<?php
		}
				

		}
		else
		{
			header("Location: index.php");
		}
		?>
    </div>
          <div class="clear"></div>
		 <?php
			require 'foother.php';
		 ?>
        </div>
</div>
</body>
</html>