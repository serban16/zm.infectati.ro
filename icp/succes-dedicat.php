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
		<h3>Server-ul din Constanta booteaza, te rog asteapta in jur de 2 minute pana la conectarea SSH.</h3>
		<?php
		}
		else
			header("Location: index.php");
		?>
          <div class="clear"></div>
        </div>
        
	<?php
	require 'foother.php';
	?>	
    </div>
</div>

</body>
</html>

