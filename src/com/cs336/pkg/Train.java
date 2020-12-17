package com.cs336.pkg;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Train implements Comparable<Train>{
	public int trainID;
	
	public Train(int trainID) {
		this.trainID = trainID; 
	}
	public Train(ResultSet rs) throws SQLException {
		this(rs.getInt("trainID"));
	}
	
	@Override
	public String toString() {
		return "Train "+trainID;
	}
	
	@Override
	public int compareTo(Train t) {
		if(this.trainID < t.trainID) {
			return -1;
		} else if(this.trainID > t.trainID) {
			return 1;
		}
		return 0;
	}
	
	@Override
	public boolean equals(Object o) {
		return false;
	}
	
	
	
	public void write() {
		
	}
}
