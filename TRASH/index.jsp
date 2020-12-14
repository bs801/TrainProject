<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%

// ASDF 123 123 123 

// miraj 

 // hello
 
 
 //hrllo  again again
 // helloagain

 
 // asdf asdf asdf
 
 // asdf QWERTY
String au = "attemptedUsername";
if("true".equals(session.getAttribute("noSuchAccountFlag"))) {
	  out.println("No such account: "+session.getAttribute(au));
	  
	  session.setAttribute("noSuchAccountFlag","");
	  session.setAttribute("attemptedUsername",null);
	  out.println("<br>");
	  out.println("Please try again.");
	  out.println("<br>");
	  out.println("<br>");
	  out.println("<br>");
}
if("true".equals(session.getAttribute("wrongPasswordFlag"))) {
	  out.println("Incorrect password for: "+session.getAttribute(au));
	  session.setAttribute("wrongPasswordFlag","");
	  session.setAttribute("attemptedUsername",null);
	  out.println("<br>");
	  out.println("Please try again.");
	  out.println("<br>");//test
	  out.println("<br>");
	  out.println("<br>");
}
session.setAttribute("usernameTaken",false);
session.setAttribute("attemptedUsername",null);
session.setAttribute("usernameLengthFlag",false);
session.setAttribute("attemptedPassword",null);
session.setAttribute("passwordLengthFlag",false);
session.setAttribute("dbError",false);
session.setAttribute("newAccount",false);
//asdf			  
%>

<!DOCTYPE html>
<html>
   <head>
      <title>Login Form</title>
   </head>
   <body>
  	<h1>Enter login information</h1>
     <form action="loginChecking.jsp" method="POST">
       Username <input type="text" name="inputUsername"/> <br/>
       Password  <input type="password" name="inputPassword"/> <br/>
       <input type="submit" value="Submit"/>
     </form>
     <br></br>
     <br></br>
     <form action="signup.jsp">
    	<input type="submit" value="Create an Account" />
	</form>
   </body>
</html>
