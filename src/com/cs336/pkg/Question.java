package com.cs336.pkg;

import java.sql.ResultSet;
import java.sql.SQLException;

/*
 * 	questionID int primary key auto_increment,
    questionText tinytext,
    username varchar(20),
    
    `descriptionText` tinytext,
    
    foreign key(username) references User(username)
 * 
 * 
 */


public class Question {
	int questionID;
	String questionText;
	
	String username;
	String descriptionText;
	
	public Question(int questionID, String questionText, String username, String descriptionTest) {
		this.questionID = questionID; this.questionText = questionText; this.username = username; this.descriptionText = descriptionText;
	}
	public Question(ResultSet rs) throws SQLException {
		this(rs.getInt("questionID"), rs.getString("questionText"), rs.getString("username"), rs.getString("descriptionText"));
	}
	
	public String toString() {
		return questionText;
	}
}
