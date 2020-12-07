<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Insert title here</title>
	</head>
	<body>
		<% try {
			String url = "	jdbc:mysql://mydb.cmejw1qzq2u6.us-east-2.rds.amazonaws.com:3306/BarBeerDrinker";
			// 				jdbc:mysql://cs336.ckksjtjg2jto.us-east-2.rds.amazonaws.com:3036/BarBeerDrinkerSample

			Class.forName("com.mysql.jdbc.Driver");
			//Get the database connection
		//	Connection con = DriverManager.getConnection(url, "admin", "!Hello202");
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String entity = request.getParameter("command");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM " + entity;
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			out.print("<table>");
		%>
			
		<!--  Make an HTML table to show the results in: -->
	<table>
		<tr>    
			<td>Name</td>
			<td>
				<%if (entity.equals("beers"))
					out.print("Manufacturer");
				else
					out.print("Address");
				%>
			</td>
		</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("name") %></td>
					<td>
						<% if (entity.equals("beers")){ %>
							<%= result.getString("manf")%>
						<% }else{ %>
							<%= result.getString("addr")%>
						<% } %>
					</td>
				</tr>
				

			<% }
			//close the connection.
			%>
		</table>

			
		<%} catch (Exception e) {
			out.print(e);
		}%>
	

	</body>
</html>