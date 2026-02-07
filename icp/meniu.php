<br>
<div id='cssmenu'>
<ul>
   <li class='active'><a href='index.php'><span>Acasa</span></a></li>
   <li class='last'><a href='http://www.infectati.ro/forum'><span>Forum</span></a></li>
  	<?php if (isset($_SESSION['id'])) { ?> <li class='last'><a href='cont.php'><span>Contul meu</span></a></li> <?php } ?>
   <li class='has-sub'><a href='#'><span>Cumpara</span></a>
      <ul>
         <li><a href='cumparazm.php'><span>Cumpara Grad pe Zm.infectati.ro</span></a></li>
         <li><a href='cumparacs.php'><span>Cumpara Grad pe Cs.infectati.ro</span></a></li>
		 <li class='last'><a href='cumparacsgo.php'><span>Cumpara Grad pe CSGO.infectati.ro</span></a></li>
      </ul>
   </li>
  <?php
  			$command256="SELECT * FROM setari WHERE id = '3'";
			$results256 = mysql_query($command256);
			
			while($row256 = mysql_fetch_array($results256))
				$link = $row256["valuare"];
			if ($link == "da") 
			{ ?>
	<li class='last'><a href='pari.php'><span>Pariuri Clanuri</span></a></li>
	<?php } ?>
   <li class='last'><a href='contact.php'><span>Contact</span></a></li>
</ul>
</div>
