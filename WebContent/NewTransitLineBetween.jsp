<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

    
<%
	if(session.getAttribute("NLB_ERRORS") != null){
		out.println((ArrayList<String>) session.getAttribute("NLB_ERRORS"));
	}
	int orig = Integer.parseInt(request.getParameter("ORIG"));
	int dest = Integer.parseInt(request.getParameter("DEST"));
	ArrayList<String> errors = new ArrayList<String>();
	if(orig == dest){
		errors.add("Origin must be a different station than the destination");
	}
	try{
		float f = Float.parseFloat(request.getParameter("FARE"));
		if(f < 0 || f > 200){
			
			errors.add("Fare must be an between 0 and 200");
		}
	}catch(Exception e){
		errors.add("Fare must be a decimal number");
	}
	String tln = request.getParameter("TLN");
	if(tln.equals("") || tln == null){
		errors.add("Must enter in a transit line name");
	}
	if(errors.size() > 0){
		session.setAttribute("NTL2", errors);
		response.sendRedirect("NewTransitLine.jsp");
		return;
	}
	int interStops = Integer.parseInt(request.getParameter("STOPS"));
	session.setAttribute("interStops",""+interStops+""); //Integer.parseInt(session.getAttribute("interStops"));
	ArrayList<Station> stations = (ArrayList<Station>) session.getAttribute("NTL1");
	session.setAttribute("NLB_ORIG",stations.get(orig));
	session.setAttribute("NLB_DEST",stations.get(dest));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	Origin: <%=stations.get(orig)%>
	<form action="NewTransitLineTimes.jsp" method="POST">
		<%	for(int j=1; j<interStops+1; j++) { %>
			Stop <%=j%>:
			<select id=<%=j%> name=<%=j%>>
			<% for(int i=0; i<stations.size(); i++){ %>
		  	    <option value=<%=i%> /> <%=stations.get(i).name%></option>
	    	<% } %>	
			</select>
			<br></br>
		<% } %>
		Destination: <%=stations.get(dest) %>	<br></br>
		<input type="Submit" value="Next"/>
	</form>


</body>
</html>