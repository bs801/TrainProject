package com.cs336.pkg;

public class ScheduleBuilder {

	
	public ScheduleStop orig;
	public ScheduleStop dest;
	public Schedule schedule;
	public ScheduleBuilder(ScheduleStop oStop, ScheduleStop dStop, Schedule sc) {
		this.orig = oStop; this.dest = dStop; this.schedule = sc;
	}
}
