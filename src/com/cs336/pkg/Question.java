package com.cs336.pkg;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/*
 * 	questionID int primary key auto_increment,
    questionText tinytext,
    username varchar(20),
    
    `descriptionText` tinytext,
    
    foreign key(username) references User(username)
 * 
 * 
 */


public class Question implements Comparable<Question> {
	int questionID;
	String questionText;
	
	String username;
	String descriptionText;
	
	public Question(int questionID, String questionText, String username, String descriptionText) {
		this.questionID = questionID; this.questionText = questionText; this.username = username; this.descriptionText = descriptionText;
	}
	public Question(ResultSet rs) throws SQLException {
		this(rs.getInt("questionID"), rs.getString("questionText"), rs.getString("username"), rs.getString("descriptionText"));
	}
	
	public String toString() {
		return questionText;
	}
	@Override
	public int compareTo(Question o) {
		if(this.questionID > o.questionID) {
			return -1;
		} else {
			return 1;
		}
	}
	
	
	public ArrayList<Answer> getAnswers() throws SQLException{
		ArrayList<Answer> questionAnswers = new ArrayList<Answer>();
		for(Answer a :  TrainProject.Answers.getAsList()) {
			if(a.questionID == this.questionID) {
				questionAnswers.add(a);
			}
		}
		return questionAnswers;
	}
}
