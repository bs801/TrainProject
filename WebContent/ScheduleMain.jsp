<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.LocalDate"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<form action="RepresentativeLanding.jsp" method="GET">
	<input type="Submit" name="filter" value="RETURN TO DASHBOARD" /> <br></br>
</form>

<h2>Create a New Schedule</h2>
<form action="CreateSchedule.jsp" method="GET">
	<input type="Submit" name="filter" value="Create New Schedule" /> <br></br>
</form>
<br></br>
<h2>Schedule Filter Options</h2>
Use these options to filter the list active of schedules below.
<%
	System.out.println("ASDF");
	boolean nofilter = false;
	boolean datefilter = false;
	boolean tlnfilter = false;
	LocalDate d1 = null;
	LocalDate d2 = null;
	String tln = null;
	
	String datevalue1 = "";
	String datevalue2 = "";
	
	String check1 = "";
	String check2 = "";
	String check3 = "";
	String check4 = "";
	
	ArrayList<Schedule> schedules = TrainProject.Schedules.getFutureSchedules();
	Collections.sort(schedules,
            new Comparator<Schedule>() {
                public int compare(Schedule s1, Schedule s2)
                {
                    return (s1.scheduleDepartureTime.toLocalDateTime().isBefore(s2.scheduleDepartureTime.toLocalDateTime()) ? -1 : 1);
                }
            }
	);
	System.out.println("50");
	int resettln = 0;
	if(request.getParameter("filter") != null){
		System.out.println("DF DF DF "+request.getParameter("df"));
		if("0".equals(request.getParameter("df"))){
			check1 = "checked";
		} else {
			try{
				d1 = LocalDate.parse(request.getParameter("date1"));
				d2 = LocalDate.parse(request.getParameter("date2"));
				if(d2.isBefore(d1)){
					throw new Exception();
				}
				ArrayList<Schedule> newScheduleList = new ArrayList<Schedule>();
				for(Schedule sc : schedules){
					if(!sc.scheduleDepartureTime.toLocalDateTime().toLocalDate().isBefore(d1) && !sc.scheduleDepartureTime.toLocalDateTime().toLocalDate().isAfter(d2)){
						newScheduleList.add(sc);
					}
				}
				
				datevalue1 = request.getParameter("date1");
				datevalue2 = request.getParameter("date2");
				
				check2 = "checked";
				
				schedules = newScheduleList;
				datefilter = true;
				
			}catch(Exception e){
				System.out.println("DATE ERROR");
				check1 = "checked";
			}
		}
		System.out.println("81");
		if(request.getParameter("tlnf").equals("0") || request.getParameter("TransitLineName").equals("NO_SELECTION")){
			check3 = "checked";
		} else {
			tln = Formatting.getTransitLineNames().get(Integer.parseInt((String) request.getParameter("TransitLineName")));
			ArrayList<Schedule> newScheduleList = new ArrayList<Schedule>();
			for(Schedule sc : schedules){
				if(sc.transitLineName.equals(tln)){
					newScheduleList.add(sc);
				}
			}
			if(datefilter){
				datefilter = false;
			} else {
				tlnfilter = true;
			}
			schedules = newScheduleList;
			check4 = "checked";
			
		}
		System.out.println("99");
		if(!datefilter && !tlnfilter){
			nofilter = true;
		}
	} else {
		check1 = "checked";
		check3 = "checked";
		nofilter = true;
	}
	session.setAttribute("schedules_edit", schedules);
	System.out.println("105");
%>

<form>


</form>



<form action="ScheduleMain.jsp" method="GET">
Departure Date Filter:<br></br>
<input type="radio" name="df" value="0" <% out.println(check1); %> /> No filter  <br></br>
<input type="radio" name="df" value="1" <% out.println(check2); %> /> Use filter  <br></br>
Start Date: <input type="date" name="date1" value=<% out.println(datevalue1); %> >
End Date:<input type="date" name="date2" value=<% out.println(datevalue2); %>>
 <br></br>

 
Transit Line Name Filter:<br></br>
<input type="radio" name="tlnf" value="0" <% out.println(check3); %> /> No filter  <br></br>
<input type="radio" name="tlnf" value="1" <% out.println(check4); %> /> Use filter  <br></br>
<select name="TransitLineName">
		<option value="NO_SELECTION">-Pick a transit line name-</option>
		<% for(int i=0; i<Formatting.getTransitLineNames().size(); i++){ %>
			<option  <%=(MonthReport.TLNSELECT == i+1 ? "selected" : "") %> value=<%=""+i+""%>><%=Formatting.getTransitLineNames().get(i)%></option>
		<% } %>
	</select> <br></br>

<input type="Submit" name="filter" value="Apply Filter Options" /> <br></br>
</form>


<%//<h2> Schedule Information </h2> %>
<form action="EditSchedule.jsp" method="POST">
<%

String starttag = "<h2>";
String endtag = "</h2>";
if(nofilter){
	out.println(starttag+"Showing all schedules"+endtag);
	System.out.println("nofilter"+nofilter);
} else if(datefilter){
	out.println(starttag+"Showing schedules with departure time between "+Formatting.displayTime(d1)+" and "+Formatting.displayTime(d2)+endtag);
} else if(tlnfilter){
	out.println(starttag+"Showing schedules with transit line name "+tln+endtag);
} else {
	out.println(starttag+"Showing schedules with departure time between "+Formatting.displayTime(d1)+" and "+Formatting.displayTime(d2)+
			" with transit line name "+tln+endtag);
}
for(int i=0; i<schedules.size(); i++){
	out.println(schedules.get(i).getString()); %> 
	<input type="Submit" name=<%="E"+i%> value="Edit" />
	<input type="Submit" name=<%="D"+i%> value="Delete" />
	<br></br>
<%}
%>
</form>



</body>
</html>