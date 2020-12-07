package com.cs336.pkg;

public class Station {
	public final int stationID;
	public String name;
	public String city;
	public String state;
	public Station(int stationID, String name, String city, String state) {
		//if(name == null) {
		//	throw new RuntimeException("Name must be used in Station");
		//}
		this.stationID = stationID; this.name = name; this.city = city; this.state = state;
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
}
