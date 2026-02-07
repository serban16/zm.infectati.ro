<?php

define('INCLUDE_CHECK',true);

require 'connect.php';
require 'functions.php';
require 'header.php';


// Those two files can be included only if INCLUDE_CHECK is defined



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
		<?php
			if($_SESSION['id'])
			{
				if ($_POST['casa3'] < $_POST['euro'])
				{ ?>
				<h1>Cantitatea specificate depaseste valoare contului tau bancar.</h1><br>
				<?php
				} else if ($_POST['euro'] < "0")
				{ ?>
				<h1>Cantitatea specificate trebuie sa fie mai mare ca zero.</h1><br>
				<?php
				} else
				{
					$nou = $_POST['casa2'] + $_POST['euro'];
					$vechi = $_POST['casa3'] - $_POST['euro'];
					mysql_query("	UPDATE zp_bank
					SET
						cantitate = '$nou'
								
					WHERE auth LIKE '".$_POST['casa']."'");
					mysql_query("	UPDATE zp_bank
					SET
						cantitate = '$vechi'
								
					WHERE auth LIKE '{$_SESSION['auth']}'");
					mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('{$_SESSION['auth']} i-a donat lui ".$_POST['casa']." ".$_POST['euro']." Euro','$admin',NOW())");
					?>
					<h1><?php echo 'I-ai trimis lui '; echo $_POST['casa']; echo ' '; echo $_POST['euro']; ?> Euro</h1><br>
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