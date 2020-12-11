package com.cs336.pkg;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;

public class CSNTLPipeline {
	public int val;
	public ArrayList<String> errors = new ArrayList<String>();
	
	
	
	
	public String getErrors(){
		String returnErrors;
		if(errors.size() == 0) {
			returnErrors = "";
		} else {
			returnErrors = "<br></br>" + errors.toString() + "<br></br>" + "<br></br>";
		}
		errors = new ArrayList<String>();
		return returnErrors;
	}
	
	//public ArrayList<Train> availableTrainList;
	
	public LocalTime XMTime;
	public boolean xmIsAM;
	public Schedule incompleteSchedule;
	public String originDepartureTime;
	
	
	public String transitLineName;
	public int numberOfStops;
	public Station origin;
	public Station destination;
	public Float fare;
	
	HashMap<Integer, Station> stationSelection;
	public ArrayList<Station> selectedStationList; 
	
	
	public LocalTime getDelta(LocalTime S) {
		LocalTime D = XMTime;
		if(D.getHour() == S.getHour() && D.getMinute() == S.getMinute()) {
			return LocalTime.of(0, 0);
		}
		if(D.isBefore(S)) {
			return S.minusHours(D.getHour()).minusMinutes(D.getMinute());
		}
		if(D.isAfter(S)) {
			return (LocalTime.of(12, 0).minusHours(D.getHour()).minusMinutes(D.getMinute())  ).plusHours(S.getHour()).plusMinutes(S.getMinute());
		}
		throw new RuntimeException("REEEEEEEEEEEEEEEEE");
	}
	//public 
}
