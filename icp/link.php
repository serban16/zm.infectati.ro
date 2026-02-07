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
		
		<?php
			$command256="SELECT * FROM setari WHERE id = '2'";
			$results256 = mysql_query($command256);
			
			while($row256 = mysql_fetch_array($results256))
				$link = $row256["valuare"];
			if (($link == "da") and ($_SESSION['id']))
			{
			require 'meniu.php'; 
		?>
        
        <div class="container">
		<h1>Link Unic</h1><br>
		<h3> Link-ul tau este:  <input type="text" name="link" value="http://icp.infectati.ro/adaugat_link.php?id=<?php echo $_SESSION['id']; ?>" readonly></h3><br>
		<h3>Cu ajutorul acestui link iti poti adauga fonduri automat in cont, mai exact trebuie trimis la cat mai multe persoane si ti se adauga fonduri in cont. Un vizitator = 0.01 Euro in cont, 300 vizitatori = 3 Euro in contul tau.</h3>
		<?php
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