<?php
//**********************************************************************************//
$Email = Trim(stripslashes($_POST['Email']));

//**********************************************************************************//
// Inlocuieste adresa de email de mai jos, cu adresa ta de email la care vrei sa primesti mesajele.
$EmailTo = "infectati@yahoo.ro";
//**********************************************************************************//

$Subiect = Trim(stripslashes($_POST['Subiect']));
$Numele = Trim(stripslashes($_POST['Numele']));
$Comentarii = Trim(stripslashes($_POST['Comentarii'])); 

$validationOK=true;
if (Trim($Email)=="") $validationOK=false;
if (!$validationOK) {
  print "	<meta http-equiv=\"refresh\" content=\"3;URL=http://infectati.ro/suport2.html\">
			<div align=\"center\">
				<font size=\"6\" color=\"#FF0000\" face=\"Verdana, Arial, Helvetica, sans-serif\"><strong>Eroare!</strong></font><br /><br />
				<font size=\"6\" color=\"#FF0000\" face=\"Verdana, Arial, Helvetica, sans-serif\"><strong>(adresa e-mail incorecta)</strong></font><br /><br />
				<font size=\"6\" color=\"#FF0000\" face=\"Verdana, Arial, Helvetica, sans-serif\"><strong><a href=\"http://infectati.ro/suport2.html\">Reincercati!</a></strong></font><br /><br />
			</div>
  ";
  exit;
}

$Body = "";
$Body .= "Numele: ";
$Body .= $Numele;
$Body .= "\n";
$Body .= "\n";
$Body .= "Comentarii: ";
$Body .= $Comentarii;
$Body .= "\n";

$success = mail($EmailTo, $Subiect, $Body, "From: <$Email>");

if ($success){
  print "	<meta http-equiv=\"refresh\" content=\"3;URL=http://infectati.ro/suport2.html\">
			<div align=\"center\"><br /><br /><br /><br />
				<font size=\"6\" color=\"#666666\" face=\"Verdana, Arial, Helvetica, sans-serif\"><strong>Mesajul a fost trimis !</strong></font><br /><br />
				<font size=\"6\" color=\"red\" face=\"Verdana, Arial, Helvetica, sans-serif\"><strong>Va multumim !</strong></font><br /><br />
			</div>
  ";
}
else{
  print "	<meta http-equiv=\"refresh\" content=\"3;URL=http://infectati.ro/suport2.html\">
			<div align=\"center\">
				<font size=\"6\" color=\"#FF0000\" face=\"Verdana, Arial, Helvetica, sans-serif\"><strong>Eroare!</strong></font><br /><br />
				<font size=\"6\" color=\"#FF0000\" face=\"Verdana, Arial, Helvetica, sans-serif\"><strong>(adresa e-mail incorecta)</strong></font><br /><br />
				<font size=\"6\" color=\"#FF0000\" face=\"Verdana, Arial, Helvetica, sans-serif\"><strong><a href=\"http://infectati.ro/suport2.html\">Reincercati!</a></strong></font><br /><br />
			</div>
  ";
}
?>