<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reset User Password</title>
</head>
<body>
	<h1>Reset User Password</h1>
	<div style="position:absolute;top:0;right:0;">[<a href="index.jsp">GO HOME</a>]</div>
	<form method="post" action="server/userResetPasswordScript.jsp">
		<table>
			<tr>
				<td>Username: </td>
				<td><input type="text" name="userToReset"></td>
			</tr>
			<tr>
				<td>Reset Password to: </td>
				<td><input type="password" name="newPassword"></td>
			</tr>			
		</table>
		<br>
		<input type="submit" value="Reset">
	</form>
</body>
</html>