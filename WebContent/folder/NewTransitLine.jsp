<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	//NewTLPipeline newTLPipeline = (Session) session.getAttribute("NewTLPipeline");
	
	/CSNTLPipeline NTLP = (Session) session.getAttribute("NTLP");
	

	if(session.getAttribute("NTL2") != null){
		ArrayList<String> errors = (ArrayList<String>) session.getAttribute("NTL2");
		for(String error : errors){
	out.println("<br>"+errors+"</br>");
		}
		session.setAttribute("NTL2", null);
	}

	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Class.forName("com.mysql.jdbc.Driver");
	
	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery("select * from station");
	
	ArrayList<Station> stations = new ArrayList<Station>();
	while(rs.next()){
		stations.add(new Station((int) rs.getFloat(1), rs.getString(2), null, null));
	}
	Collections.sort(stations,
	                 new Comparator<Station>() {
	                     public int compare(Station s1, Station s2)
	                     {
	                         return s1.toString().compareTo(s2.toString());
	                     }
	                 }
	);
	session.setAttribute("NTL1", stations);
%>    



<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<form action="NewTransitLineBetween.jsp" method="GET">

	<p1> Transit Line Name </p1>
	<input type="text" name="TLN" />


	<br></br>
	<p1>Select Origin</p1>
	<select id="ORIG" name="ORIG">
		<% for(int i=0; i<stations.size(); i++){ %>
	  	    <option value=<%=i%> /> <%=stations.get(i).name%></option>
	    <% } %>
	    
	</select>
	
	<p1>Select Destination</p1>
	<select id="DEST" name="DEST">
		<% for(int i=0; i<stations.size(); i++){ %>
	  	    <option value=<%=i%> /> <%=stations.get(i).name%></option>
    	<% } %>
	</select>
	
	<p1>Number of in-between stops</p1>
	<select id="STOPS" name="STOPS">
		<% for(int i=0; i<stations.size()-2; i++){ %>
	  	    <option value=<%=i%> /> <%=i%></option>
    	<% } %>
	</select>
	<br></br>
	
	<p1>Fare $</p1> <input type="text" name="FARE"/>
	<br></br><input type="submit" name="NewTransitLine" value="Next" />
</form>



</body>
</html>