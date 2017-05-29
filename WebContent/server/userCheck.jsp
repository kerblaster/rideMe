<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Check user</title>
	</head>
	<body>
	<div style="position:absolute;top:0;right:0;">[<a href="../login.jsp">Try Again...</a>]</div>
		<%
		try {
			//Create a connection string
			//String url = "jdbc:mysql://cs336-2.crujdr9emkb3.us-east-1.rds.amazonaws.com:3306/BarBeerDrinkerSample";
			String url = "jdbc:mysql://cs336g32.cyi4cdd85yp2.us-east-1.rds.amazonaws.com:3306/cs336g32";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");
	
			//Create a connection to your DB
			Connection con = DriverManager.getConnection(url, "admin", "password");
	
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Get parameters from the HTML form
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			
			//Check counts once again (the same as the above)
			String str = "SELECT * FROM users WHERE users.username = '" + username + "' AND users.password = '" + password +"'";
			ResultSet result = stmt.executeQuery(str);
			result.next();
			
			String banned = result.getString("isBanned");
			if(banned.equals("1"))
				throw new Exception("You are banned");
			
			String email = result.getString("email");
			String name = result.getString("name");
			String address = result.getString("address"); 
			String phone = result.getString("phone");
			String type = result.getString("type");
			
			String str2 = "SELECT carId AS c FROM cars WHERE owner = '"+username+"' AND isDefault = '1'";
			ResultSet car = stmt.executeQuery(str2);
			String carId = null;
			if(car.next())
				carId = car.getInt("c")+"";
			
			//Find if waiting for ride
			String str3 = "SELECT COUNT(rideRequests.rideId) AS unfulfilled FROM rides, rideRequests WHERE rideRequests.rider='"+username+"' AND rides.rideId <> rideRequests.rideId AND rides.isComplete='0'";
			ResultSet result3 = stmt.executeQuery(str3);
			result3.next();
			int count = result3.getInt("unfulfilled");
			if (count > 0){
				session.setAttribute("user.isWaiting", "true");
			}
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			session.setAttribute("user.username", username);
			session.setAttribute("user.password", password);
			session.setAttribute("user.email", email);
			session.setAttribute("user.name", name);
			session.setAttribute("user.address", address);
			session.setAttribute("user.phone", phone);		
			session.setAttribute("user.type", type);
			if(carId!=null)
				session.setAttribute("user.carId", carId);
			
			response.sendRedirect("../index.jsp");
		} catch (Exception ex) {
			out.print("Login Failed <br> " + ex);
		}
		%>
	</body>
</html>