<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- saved from url=(0035)http://192.168.1.9:8080/cs336Final/ -->
<html>

<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
	<title>Rate Experience</title>
</head>
<body>

<h1>Rate your experience as Driver</h1><br>
<div style="position:absolute;top:0;right:0;">[<a href="index.jsp">GO HOME</a>]</div>
<h2>
	Passenger: 
	<%
		String cookieValue = "";
		String rider = "";
		String rideId = "";
		String isRecurring = "";
		try {
			//get rideId from URL: url.jsp?rideId=#######
			String queryStr = request.getQueryString().toString();
			cookieValue = queryStr.split("=")[1];
		    
			//Create a connection string
			//String url = "jdbc:mysql://cs336-2.crujdr9emkb3.us-east-1.rds.amazonaws.com:3306/BarBeerDrinkerSample";
			String url = "jdbc:mysql://cs336g32.cyi4cdd85yp2.us-east-1.rds.amazonaws.com:3306/cs336g32";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");
	
			//Create a connection to your DB
			Connection con = DriverManager.getConnection(url, "admin", "password");
	
			//Create a SQL statement
			Statement stmt = con.createStatement();
	
			//Check counts once again (the same as the above)
			String select = "SELECT * FROM rideRequests WHERE rideRequests.rideId = '" + cookieValue + "'";
			ResultSet result = stmt.executeQuery(select);
			result.next();
			
			rideId = result.getString("rideId");
			rider = result.getString("rider");
			isRecurring = result.getString("recurring");
			
			//Ride becomes official
			String insert = "INSERT INTO rides(rideId, driver, carId) VALUES (?, ?, ?)";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);
			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, rideId);
			ps.setString(2, session.getAttribute("user.username").toString());
			ps.setString(3, session.getAttribute("user.carId").toString());
			//Run the query against the DB
			ps.executeUpdate();
			
			
			//Add if recurring ride to recurring ride table
			if (isRecurring.equals("1")){
				String insert2 = "INSERT INTO ridesRecurring(rideId) VALUES (?)";
				PreparedStatement ps2 = con.prepareStatement(insert2);
				ps2.setString(1, rideId);
				ps2.executeUpdate();
			}
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();

			out.print(rider);
		} catch (Exception ex) {
			out.print("Form generation failed or Accepting ride failed <br> " + ex);
		}
	%>
</h2>					  
	<p>(save name for future messaging)</p>
	<br>
	<form method="post" action="server/ratePassenger.jsp">
		<table>
			<tr>    
				<td>Rating: </td>
				<td>
				  	<input type="radio" name="value" value="1"> 1
  					<input type="radio" name="value" value="2"> 2
  					<input type="radio" name="value" value="3" checked> 3
  					<input type="radio" name="value" value="4"> 4
  					<input type="radio" name="value" value="5"> 5
  				</td>
			</tr>
			<tr>
				<td>Comment: </td>
				<td><textarea name="comment" rows="4" cols="50" placeholder="Add additional comments here"></textarea></td>
			</tr>
		</table>
		<br>
		<input type="hidden" id="rideId" name="rideId" value="">
		<input type="hidden" id="rider" name="rider" value="">
		<input type="checkbox" name="public" value="1"> Public?<br>
		<input type="submit" value="Rate">
	</form>
	<script>
		document.getElementById("rideId").value = '<%= cookieValue %>';	
		document.getElementById("rider").value = '<%= rider %>';	
	</script>
</body>
</html>