<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
    
<%
	String newUsername = request.getParameter("username");   
	String newPassword = request.getParameter("password");
	
	

	String SSN = request.getParameter("SSN");
	
	String firstname = request.getParameter("firstname");
	String lastname = request.getParameter("lastname");
    
	ArrayList<String> errors = new ArrayList<String>();
 	if(newUsername.length() < 6 || newUsername == null || newUsername.length() > 20){
 		errors.add("Username must be between 6 to 20 characters");
 	}
 	if(newPassword.length() < 8 || newPassword  == null || newPassword.length() > 20){
 		errors.add("Password must be between 8 to 20 characters");
 	}
 	
 	if(!(SSN.length() < 12)){
 		errors.add("SSN must be 11 characters or less");
 	}

 	
 	if("".equals(firstname)){
 		errors.add("First name cannot be empty");
 	}
 	if("".equals(lastname)){
 		errors.add("Last name cannot be empty");
 	}
 	
 	ArrayList<Representative> users = TrainProject.Representatives.getAsList();
 	for(Representative u : users){
 		if(u.username.equalsIgnoreCase(newUsername)){
 			errors.add("Username "+newUsername+" is already taken");
 		}
 	}
 	if(errors.size() > 0 ){
 		session.setAttribute("NR2", errors);
 		response.sendRedirect("NewRepresentative.jsp");
 		return;
 	}
 	
 	
 	Representative newUser = new Representative(newUsername, newPassword,firstname, lastname, SSN);
	TrainProject.Representatives.insert(newUser);

 	
	session.setAttribute("username", newUser.username);
	session.setAttribute("representative", newUser);
   	response.sendRedirect("RepresentativeLanding.jsp");
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>