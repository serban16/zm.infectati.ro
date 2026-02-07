<?php

define('INCLUDE_CHECK',true);

require 'connect.php';
require 'functions.php';
require 'header.php';
// Those two files can be included only if INCLUDE_CHECK is defined
function wol($broadcast, $mac){    $mac_array = split(':', $mac);    $hwaddr = '';    foreach($mac_array AS $octet)    {        $hwaddr .= chr(hexdec($octet));    }    // Create Magic Packet    $packet = '';    for ($i = 1; $i <= 6; $i++)    {        $packet .= chr(255);    }    for ($i = 1; $i <= 16; $i++)    {        $packet .= $hwaddr;    }    $sock = socket_create(AF_INET, SOCK_DGRAM, SOL_UDP);    if ($sock)    {        $options = socket_set_option($sock, 1, 6, true);        if ($options >=0)         {                $e = socket_sendto($sock, $packet, strlen($packet), 0, $broadcast, 7);            socket_close($sock);        }        }}


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
				$adminu = $row16["admin"];								$dedicat = $row16["dedicat"];
			}
			if (($adminu == "da") and ($dedicat == "da"))
			{
			require 'meniu.php';
			$command2="SELECT * FROM tz_members WHERE id = '{$_SESSION['id']}'";
			$results2 = mysql_query($command2);
			while($row2 = mysql_fetch_array($results2))
			{
				$auth = $row2['auth'];
				$admin = $row2['admin'];
			}
			if ($_POST['submit1']=='Porneste Dedicatul de pe Constanta')
			{							wol("datacenterconstanta.myftp.org","00:1A:4D:38:D1:9D");
				header("Location: succes-dedicat.php");
			}
		?>
        
        <div class="container">
		<h1>Dedicat Constanta</h1><br>		<h1>ATENTIE pentru Max sau Iulik, NU apasati butonul, porneste un calculator Adevarat.
		<?php

		?>
		<form name="form1" method="post" action=""><h3><input type="submit" name="submit1" value="Porneste Dedicatul de pe Constanta" class="buton_albastru" /></h3></form>
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