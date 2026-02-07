<?php

define('INCLUDE_CHECK',true);

require 'connect.php';
require 'functions.php';
		
$command = mysql_query("SELECT * FROM tz_members WHERE NOW() >= cs_expira_access");
$results = mysql_fetch_assoc($command);

if ($results)
{
		$auth = $results["auth"];
		$email2 = $results["email"];
	mysql_query("	UPDATE tz_members
				SET				
					cs_expira_access = '3000-01-01',
					access_cs = 'z'
				WHERE NOW() >= cs_expira_access");
	
					$from = "infectati@yahoo.ro";
					$headers = "From:" . $from;
			
					$Body = "";
					$Body .= "Gradul tau de pe Cs.infectati.ro a expirat. Ca sa il reactivezi intra pe http://icp.infectati.ro ";					
					$Body .= "\n";
					$Body .= "Echipa Infectati.ro";
			
					mail($email2, "ICP Infect Control Panel - Expirare Grad", $Body, $headers);
	mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('Eu ICP-ul i-am scos gradul de admin lui $auth de pe server-ul cs.infectati.ro','normal',NOW())");
}

$command2 = mysql_query("SELECT * FROM tz_members WHERE NOW() >= zm_expira_access ORDER BY zm_expira_access");
$results2 = mysql_fetch_assoc($command2);

if ($results2)
{
		$zm_access = $results2["access_zm"];
		$email3 = $results2["email"];
		$auth2 = $results2["auth"];
	
	if ($zm_access == "x")
	{
		$zm_access = "z";
	}
	else if ($zm_access == "bx")
	{
		$zm_access = "x";
	}
	else if ($zm_access == "cefijx")
	{
		$zm_access = "x";
	}
	else if ($zm_access == "cdefijmx")
	{
		$zm_access = "x";
	}
	else if ($zm_access == "cdefgijmnx")
	{
		$zm_access = "x";
	}
	else if ($zm_access == "abcdefghijklmnopqrstux")
	{
		$zm_access = "x";
	}
	else if ($zm_access == "bcefijx")
	{
		$zm_access = "x";
	}
	else if ($zm_access == "bcdefijmx")
	{
		$zm_access = "x";
	}
	else if ($zm_access == "bcdefgijmnx")
	{
		$zm_access = "x";
	}
		
	mysql_query("	UPDATE tz_members
				SET				
					zm_expira_access = '3000-01-01',
					access_zm = '$zm_access'
				WHERE NOW() >= zm_expira_access ORDER BY zm_expira_access");
				
					$from = "infectati@yahoo.ro";
					$headers = "From:" . $from;
			
					$Body = "";
					$Body .= "Gradul tau de pe Zm.infectati.ro a expirat. Ca sa il reactivezi intra pe http://icp.infectati.ro ";					
					$Body .= "\n";
					$Body .= "Echipa Infectati.ro";
			
					mail($email3, "ICP Infect Control Panel - Expirare Grad", $Body, $headers);
	mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('Eu ICP-ul i-am scos gradul de admin lui $auth2 de pe server-ul zm.infectati.ro','normal',NOW())");
}

$command3 = mysql_query("SELECT * FROM tz_members WHERE NOW() >= zm_expira_vip ORDER BY zm_expira_vip");
$results3 = mysql_fetch_assoc($command3);

if ($results3)
{

		$email4 = $results3["email"];
		$zm_access = $results3["access_zm"];
		$auth3 = $results3["auth"];
		
	if ($zm_access == "x")
	{
		$zm_access = "z";
	}
	else if ($zm_access == "bx")
	{
		$zm_access = "b";
	}
	else if ($zm_access == "cefijx")
	{
		$zm_access = "cefij";
	}
	else if ($zm_access == "cdefijmx")
	{
		$zm_access = "cdefijm";
	}
	else if ($zm_access == "cdefgijmnx")
	{
		$zm_access = "cdefgijmn";
	}
	else if ($zm_access == "abcdefghijklmnopqrstux")
	{
		$zm_access = "abcdefghijklmnopqrstu";
	}
	else if ($zm_access == "bcefijx")
	{
		$zm_access = "bcefij";
	}
	else if ($zm_access == "bcdefijmx")
	{
		$zm_access = "bcdefijm";
	}
	else if ($zm_access == "bcdefgijmnx")
	{
		$zm_access = "bcdefgijmn";
	}
	else if ($zm_access == "abcdefghijklmnopqrstux")
	{
		$zm_access = "abcdefghijklmnopqrstu";
	}
	mysql_query("	UPDATE tz_members
				SET				
					zm_expira_vip = '3000-01-01',
					access_zm_vip = '',
					access_zm = '$zm_access'
				WHERE NOW() >= zm_expira_vip ORDER BY zm_expira_vip");
				
						$from = "infectati@yahoo.ro";
					$headers = "From:" . $from;
			
					$Body = "";
					$Body .= "Gradul tau de pe Zm.infectati.ro a expirat. Ca sa il reactivezi intra pe http://icp.infectati.ro ";					
					$Body .= "\n";
					$Body .= "Echipa Infectati.ro";
			
					mail($email4, "ICP Infect Control Panel - Expirare Grad", $Body, $headers);
	mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('Eu ICP-ul i-am scos gradul de vip lui $auth3 de pe server-ul zm.infectati.ro','normal',NOW())");
}


$command4 = mysql_query("SELECT * FROM tz_members WHERE NOW() >= zm_expira_banca ORDER BY zm_expira_banca");
$results4 = mysql_fetch_assoc($command4);

if ($results4)
{
		$email5 = $results4["email"];
		$auth4 = $results4["auth"];
		
	mysql_query("	UPDATE tz_members
				SET				
					zm_expira_banca = '3000-01-01',
					access_zm_bank = ''
				WHERE NOW() >= zm_expira_banca ORDER BY zm_expira_banca");
				
					$from = "infectati@yahoo.ro";
					$headers = "From:" . $from;
			
					$Body = "";
					$Body .= "Gradul tau de pe Zm.infectati.ro a expirat. Ca sa il reactivezi intra pe http://icp.infectati.ro ";					
					$Body .= "\n";
					$Body .= "Echipa Infectati.ro";
			
					mail($email5, "ICP Infect Control Panel - Expirare Grad", $Body, $headers);
	mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('Eu ICP-ul i-am scos gradul bancar lui $auth4 de pe server-ul zm.infectati.ro','normal',NOW())");
}
$eu = mysql_fetch_assoc(mysql_query("SELECT * FROM tz_members WHERE banat = 'da'"));

if ($eu)
{
	$chiar = mysql_fetch_assoc(mysql_query("SELECT id,bantime,auth FROM tz_members WHERE banat = 'da' ORDER BY bantime"));
	
	$idd = $chiar["id"];
	$asa = $chiar["bantime"];
	$auth90 = $chiar["auth"];
	
	$today = date("Y-m-d", time());
	if ($today >= $asa)
	{
	mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('Eu ICP-ul i-am scos ban-ul din mine lui $auth90, data viitoare nu o mai fac','normal',NOW())");
	$casa = mysql_fetch_assoc(mysql_query("SELECT zm_expira_access,zm_expira_vip,zm_expira_banca,cs_expira_access,access_zm,access_zm_vip,access_zm_bank,access_cs FROM ban_list WHERE id = '$idd'"));

		$zm_expira_access = $casa["zm_expira_access"];
		$zm_expira_vip = $casa["zm_expira_vip"];
		$zm_expira_banca = $casa["zm_expira_banca"];
		$cs_expira_access = $casa["cs_expira_access"];
		$access_zm = $casa["access_zm"];
		$access_zm_vip = $casa["access_zm_vip"];
		$access_zm_bank = $casa["access_zm_bank"];
		$access_cs = $casa["access_cs"];
	
	mysql_query("	UPDATE tz_members
				SET	
					zm_expira_access = '$zm_expira_access',
					zm_expira_vip = '$zm_expira_vip',
					zm_expira_banca = '$zm_expira_banca',
					
					cs_expira_access = '$cs_expira_access',
					
					access_zm = '$access_zm',
					access_zm_vip = '$access_zm_vip',
					access_zm_bank = '$access_zm_bank',
					access_cs = '$access_cs',
					banat = 'nu',
					bantime = '0000-00-00'
				
				WHERE id = '$idd'");
	
	mysql_query("DELETE FROM ban_list WHERE id = '$idd'");

	}
}
$alert = mysql_fetch_assoc(mysql_query("SELECT * FROM tz_members WHERE NOW() >= avertisment_cs_expira ORDER BY avertisment_cs_expira"));

if ($alert)
{
	$auth5 = $alert["auth"];
	$numarat = mysql_fetch_assoc(mysql_query("SELECT avertisment_cs,avertisment_cs_expira FROM tz_members WHERE NOW() >= avertisment_cs_expira"));

	$avertisment_cs = $numarat["avertisment_cs"];
	$avertisment_cs_expira = $numarat["avertisment_cs_expira"];
	
	$avertisment_cs = $avertisment_cs - "1";
	mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('Eu ICP-ul i-am scos avertismentul din mine lui $auth5 la gradul de admin pe server-ul cs.infectati.ro, data viitoare nu o mai fac','normal',NOW())");
	if ($avertisment_cs < "0")
		$avertisment_cs = "0";
	
	if ($avertisment_cs == "0")
		$avertisment_cs_expira = "3000-01-01";
	
		mysql_query("	UPDATE tz_members
				SET	
					avertisment_cs = '$avertisment_cs',
					avertisment_cs_expira = '$avertisment_cs_expira'
					
				WHERE NOW() >= avertisment_cs_expira ORDER BY avertisment_cs_expira");
					
	
}
$alert2 = mysql_fetch_assoc(mysql_query("SELECT * FROM tz_members WHERE NOW() >= avertisment_zm_expira ORDER BY avertisment_zm_expira"));

if ($alert2)
{
	$auth6 = $alert2["auth"];
	$numarat2 = mysql_fetch_assoc(mysql_query("SELECT avertisment_zm,avertisment_zm_expira FROM tz_members WHERE NOW() >= avertisment_zm_expira"));

	$avertisment_zm = $numarat2["avertisment_zm"];
	$avertisment_zm_expira = $numarat2["avertisment_zm_expira"];
	
	$avertisment_zm = $avertisment_zm - "1";
	mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('Eu ICP-ul i-am scos avertismentul din mine lui $auth6 la gradul de admin pe server-ul zm.infectati.ro, data viitoare nu o mai fac','normal',NOW())");
	if ($avertisment_zm < "0")
		$avertisment_zm = "0";
	
	if ($avertisment_zm == "0")
		$avertisment_zm_expira = "3000-01-01";
	
		mysql_query("	UPDATE tz_members
				SET	
					avertisment_zm = '$avertisment_zm',
					avertisment_zm_expira = '$avertisment_zm_expira'
					
				WHERE NOW() >= avertisment_zm_expira ORDER BY avertisment_zm_expira");
					
	
}
$alert3 = mysql_fetch_assoc(mysql_query("SELECT * FROM tz_members WHERE NOW() >= avertisment_zm_vip_expira ORDER BY avertisment_zm_vip_expira"));

if ($alert3)
{
	$auth7 = $alert3["auth"];
	$numarat3 = mysql_fetch_assoc(mysql_query("SELECT avertisment_zm_vip,avertisment_zm_vip_expira FROM tz_members WHERE NOW() >= avertisment_zm_vip_expira"));

	$avertisment_zm_vip = $numarat3["avertisment_zm_vip"];
	$avertisment_zm_vip_expira = $numarat3["avertisment_zm_vip_expira"];
	
	$avertisment_zm_vip = $avertisment_zm_vip - "1";
	mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('Eu ICP-ul i-am scos avertismentul din mine lui $auth7 la gradul de VIP pe server-ul zm.infectati.ro, data viitoare nu o mai fac','normal',NOW())");
	if ($avertisment_zm_vip < "0")
		$avertisment_zm_vip = "0";
	
	if ($avertisment_zm_vip == "0")
		$avertisment_zm_vip_expira = "3000-01-01";
	
		mysql_query("	UPDATE tz_members
				SET	
					avertisment_zm_vip = '$avertisment_zm_vip',
					avertisment_zm_vip_expira = '$avertisment_zm_vip_expira'
					
				WHERE NOW() >= avertisment_zm_vip_expira ORDER BY avertisment_zm_vip_expira");
					
	
}

$concurs = mysql_fetch_assoc(mysql_query("SELECT * FROM setari WHERE id = '1'"));
if ($concurs["valuare"] == "da")
{
	$concurs_date = mysql_fetch_assoc(mysql_query("SELECT * FROM concurs_date WHERE id = '1'"));
	
	$concurs_anul = $concurs_date["year"];
	$concurs_luna = $concurs_date["month"];
	$concurs_ziua = $concurs_date["day"];
	$concurs_ora = $concurs_date["hour"];
	$concurs_minut = $concurs_date["minute"];
	$concurs_data_final = "$concurs_anul-$concurs_luna-$concurs_ziua";

	$today = date("Y-m-d", time());
	
	if (strtotime('now') >= strtotime($concurs_data_final))
	{
		$concurs_ziua = $concurs_ziua + "7";
		if ($concurs_ziua > "30")
		{
			$concurs_ziua = "01";
			$concurs_luna = $concurs_luna + "1";
		}
		if ($concurs_luna > "12")
		{
			$concurs_luna = "01";
			$concurs_anul = $concurs_anul + "1";
		}
		mysql_query("	UPDATE concurs_date
				SET
					year = '$concurs_anul',
					month = '$concurs_luna',
					day = '$concurs_ziua'
					WHERE id=1");
					
		
			$command161="SELECT * FROM tz_members WHERE concurs='da' and admin <>'da' and banat<>'da' ORDER BY RAND() ";
			$results161 = mysql_query($command161);
			while($row161 = mysql_fetch_array($results161))
			{
				$castigator = $row161["auth"];
				$grad = $row161["access_zm_vip"];
				$expira_vip = $row161["zm_expira_vip"];
				$zm_access = $row161["access_zm"];
			}
			if ($grad == "abcde")
				$expiry = date("Y-m-d", strtotime("+1 Month", strtotime($expira_vip)));
			else
				$expiry = date("Y-m-d", time() + 3*24*60*60 );
				
			if (($zm_access == "z") or ($zm_access == "x"))
					{
							$zm_access = "x";
						}
						else if (($zm_access == "b") or ($zm_access == "bx"))
						{
							$zm_access = "bx";
						}
						else if (($zm_access == "cefij") or ($zm_access == "cefijx"))
						{
							$zm_access = "cefijx";
						}
						else if (($zm_access == "cdefijm") or ($zm_access == "cdefijmx"))
						{
							$zm_access = "cdefijmx";
						}
						else if (($zm_access == "cdefgijmn") or ($zm_access == "cdefgijmnx"))
						{
							$zm_access = "cdefgijmnx";
						}
						else if (($zm_access == "abcdefghijklmnopqrstu") or ($zm_access == "abcdefghijklmnopqrstux"))
						{
							$zm_access = "abcdefghijklmnopqrstux";
						}
						else if (($zm_access == "bcefij") or ($zm_access == "bcefijx"))
						{
							$zm_access = "bcefijx";
						}
						else if (($zm_access == "bcdefijm") or ($zm_access == "bcdefijmx"))
						{
							$zm_access = "bcdefijmx";
						}
						else if (($zm_access == "bcdefgijmn") or ($zm_access == "bcdefgijmnx"))
						{
							$zm_access = "bcdefgijmnx";
						}
						
				mysql_query("	UPDATE tz_members
						SET				
							access_zm_vip = 'abcde',
							access_zm = '$zm_access',
							zm_expira_vip = '$expiry',
							zm_expira_access = '$expiry'
						WHERE auth = '$castigator'");
				mysql_query("	UPDATE concurs
						SET
							nume = '$castigator'
							WHERE id=1");
				mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('Eu ICP-ul l-am desemnat pe $castigator ca fiind castigatorul de saptamana aceasta','$admin',NOW())");	
	}
}
?>
