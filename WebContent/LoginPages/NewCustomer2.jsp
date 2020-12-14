<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
    
<%
	String newUsername = request.getParameter("username");   
	String newPassword = request.getParameter("password");
	
	

	String email = request.getParameter("email");
	
	String firstname = request.getParameter("firstname");
	String lastname = request.getParameter("lastname");
    
	ArrayList<String> errors = new ArrayList<String>();
 	if(newUsername.length() < 6 || newUsername == null || newUsername.length() > 20){
 		errors.add("Username must be between 6 to 20 characters");
 	}
 	if(newPassword.length() < 8 || newPassword  == null || newPassword.length() > 20){
 		errors.add("Password must be between 8 to 20 characters");
 	}
 	if(email.length() > 20){
 		errors.add("Email must be less than 20 characters");
 	}
 	
 	
 	if(email == null || "".equals(email)){
 		errors.add("Please enter in an email");
 	}
 	int alpha = email.indexOf('@');
 	if(alpha == -1){
 		errors.add("Email should have a @ character");
 	}
 	int comma = -1; //email.indexOf('.');
 	int alpha2 = -1;
 	try{
 		alpha2 = email.substring(alpha+1).indexOf('@');
 		if(alpha2 != -1){
 			errors.add("Email can only have one @ character");
 		}
 	}catch(Exception e){
 		
 	}
 	try{
 		comma = email.substring(alpha+2).indexOf('.');
 		if(comma == -1){
 			errors.add("Email should have a '.' character after the @ character");
 		}
 	}catch(Exception e){
 		
 	}
 	
 	if("".equals(firstname)){
 		errors.add("First name cannot be empty");
 	}
 	if("".equals(lastname)){
 		errors.add("Last name cannot be empty");
 	}
 	
 	ArrayList<User> users = TrainProject.Users.getAsList();
 	for(User u : users){
 		if(u.username.equalsIgnoreCase(newUsername)){
 			errors.add("Username "+newUsername+" is already taken");
 		}
 	}
 	if(errors.size() > 0 ){
 		session.setAttribute("NC2", errors);
 		response.sendRedirect("NewCustomer.jsp");
 		return;
 	}
 	
 	
 	User newUser = new User(newUsername, newPassword,firstname, lastname, email);
	TrainProject.Users.insert(newUser);
 	
	session.setAttribute("username",newUser.username);
   	response.sendRedirect("../CustomerLanding.jsp");
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