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
        <h1>Contul Meu</h1>
        <h2>Infect Control Panel</h2>
        </div>
		
		<?php if(!$_SESSION['id'])
		{ 
			require 'meniu.php'; 
		?>
        
        <div class="container">
				<form class="clearfix" action="" method="post">
				<center>
					<h1>Autentifica-te</h1><br>
                    
                    <?php
						
						if($_SESSION['msg']['login-err'])
						{
							echo '<div class="err">'.$_SESSION['msg']['login-err'].'</div>';
							unset($_SESSION['msg']['login-err']);
						}
					?>
					
					<label class="grey" for="username">Nume de utilizator:</label>
					<input class="field" type="text" name="username" id="username" value="" size="23" /><br>
					<label class="grey" for="password">Parola:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<input class="field" type="password" name="password" id="password" size="23" /><br><br>
	            	<label><input name="rememberMe" id="rememberMe" type="checkbox" checked="checked" value="1" /> &nbsp;Tine-ma minte</label><br><br> 	<a href="parola_pierduta.php">Am uitat Numele de Utilizator si Parola</a><br><br>
        			<div class="clear"></div>
					<input type="submit" name="submit" value="Autentifica" class="buton_albastru" />
					</center>
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