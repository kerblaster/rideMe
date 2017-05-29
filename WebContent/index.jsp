<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>RideMe</title>
	</head>
	<body>
		<h1>Welcome to RideMe!</h1>
		<h2>Where Rutgers can ride</h2>
		<br>
		<%
			//logged out
			if (session.getAttribute("user.username") == null){
				out.print("Login or Register to begin!<br>");
				out.print("<a href='login.jsp'>Login</a><br>");
				out.print("<a href='register.jsp'>Register</a><br>");
			}else {
			//logged in
				out.print("Welcome, " + session.getAttribute("user.username").toString() + "! | ");
				out.print("<a href='logout.jsp'>Logout</a><br><br>");
				if (session.getAttribute("user.type").toString().equals("admin")){ //admin user
					out.print("<a href='statisticsAdmin.jsp'>View/Query Statistics</a><br>");
					out.print("<a href='registerStaffForm.jsp'>Create Support Staff Account</a><br>");
				} else if (session.getAttribute("user.type").toString().equals("staff")){ //system support user
					out.print("<a href='banUser.jsp'>Ban a User</a><br>");
					out.print("<a href='userResetPassword.jsp'>User Reset Password</a><br><br>");
					out.print("<a href='createAdForm.jsp'>Create Advertisement</a><br>");
					out.print("<a href='trackAds.jsp'>Track Advertisement</a><br>");
				} else{ //shitty end user
					//check on ride request status
					if(session.getAttribute("user.isWaiting") != null && session.getAttribute("user.isWaiting").toString().equals("true")){
						String url = "jdbc:mysql://cs336g32.cyi4cdd85yp2.us-east-1.rds.amazonaws.com:3306/cs336g32";
						Class.forName("com.mysql.jdbc.Driver");
						Connection con = DriverManager.getConnection(url, "admin", "password");
						ResultSet result = null;
						Statement stmt = con.createStatement();
						String str = "SELECT * FROM rides, cars WHERE rides.isComplete=\"0\" AND rides.carId=cars.carId AND rides.rideId=(SELECT MAX(rideRequests.rideId) FROM rideRequests WHERE rideRequests.rider='"+session.getAttribute("user.username").toString()+"')";
						result = stmt.executeQuery(str);
						if (result.next()){
							String driver = result.getString("driver");
							String carDesc = result.getString("carDesc");
							String carNumPassengers = result.getString("carNumPassengers");
							String date = result.getString("date");
							
								out.print("Status: <b>"+driver+" is picking you up in a " + carNumPassengers + " passenger " + carDesc + " at " +date+ " (GMT)</b> <form style=\"display:inline;\" method=\"post\" action=\"server/completeRide.jsp\"><input type=\"hidden\" name=\"rideId\" value=\""+result.getInt("rideId")+"\"><input type=\"submit\" value=\"Mark Complete\"></form>");
						} else{
							out.print("Status: waiting for a ride (refresh page to update)");
						}
					} else{
						out.print("Status: no ride requested");
					}
					
					out.print("<p>Requesting a ride as a passenger allows you to be matched and accepted by a driver offering a ride.</p>");
					out.print("<a href='setCarForm.jsp'>Set Default Car</a><br>");
					out.print("<a href='recurringRidesList.jsp'>Your Recurring Rides</a><br>");
					out.print("<a href='statisticsUser.jsp'>Your Statistics</a><br>");
					out.print("<a href='getRating.jsp'>Your Rating/Feedback</a><br>");
					out.print("<a href='sendMailForm.jsp'>Send mail</a> | ");
					out.print("<a href='getMailForm.jsp'>Get mail</a><br>");
					
					// GET CAR LOGIC
					String url = "jdbc:mysql://cs336g32.cyi4cdd85yp2.us-east-1.rds.amazonaws.com:3306/cs336g32";
					//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
					Class.forName("com.mysql.jdbc.Driver");
					//Create a connection to your DB
					Connection con = DriverManager.getConnection(url, "admin", "password");
					ResultSet cars = null;
					Statement stmt = con.createStatement();
					String str = "SELECT COUNT(*) AS c FROM cars WHERE owner = '"+session.getAttribute("user.username").toString()+"'";
					cars = stmt.executeQuery(str);
					cars.next();
					int c = cars.getInt("c");
					
					if (c!=0){ //has car
						out.print("<a href='rideOfferForm.jsp'>Offer a ride (as Driver)</a> | ");
					} else{ //no car
						out.print("<strike title='You have no car'>Offer a ride (as Driver)</strike> | ");
					}
					out.print("<a href='rideRequestForm.jsp'>Request a ride (as Passenger)</a><br>");
					out.print("<a href='rateDriversList.jsp'>Rate Past Drivers (as Passenger)</a><br>");
				}
			}
			out.print("<br><a href='publicComments.jsp'>Common Systems Board</a>");
			out.print("<br><a href='leaderboard.jsp'>Leaderboard</a>");
		%>
	</body>
</html>