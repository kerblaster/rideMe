<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- saved from url=(0035)http://192.168.1.9:8080/cs336Final/ -->
<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
	<title>Statistics</title>
</head>
<body>
<h1>User Statistics</h1>
<div style="position:absolute;top:0;right:0;">[<a href="index.jsp">GO HOME</a>]</div>
<script>
	
	$(document).ready(function() {
		$("#month").on("click", function(){
			$("#monthList").css("display", "block");
			$("#semesterList").css("display", "none");
		});
		$("#semester").on("click", function(){
			$("#monthList").css("display", "none");
			$("#semesterList").css("display", "block");
		});
	});
</script>


<br>

	<form method="post" action="server/getStatisticsUser.jsp">
	<form>
  		<input type="radio" name="time" value="month" id="month"> Month<br>
  		<input type="radio" name="time" value="semester" id="semester"> Semester<br>
  		<select name="monthList" id="monthList" style="display:none;">
  			<option value="january">January</option>
  			<option value="february">February</option>
  			<option value="march">March</option>
  			<option value="april">April</option>
  			<option value="may">May</option>
  			<option value="june">June</option>
  			<option value="july">July</option>
  			<option value="august">August</option>
  			<option value="september">September</option>
  			<option value="october">October</option>
  			<option value="november">November</option>
  			<option value="december">December</option>
  		</select>
  		<select name="semesterList" id="semesterList" style="display:none;">
  			<option value="fall">Fall</option>
  			<option value="spring">Spring</option>
  		</select>
  		<input type="submit" value="Query">
	</form>

</html>