<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
System.out.println("UP FRONT");
	CSNTLPipeline p = (CSNTLPipeline) session.getAttribute("CSNTLP");
	if(p == null){
		p = new CSNTLPipeline();
		session.setAttribute("CSNTLP", p);
	}
	out.println(p.getErrors());
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form action="CreateSchedule2.jsp" method="GET">
	Date
	<select name="month">
	    <option selected value="0">--Month--</option>
	    <option value="1">January</option>
	    <option value="2">February</option>
	    <option value="3">March</option>
	    <option value="4">April</option>
	    <option value="5">May</option>
	    <option value="6">June</option>
	    <option value="7">July</option>
	    <option value="8">August</option>
	    <option value="9">September</option>
	    <option value="10">October</option>
	    <option value="11">November</option>
	    <option value="12">December</option>
	</select> 
	<input type="text" name="day" placeholder="dd">
	<input type="text" name="year" placeholder="yyyy">
	
	<br></br>
	Departure Time
	<select name="hour">
		<% for(int i=1; i <= 12; i++){ %>
			<option value=<%=i%>><%=i%></option>
		<% } %>
	</select>:
	<select name="minute">
		<% for(int i=0; i <= 59; i++){ %>
		<option value=<%=i%>><%=(i < 10 ? "0" : "")+""+i%></option>
		<% } %>
	</select>
	<select name="xm">
		<option value="am">AM</option>
		<option value="pm">PM</option>
	</select>
	<br></br>

	Train
	<select name="trainID">
	<option selected value="-1">--Select Train--</option>
	<% 
	
	ArrayList<Train> TrainList = TrainProject.Trains.getAsList();
	
	for(int i=0; i<TrainList.size(); i++){ %>
		<option value=<%=TrainList.get(i).trainID%>><%=TrainList.get(i)%></option>
	<% } %>
	</select>
	<br></br>
	
	<%
    ArrayList<TransitLine> transitLines = TrainProject.TransitLines.getAsList();
  
   
    

	%>
	
	Transit Line
	<select name="TLOption">
		<option value="NO_SELECTION">-------------------------</option>
		<option value="CREATE">CREATE NEW TRANSIT LINE</option>
		<option value="NO_SELECTION">-------------------------</option>
		<% for(int i=0; i<transitLines.size(); i++){ %>
			<option value=<%=""+i+""%>><%=transitLines.get(i).toString()%></option>
		<% } %>
	</select>
	<br></br>
	<input type="submit" value="Continue"/> 
</form>
</body>
</html>