package com.cs336.pkg;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;

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
				if(LocalDateTime.now().isAfter(s1.departureTime)) {
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
		static ArrayList<ReservationBuilder> getReservationOptions(ArrayList<Schedule> sameDateSchedules, String cityA, String cityB) throws SQLException{
			ArrayList<Station> origins = new ArrayList<Station>();
			ArrayList<Station> destinations = new ArrayList<Station>();
			
			for(Station s : TrainProject.Stations.getAsList()){
				if(s.city.equals(cityA)){
					origins.add(s);
				}
				if(s.city.equals(cityB)){
					destinations.add(s);
				}
			}

			ArrayList<ReservationBuilder> validRoutes = new ArrayList<ReservationBuilder>();
			
			for(Station oStation: origins){
				for(Station dStation: destinations){
					ArrayList<ReservationBuilder> validRoutesSASB = getReservationOptions(sameDateSchedules, oStation, dStation);
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
		
		static ArrayList<ReservationBuilder> getReservationOptions(LocalDate departureDate, Station A, String cityB) throws SQLException{
			ArrayList<Schedule> sameDateSchedules = filterSchedulesByDate(departureDate);
			ArrayList<Station> destinations = new ArrayList<Station>();
			for(Station s : TrainProject.Stations.getAsList()){
				if(s.city.equals(cityB)){
					destinations.add(s);
				}
			}
			
			ArrayList<ReservationBuilder> validRoutes = new ArrayList<ReservationBuilder>();
			
				for(Station dStation: destinations){
					ArrayList<ReservationBuilder> validRoutesSASB = getReservationOptions(sameDateSchedules, A, dStation);
					for(ReservationBuilder rb : validRoutesSASB) {
						validRoutes.add(rb);
					}
				}
			return validRoutes;
		}
		
		static ArrayList<ReservationBuilder> getReservationOptions(LocalDate departureDate, String cityA, Station B) throws SQLException{
			ArrayList<Schedule> sameDateSchedules = filterSchedulesByDate(departureDate);
			ArrayList<Station> origins = new ArrayList<Station>();
			for(Station s : TrainProject.Stations.getAsList()){
				if(s.city.equals(cityA)){
					origins.add(s);
				}
			}
			ArrayList<ReservationBuilder> validRoutes = new ArrayList<ReservationBuilder>();
			
				for(Station oStation: origins){
					ArrayList<ReservationBuilder> validRoutesSASB = getReservationOptions(sameDateSchedules, oStation, B);
					for(ReservationBuilder rb : validRoutesSASB) {
						validRoutes.add(rb);
					}
				}
			return validRoutes;
		}
		
		public static ArrayList<ReservationBuilder> getReservationOptions(LocalDate departureDate, Object A, Object B) throws SQLException{
			if(A instanceof String && B instanceof String) {
				return getReservationOptions(departureDate, (String) A, (String) B);
			}
			if(A instanceof String && B instanceof Station) {
				return getReservationOptions(departureDate, (String) A, (Station) B);
			}
			if(A instanceof Station && B instanceof String) {
				return getReservationOptions(departureDate, (Station) A, (String) B);
			}
			if(A instanceof Station && B instanceof Station) {
				return getReservationOptions(departureDate, (Station) A, (Station) B);
			}
			throw new RuntimeException("getResOps");
		}
		
		//public static boolean foundOnNextDay = false;
		public static int omitted;
		
		public static ArrayList<ReservationBuilder> filterForRoundTrip(LocalDate returnDate, ArrayList<ReservationBuilder> forwardTrips) throws SQLException{
		//	foundOnNextDay = false;
			
			ArrayList<ReservationBuilder> returnTripCompatibleRBs = new ArrayList<ReservationBuilder>();
			omitted = 0;
			
			HashMap<Integer, HashMap<Integer, ArrayList<ReservationBuilder>>> returnOpMap = new HashMap<Integer, HashMap<Integer, ArrayList<ReservationBuilder>>>();
			
			for(ReservationBuilder rb : forwardTrips) {
				Station sB = rb.getDestination().getStation();
				Station sA = rb.getOrigin().getStation();
				
				if(returnOpMap.get(sB.stationID) == null) {
					returnOpMap.put(sB.stationID, new HashMap<Integer, ArrayList<ReservationBuilder>>());
				}
				ArrayList<ReservationBuilder> returnOpsForRB;
				if(returnOpMap.get(sB.stationID).get(sA.stationID) == null) {
					returnOpMap.get(sB.stationID).put(sA.stationID, getReservationOptions(returnDate, sB, sA));
				}
				returnOpsForRB =  returnOpMap.get(sB.stationID).get(sA.stationID);
				
				for(ReservationBuilder returnCandidate : returnOpsForRB) {
					ScheduleStop ssB = returnCandidate.schedule.scheduleStopForStation(sB);
					if(ssB.departureTime.isAfter(rb.getDestination().arrivalTime) && ssB.departureTime.toLocalDate().isEqual(returnDate)) {
						rb.candidateReturnBuilders.add(returnCandidate);
						System.out.println("FOUND A RETURN TRIP "+returnCandidate.schedule);
					}
				}
				
				
				/*
				TransitLine TL = rb.schedule.getTransitLine();
				int revTL = (TL.reverseLine == 0 ? 1 : 0);
				ArrayList<Schedule> revSchedules = TrainProject.TransitLines.get(TL.transitLineName, revTL).getSchedules();
				for(Schedule sc : revSchedules) {
					ScheduleStop B = sc.scheduleStopForStation(rb.getDestination().getStation());
					if(B.departureTime.isAfter(rb.getDestination().arrivalTime) && B.departureTime.toLocalDate().isEqual(returnDate)) {
						rb.candidateReturnSchedules.add(sc);
					}
				}
				*/
				
				if(rb.candidateReturnBuilders.size() > 0) {
					returnTripCompatibleRBs.add(rb);
				} else {
					omitted++;
				}
			}
			return returnTripCompatibleRBs;
			
		}
		
		public static ArrayList<ReservationBuilder> getReservationOptions(LocalDate departureDate, Object A, Object B, LocalDate returnDate) throws SQLException{
			ArrayList<ReservationBuilder> forwardTrips = getReservationOptions(departureDate, A, B);
			return filterForRoundTrip(returnDate, forwardTrips);
		}
		
		
}
