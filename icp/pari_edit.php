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
			if (($adminu == "da") && ($_SESSION['id']))
			{
			require 'meniu.php';
			
			if($_POST['submit']=='Salveaza')
			{
			
					$_POST['clan1'] = mysql_real_escape_string($_POST['clan1']);
					$_POST['clan2'] = mysql_real_escape_string($_POST['clan2']);
					$_POST['clan3'] = mysql_real_escape_string($_POST['clan3']);
					$_POST['clan4'] = mysql_real_escape_string($_POST['clan4']);
					$_POST['clan5'] = mysql_real_escape_string($_POST['clan5']);
					$_POST['clan6'] = mysql_real_escape_string($_POST['clan6']);
					$_POST['clan8'] = mysql_real_escape_string($_POST['clan8']);
					$_POST['clan9'] = mysql_real_escape_string($_POST['clan9']);
					$_POST['clan10'] = mysql_real_escape_string($_POST['clan10']);
					$_POST['clan11'] = mysql_real_escape_string($_POST['clan11']);
					$_POST['clan12'] = mysql_real_escape_string($_POST['clan12']);
					$_POST['clan13'] = mysql_real_escape_string($_POST['clan13']);
					$_POST['clan14'] = mysql_real_escape_string($_POST['clan14']);
					$_POST['clan15'] = mysql_real_escape_string($_POST['clan15']);
				
					
					$_POST['echipa1'] = mysql_real_escape_string($_POST['echipa1']);
					$_POST['echipa2'] = mysql_real_escape_string($_POST['echipa2']);
					$_POST['echipa3'] = mysql_real_escape_string($_POST['echipa3']);
					$_POST['echipa4'] = mysql_real_escape_string($_POST['echipa4']);
					$_POST['echipa5'] = mysql_real_escape_string($_POST['echipa5']);
					$_POST['echipa6'] = mysql_real_escape_string($_POST['echipa6']);
					$_POST['echipa7'] = mysql_real_escape_string($_POST['echipa7']);
					$_POST['echipa8'] = mysql_real_escape_string($_POST['echipa8']);
					$_POST['echipa9'] = mysql_real_escape_string($_POST['echipa9']);
					$_POST['echipa10'] = mysql_real_escape_string($_POST['echipa10']);
					$_POST['echipa11'] = mysql_real_escape_string($_POST['echipa11']);
					$_POST['echipa12'] = mysql_real_escape_string($_POST['echipa12']);
					$_POST['echipa13'] = mysql_real_escape_string($_POST['echipa13']);
					$_POST['echipa14'] = mysql_real_escape_string($_POST['echipa14']);
					$_POST['echipa15'] = mysql_real_escape_string($_POST['echipa15']);
					
					
					$_POST['adv_clan1'] = mysql_real_escape_string($_POST['adv_clan1']);
					$_POST['adv_clan2'] = mysql_real_escape_string($_POST['adv_clan2']);
					$_POST['adv_clan3'] = mysql_real_escape_string($_POST['adv_clan3']);
					$_POST['adv_clan4'] = mysql_real_escape_string($_POST['adv_clan4']);
					$_POST['adv_clan5'] = mysql_real_escape_string($_POST['adv_clan5']);
					$_POST['adv_clan6'] = mysql_real_escape_string($_POST['adv_clan6']);
					$_POST['adv_clan7'] = mysql_real_escape_string($_POST['adv_clan7']);
					$_POST['adv_clan8'] = mysql_real_escape_string($_POST['adv_clan8']);
					$_POST['adv_clan9'] = mysql_real_escape_string($_POST['adv_clan9']);
					$_POST['adv_clan10'] = mysql_real_escape_string($_POST['adv_clan10']);
					$_POST['adv_clan11'] = mysql_real_escape_string($_POST['adv_clan11']);
					$_POST['adv_clan12'] = mysql_real_escape_string($_POST['adv_clan12']);
					$_POST['adv_clan13'] = mysql_real_escape_string($_POST['adv_clan13']);
					$_POST['adv_clan14'] = mysql_real_escape_string($_POST['adv_clan14']);
					$_POST['adv_clan15'] = mysql_real_escape_string($_POST['adv_clan15']);
					
					
					mysql_query("	UPDATE pari_edit
						SET				
							clan1 = '".$_POST['clan1']."',
							echipa_castigatoare = '".$_POST['echipa1']."',
							dezactivat = '".$_POST['dezactivat1']."',
							data = '".$_POST['data1']."',
							cota1 = '".$_POST['cota_clan1']."',
							clan2 = '".$_POST['adv_clan1']."',
							cota2 = '".$_POST['cota_adv_clan1']."'
						WHERE id = '1'");
					mysql_query("	UPDATE pari_edit
						SET				
							clan1 = '".$_POST['clan2']."',
							echipa_castigatoare = '".$_POST['echipa2']."',
							data = '".$_POST['data2']."',
							dezactivat = '".$_POST['dezactivat2']."',
							cota1 = '".$_POST['cota_clan2']."',
							clan2 = '".$_POST['adv_clan2']."',
							cota2 = '".$_POST['cota_adv_clan2']."'
						WHERE id = '2'");
					mysql_query("	UPDATE pari_edit
						SET				
							clan1 = '".$_POST['clan3']."',
							echipa_castigatoare = '".$_POST['echipa3']."',
							dezactivat = '".$_POST['dezactivat3']."',
							data = '".$_POST['data3']."',
							cota1 = '".$_POST['cota_clan3']."',
							clan2 = '".$_POST['adv_clan3']."',
							cota2 = '".$_POST['cota_adv_clan3']."'
						WHERE id = '3'");	
					mysql_query("	UPDATE pari_edit
						SET				
							clan1 = '".$_POST['clan4']."',
							echipa_castigatoare = '".$_POST['echipa4']."',
							dezactivat = '".$_POST['dezactivat4']."',
							data = '".$_POST['data4']."',
							cota1 = '".$_POST['cota_clan4']."',
							clan2 = '".$_POST['adv_clan4']."',
							cota2 = '".$_POST['cota_adv_clan4']."'
						WHERE id = '4'");	
					mysql_query("	UPDATE pari_edit
						SET				
							clan1 = '".$_POST['clan5']."',
							echipa_castigatoare = '".$_POST['echipa5']."',
							dezactivat = '".$_POST['dezactivat5']."',
							data = '".$_POST['data5']."',
							cota1 = '".$_POST['cota_clan5']."',
							clan2 = '".$_POST['adv_clan5']."',
							cota2 = '".$_POST['cota_adv_clan5']."'
						WHERE id = '5'");	
					mysql_query("	UPDATE pari_edit
						SET				
							clan1 = '".$_POST['clan6']."',
							echipa_castigatoare = '".$_POST['echipa6']."',
							dezactivat = '".$_POST['dezactivat6']."',
							data = '".$_POST['data6']."',
							cota1 = '".$_POST['cota_clan6']."',
							clan2 = '".$_POST['adv_clan6']."',
							cota2 = '".$_POST['cota_adv_clan6']."'
						WHERE id = '6'");
					mysql_query("	UPDATE pari_edit
						SET				
							clan1 = '".$_POST['clan7']."',
							echipa_castigatoare = '".$_POST['echipa7']."',
							dezactivat = '".$_POST['dezactivat7']."',
							data = '".$_POST['data7']."',
							cota1 = '".$_POST['cota_clan7']."',
							clan2 = '".$_POST['adv_clan7']."',
							cota2 = '".$_POST['cota_adv_clan7']."'
						WHERE id = '7'");
					mysql_query("	UPDATE pari_edit
						SET				
							clan1 = '".$_POST['clan8']."',
							echipa_castigatoare = '".$_POST['echipa8']."',
							dezactivat = '".$_POST['dezactivat8']."',
							data = '".$_POST['data8']."',
							cota1 = '".$_POST['cota_clan8']."',
							clan2 = '".$_POST['adv_clan8']."',
							cota2 = '".$_POST['cota_adv_clan8']."'
						WHERE id = '8'");
					mysql_query("	UPDATE pari_edit
						SET				
							clan1 = '".$_POST['clan9']."',
							echipa_castigatoare = '".$_POST['echipa9']."',
							dezactivat = '".$_POST['dezactivat9']."',
							data = '".$_POST['data9']."',
							cota1 = '".$_POST['cota_clan9']."',
							clan2 = '".$_POST['adv_clan9']."',
							cota2 = '".$_POST['cota_adv_clan9']."'
						WHERE id = '9'");
					mysql_query("	UPDATE pari_edit
						SET				
							clan1 = '".$_POST['clan10']."',
							echipa_castigatoare = '".$_POST['echipa10']."',
							dezactivat = '".$_POST['dezactivat10']."',
							data = '".$_POST['data10']."',
							cota1 = '".$_POST['cota_clan10']."',
							clan2 = '".$_POST['adv_clan10']."',
							cota2 = '".$_POST['cota_adv_clan10']."'
						WHERE id = '10'");		
					mysql_query("	UPDATE pari_edit
						SET				
							clan1 = '".$_POST['clan11']."',
							echipa_castigatoare = '".$_POST['echipa11']."',
							dezactivat = '".$_POST['dezactivat11']."',
							data = '".$_POST['data11']."',
							cota1 = '".$_POST['cota_clan11']."',
							clan2 = '".$_POST['adv_clan11']."',
							cota2 = '".$_POST['cota_adv_clan11']."'
						WHERE id = '11'");	
					mysql_query("	UPDATE pari_edit
						SET				
							clan1 = '".$_POST['clan12']."',
							echipa_castigatoare = '".$_POST['echipa12']."',
							dezactivat = '".$_POST['dezactivat12']."',
							data = '".$_POST['data12']."',
							cota1 = '".$_POST['cota_clan12']."',
							clan2 = '".$_POST['adv_clan12']."',
							cota2 = '".$_POST['cota_adv_clan12']."'
						WHERE id = '12'");		
					mysql_query("	UPDATE pari_edit
						SET				
							clan1 = '".$_POST['clan13']."',
							echipa_castigatoare = '".$_POST['echipa13']."',
							dezactivat = '".$_POST['dezactivat13']."',
							data = '".$_POST['data13']."',
							cota1 = '".$_POST['cota_clan13']."',
							clan2 = '".$_POST['adv_clan13']."',
							cota2 = '".$_POST['cota_adv_clan13']."'
						WHERE id = '13'");
					mysql_query("	UPDATE pari_edit
						SET				
							clan1 = '".$_POST['clan14']."',
							echipa_castigatoare = '".$_POST['echipa14']."',
							dezactivat = '".$_POST['dezactivat14']."',
							data = '".$_POST['data14']."',
							cota1 = '".$_POST['cota_clan14']."',
							clan2 = '".$_POST['adv_clan14']."',
							cota2 = '".$_POST['cota_adv_clan14']."'
						WHERE id = '14'");	
					mysql_query("	UPDATE pari_edit
						SET				
							clan1 = '".$_POST['clan15']."',
							echipa_castigatoare = '".$_POST['echipa15']."',
							dezactivat = '".$_POST['dezactivat15']."',
							data = '".$_POST['data15']."',
							cota1 = '".$_POST['cota_clan15']."',
							clan2 = '".$_POST['adv_clan15']."',
							cota2 = '".$_POST['cota_adv_clan15']."'
						WHERE id = '15'");						
			}
		$command1 = mysql_query("SELECT * FROM pari_edit WHERE id = '1'");
		$results1 = mysql_fetch_assoc($command1);
		$command2 = mysql_query("SELECT * FROM pari_edit WHERE id = '2'");
		$results2 = mysql_fetch_assoc($command2);
		$command3 = mysql_query("SELECT * FROM pari_edit WHERE id = '3'");
		$results3 = mysql_fetch_assoc($command3);
		$command4 = mysql_query("SELECT * FROM pari_edit WHERE id = '4'");
		$results4 = mysql_fetch_assoc($command4);
		$command5 = mysql_query("SELECT * FROM pari_edit WHERE id = '5'");
		$results5 = mysql_fetch_assoc($command5);
		$command6 = mysql_query("SELECT * FROM pari_edit WHERE id = '6'");
		$results6 = mysql_fetch_assoc($command6);
		$command7 = mysql_query("SELECT * FROM pari_edit WHERE id = '7'");
		$results7 = mysql_fetch_assoc($command7);
		$command8 = mysql_query("SELECT * FROM pari_edit WHERE id = '8'");
		$results8 = mysql_fetch_assoc($command8);
		$command9 = mysql_query("SELECT * FROM pari_edit WHERE id = '9'");
		$results9 = mysql_fetch_assoc($command9);
		$command10 = mysql_query("SELECT * FROM pari_edit WHERE id = '10'");
		$results10 = mysql_fetch_assoc($command10);
		$command11 = mysql_query("SELECT * FROM pari_edit WHERE id = '11'");
		$results11 = mysql_fetch_assoc($command11);
		$command12 = mysql_query("SELECT * FROM pari_edit WHERE id = '12'");
		$results12 = mysql_fetch_assoc($command12);
		$command13 = mysql_query("SELECT * FROM pari_edit WHERE id = '13'");
		$results13 = mysql_fetch_assoc($command13);
		$command14 = mysql_query("SELECT * FROM pari_edit WHERE id = '14'");
		$results14 = mysql_fetch_assoc($command14);
		$command15 = mysql_query("SELECT * FROM pari_edit WHERE id = '15'");
		$results15 = mysql_fetch_assoc($command15);
		?>
        
        <div class="container">
		<h1>Editeaza Pariuri Clanuri</h1><br>
		<form name="off_pari" action="" method="post">

		<h3>1. Clanul: <input type="text" name="clan1" value="<?php echo $results1["clan1"]; ?>"> vs Clanul <input type="text" name="adv_clan1" value="<?php echo $results1["clan2"]; ?>"> Data: <input type="text" name="data1" value="<?php echo $results1["data"]; ?>">Echipa castigatoare: <input type="text" name="echipa1" value="<?php echo $results1["echipa_castigatoare"]; ?>"> Dezactivat: <input type="text" name="dezactivat1" value="<?php echo $results1["dezactivat"]; ?>"><br></h3><br>
		<h3>&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_clan1" value="<?php echo $results1["cota1"]; ?>">&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_adv_clan1" value="<?php echo $results1["cota2"]; ?>"><br></h3><br>
		<h3>2. Clanul: <input type="text" name="clan2" value="<?php echo $results2["clan1"]; ?>"> vs Clanul <input type="text" name="adv_clan2" value="<?php echo $results2["clan2"]; ?>"> Data: <input type="text" name="data2" value="<?php echo $results2["data"]; ?>">Echipa castigatoare: <input type="text" name="echipa2" value="<?php echo $results2["echipa_castigatoare"]; ?>"> Dezactivat: <input type="text" name="dezactivat2" value="<?php echo $results2["dezactivat"]; ?>"><br></h3><br>
		<h3>&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_clan2" value="<?php echo $results2["cota1"]; ?>">&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_adv_clan2" value="<?php echo $results2["cota2"]; ?>"><br></h3><br>		
		<h3>3. Clanul: <input type="text" name="clan3" value="<?php echo $results3["clan1"]; ?>"> vs Clanul <input type="text" name="adv_clan3" value="<?php echo $results3["clan2"]; ?>"> Data: <input type="text" name="data3" value="<?php echo $results3["data"]; ?>">Echipa castigatoare: <input type="text" name="echipa3" value="<?php echo $results3["echipa_castigatoare"]; ?>"> Dezactivat: <input type="text" name="dezactivat3" value="<?php echo $results3["dezactivat"]; ?>"><br></h3><br>
		<h3>&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_clan3" value="<?php echo $results3["cota1"]; ?>">&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_adv_clan3" value="<?php echo $results3["cota2"]; ?>"><br></h3><br>
		<h3>4. Clanul: <input type="text" name="clan4" value="<?php echo $results4["clan1"]; ?>"> vs Clanul <input type="text" name="adv_clan4" value="<?php echo $results4["clan2"]; ?>"> Data: <input type="text" name="data4" value="<?php echo $results4["data"]; ?>">Echipa castigatoare: <input type="text" name="echipa4" value="<?php echo $results4["echipa_castigatoare"]; ?>"> Dezactivat: <input type="text" name="dezactivat4" value="<?php echo $results4["dezactivat"]; ?>"><br></h3><br>
		<h3>&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_clan4" value="<?php echo $results4["cota1"]; ?>">&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_adv_clan4" value="<?php echo $results4["cota2"]; ?>"><br></h3><br>
		<h3>5. Clanul: <input type="text" name="clan5" value="<?php echo $results5["clan1"]; ?>"> vs Clanul <input type="text" name="adv_clan5" value="<?php echo $results5["clan2"]; ?>"> Data: <input type="text" name="data5" value="<?php echo $results5["data"]; ?>">Echipa castigatoare: <input type="text" name="echipa5" value="<?php echo $results5["echipa_castigatoare"]; ?>"> Dezactivat: <input type="text" name="dezactivat5" value="<?php echo $results5["dezactivat"]; ?>"><br></h3><br>
		<h3>&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_clan5" value="<?php echo $results5["cota1"]; ?>">&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_adv_clan5" value="<?php echo $results5["cota2"]; ?>"><br></h3><br>
		<h3>6. Clanul: <input type="text" name="clan6" value="<?php echo $results6["clan1"]; ?>"> vs Clanul <input type="text" name="adv_clan6" value="<?php echo $results6["clan2"]; ?>"> Data: <input type="text" name="data6" value="<?php echo $results6["data"]; ?>">Echipa castigatoare: <input type="text" name="echipa6" value="<?php echo $results6["echipa_castigatoare"]; ?>"> Dezactivat: <input type="text" name="dezactivat6" value="<?php echo $results6["dezactivat"]; ?>"><br></h3><br>
		<h3>&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_clan6" value="<?php echo $results6["cota1"]; ?>">&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_adv_clan6" value="<?php echo $results6["cota2"]; ?>"><br></h3><br>
		<h3>7. Clanul: <input type="text" name="clan7" value="<?php echo $results7["clan1"]; ?>"> vs Clanul <input type="text" name="adv_clan7" value="<?php echo $results7["clan2"]; ?>"> Data: <input type="text" name="data7" value="<?php echo $results7["data"]; ?>">Echipa castigatoare: <input type="text" name="echipa7" value="<?php echo $results7["echipa_castigatoare"]; ?>"> Dezactivat: <input type="text" name="dezactivat7" value="<?php echo $results7["dezactivat"]; ?>"><br></h3><br>
		<h3>&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_clan7" value="<?php echo $results7["cota1"]; ?>">&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_adv_clan7" value="<?php echo $results7["cota2"]; ?>"><br></h3><br>
		<h3>8. Clanul: <input type="text" name="clan8" value="<?php echo $results8["clan1"]; ?>"> vs Clanul <input type="text" name="adv_clan8" value="<?php echo $results8["clan2"]; ?>"> Data: <input type="text" name="data8" value="<?php echo $results8["data"]; ?>">Echipa castigatoare: <input type="text" name="echipa8" value="<?php echo $results8["echipa_castigatoare"]; ?>"> Dezactivat: <input type="text" name="dezactivat8" value="<?php echo $results8["dezactivat"]; ?>"><br></h3><br>
		<h3>&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_clan8" value="<?php echo $results8["cota1"]; ?>">&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_adv_clan8" value="<?php echo $results8["cota2"]; ?>"><br></h3><br>
		<h3>9. Clanul: <input type="text" name="clan9" value="<?php echo $results9["clan1"]; ?>"> vs Clanul <input type="text" name="adv_clan9" value="<?php echo $results9["clan2"]; ?>"> Data: <input type="text" name="data9" value="<?php echo $results9["data"]; ?>">Echipa castigatoare: <input type="text" name="echipa9" value="<?php echo $results9["echipa_castigatoare"]; ?>"> Dezactivat: <input type="text" name="dezactivat9" value="<?php echo $results9["dezactivat"]; ?>"><br></h3><br>
		<h3>&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_clan9" value="<?php echo $results9["cota1"]; ?>">&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_adv_clan9" value="<?php echo $results9["cota2"]; ?>"><br></h3><br>
		<h3>10. Clanul: <input type="text" name="clan10" value="<?php echo $results10["clan1"]; ?>"> vs Clanul <input type="text" name="adv_clan10" value="<?php echo $results10["clan2"]; ?>"> Data: <input type="text" name="data10" value="<?php echo $results10["data"]; ?>">Echipa castigatoare: <input type="text" name="echipa10" value="<?php echo $results10["echipa_castigatoare"]; ?>"> Dezactivat: <input type="text" name="dezactivat10" value="<?php echo $results10["dezactivat"]; ?>"><br></h3><br>
		<h3>&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_clan10" value="<?php echo $results10["cota1"]; ?>">&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_adv_clan10" value="<?php echo $results10["cota2"]; ?>"><br></h3><br>
		<h3>11. Clanul: <input type="text" name="clan11" value="<?php echo $results11["clan1"]; ?>"> vs Clanul <input type="text" name="adv_clan11" value="<?php echo $results11["clan2"]; ?>"> Data: <input type="text" name="data11" value="<?php echo $results11["data"]; ?>">Echipa castigatoare: <input type="text" name="echipa11" value="<?php echo $results11["echipa_castigatoare"]; ?>"> Dezactivat: <input type="text" name="dezactivat11" value="<?php echo $results11["dezactivat"]; ?>"><br></h3><br>
		<h3>&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_clan11" value="<?php echo $results11["cota1"]; ?>">&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_adv_clan11" value="<?php echo $results11["cota2"]; ?>"><br></h3><br>
		<h3>12. Clanul: <input type="text" name="clan12" value="<?php echo $results12["clan1"]; ?>"> vs Clanul <input type="text" name="adv_clan12" value="<?php echo $results12["clan2"]; ?>"> Data: <input type="text" name="data12" value="<?php echo $results12["data"]; ?>">Echipa castigatoare: <input type="text" name="echipa12" value="<?php echo $results12["echipa_castigatoare"]; ?>"> Dezactivat: <input type="text" name="dezactivat12" value="<?php echo $results12["dezactivat"]; ?>"><br></h3><br>
		<h3>&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_clan12" value="<?php echo $results12["cota1"]; ?>">&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_adv_clan12" value="<?php echo $results12["cota2"]; ?>"><br></h3><br>
		<h3>13. Clanul: <input type="text" name="clan13" value="<?php echo $results13["clan1"]; ?>"> vs Clanul <input type="text" name="adv_clan13" value="<?php echo $results13["clan2"]; ?>"> Data: <input type="text" name="data13" value="<?php echo $results13["data"]; ?>">Echipa castigatoare: <input type="text" name="echipa13" value="<?php echo $results13["echipa_castigatoare"]; ?>"> Dezactivat: <input type="text" name="dezactivat13" value="<?php echo $results13["dezactivat"]; ?>"><br></h3><br>
		<h3>&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_clan13" value="<?php echo $results13["cota1"]; ?>">&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_adv_clan13" value="<?php echo $results13["cota2"]; ?>"><br></h3><br>
		<h3>14. Clanul: <input type="text" name="clan14" value="<?php echo $results14["clan1"]; ?>"> vs Clanul <input type="text" name="adv_clan14" value="<?php echo $results14["clan2"]; ?>"> Data: <input type="text" name="data14" value="<?php echo $results14["data"]; ?>">Echipa castigatoare: <input type="text" name="echipa14" value="<?php echo $results14["echipa_castigatoare"]; ?>"> Dezactivat: <input type="text" name="dezactivat14" value="<?php echo $results14["dezactivat"]; ?>"><br></h3><br>
		<h3>&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_clan14" value="<?php echo $results14["cota1"]; ?>">&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_adv_clan14" value="<?php echo $results14["cota2"]; ?>"><br></h3><br>
		<h3>15. Clanul: <input type="text" name="clan15" value="<?php echo $results15["clan1"]; ?>"> vs Clanul <input type="text" name="adv_clan15" value="<?php echo $results15["clan2"]; ?>"> Data: <input type="text" name="data15" value="<?php echo $results15["data"]; ?>">Echipa castigatoare: <input type="text" name="echipa15" value="<?php echo $results15["echipa_castigatoare"]; ?>"> Dezactivat: <input type="text" name="dezactivat15" value="<?php echo $results15["dezactivat"]; ?>"><br></h3><br>
		<h3>&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_clan15" value="<?php echo $results15["cota1"]; ?>">&nbsp &nbsp &nbsp &nbsp Cota: <input type="text" name="cota_adv_clan15" value="<?php echo $results15["cota2"]; ?>"><br></h3><br>
		
		<h3>-1 dezactiveaza caseta</h3><br>
		<input type="submit" name="submit" value="Salveaza" class="buton_albastru"/>
		</form>
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
