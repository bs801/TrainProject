package com.cs336.pkg;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

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
	
	public static ArrayList<Object> getOps() throws SQLException{
		ArrayList<Station> stations = TrainProject.Stations.getAsList();
		
		ArrayList<Object> options = new ArrayList<Object>();
		
		
		for(Station s : stations){
			if(options.contains(s.city)){
				continue;
			}
			options.add(s.city);
			options.add(s);
	
		}

		Collections.sort(options,
	            new Comparator<Object>() {
	                public int compare(Object o1, Object o2)
	                {
	                	//System.out.println(o1.toString());
	                	String s1;
	                	String s2;
	                	if(o1 instanceof String) {
	                		s1 = (String) o1;
	                	} else {
	                		s1 = ((Station) o1).toString();
	                	}
	                	if(o2 instanceof String) {
	                		s2 = (String) o2;
	                	} else {
	                		s2 = ((Station) o2).toString();
	                	}
	                    return s1.compareTo(s2);
	                }
	            }
		);
		return options;
	}
	
}
