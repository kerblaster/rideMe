<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- saved from url=(0035)http://192.168.1.9:8080/cs336Final/ -->
<html>

<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
	<script>
		var timeValid = false;
		var locValid = false;
		var startTime = 0;
		var endTime = 0;
		function start(){
			document.getElementById('submit').disabled = true;
		}
		function startTimeValid(time){
			startTime = time.split(":")[0] + time.split(":")[1];
			checkTimeIsValid();
		}
		function endTimeValid(time){
			endTime = time.split(":")[0] + time.split(":")[1];
			checkTimeIsValid();
		}
		function checkTimeIsValid(){
			if (startTime > endTime){ //error
				timeValid = false;
				ableSubmit();
			} else{
				timeValid = true;
				ableSubmit();
			}			
		}
		function checkLocation(){
			if (document.getElementById('departure').value && document.getElementById('destination').value){
				locValid = true;
				ableSubmit();
			} else{
				locValid = false;
				ableSubmit();
			}
			
		}
		function ableSubmit(){
			console.log(locValid + " " + timeValid);
			if (timeValid && locValid){
				document.getElementById('submit').disabled = false;
			} else{
				document.getElementById('submit').disabled = true;
			}
		}
	</script>
	<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
	<title>Ride Offer Form</title>
</head>


<body onload="start();">
<h1>Offer a Ride</h1>	
<div style="position:absolute;top:0;right:0;">[<a href="index.jsp">GO HOME</a>]</div>				  
<!-- Advertising Logic (Start) -->
<%
	try {
		ResultSet result = null;
		//Create a connection string
		//String url = "jdbc:mysql://cs336-2.crujdr9emkb3.us-east-1.rds.amazonaws.com:3306/BarBeerDrinkerSample";
		String url = "jdbc:mysql://cs336g32.cyi4cdd85yp2.us-east-1.rds.amazonaws.com:3306/cs336g32";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver");
	
		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "admin", "password");
	
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		//Random ad
		String str = "SELECT * FROM ads ORDER BY RAND() LIMIT 1";
		result = stmt.executeQuery(str);
		
		if(result.next()){
			int adId = result.getInt("adId");
			out.print("<div style=\"border: solid; width: 50%; text-align:center;\"><h3>(Ad) " + result.getString("advertiser") + "</h3>" + "<p>"+result.getString("content")+"</p></div>");
			Statement stmt2 = con.createStatement();
			String update = "UPDATE ads SET ads.views=ads.views+1 WHERE ads.adId= '" + adId + "'";
			PreparedStatement ps = con.prepareStatement(update);
			ps.executeUpdate();
		} else{ //no ad
			out.print("<p>No ads available</p>");
		}
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
	} catch (Exception ex) {
		out.print("getting ad failed <br> " + ex);
	}
%>
<!-- Advertising Logic (End) -->
<br>
	<form method="post" action="server/rideOffer.jsp">
		<table>
			<tr>    
				<td>Departure</td><td>
				<select id="departure" name="departure" onchange="checkLocation()">
					<option disabled selected value>Select Campus</option>
					<option value="depart_busch">Busch</option>
			  		<option value="depart_livi">Livingston</option>
			  		<option value="depart_ca">College Ave</option>
			  		<option value="depart_cd">Cook-Douglass</option>
				</select></td>
			</tr>
			<tr>
				<td>Destination</td><td>
				<select id="destination" name="destination" onchange="checkLocation()">
					<option disabled selected value>Select Campus</option>
					<option value="dest_busch">Busch</option>
			  		<option value="dest_livi">Livingston</option>
			  		<option value="dest_ca">College Ave</option>
			  		<option value="dest_cd">Cook-Douglass</option>
				</select></td>	
			</tr>	
			<tr>    
				<td>Time Window</td>
				<td>
					<input type="time" name="timeStart" onchange="startTimeValid(this.value)" required>-
					<input type="time" name="timeEnd" onchange="endTimeValid(this.value)" required>
				</td>
				
			</tr>
			<tr>
		  		<td><input type="checkbox" name="recurring" value="1"> Recurring Offer?<br></td>	
			</tr>
		</table>
		<br>
		<input id="submit" type="submit" value="Offer">
	</form>
</body>
</html>