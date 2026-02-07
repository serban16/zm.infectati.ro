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
		  <h3><font color="#d10000">Anunt</font>: Daca ai gasit un bug(greseala) care este destul de importanta la acest sistem te rugam sa ne contactezi iar infectati.ro te recompenseaza.</h3><br>
          <h3><font color="#d10000">Atentie</font>: Gradul cumparat este posibil sa nu intre automat pe servere, asteptati sa se schimbe harta apoi gradul se v-a aplica si pe server, in cazul in care nu intra va rugam sa ne contactati.</h3>
			<br><br>
          <div class="clear"></div>
        </div>
        
	<?php
	require 'foother.php';
	?>	
    </div>
</div>

</body>
</html>

