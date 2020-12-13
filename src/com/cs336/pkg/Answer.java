package com.cs336.pkg;

import java.sql.ResultSet;
import java.sql.SQLException;

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

public class Answer implements Comparable<Answer>{
	public int answerID;
	public String answerText;
	public int questionID;
	public String username;

	
	public Answer(int answerID, String answerText, int questionID, String username) {
		this.questionID = questionID; this.answerText = answerText; this.username = username;
	}
	public Answer(ResultSet rs) throws SQLException {
		this(rs.getInt("answerID"), rs.getString("answerText"), rs.getInt("questionID"), rs.getString("username"));
	}
	
	public String toString() {
		return answerText;
	}
	@Override
	public int compareTo(Answer o) {
		if(this.answerID > o.answerID) {
			return -1;
		} else {
			return 1;
		}
	}
	public int getQuestionID() {
		return questionID;
	}
	
}
