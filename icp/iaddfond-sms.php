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

	

		<?php if($_SESSION['id'])

		{ 

		?>

        

        <div class="container">

        <?php

			$command2="SELECT * FROM tz_members WHERE id = '{$_SESSION['id']}'";

			$results2 = mysql_query($command2);

			while($row2 = mysql_fetch_array($results2))

			{

				$auth = $row2['auth'];

			}


		?>

		<h1>Adauga Fonduri</h1><br>

		<form action="" method="post">

			<?php
			 
			

		  $raspuns = file_get_contents('http://invalid.ro/icpinfectati.php?cod='.$_POST['cod']);
  
  
	  if ($raspuns == "incorect")
		  $stare = "nereusit";
	  else if ($raspuns > 0)
	  {
	
		$sqlCoins = "UPDATE tz_members SET balanta=balanta+".$raspuns." WHERE id='".$_SESSION['id']."' LIMIT 1";
		$qryCoins = mysql_query($sqlCoins);
		
		mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth a platit prin sms si i-am adaugat $raspuns Euro','Eu ICP-ul - ',NOW())");
		
		$stare = "reusit";
      
	  } else
		  $stare = "necunoscut";
	  
	if(isset($_POST['aufladenn']) && $_POST['aufladenn']=="Trimite") {
	if ($stare == "nereusit")
	{
			?>
	<div class="error">Codul introdus este incorect sau deja a fost folosit.</div><br><br>
	<?php
	}
	else if ($stare == "reusit")
	{
	header("Location: cont.php");
} else if ($stare == "necunoscut")
	{
	?>
	<div class="error">Eroare la procesarea platii.</div><br><br>
	<?php
	}
	}
	?>
				
				<h3>Operator/Valoare: <select name="alege" onchange="this.form.submit();">

				<option selected value="alegere">Alege</option>
				
				<option <?php if ($_POST['alege'] == "vdf-3") { ?> selected <?php } ?> value="vdf-3">Vodafone - Platesti 3 euro/ Primesti 1.35 euro</option>

				<option <?php if ($_POST['alege'] == "vdf-4") { ?> selected <?php } ?> value="vdf-4">Vodafone - Platesti 4 euro/ Primesti 3 euro</option>

				<option <?php if ($_POST['alege'] == "vdf-5") { ?> selected <?php } ?> value="vdf-5">Vodafone - Platesti 5 euro/ Primesti 4 euro</option>

				<option <?php if ($_POST['alege'] == "vdf-6") { ?> selected <?php } ?> value="vdf-6">Vodafone - Platesti 6 euro/ Primesti 5 euro</option>
				
				<option <?php if ($_POST['alege'] == "vdf-7") { ?> selected <?php } ?> value="vdf-7">Vodafone - Platesti 7 euro/ Primesti 6 euro</option>

				<option <?php if ($_POST['alege'] == "vdf-8") { ?> selected <?php } ?> value="vdf-8">Vodafone - Platesti 8 euro/ Primesti 7 euro</option>

				<option <?php if ($_POST['alege'] == "vdf-9") { ?> selected <?php } ?> value="vdf-9">Vodafone - Platesti 9 euro/ Primesti 8 euro</option>

				<option <?php if ($_POST['alege'] == "vdf-10") { ?> selected <?php } ?> value="vdf-10">Vodafone - Platesti 10 euro/ Primesti 9 euro</option>

				<option <?php if ($_POST['alege'] == "vdf-14") { ?> selected <?php } ?> value="vdf-15">Vodafone - Platesti 15 euro/ Primesti 15 euro</option>

				<option <?php if ($_POST['alege'] == "vdf-19") { ?> selected <?php } ?> value="vdf-20">Vodafone - Platesti 20 euro/ Primesti 20 euro</option>
				
				<option disabled value="nu">-------------------------------------------------------------</option>
				
				<option <?php if ($_POST['alege'] == "ora-3") { ?> selected <?php } ?> value="ora-3">Orange - Platesti 3 euro/ Primesti 1.35 euro</option>

				<option <?php if ($_POST['alege'] == "ora-4") { ?> selected <?php } ?> value="ora-4">Orange - Platesti 4 euro/ Primesti 3 euro</option>

				<option <?php if ($_POST['alege'] == "ora-5") { ?> selected <?php } ?> value="ora-5">Orange - Platesti 5 euro/ Primesti 4 euro</option>

				<option <?php if ($_POST['alege'] == "ora-6") { ?> selected <?php } ?> value="ora-6">Orange - Platesti 6 euro/ Primesti 5 euro</option>
				
				<option <?php if ($_POST['alege'] == "ora-7") { ?> selected <?php } ?> value="ora-7">Orange - Platesti 7 euro/ Primesti 6 euro</option>

				<option <?php if ($_POST['alege'] == "ora-8") { ?> selected <?php } ?> value="ora-8">Orange - Platesti 8 euro/ Primesti 7 euro</option>

				<option <?php if ($_POST['alege'] == "ora-9") { ?> selected <?php } ?> value="ora-9">Orange - Platesti 9 euro/ Primesti 8 euro</option>

				<option <?php if ($_POST['alege'] == "ora-10") { ?> selected <?php } ?> value="ora-10">Orange - Platesti 10 euro/ Primesti 9 euro</option>
				
				
				<option disabled value="nu">-------------------------------------------------------------</option>
				
				<option <?php if ($_POST['alege'] == "tel-3") { ?> selected <?php } ?> value="tel-3">Telekom - Platesti 3 euro/ Primesti 1.35 euro</option>

				<option <?php if ($_POST['alege'] == "tel-4") { ?> selected <?php } ?> value="tel-4">Telekom - Platesti 4 euro/ Primesti 3 euro</option>

				<option <?php if ($_POST['alege'] == "tel-5") { ?> selected <?php } ?> value="tel-5">Telekom - Platesti 5 euro/ Primesti 4 euro</option>

				<option <?php if ($_POST['alege'] == "tel-6") { ?> selected <?php } ?> value="tel-6">Telekom - Platesti 6 euro/ Primesti 5 euro</option>
				
				<option <?php if ($_POST['alege'] == "tel-7") { ?> selected <?php } ?> value="tel-7">Telekom - Platesti 7 euro/ Primesti 6 euro</option>

				<option <?php if ($_POST['alege'] == "tel-8") { ?> selected <?php } ?> value="tel-8">Telekom - Platesti 8 euro/ Primesti 7 euro</option>

				<option <?php if ($_POST['alege'] == "tel-9") { ?> selected <?php } ?> value="tel-9">Telekom - Platesti 9 euro/ Primesti 8 euro</option>

				<option <?php if ($_POST['alege'] == "tel-10") { ?> selected <?php } ?> value="tel-10">Telekom - Platesti 10 euro/ Primesti 9 euro</option>

			</select><br><br><br>
			<?php
			
			 if ($_POST['alege'])
			 {
			
			if ($_POST['alege'] == "vdf-3")
				echo 'Trimite un sms cu textul cloudcenter la numarul de telefon: 7413';
			else if ($_POST['alege'] == "vdf-4")
				echo 'Trimite un sms cu textul cloudcenter la numarul de telefon: 7604';
			else if ($_POST['alege'] == "vdf-5")
				echo 'Trimite un sms cu textul cloudcenter la numarul de telefon: 7415';
			else if ($_POST['alege'] == "vdf-6")
				echo 'Trimite un sms cu textul cloudcenter la numarul de telefon: 7686';
			else if ($_POST['alege'] == "vdf-7")
				echo 'Trimite un sms cu textul cloudcenter la numarul de telefon: 7510';
			else if ($_POST['alege'] == "vdf-8")
				echo 'Trimite un sms cu textul cloudcenter la numarul de telefon: 7662';
			else if ($_POST['alege'] == "vdf-9")
				echo 'Trimite un sms cu textul cloudcenter la numarul de telefon: 7509';
			else if ($_POST['alege'] == "vdf-10")
				echo 'Trimite un sms cu textul cloudcenter la numarul de telefon: 7410';
			else if ($_POST['alege'] == "vdf-15")
				echo 'Trimite un sms cu textul cloudcenter la numarul de telefon: 7366';
			else if ($_POST['alege'] == "vdf-20")
				echo 'Trimite un sms cu textul cloudcenter la numarul de telefon: 7377';
			
			
			else if ($_POST['alege'] == "ora-3")
				echo 'Trimite un sms cu textul cloudcenter la numarul de telefon: 1377';
			else if ($_POST['alege'] == "ora-4")
				echo 'Trimite un sms cu textul cloudcenter la numarul de telefon: 1378';
			else if ($_POST['alege'] == "ora-5")
				echo 'Trimite un sms cu textul cloudcenter la numarul de telefon: 7515';
			else if ($_POST['alege'] == "ora-6")
				echo 'Trimite un sms cu textul cloudcenter la numarul de telefon: 7516';
			else if ($_POST['alege'] == "ora-7")
				echo 'Trimite un sms cu textul cloudcenter la numarul de telefon: 7517';
			else if ($_POST['alege'] == "ora-8")
				echo 'Trimite un sms cu textul cloudcenter la numarul de telefon: 7518';
			else if ($_POST['alege'] == "ora-9")
				echo 'Trimite un sms cu textul cloudcenter la numarul de telefon: 7519';
			else if ($_POST['alege'] == "ora-10")
				echo 'Trimite un sms cu textul cloudcenter la numarul de telefon: 7520';
			
			
			else if ($_POST['alege'] == "tel-3")
				echo 'Trimite un sms cu textul cloudcenter la numarul de telefon: 7413';
			else if ($_POST['alege'] == "tel-4")
				echo 'Trimite un sms cu textul cloudcenter la numarul de telefon: 7604';
			else if ($_POST['alege'] == "tel-5")
				echo 'Trimite un sms cu textul cloudcenter la numarul de telefon: 7415';
			else if ($_POST['alege'] == "tel-6")
				echo 'Trimite un sms cu textul cloudcenter la numarul de telefon: 7686';
			else if ($_POST['alege'] == "tel-7")
				echo 'Trimite un sms cu textul cloudcenter la numarul de telefon: 7510';
			else if ($_POST['alege'] == "tel-8")
				echo 'Trimite un sms cu textul cloudcenter la numarul de telefon: 7662';
			else if ($_POST['alege'] == "tel-9")
				echo 'Trimite un sms cu textul cloudcenter la numarul de telefon: 7509';
			else if ($_POST['alege'] == "tel-10")
				echo 'Trimite un sms cu textul cloudcenter la numarul de telefon: 7410';
				
				
			?><br>


		<br>
    	Pentru a finaliza plata, te rugam sa introduci codul primit in caseta text de mai jos.:<br/></h3>
       <input type="text" name="cod"> <br>

      <input type="submit" name="aufladenn" value="Trimite" class="buton_albastru"/>
				
				
			<?php
			 }
			 ?>

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
