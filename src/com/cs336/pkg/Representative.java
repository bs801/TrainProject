package com.cs336.pkg;

import java.sql.ResultSet;
import java.sql.SQLException;

/*
 * 
 * 
 *     username varchar(20) primary key,
    password varchar(20) NOT NULL,
    
    SSN varchar(11),
    firstName varchar(20),
    lastName varchar(20)
 */


public class Representative {

	String username;
	String password;
	
	String SSN;
	
	String firstName;
	String lastName;
	
	public Representative(String username, String password, String firstName, String lastName, String SSN) {
		this.username = username; this.password = password; this.firstName = firstName; this.lastName = lastName; this.SSN = SSN;
	}
	
	public Representative(ResultSet rs) throws SQLException {
		this(rs.getString("username"), rs.getString("password"), rs.getString("firstName"), rs.getString("lastName"), rs.getString("SSN"));		
	}
	
	public String toString() {
		return firstName + " " + lastName; 
		
	}
	
}
