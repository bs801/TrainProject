package com.cs336.pkg;

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
	String descriptionTest;
	
	public Question(int questionID, String questionText, String username, String descriptionTest) {
		//this.questionID = questionID, this.questionText = questionText, this.username = username, this.descriptionTest = descriptionTest;
	}
	public Question() {
		
	}
}
