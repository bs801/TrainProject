<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

    
<%
	CSNTLPipeline csntlPipeline = (CSNTLPipeline) session.getAttribute("CSNTLP");
	out.println(csntlPipeline.getErrors());
	
	String transitLineName;
	Station origin = TrainProject.Stations.getAsList().get(  Integer.parseInt(request.getParameter("ORIG")) );
	Station destination = TrainProject.Stations.getAsList().get(  Integer.parseInt(request.getParameter("DEST")) );
	
	ArrayList<String> errors = new ArrayList<String>();
	
	if(origin == csntlPipeline.destination){
		errors.add("Origin must be a different station than the destination");
	}
	Float fare = -1f;
	try{
		fare = Float.parseFloat(request.getParameter("FARE"));
		if(fare < 0 || fare > 200){
			
			errors.add("Fare must be an between 0 and 200");
		}
	}catch(Exception e){
		errors.add("Fare must be a decimal number");
	}
	transitLineName = request.getParameter("TLN");
	if(transitLineName.equals("") || transitLineName == null){
		errors.add("Must enter in a transit line name");
	}
	
	if(errors.size() > 0){
		csntlPipeline.errors = errors;
		response.sendRedirect("NewTransitLine.jsp");
		return;
	}
	
	int numberOfStops = Integer.parseInt(request.getParameter("STOPS"));
	
	csntlPipeline.transitLineName = transitLineName; csntlPipeline.origin = origin; csntlPipeline.destination = destination; csntlPipeline.fare = fare; csntlPipeline.numberOfStops = numberOfStops;
	
	/*
	session.setAttribute("interStops",""+interStops+""); //Integer.parseInt(session.getAttribute("interStops"));
	ArrayList<Station> stations = (ArrayList<Station>) session.getAttribute("NTL1");
	session.setAttribute("NLB_ORIG",stations.get(orig));
	session.setAttribute("NLB_DEST",stations.get(dest)); */
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	Origin: <%=origin.toString()%>
	<form action="NewTransitLine3.jsp" method="POST">
		<%	for(int j=1; j<numberOfStops+1; j++) { %>
		
			Stop <%=j%>:<select id=<%=j%> name=<%=j%>>
			<% for(int i=0; i<TrainProject.Stations.getAsList().size(); i++){ %>
		  	    <option value=<%=i%> /><%=TrainProject.Stations.getAsList().get(i).toString()%></option>
	    	<% } %>	
			</select>
			<br></br>
		<% } %>
		Destination: <%=destination.toString() %>	<br></br>
		<input type="Submit" value="Next"/>
	</form>


</body>
</html>