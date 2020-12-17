<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.time.*"%>
<%
int v = -1;
ArrayList<String> errors = new ArrayList<String>();
try{
	v = Integer.parseInt(request.getParameter("trainID"));
	if(v < 0 || v > 9999){
		throw new Exception();
	}
}catch(Exception e){
	errors.add("Please enter in a trainID that is a number 0 - 1000");
	session.setAttribute("AT2",errors);
	response.sendRedirect("addTrain.jsp");
	return;
}
ArrayList<Train> train = TrainProject.Trains.getAsList();


	for(Train t : train){
		if(t.trainID == v){
			errors.add("TrainID "+v+" is already taken");
			session.setAttribute("AT2",errors);
			response.sendRedirect("addTrain.jsp");
			return;
		}
	}

	Train tt = new Train(v);
	TrainProject.Trains.insert(tt);
	out.println("Train "+v+" was successfully created <br></br>");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<br></br>
<form action="AddTrain.jsp" method="POST">
<input type="Submit" value="Add a new train"/>
</form>
<br></br>
<form action="RepresentativeLanding.jsp" method="POST">
<input type="Submit" value="Back to representative dashboard"/>
</form>
</body>
</html>