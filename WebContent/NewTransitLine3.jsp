<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	CSNTLPipeline p = (CSNTLPipeline) session.getAttribute("CSNTLP");
	out.println(p.getErrors());
	

	ArrayList<String> errors = new ArrayList<String>();
	
	ArrayList<Station> selectedStationList = new ArrayList<Station>();
	
	for(int j=1; j< p.numberOfStops+1 ; j++) { 
		
		String v = request.getParameter(""+j+"");
		int s = Integer.parseInt(v);
		Station newStation = TrainProject.Stations.get(s);
		if(selectedStationList.contains(newStation) || newStation.equals(p.origin) || newStation.equals(p.destination)){
			
			errors.add("Station "+newStation+" was added more than once");
			p.errors = errors;
			response.sendRedirect("NewTransitLine2.jsp");
			return;
		}
		selectedStationList.add(newStation);
	}

	p.selectedStationList = selectedStationList;
%>

<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	Enter in times in X:YZ format. System will automatically detect AM/PM changes assuming stops are at most 11:59 hours apart. 
	<br></br>
		<br></br>
			<br></br>
	STATION NAME_____________________________: _ [ARRIVAL TIME] _ [DEPARTURE TIME] <br></br> 	<br></br>
	
	<% String extraO = ""; for(int s=p.origin.toString().length(); s<50; s++){ extraO += "_"; } %>
	<%=""+p.origin+extraO+""%>: ORIGIN <%=session.getAttribute("CS2_STDSTR") %> <br></br>
	
	<form action="NewTransitLine4.jsp" method="POST">
	
		<%	for(int j=0; j<selectedStationList.size(); j++) {
				String extra = ""; for(int s=selectedStationList.get(j).toString().length(); s<50; s++){ extra += "_"; }	%>
			
			<%=selectedStationList.get(j)+extra%>:
			<input type="text" name=<%="A"+j%> placeholder="i.e. 5:04" />
			<input type="text" name=<%="D"+j%> placeholder="i.e. 5:07" />
			<br></br>
		<% } %>
	<% String extraD = ""; for(int s=p.destination.toString().length(); s<50; s++){ extraD += "_"; } %>
	<%=""+p.destination+extraD+""%>: <input type="text" name=<%="DA"%> placeholder="5:04" /> DESTINATION
	<br></br><input type="submit" value="Next" />
	</form>
	
</body>
</html>