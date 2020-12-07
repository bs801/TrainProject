<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
    String newUsername = request.getParameter("NewUsername");   
    String newPassword = request.getParameter("NewPassword");
    
 	boolean returnFlag = false;
   	if(newUsername.length() < 6 || newUsername == null || newUsername.length() > 20){
   		session.setAttribute("attemptedUsername",newUsername);
   		session.setAttribute("usernameLengthFlag",true);
   		returnFlag = true;
   	}
   	if(newPassword.length() < 8 || newPassword  == null || newPassword.length() > 20){
   		session.setAttribute("attemptedPassword",newPassword);
   		session.setAttribute("passwordLengthFlag",true);
   		returnFlag = true;
   	}
   	if(returnFlag){
   		response.sendRedirect("signup.jsp");
   		return;
   	}
   	
    
    
    ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
    Class.forName("com.mysql.jdbc.Driver");
    
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("select * from users where username='" + newUsername + "'");
    if (rs.next()) {
    	session.setAttribute("usernameTaken",true);
    	session.setAttribute("attemptedUsername",newUsername);
        response.sendRedirect("signup.jsp");
        return;
    } 
   	
  

	String insert = "INSERT INTO users(username, password)"	+ "VALUES (?, ?)";
	PreparedStatement ps = con.prepareStatement(insert);
	ps.setString(1, newUsername);
	ps.setString(2, newPassword);
	
	try {
		ps.executeUpdate();
	} catch (Exception ex) {
		out.print(ex);
		out.print("Login insert failed :()");
		session.setAttribute("dbError",true);
		response.sendRedirect("signup.jsp");
		return;
	}
	
	session.setAttribute("username",newUsername);
	session.setAttribute("newAccount",true);
	response.sendRedirect("loginSuccessful.jsp"); 
%>

</body>
</html>