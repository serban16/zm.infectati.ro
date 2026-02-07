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
			$command16="SELECT * FROM tz_members WHERE id = '{$_SESSION['id']}'";
			$results16 = mysql_query($command16);
			while($row16 = mysql_fetch_array($results16))
			{
				$adminu = $row16["admin"];
			}
			if ($adminu == "da")
			{
			require 'meniu.php';
			$command2="SELECT * FROM tz_members WHERE id = '{$_SESSION['id']}'";
			$results2 = mysql_query($command2);
			while($row2 = mysql_fetch_array($results2))
			{
				$auth = $row2['auth'];
				$admin = $row2['admin'];
			}
			if ($_POST['submit1']=='Sterge')
			{
				mysql_query("DELETE FROM log WHERE data + interval 7 day < NOW()");
				mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth a sters jurnalele mai vechi de 7 zile pe icp','$admin',NOW())");
				header("Location: log.php");
			}
		?>
        
        <div class="container">
		<h1>Jurnal ICP</h1><br>
		<?php
			$numar = $_GET["nr"];
			if ($numar == 0)
				$numar = 25;
			$command1611="SELECT * FROM log ORDER BY id DESC LIMIT $numar";
			$results1611 = mysql_query($command1611);
			while($row1611 = mysql_fetch_array($results1611))
			{
		?><h3>La data de <?php echo $row1611['data'];?> <font color="#d10000"><?php echo $row1611['comanda'];?></font><?php if (($row1611['admin'] == "da") or ($row1611['admin'] == "avertisment")) { ?> si este Administrator pe ICP <?php } ?><br><br></h3>
		<?php
			}
		?>
		<form name="form1" method="post" action=""><h3>Sterge inregistrarile mai vechi de 7 zile <input type="submit" name="submit1" value="Sterge" class="buton_albastru" /></h3></form>
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