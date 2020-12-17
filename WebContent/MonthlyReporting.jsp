<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"  import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>

<%
	
	MonthReport.update(request);
	

%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
Select Month to View Metrics For:
<form action="MonthlyReporting.jsp" method="GET">

	
	<select name="month">
	    <option <%=(MonthReport.MONTHSELECT == 0 ? "selected" : "")%> value="0">--Month--</option>
	    <option <%=(MonthReport.MONTHSELECT == 1 ? "selected" : "")%> value="1">January</option>
	    <option <%=(MonthReport.MONTHSELECT == 2 ? "selected" : "")%> value="2">February</option>
	    <option <%=(MonthReport.MONTHSELECT == 3 ? "selected" : "")%> value="3">March</option>
	    <option <%=(MonthReport.MONTHSELECT == 4 ? "selected" : "")%> value="4">April</option>
	    <option <%=(MonthReport.MONTHSELECT == 5 ? "selected" : "")%> value="5">May</option>
	    <option <%=(MonthReport.MONTHSELECT == 6 ? "selected" : "")%> value="6">June</option>
	    <option <%=(MonthReport.MONTHSELECT == 7 ? "selected" : "")%> value="7">July</option>
	    <option <%=(MonthReport.MONTHSELECT == 8 ? "selected" : "")%> value="8">August</option>
	    <option <%=(MonthReport.MONTHSELECT == 9 ? "selected" : "")%> value="9">September</option>
	    <option <%=(MonthReport.MONTHSELECT == 10 ? "selected" : "")%> value="10">October</option>
	    <option <%=(MonthReport.MONTHSELECT == 11 ? "selected" : "")%> value="11">November</option>
	    <option <%=(MonthReport.MONTHSELECT == 12 ? "selected" : "")%> value="12">December</option>
	</select> 
	<% 
		if(MonthReport.validdate == false){
			%><input type="text" name="year" placeholder="yyyy"><%
		} else {
			%><input type="text" name="year" placeholder="yyyy" value=<%=MonthReport.YEARSELECT%>><%
		}
	%>

	<input type = "submit" name="datesubmit" value = "Select Month/Year"/>

	
	
	<h3> View revenue and reservation report </h3>
	
	The revenue and reservation report shows revenue and reservations either for a selected customer or transit line.
	
	<input type="radio" name="torc" value="0" <% out.println(MonthReport.c1); %> /> Do not use
	<br></br>
	
	<input type="radio" name="torc" value="1" <% out.println(MonthReport.c2); %> /> For Customer 
	<select name="customerindex">
		<% for(int i=0; i<MonthReport.COptions.size(); i++){ %>
				<option value=<%=""+i+""%>><%=MonthReport.COptions.get(i)%></option>
		<% } %>
	</select>
	
	<input type="radio" name="torc" value="2" <% out.println(MonthReport.c3); %> /> For Transit Line 
	<select name="tlnindex">
		<% for(int i=0; i<MonthReport.TLOptions.size(); i++){ %>
				<option value=<%=""+i+""%>><%=MonthReport.TLOptions.get(i)%></option>
		<% } %>
	</select>
	<br></br>
	<br></br>
	
	<input type="Submit" name="reportsubmit" value="View Report" />
</form>

<br></br>
<br></br>
<form action="AdminLanding.jsp">
<input type="submit" value="Cancel"/>
</form>



</body>
</html>