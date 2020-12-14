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

}
