<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Manage cars</title>
</head>
<body>
<h1>Set/Add Default Car</h1>
<div style="position:absolute;top:0;right:0;">[<a href="index.jsp">GO HOME</a>]</div>
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
			
			String username = session.getAttribute("user.username").toString();
			
			//Check counts once again (the same as the above)
			String str = "SELECT * FROM cars WHERE owner = '"+username+"'";
			ResultSet result = stmt.executeQuery(str);
			/*
			<input type="radio" name="mode" value="time" id="time"> Time<br>
  			<input type="radio" name="mode" value="user" id="user"> User<br>
  			<input type="radio" name="mode" value="origin" id="origin"> Origin<br>
  			<input type="radio" name="mode" value="destination" id="destination"> Destination<br>
			*/
			
			while(result.next()){
				String html="<form method=\"post\" action=\"server/updateCar.jsp\">";
				String temp = "";
				if(result.getInt("isDefault")==1){
					temp = " | [Default]";
					session.setAttribute("user.carId", result.getInt("carId")+"");
				}
				html+="id: "+result.getInt("carId")+" | "+result.getString("carDesc")+" | "+result.getInt("carNumPassengers")+" passengers"+temp;
				html+="<input type=\"hidden\" name=\"carId\" value=\""+result.getInt("carId")+"\">";
				String temp2 = "submit";
				if(result.getInt("isDefault")==1)
					temp2 = "hidden";
				html+="<input type=\""+temp2+"\" value=\"Make default\">";
				html+="</form>";
				out.print(html);
			}
			
			con.close();
			
		} catch (Exception ex) {
			out.print("Car change failed <br> " + ex);
		}
		%>
		<br>
		<form method="post" action="server/carAdd.jsp">
			description:
			<input type="text" name="description">
			number of passengers:
			<input type="number" name="numPassengers">
			<input type="submit" value="Add car">
		</form>
		<form method="post" action="server/carDelete.jsp">
			carId:
			<input type="text" name="carId">
			<input type="submit" value="Delete car">
		</form>
</body>
</html>