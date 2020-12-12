package com.cs336.pkg;


/*
 * 
 * answerID int auto_increment, 
    answerText tinytext, 
    questionID int NOT NULL,
    
    username varchar(20),
    foreign key(username) references Representative(username),
    
    primary key(answerID, questionID),
    foreign key(questionID) references Question(questionID)
 * 
 */

public class Answer {
	int answerID;
	String answerText;
	int questionID;
	String username;

	
	
}
