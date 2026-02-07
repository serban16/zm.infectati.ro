<?php

define('INCLUDE_CHECK',true);

require 'connect.php';
require 'functions.php';
require 'header.php';

// Those two files can be included only if INCLUDE_CHECK is defined

?>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="login_panel/css/tabel_meciuri.css"/>
	<link href="style/style.css" rel="stylesheet" type="text/css">
</head>

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
				$pass = $row16["password"];
			}
			if ($_SESSION['id'])
			{
			$command256="SELECT * FROM setari WHERE id = '3'";
			$results256 = mysql_query($command256);
			
			while($row256 = mysql_fetch_array($results256))
				$link = $row256["valuare"];
			if ($link == "da") 
			{
			require 'meniu.php';
			
		?>
        
        <div class="container">
		<h1>Pariuri Clanuri</h1>
			<iframe src="/topor/index.php?user=<?php echo $_SESSION['auth']; ?>&pass=<?php echo $pass; ?>" name="frame1" scrolling="no" frameborder="no" align="center" height = "530px" width = "770px">
			</iframe>

    
          <div class="clear"></div>
		<?php
		}
		}
		else
			header("Location: index.php");
		?>
        </div>
        
	<?php
	require 'foother.php';
	?>	
    </div>
</div>

</body>
</html>
