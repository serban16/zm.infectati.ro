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
      <h1>Ne puteti contacta...</h1>
	  <br>
	  <h1>Telefonic</h1>
      <p><b>Pentru orice tip de probleme(adaugare fonduri, vanzari, probleme la accesul serviciului) ne puteti contacta la numarul de telefon <font color="#d10000">0341425658</font> de luni pana joi intre orele 13:00 - 16:30.</b></p>
	  <br>
	  <h1>Yahoo</h1>
	  <span>Email: infectati@yahoo.ro<br>&nbsp;<br></span><br>
     <a href="ymsgr:sendim?infectati" target="_self" title="Suport Yahoo Messenger">
     <img src="http://opi.yahoo.com/online?u=infectati&t=14" border="0"></img>
     </a>
	 <br>
	 <br>
	 <br>
	 <h1>Sau pentru urgente:</h1>
	 <br>
	 					<p>Email: serban_alexandru2001@yahoo.com</p>
					<a href="ymsgr:sendim?serban_alexandru2001" target="_self" title="Serbu">
					<img src="http://opi.yahoo.com/online?u=serban_alexandru2001&t=14" border="0"></img>
					</a>
	<br>
              <div class="clear"></div>
      </div>
        </div>
        
	<?php
	require 'foother.php';
	?>	
    </div>
</div>

</body>
</html>