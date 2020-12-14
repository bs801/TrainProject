<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>signup</title>
</head>
<body>
<h1> Create an account </h1>

<%
	boolean pta = false;
	boolean usernameTaken = ((Boolean) session.getAttribute("usernameTaken")).booleanValue();
	if(usernameTaken){
		out.println("Username "+session.getAttribute("attemptedUsername")+" is already taken.");
		pta = true;
	}
	boolean usernameLengthFlag = ((Boolean) session.getAttribute("usernameLengthFlag")).booleanValue();
	boolean passwordLengthFlag = ((Boolean) session.getAttribute("passwordLengthFlag")).booleanValue();
	if(usernameLengthFlag){
		out.println("Username "+session.getAttribute("attemptedUsername")+" is not between 6 and 20 characters.");
		pta = true;
	}
	
	if(passwordLengthFlag){
		String showPass = "";
		String pass = (String) session.getAttribute("attemptedPassword");
		if(pass != null){
			for(int i=0; i<pass.length(); i++){
				if(i == 0){
					showPass = pass.substring(0,1); continue;
				}
				showPass = showPass + "*";
				if(i == 20){
					showPass = showPass + "..."; break;
				}
			}
		}
		out.println("Password "+showPass+" is not between 6 and 20 characters.");
		pta = true;
	}
	
	boolean dbError = ((Boolean) session.getAttribute("dbError")).booleanValue();
	if(dbError){
		out.println("Database error in signup");
		pta = true;
	}
	if(pta){
		out.println("<br><br/>");
		out.println("Please try again.");
	}
	
	session.setAttribute("usernameTaken",false);
	session.setAttribute("attemptedUsername",null);
	session.setAttribute("usernameLengthFlag",false);
	session.setAttribute("attemptedPassword",null);
	session.setAttribute("passwordLengthFlag",false);
	session.setAttribute("dbError",false);
	
%>


<form action="signupChecking.jsp" method="POST">
	   
	   <br/>
	   
	   
	    
	   <h3>Username must be 6-20 characters</h3>
       Username <input type="text" name="NewUsername"/> <br/>
       
       <h3>Password must be 8-20 characters</h3>
       Password <input type="password" name="NewPassword"/> <br/>
       
       <br></br>
       <input type="submit" value="Sign up"/>
</form>
<br/><br/>
<form action="index.jsp" method="POST"><input type="submit" value="Return to login"></form>
</body>
</html>