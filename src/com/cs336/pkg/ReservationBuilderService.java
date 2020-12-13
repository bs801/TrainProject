package com.cs336.pkg;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

public class ReservationBuilderService {

		public static ArrayList<Schedule> filterSchedulesByDate(LocalDate departureDate) throws SQLException{
			ArrayList<Schedule> Schedules = TrainProject.Schedules.getAsList();
			ArrayList<Schedule> sameDateSchedules = new ArrayList<Schedule>();
			for(Schedule sc : Schedules) {
				if(departureDate.isEqual(sc.scheduleDepartureTime.toLocalDateTime().toLocalDate())) {
					sameDateSchedules.add(sc);
				}
			}
			return sameDateSchedules;
		}
		public static ArrayList<ReservationBuilder> getReservationOptions(LocalDate departureDate, Station A, Station B) throws SQLException{
			return getReservationOptions(filterSchedulesByDate(departureDate), A, B);
		}
		private static ArrayList<ReservationBuilder> getReservationOptions(ArrayList<Schedule> sameDateSchedules, Station A, Station B) throws SQLException{
			ArrayList<ReservationBuilder> validRoutes = new ArrayList<ReservationBuilder>();
			for(Schedule sc : sameDateSchedules) {
				ScheduleStop s1 = sc.scheduleStopForStation(A);
				ScheduleStop s2 = sc.scheduleStopForStation(B);
				
				if(s1 == null || s2 == null) {
					continue;
				}
				if(!(s1.stopID < s2.stopID)) {
					continue;
				}
				ArrayList<ScheduleStop> scheduleStops = sc.getScheduleStops();
				ArrayList<ScheduleStop> reservationStops = new ArrayList<ScheduleStop>();
				
				int i;
				for(i=0; i<scheduleStops.size(); i++) {
					if(scheduleStops.get(i).stationID == s1.stationID) {
						break;
					}
				}
				for(i=i; i<scheduleStops.size(); i++) {
					reservationStops.add(scheduleStops.get(i));
					if(scheduleStops.get(i).stationID == s2.stationID) {
						break;
					}
				}
				validRoutes.add(new ReservationBuilder(sc, reservationStops));
			}
			return validRoutes;
		}
		static ArrayList<ReservationBuilder> getReservationOptions(ArrayList<Schedule> sameDateSchedule, String cityA, String cityB) throws SQLException{
			ArrayList<Station> origins = new ArrayList<Station>();
			ArrayList<Station> destinations = new ArrayList<Station>();
			
			for(Station s : TrainProject.Stations.getAsList()){
				if(cityA.equals(cityA)){
					origins.add(s);
				}
				if(cityB.equals(cityB)){
					destinations.add(s);
				}
			}

			ArrayList<ReservationBuilder> validRoutes = new ArrayList<ReservationBuilder>();
			
			for(Station oStation: origins){
				for(Station dStation: destinations){
					ArrayList<ReservationBuilder> validRoutesSASB = getReservationOptions(sameDateSchedule, oStation, dStation);
					for(ReservationBuilder rb : validRoutesSASB) {
						validRoutes.add(rb);
					}
				}
			}
			return validRoutes;
		}
		public static ArrayList<ReservationBuilder> getReservationOptions(LocalDate departureDate, String cityA, String cityB) throws SQLException{
			return getReservationOptions(filterSchedulesByDate(departureDate), cityA, cityB);
		}
		
}
