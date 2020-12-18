<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	String a = request.getParameter("objectA");
	String b = request.getParameter("rt");
	ArrayList<Schedule> c = TrainProject.Schedules.getFutureSchedules();
	ArrayList<Schedule> temp = new ArrayList<Schedule>();
	Station s = TrainProject.Stations.getAsList().get(Integer.parseInt(a));
	//System.out.println("WORKIGN WITH STATION "+s);
	
	/*for(int j = 0; j < c.size();j++){
		if(request.getParameter())
		
	}*/
	if(b.equals("0")){
		for(Schedule sc: c){
		//	System.out.println("WORKIGN WITH "+sc.getScheduleStops().get(0).stationID+" vs"+ s.stationID);
			if(sc.getScheduleStops().get(0).stationID == s.stationID){
				temp.add(sc);
			}
		}
	}else{
		for(Schedule sc: c){
			if(sc.getScheduleStops().get(sc.getScheduleStops().size()-1).stationID == s.stationID){
				temp.add(sc);
			}
		}
	}
	//System.out.println(temp.size());
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>All Schedules For A Given Station</title>
</head>
<body>
	
	<h1><font color = "black" size = "6">All Schedules For A Given Station</font></h1>
	
	<p><font color="black">Example</font> TransitLineName: Origin -> Destination @ StartingTime  </p><br></br>
	<%
	for(int j=0; j< temp.size(); j++){
	%> <%=temp.get(j).toString()%><br></br><%
	}
	if(temp.size() == 0){
		out.println("No results found");
	}
	%>
	
	
	<form action = "trainScheduleForAStation.jsp">
	<input type ="submit" value = "Back"/>
	</form>
<br></br>
<form action = "RepresentativeLanding.jsp">
	<input type ="submit" value = "Back to Dashboard"/>
	</form>
</body>
</html>