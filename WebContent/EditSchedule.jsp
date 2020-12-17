<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
    
<%
if(session.getAttribute("ES2") != null){
	out.println((ArrayList<String>) session.getAttribute("ES2")+"<br></br>");
}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
	ArrayList<Schedule> schedules = (ArrayList<Schedule>) session.getAttribute("schedules_edit");
//	session.setAttribute("ScheduleEdit");
 	int i = 0;
 	boolean foundit = false;
	for(i=0; i<schedules.size(); i++){
		if(request.getParameter("E"+i) != null){
			foundit = true;
			session.setAttribute("storedES", "E"+i);
			break;	
		}
		if(request.getParameter("D"+i) != null){
			foundit = true;
			session.setAttribute("storedDS", "D"+i);
			break;
		}
	}
	
	if(!foundit){
		String storedParam = (String)session.getAttribute("storedDS");
		for(i=0; i<schedules.size(); i++){
			if(storedParam.equals("E"+i)){
				foundit = true;
				break;	
			}
			if(storedParam.equals("D"+i)){
				foundit = true;
				break;
			}
		}
	}
	Schedule sc = schedules.get(i);
	session.setAttribute("editSc", sc);
	
	out.println("Editing Schedule");
	out.println(sc.getString()+"<br></br>");
%>
<form action="EditSchedule2.jsp" action="POST">


Departure Date: <input type="date" name="date" value=<%=sc.scheduleDepartureTime.toString()%>> 	<br></br>

Departure Time
	<select name="hour">
		<%
		
		Formatting.getTimeValue(sc.scheduleDepartureTime.toLocalDateTime());
		
		for(i=1; i <= 12; i++){ %>
			<option <%=(i == Formatting.HOUR ? "selected" : "") %> value=<%=i%>><%=i%></option>
		<% } %>
	</select>:
	<select name="minute">
		<% for(i=0; i <= 59; i++){ %>
		<option  <%=(i == Formatting.MIN ? "selected" : "") %> value=<%=i%>><%=(i < 10 ? "0" : "")+""+i%></option>
		<% } %>
	</select>
	<select name="xm">
		<option value="am" <%=(Formatting.RXM.equals("AM") ? "selected" : "")%> >AM</option>
		<option value="pm" <%=(Formatting.RXM.equals("PM") ? "selected" : "")%> >PM</option>
	</select>
	<br></br>

Train: 
<select name="trainID">
	<%  	
	ArrayList<Train> TrainList = TrainProject.Trains.getAsList();
	for(i=0; i<TrainList.size(); i++){ %>
		<option <%=(TrainList.get(i).trainID == sc.trainID ? "selected" : "")%> value=<%=TrainList.get(i).trainID%>><%=Formatting.getTrainID(TrainList.get(i).trainID)%></option>
	<% } %>
	</select>
	
	<input type="Submit" value="Update Schedule"/>
</form>

<form action="ScheduleMain.jsp" method="POST">
	<input type="Submit" value="Cancel"/>
</form>
</body>
</html>