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
		
		<?php if($_SESSION['id'])
		{ 
			require 'meniu.php'; 
		?>
        
        <div class="container">
		<?php
			$command2="SELECT * FROM tz_members WHERE id = '{$_SESSION['id']}'";
			$results2 = mysql_query($command2);
			while($row2 = mysql_fetch_array($results2))
			{
				$balanta = $row2["balanta"];
			}
			?>
		<h3>Ai prelungit gradul cu success, mai ai in contul tau <font color="#d10000"> <?php echo $balanta; ?></font> Euro.</h3>
          <div class="clear"></div>
		<?php
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
