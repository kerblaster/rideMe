<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Read Mail</title>
</head>
<body>
	<h1>Mailbox</h1>
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
			
			String str = "SELECT * FROM messages WHERE toUser = '"+session.getAttribute("user.username").toString()+"' ORDER BY mId DESC";
			Statement stmt = con.createStatement();
			ResultSet result = stmt.executeQuery(str);
			
			int count = 0;
			
			while(result.next()){
				count++;
				String temp = "<form method=\"post\" action=\"server/sendMail.jsp\">";
				temp+="Forward to: <input type=\"text\" name=\"to\"> <input type=\"hidden\" name=\"message\" value=\""+result.getString("body")+"\"> <input type=\"submit\" value=\"Send\">";
				temp+="</form>";
				out.print("<b>"+result.getString("fromUser")+":</b> <p>"+result.getString("body")+"</p>"+temp+"<br>");
			}
			
			if(count==0){
				out.print("No mail :(");
			}
			
			con.close();
			
		} catch (Exception ex) {
			if (session.getAttribute("user.username") == null){
				response.sendRedirect("/login.jsp");
			}
			out.print("Getting mail failed <br> " + ex);
		}
		%>
</body>
</html>