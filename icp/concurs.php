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
			$command256="SELECT * FROM setari WHERE id = '1'";
			$results256 = mysql_query($command256);
			
			while($row256 = mysql_fetch_array($results256))
				$concurs = $row256["valuare"];
			if (($concurs == "da") and ($_SESSION['id']))
			{
			require 'meniu.php'; 
			
			$command24="SELECT * FROM tz_members WHERE id = '{$_SESSION['id']}'";
			$results24 = mysql_query($command24);
			
			while($row24 = mysql_fetch_array($results24))
				$concurs2 = $row24["concurs"];
			
			if($_POST['submit']=='Trimite')
			{
				if (isset($_POST['concurs']))
				{
					mysql_query("	UPDATE tz_members
						SET				
							concurs = 'da'
						WHERE id = '{$_SESSION['id']}'");
				}
				else
				{
					mysql_query("	UPDATE tz_members
						SET				
							concurs = 'nu'
						WHERE id = '{$_SESSION['id']}'");
				}
				
				header("Location: setari_editate.php");
			}
			$declarat = mysql_fetch_assoc(mysql_query("SELECT id,nume FROM concurs WHERE id=1"));
			$declar = $declarat["nume"];
			$anss = mysql_fetch_assoc(mysql_query("SELECT * FROM concurs_date"));
			$anxx = $anss["year"];
			$anxx2 = $anss["month"];
			$anxx3 = $anss["day"];
			$anxx4 = $anss["hour"];
			$anxx5 = $anss["minute"];
		?>
        
        <div class="container">
		<h1>Concurs + Abonare Newsletter</h1><br>
		<form name="form1" method="post" action="">
			<h3>Participa la Concurs : <input type="checkbox" <?php if ($concurs2 == "da") { ?> checked <?php } ?> name="concurs" value="concurs"><h3><br>
			<h3>Concursul consta in abonarea saptamanala la noi. Mai exact veti primi saptamanal un email cu ce mai este nou prin lumea gaming-ului, ce mai este nou la infectati.ro etc. Cei care sunt abonati sunt inscrisi automat si la concurs. Saptamal este extragerea automata si este declarat un castigator care primeste 3 zile vip gratuit pe server-ul zm.infectati.ro sau daca deja are vip v-a mai primi inca o luna in plus vip.</h3><br>
			<input type="submit" name="submit" value="Trimite" class="buton_albastru" /></h3>
		</form>
		<br>
		<h3>Castigatorul de saptamana aceasta este: <font color="red"><?php echo $declar; ?></font></h3><br>
<head>

<style type="text/css">

#count {

    border: none;

    font-family:"Arial Narrow",Arial,Helvetica,sans-serif;

    font-size: 23px;

    font-weight: normal;    /* options are normal, bold, bolder, lighter */

    font-style: bold;     /* options are normal or italic */

    color: #000000;    /* change color using the hexadecimal color codes for HTML */


}

</style>

</head>


<body>

    <h3> Timp ramas pana la urmatoarea extragere automata:<br> <div id="count"></div> </h3>


<script>


/*

Count down until any date script-

By JavaScript Kit (www.javascriptkit.com)

Over 200+ free scripts here!

Modified by Robert M. Kuhnhenn, D.O.

on 5/30/2006 to count down to a specific date AND time,

and on 1/10/2010 to include time zone offset.

*/


/*  Change the items below to create your countdown target date and announcement once the target date and time are reached.  */

var current="Castigatorul este <?php echo $declar; ?>";        //—>enter what you want the script to display when the target date and time are reached, limit to 20 characters

var year=<?php echo $anxx; ?>;        //—>Enter the count down target date YEAR

var month=<?php echo $anxx2; ?>;          //—>Enter the count down target date MONTH

var day=<?php echo $anxx3; ?>;           //—>Enter the count down target date DAY

var hour=<?php echo $anxx4; ?>;          //—>Enter the count down target date HOUR (24 hour clock)

var minute=<?php echo $anxx5; ?>;         //—>Enter the count down target date MINUTE

var tz=-5;            //—>Offset for your timezone in hours from UTC (see http://wwp.greenwichmeantime.com/index.htm to find the timezone offset for your location)


//—>    DO NOT CHANGE THE CODE BELOW!    <—

var montharray=new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");


function countdown(yr,m,d,hr,min){

theyear=yr;themonth=m;theday=d;thehour=hr;theminute=min;

var today=new Date();

var todayy=today.getYear();

if (todayy < 1000) {

todayy+=1900; }

var todaym=today.getMonth();

var todayd=today.getDate();

var todayh=today.getHours();

var todaymin=today.getMinutes();

var todaysec=today.getSeconds();

var todaystring1=montharray[todaym]+" "+todayd+", "+todayy+" "+todayh+":"+todaymin+":"+todaysec;

var todaystring=Date.parse(todaystring1)+(tz*1000*60*60);

var futurestring1=(montharray[m-1]+" "+d+", "+yr+" "+hr+":"+min);

var futurestring=Date.parse(futurestring1)-(today.getTimezoneOffset()*(1000*60));

var dd=futurestring-todaystring;

var dday=Math.floor(dd/(60*60*1000*24)*1);

var dhour=Math.floor((dd%(60*60*1000*24))/(60*60*1000)*1);

var dmin=Math.floor(((dd%(60*60*1000*24))%(60*60*1000))/(60*1000)*1);

var dsec=Math.floor((((dd%(60*60*1000*24))%(60*60*1000))%(60*1000))/1000*1);

if(dday<=0&&dhour<=0&&dmin<=0&&dsec<=0){

document.getElementById('count').innerHTML=current;

return;

}

else {

document.getElementById('count').innerHTML=+dday+ " zile, "+dhour+" ore, "+dmin+" minute, "+dsec+" secunde";

setTimeout("countdown(theyear,themonth,theday,thehour,theminute)",1000);

}

}


countdown(year,month,day,hour,minute);


</script>

</body>
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