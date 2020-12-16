<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.time.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Train</title>
</head>
<body>
<h1>Add a Train Here</h1>
<%
ArrayList<Train> train = TrainProject.Trains.getAsList();

int id = train.get(train.size()-1).trainID;
%>
	<form action="" method="POST">
		TrainID: <input type="text" name="trainID" value="<%=id+1%>" /> 
		<br></br> 
		
		
	</form>
</body>
</html>