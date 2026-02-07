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
        
        <div class="container">
        
          <p><b>ICP</b> (Infect Control Panel) este un sistem cu ajutorul caruia puteti sa va rezervati numele pe server, sa cumparati un admin, un vip pe unul dintre serverele noastre. Aceste lucruri se fac automat si nu mai este necesar sa contacta-ti echipa pentru a va adauga un vip, un admin, doar pentru a adauga fonduri trebuie momentan sa contactati echipa.</p><br>
		  <p>Bafta la Frag-uri!!!</p><br>
		  <h1>Tutorial folosire ICP</h1>
		  <iframe width="420" height="315" src="//www.youtube.com/embed/_NL3s_YG7dM" frameborder="0" allowfullscreen></iframe>
			<br><br>
		<h1>Tutorial folosire Pariuri Clanuri</h1>	
		<iframe width="420" height="315" src="//www.youtube.com/embed/K-al3UODWEM" frameborder="0" allowfullscreen></iframe>
			

		<br><br><h3>Total Utilizatori Inregistrati <font color="#d10000"><?php echo $result5555['total']; ?></font> , Total Utilizatori Conectati <font color="#d10000"><?php echo $count_user_online; ?></font> , Total Vizitatori <font color="#d10000"><?php $adevarat = $count - $count_user_online; if ($adevarat < "0") $adevarat = "0"; echo $adevarat; ?></font>.</h3>
		<br>
		<h1>Concurs Automat ICP</h1>
		<?php
			$declarat = mysql_fetch_assoc(mysql_query("SELECT id,nume FROM concurs WHERE id=1"));
			$declar = $declarat["nume"];
			$anss = mysql_fetch_assoc(mysql_query("SELECT * FROM concurs_date"));
			$anxx = $anss["year"];
			$anxx2 = $anss["month"];
			$anxx3 = $anss["day"];
			$anxx4 = $anss["hour"];
			$anxx5 = $anss["minute"];
		?>
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
<br>
<br>
<br>
<h1 class="priceplanhr">Parerea Jucatorilor...<br></h3><br>

<center>
<div id="fb-root"></div>
<script src="http://connect.facebook.net/en_US/all.js#xfbml=1"></script>
<fb:comments href="https://www.facebook.com/comunitatea.infectatilor/icp" num_posts="15" width="width of comment box"></fb:comments>
</center>
		<div class="clear"></div>
        </div>
    
	<?php
	require 'foother.php';
	?>	
    </div>
</div>

</body>
</html>
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
		header("Location: un_pas.php");
	}
	}
?>
