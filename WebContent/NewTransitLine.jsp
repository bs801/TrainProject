<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	CSNTLPipeline csntlp = (CSNTLPipeline) session.getAttribute("CSNTLP");

	csntlp = new CSNTLPipeline(); // DELETE THIS AFTER CS1
	out.println(csntlp.getErrors());
	session.setAttribute("CSNTLP", csntlp);

	ArrayList<Station> Stations = TrainProject.Stations.getAsList();
%>    



<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<form action="NewTransitLine2.jsp" method="GET">

	<p1> Transit Line Name </p1>
	<input type="text" name="TLN" />


	<br></br>
	<p1>Select Origin</p1>
	<select id="ORIG" name="ORIG">
		<% for(int i=0; i<Stations.size(); i++){ %>
	  	    <option value=<%=i%> /> <%=Stations.get(i).name%></option>
	    <% } %>
	    
	</select>
	
	<p1>Select Destination</p1>
	<select id="DEST" name="DEST">
		<% for(int i=0; i<Stations.size(); i++){ %>
	  	    <option value=<%=i%> /> <%=Stations.get(i).name%></option>
    	<% } %>
	</select>
	
	<p1>Number of in-between stops</p1>
	<select id="STOPS" name="STOPS">
		<% for(int i=0; i<Stations.size()-2; i++){ %>
	  	    <option value=<%=i%> /> <%=i%></option>
    	<% } %>
	</select>
	<br></br>
	
	<p1>Fare $</p1> <input type="text" name="FARE"/>
	<br></br><input type="submit" name="NewTransitLine" value="Next" />
</form>



</body>
</html>