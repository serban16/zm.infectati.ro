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
			if($_SESSION['id'])
			{
			require 'meniu.php'; 
		?>
        
        <div class="container">
		<h1>Doneaza euro din banca catre un alt Utilizator</h1><br>
		<form name="form1" method="post" action="doneaza_banca2.php">
			<h3>Cauta Utilizator: <input type="text" name="casuta" />
			<input type="submit" name="submit" value="Cauta" class="buton_albastru" /></h3>
		</form>
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
