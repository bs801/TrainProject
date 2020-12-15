package com.cs336.pkg;

import java.sql.ResultSet;
import java.sql.SQLException;

/*
 * 	username varchar(20) primary key,
    password varchar(20) NOT NULL,
    
    firstName varchar(20),
    lastName varchar(20),
    emailAddress varchar(20)
 * 
 * 
 */

public class Customer {
	
	public String username;
	public String password;
	public String firstName;
	public String lastName;
	public String emailAddress;
	
	public Customer(String username, String password, String firstName, String lastName, String email) {
		this.username = username; this.password = password; this.firstName = firstName; this.lastName = lastName; this.emailAddress = emailAddress;
	}
	
	public Customer(ResultSet rs) throws SQLException {
		this(rs.getString("username"), rs.getString("password"), rs.getString("firstName"), rs.getString("lastName"), rs.getString("emailAddress"));		
	}
	
	public String toString() {
		return firstName + " " + lastName; 
	}
}
