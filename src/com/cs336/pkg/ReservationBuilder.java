package com.cs336.pkg;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;

public class ReservationBuilder {

	public ArrayList<ScheduleStop> reservationStops;
	public Schedule schedule;
	public Float fare;
	
	public ReservationBuilder(Schedule sc, ArrayList<ScheduleStop> reservationStops) throws SQLException {
		this.reservationStops = reservationStops; this.schedule = sc;
		this.fare = (sc.getTransitLine().fare) * (reservationStops.size() / sc.getTransitLine().getTransitStops().size());
	}
	
	public ScheduleStop getOrigin() {
		return reservationStops.get(0);
	}
	public ScheduleStop getDestination() {
		return reservationStops.get(reservationStops.size()-1);
	}
	
	
	public ArrayList<Schedule> candidateReturnSchedules = new ArrayList<Schedule>();
	
	
	//Full scope of RerservationBuilder is not used on the return trip. Used more for half storage.
	public ArrayList<ReservationBuilder> candidateReturnBuilders = new ArrayList<ReservationBuilder>();
	/*
	public ArrayList<ReservationBuilder> getReturnBuilders() throws SQLException{
		
		
		candidateReturnBuilders = new ArrayList<ReservationBuilder>();
		for(Schedule sc : candidateReturnSchedules) {
			
			ArrayList<ScheduleStop> scheduleStops = sc.getScheduleStops();
			ArrayList<ScheduleStop> reservationStops = new ArrayList<ScheduleStop>();
			
			int i;
			for(i=0; i<scheduleStops.size(); i++) {
				if(scheduleStops.get(i).stationID == this.getDestination().stationID) {
					break;
				}
			}
			for(i=i; i<scheduleStops.size(); i++) {
				reservationStops.add(scheduleStops.get(i));
				if(scheduleStops.get(i).stationID == this.getOrigin().stationID) {
					break;
				}
			}
			
			candidateReturnBuilders.add(new ReservationBuilder(sc, reservationStops));
		}
		
		return candidateReturnBuilders;
	}
	*/
	
	public int selectedReturnBuilder;
	public ReservationBuilder returnBuilder;
}
