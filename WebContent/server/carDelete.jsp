<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete a car</title>
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
			
			String carId = request.getParameter("carId");
			
			Statement stmt = con.createStatement();
			String q = "SELECT * FROM cars WHERE owner = '"+session.getAttribute("user.username").toString()+"' AND isDefault='1'";
			ResultSet r = stmt.executeQuery(q);
			r.next();
			if(r.getInt("carId")==Integer.parseInt(carId)){
				String str2 = "SELECT * FROM cars WHERE owner = '"+session.getAttribute("user.username").toString()+"' AND isDefault='0'";
				Statement stmt2 = con.createStatement();
				ResultSet r2 = stmt2.executeQuery(str2);
				if(r2.next()){
					int id = r2.getInt("carId");
					String update = "UPDATE cars isDefault='1' WHERE carId = '"+id+"'";
					PreparedStatement p = con.prepareStatement(update);
					p.executeUpdate();
				}
			}
			
			String str = "DELETE FROM cars WHERE carId = '"+carId+"'";
			PreparedStatement p = con.prepareStatement(str);
			p.executeUpdate();
			
			//redirect
			con.close();
			
			response.sendRedirect("../setCarForm.jsp");
			
		} catch (Exception ex) {
			out.print("Car delete failed <br> " + ex);
		}
		%>
</body>
</html>