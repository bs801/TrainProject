package com.cs336.pkg;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Station implements Comparable<Station>{
	public final int stationID;
	public String name;
	public String city;
	public String state;
	public Station(int stationID, String name, String city, String state) {
		this.stationID = stationID; this.name = name; this.city = city; this.state = state;
	}
	public Station(ResultSet rs) throws SQLException {
		this(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4));
	}
	@Override
	public String toString() {
		return name;
	}
	
	@Override
    public boolean equals(Object o) { 
        if (o == this) { 
            return true; 
        } 
        if (!(o instanceof Station)) { 
            return false; 
        } 
        Station s = (Station) o; 
        if(this.stationID == s.stationID) {
        	return true;
        }
        return false;
    }
	@Override
	public int compareTo(Station st) {
		return this.name.compareTo(st.name);
	} 
}
