<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add a car</title>
</head>
<body>
<div style="position:absolute;top:0;right:0;">[<a href="../index.jsp">GO HOME</a>]</div>
	<%
		try {
			//Create a connection string
			//String url = "jdbc:mysql://cs336-2.crujdr9emkb3.us-east-1.rds.amazonaws.com:3306/BarBeerDrinkerSample";
			String url = "jdbc:mysql://cs336g32.cyi4cdd85yp2.us-east-1.rds.amazonaws.com:3306/cs336g32";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");
	
			//Create a connection to your DB
			Connection con = DriverManager.getConnection(url, "admin", "password");
			
			String desc = request.getParameter("description");
			String numPassengers = request.getParameter("numPassengers");
			
			Statement stmt = con.createStatement();
			String q = "SELECT COUNT(*) as c FROM cars WHERE owner = '"+session.getAttribute("user.username").toString()+"'";
			ResultSet r = stmt.executeQuery(q);
			r.next();
			int c = r.getInt("c");
			String temp = "0";
			if(c==0)
				temp="1";
			
			String str = "INSERT INTO cars(carDesc, carNumPassengers, isDefault, owner) VALUES(?, ?, ?, ?)";
			PreparedStatement p = con.prepareStatement(str);
			p.setString(1, desc);
			p.setString(2, numPassengers);
			p.setString(3, temp);
			p.setString(4, session.getAttribute("user.username").toString());
			p.executeUpdate();
			
			//redirect
			con.close();
			
			response.sendRedirect("../setCarForm.jsp");
			
		} catch (Exception ex) {
			out.print("Car add failed <br> " + ex);
		}
		%>
</body>
</html>