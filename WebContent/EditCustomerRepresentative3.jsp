<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.time.*"%>
    
    
<%
	String fn = request.getParameter("firstname");
	String ln = request.getParameter("lastname");
	if(fn.length() > 20 || ln.length() > 20){
		session.setAttribute("EC3", "First and last name must be 20 characters or less. <br></br>");
		response.sendRedirect("editCustomerRepresentative2.jsp");
		return;
	}
	int i = (Integer) session.getAttribute("EC2i");
	Representative r = TrainProject.Representatives.getAsList().get(i);
	if(fn.equals(r.firstName) && ln.equals(r.lastName)){
		session.setAttribute("EC3", "Error, no changes to first or last name were made. <br></br>");
		response.sendRedirect("editCustomerRepresentative2.jsp");
		return;
	}
	r.firstName = fn;
	r.lastName = ln;
	TrainProject.Representatives.update(r);
	session.setAttribute("EU", "Representative with username "+r.username+"'s first and last name are now "+fn+" and "+ln+"<br></br>");
	response.sendRedirect("editCustomerRepresentative.jsp");
	
%>
<!DOCTYPE html>


<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form action="editCustomerRepresentative.jsp" method="POST">
<input type="Submit" value="Cancel"/>
</form>

</body>
</html>