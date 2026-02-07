<?php
		if($_SESSION['id'])
		{
			$command1611="SELECT * FROM tz_members WHERE id = '{$_SESSION['id']}'";
			$results1611 = mysql_query($command1611);
			while($row1611 = mysql_fetch_array($results1611))
			{
				$activat = $row1611["activat"];
			}
	if ($activat !== "da")
	{
		?>
		<meta http-equiv="refresh" content="0; url=http://icp.infectati.ro/un_pas.php" />
		<?php
	}
	}
?>
<html>
      <div class="container tutorial-info">
      <center>Copyright 2012-2014 - Toate drepturile rezervate - Powered by <a href="http://www.infectati.ro/contact.php"><font color="#d10000">Echipa Infectatilor</font></a></center>
	  </div>
<div id="swifttagcontaineradozzslyhv"><div id="proactivechatcontaineradozzslyhv"></div><div style="display: inline;" id="swifttagdatacontaineradozzslyhv"></div></div> <script type="text/javascript">var swiftscriptelemadozzslyhv=document.createElement("script");swiftscriptelemadozzslyhv.type="text/javascript";var swiftrandom = Math.floor(Math.random()*1001); var swiftuniqueid = "adozzslyhv"; var swifttagurladozzslyhv="http://infectati.ro/help/visitor/index.php?/Default/LiveChat/HTML/SiteBadge/cHJvbXB0dHlwZT1jaGF0JnVuaXF1ZWlkPWFkb3p6c2x5aHYmdmVyc2lvbj00LjYwLjAuMzk3MSZwcm9kdWN0PUZ1c2lvbiZmaWx0ZXJkZXBhcnRtZW50aWQ9MSwzLDEsNCwxJnNpdGViYWRnZWNvbG9yPXdoaXRlJmJhZGdlbGFuZ3VhZ2U9ZW4mYmFkZ2V0ZXh0PWxpdmVoZWxwJm9ubGluZWNvbG9yPSMxOThjMTkmb25saW5lY29sb3Job3Zlcj0jNWZhZjVmJm9ubGluZWNvbG9yYm9yZGVyPSMxMjYyMTImb2ZmbGluZWNvbG9yPSNhMmE0YWMmb2ZmbGluZWNvbG9yaG92ZXI9I2JlYzBjNSZvZmZsaW5lY29sb3Jib3JkZXI9IzcxNzM3OCZhd2F5Y29sb3I9IzczN2M0YSZhd2F5Y29sb3Job3Zlcj0jOWVhNDgxJmF3YXljb2xvcmJvcmRlcj0jNTE1NzM0JmJhY2tzaG9ydGx5Y29sb3I9Izc4OGEyMyZiYWNrc2hvcnRseWNvbG9yaG92ZXI9I2ExYWU2NiZiYWNrc2hvcnRseWNvbG9yYm9yZGVyPSM1NDYxMTkmY3VzdG9tb25saW5lPSZjdXN0b21vZmZsaW5lPSZjdXN0b21hd2F5PSZjdXN0b21iYWNrc2hvcnRseT0KMTA0ODMwNzY5NTgyOTVmY2U4MzQ4YzA3NDUxOGE2YTNkYjRiZGExZA==";setTimeout("swiftscriptelemadozzslyhv.src=swifttagurladozzslyhv;document.getElementById('swifttagcontaineradozzslyhv').appendChild(swiftscriptelemadozzslyhv);",1);</script>

	  </html>
