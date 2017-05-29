<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- saved from url=(0035)http://192.168.1.9:8080/cs336Final/ -->
<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
	<title>Statistics</title>
</head>
<body>
<h1>Query Statistics</h1>
<div style="position:absolute;top:0;right:0;">[<a href="index.jsp">GO HOME</a>]</div>
<br>

	<form method="post" action="server/getStatistics.jsp">
	<form>
  		<input type="radio" name="mode" value="time" id="time"> Time<br>
  		<input type="radio" name="mode" value="user" id="user"> User<br>
  		<input type="radio" name="mode" value="origin" id="origin"> Origin<br>
  		<input type="radio" name="mode" value="destination" id="destination"> Destination<br>
  		<p>Examples of valid queries:</p>
  		<ul>
  			<li>Busch</li>
  			<li>nick</li>
  			<li>Monday</li>
  			<li>Mon</li>
  			<li>Spring 2017</li>
  			<li>January</li>
  			<li>Jan</li>
  			<li>2015</li>
  			<li>13:49:07</li>
  		</ul>
  		<input type="text" name="query">
  		<input type="submit" value="statistic">
	</form>

</html>