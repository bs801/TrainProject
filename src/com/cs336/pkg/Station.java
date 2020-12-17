package com.cs336.pkg;

import java.sql.ResultSet;
import java.util.Comparator;
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
	public static Comparator<Station> sortByStationID = new Comparator<Station>() {
		
		@Override
		public int compare(Station obj1, Station obj2) {
			
			//sort in ascending order
			return obj1.stationID-obj2.stationID;
			
			//sort in descending order
			//return obj2.age-obj1.age;
		}
	}; 
}
