<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import ="java.sql.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
</body>
</html>

<%
//miraj 

//test
//another test
	String inputUsername = request.getParameter("inputUsername");   
	String inputPassword = request.getParameter("inputPassword");
    
    ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	// asdf asdf asdf
	// asdf asdf asdf 
    Class.forName("com.mysql.jdbc.Driver");
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("select * from users where username='" + inputUsername + "'");

    if(rs.next()) {
    	String accountPassword = rs.getString(2);
    	System.out.println(accountPassword);
    	if(!inputPassword.equals(accountPassword)){
    		session.setAttribute("wrongPasswordFlag", "true");
    		session.setAttribute("attemptedUsername", inputUsername);
    		response.sendRedirect("index.jsp");
    		return;
    	}
        session.setAttribute("username", inputUsername); // the username will be stored in the session
        response.sendRedirect("loginSuccessful.jsp");
        return;
    } 
    // asdf
    session.setAttribute("noSuchAccountFlag","true");
    session.setAttribute("attemptedUsername", inputUsername);
    response.sendRedirect("index.jsp");
    return;
%>