package com.cs336.pkg;

import java.time.LocalDateTime;

public class ScheduleStop {
	
	public LocalDateTime arrivalTime;
	public LocalDateTime departureTime;

	public ScheduleStop(Schedule schedule, TransitStop t) {
		this.arrivalTime = schedule.scheduleDepartureTime.toLocalDateTime().plusHours(t.arrivalTime.toLocalTime().getHour()).plusMinutes(t.arrivalTime.toLocalTime().getMinute());
		this.arrivalTime = schedule.scheduleDepartureTime.toLocalDateTime().plusHours(t.departureTime.toLocalTime().getHour()).plusMinutes(t.departureTime.toLocalTime().getMinute());
	}

	

}
