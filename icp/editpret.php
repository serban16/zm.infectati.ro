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
			
			$commanda="SELECT * FROM preturi WHERE nume_produs = 'zm_slot'";
			$resultsa = mysql_query($commanda);
			while($rowa = mysql_fetch_array($resultsa))
			{
				$pret = $rowa["pret"];
			}
			$commanda2="SELECT * FROM preturi WHERE nume_produs = 'zm_mini_admin'";
			$resultsa2 = mysql_query($commanda2);
			while($rowa2 = mysql_fetch_array($resultsa2))
			{
				$pret2 = $rowa2["pret"];
			}
			$commanda3="SELECT * FROM preturi WHERE nume_produs = 'zm_co_administrator'";
			$resultsa3 = mysql_query($commanda3);
			while($rowa3 = mysql_fetch_array($resultsa3))
			{
				$pret3 = $rowa3["pret"];
			}
			$commanda4="SELECT * FROM preturi WHERE nume_produs = 'zm_administrator'";
			$resultsa4 = mysql_query($commanda4);
			while($rowa4 = mysql_fetch_array($resultsa4))
			{
				$pret4 = $rowa4["pret"];
			}
			$commanda5="SELECT * FROM preturi WHERE nume_produs = 'zm_owner'";
			$resultsa5 = mysql_query($commanda5);
			while($rowa5 = mysql_fetch_array($resultsa5))
			{
				$pret5 = $rowa5["pret"];
			}
			$commanda6="SELECT * FROM preturi WHERE nume_produs = 'zm_vip'";
			$resultsa6 = mysql_query($commanda6);
			while($rowa6 = mysql_fetch_array($resultsa6))
			{
				$pret6 = $rowa6["pret"];
			}
			$commanda7="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_1000'";
			$resultsa7 = mysql_query($commanda7);
			while($rowa7 = mysql_fetch_array($resultsa7))
			{
				$pret7 = $rowa7["pret"];
			}
			$commanda8="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_1500'";
			$resultsa8 = mysql_query($commanda8);
			while($rowa8 = mysql_fetch_array($resultsa8))
			{
				$pret8 = $rowa8["pret"];
			}
			$commanda9="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_2000'";
			$resultsa9 = mysql_query($commanda9);
			while($rowa9 = mysql_fetch_array($resultsa9))
			{
				$pret9 = $rowa9["pret"];
			}
			$commanda10="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_2500'";
			$resultsa10 = mysql_query($commanda10);
			while($rowa10 = mysql_fetch_array($resultsa10))
			{
				$pret10 = $rowa10["pret"];
			}
			
			$commanda11="SELECT * FROM preturi WHERE nume_produs = 'cs_slot'";
			$resultsa11 = mysql_query($commanda11);
			while($rowa11 = mysql_fetch_array($resultsa11))
			{
				$pret11 = $rowa11["pret"];
			}
			$commanda12="SELECT * FROM preturi WHERE nume_produs = 'cs_mini_admin'";
			$resultsa12 = mysql_query($commanda12);
			while($rowa12 = mysql_fetch_array($resultsa12))
			{
				$pret12 = $rowa12["pret"];
			}
			$commanda13="SELECT * FROM preturi WHERE nume_produs = 'cs_co_administrator'";
			$resultsa13 = mysql_query($commanda13);
			while($rowa13 = mysql_fetch_array($resultsa13))
			{
				$pret13 = $rowa13["pret"];
			}
			$commanda14="SELECT * FROM preturi WHERE nume_produs = 'cs_administrator'";
			$resultsa14 = mysql_query($commanda14);
			while($rowa14 = mysql_fetch_array($resultsa14))
			{
				$pret14 = $rowa14["pret"];
			}
			$commanda15="SELECT * FROM preturi WHERE nume_produs = 'cs_owner'";
			$resultsa15 = mysql_query($commanda15);
			while($rowa15 = mysql_fetch_array($resultsa15))
			{
				$pret15 = $rowa15["pret"];
			}
			$commanda16="SELECT * FROM preturi WHERE nume_produs = 'csgo_slot'";
			$resultsa16 = mysql_query($commanda16);
			while($rowa16 = mysql_fetch_array($resultsa16))
			{
				$pret16 = $rowa16["pret"];
			}
			$commanda17="SELECT * FROM preturi WHERE nume_produs = 'csgo_mini_admin'";
			$resultsa17 = mysql_query($commanda17);
			while($rowa17 = mysql_fetch_array($resultsa17))
			{
				$pret17 = $rowa17["pret"];
			}
			$commanda18="SELECT * FROM preturi WHERE nume_produs = 'csgo_co_administrator'";
			$resultsa18 = mysql_query($commanda18);
			while($rowa18 = mysql_fetch_array($resultsa18))
			{
				$pret18 = $rowa18["pret"];
			}
			$commanda19="SELECT * FROM preturi WHERE nume_produs = 'csgo_administrator'";
			$resultsa19 = mysql_query($commanda19);
			while($rowa19 = mysql_fetch_array($resultsa19))
			{
				$pret19 = $rowa19["pret"];
			}
			$commanda20="SELECT * FROM preturi WHERE nume_produs = 'csgo_owner'";
			$resultsa20 = mysql_query($commanda20);
			while($rowa20 = mysql_fetch_array($resultsa20))
			{
				$pret20 = $rowa20["pret"];
			}
		if($_POST['submit2']=='Editeaza')
		{
				mysql_query("	UPDATE preturi
					SET				
						pret =	'".$_POST['pret']."'
								
					WHERE nume_produs = 'zm_slot'");
				mysql_query("	UPDATE preturi
					SET				
						pret =	'".$_POST['pret2']."'
								
					WHERE nume_produs = 'zm_mini_admin'");
				mysql_query("	UPDATE preturi
					SET				
						pret =	'".$_POST['pret3']."'
								
					WHERE nume_produs = 'zm_co_administrator'");
				mysql_query("	UPDATE preturi
					SET				
						pret =	'".$_POST['pret4']."'
								
					WHERE nume_produs = 'zm_administrator'");
				mysql_query("	UPDATE preturi
					SET				
						pret =	'".$_POST['pret5']."'
								
					WHERE nume_produs = 'zm_owner'");
				mysql_query("	UPDATE preturi
					SET				
						pret =	'".$_POST['pret6']."'
								
					WHERE nume_produs = 'zm_vip'");
				mysql_query("	UPDATE preturi
					SET				
						pret =	'".$_POST['pret7']."'
								
					WHERE nume_produs = 'zm_banca_1000'");
				mysql_query("	UPDATE preturi
					SET				
						pret =	'".$_POST['pret8']."'
								
					WHERE nume_produs = 'zm_banca_1500'");
				mysql_query("	UPDATE preturi
					SET				
						pret =	'".$_POST['pret9']."'
								
					WHERE nume_produs = 'zm_banca_2000'");
				mysql_query("	UPDATE preturi
					SET				
						pret =	'".$_POST['pret10']."'
								
					WHERE nume_produs = 'zm_banca_2500'");
				
				mysql_query("	UPDATE preturi
					SET				
						pret =	'".$_POST['pret11']."'
								
					WHERE nume_produs = 'cs_slot'");
				mysql_query("	UPDATE preturi
					SET				
						pret =	'".$_POST['pret12']."'
								
					WHERE nume_produs = 'cs_mini_admin'");
				mysql_query("	UPDATE preturi
					SET				
						pret =	'".$_POST['pret13']."'
								
					WHERE nume_produs = 'cs_co_administrator'");
				mysql_query("	UPDATE preturi
					SET				
						pret =	'".$_POST['pret14']."'
								
					WHERE nume_produs = 'cs_administrator'");
				mysql_query("	UPDATE preturi
					SET				
						pret =	'".$_POST['pret15']."'
								
					WHERE nume_produs = 'cs_owner'");
				mysql_query("	UPDATE preturi
					SET				
						pret =	'".$_POST['pret16']."'
								
					WHERE nume_produs = 'csgo_slot'");
				mysql_query("	UPDATE preturi
					SET				
						pret =	'".$_POST['pret17']."'
								
					WHERE nume_produs = 'csgo_mini_admin'");
				mysql_query("	UPDATE preturi
					SET				
						pret =	'".$_POST['pret18']."'
								
					WHERE nume_produs = 'csgo_co_administrator'");
				mysql_query("	UPDATE preturi
					SET				
						pret =	'".$_POST['pret19']."'
								
					WHERE nume_produs = 'csgo_administrator'");
				mysql_query("	UPDATE preturi
					SET				
						pret =	'".$_POST['pret20']."'
								
					WHERE nume_produs = 'csgo_owner'");
			
			header("Location: setari_editate.php");
		}
		?>
        
        <div class="container">
		
		<form name="form2" method="post" action="">
		
			<h1>Editeaza Preturi Cs.infectati.ro</h1><br>
			
			<h3>Slot: <input type="text" name="pret11" value="<?php echo $pret11; ?>" /> Euro</h3>
			<h3>Mini-Admin: <input type="text" name="pret12" value="<?php echo $pret12; ?>" /> Euro</h3>
			<h3>Co-Administrator: <input type="text" name="pret13" value="<?php echo $pret13; ?>" /> Euro</h3>
			<h3>Administrator: <input type="text" name="pret14" value="<?php echo $pret14; ?>" /> Euro</h3>
			<h3>Owner: <input type="text" name="pret15" value="<?php echo $pret15; ?>" /> Euro</h3>	<br>		
			
			<h1>Editeaza Preturi Zm.infectati.ro</h1><br>
			
			<h3>VIP: <input type="text" name="pret6" value="<?php echo $pret6; ?>" /> Euro</h3>
			<h3>Slot: <input type="text" name="pret" value="<?php echo $pret; ?>" /> Euro</h3>
			<h3>Mini-Admin: <input type="text" name="pret2" value="<?php echo $pret2; ?>" /> Euro</h3>
			<h3>Co-Administrator: <input type="text" name="pret3" value="<?php echo $pret3; ?>" /> Euro</h3>
			<h3>Administrator: <input type="text" name="pret4" value="<?php echo $pret4; ?>" /> Euro</h3>
			<h3>Owner: <input type="text" name="pret5" value="<?php echo $pret5; ?>" /> Euro</h3>
			<h3>Marire banca la 1000 Euro: <input type="text" name="pret7" value="<?php echo $pret7; ?>" /> Euro</h3>
			<h3>Marire banca la 1500 Euro: <input type="text" name="pret8" value="<?php echo $pret8; ?>" /> Euro</h3>
			<h3>Marire banca la 2000 Euro: <input type="text" name="pret9" value="<?php echo $pret9; ?>" /> Euro</h3>
			<h3>Marire banca la 2500 Euro: <input type="text" name="pret10" value="<?php echo $pret10; ?>" /> Euro</h3><br>
			
			<h1>Editeaza Preturi CsGo.infectati.ro</h1><br>
			
			<h3>Slot: <input type="text" name="pret16" value="<?php echo $pret16; ?>" /> Euro</h3>
			<h3>Mini-Admin: <input type="text" name="pret17" value="<?php echo $pret17; ?>" /> Euro</h3>
			<h3>Co-Administrator: <input type="text" name="pret18" value="<?php echo $pret18; ?>" /> Euro</h3>
			<h3>Administrator: <input type="text" name="pret19" value="<?php echo $pret19; ?>" /> Euro</h3>
			<h3>Owner: <input type="text" name="pret20" value="<?php echo $pret20; ?>" /> Euro</h3>	<br>	
			
			<input type="submit" name="submit2" value="Editeaza" class="buton_albastru" /></h3>
		
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
