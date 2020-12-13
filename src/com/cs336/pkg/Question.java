package com.cs336.pkg;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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
