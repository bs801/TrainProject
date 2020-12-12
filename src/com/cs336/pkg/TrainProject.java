package com.cs336.pkg;

import java.util.*;
import java.time.*;
import java.sql.*;


public class TrainProject {
	
	public static ApplicationDB db;	
	public static Connection con;
	public static void loadApplicationDB() {
		if(db == null) {
			db = new ApplicationDB();
			con = db.getConnection();
		}
	}
	
	public static class Trains {
		static HashMap<Integer, Train> TrainTable;
		
		public static Train get(int trainID) throws SQLException {
			return getAll().get(trainID);
		}
		public static ArrayList<Train> getAsList()  throws SQLException {
			ArrayList<Train> trls = new ArrayList<Train>(getAll().values());
			Collections.sort(trls);
			return trls;
		}
		
		
		static HashMap<Integer, Train> getAll() throws SQLException {
			loadApplicationDB();
			if(TrainTable == null) {
				TrainTable = new HashMap<Integer, Train>();
				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery("select * from Train");
				while(rs.next()){
					TrainTable.put(rs.getInt(1), new Train(rs));
				}
			}
			return TrainTable;
		}
	}
	
	public static class Stations {
		static HashMap<Integer, Station> StationTable;
		
		public static Station get(int stationID) throws SQLException {
			return getAll().get(stationID);
		}
		public static ArrayList<Station> getAsList() throws SQLException {
			ArrayList<Station> sls = new ArrayList<Station>(getAll().values());
			Collections.sort(sls);
			return sls;
		}
		public static HashMap<Integer, Station> getAll() throws SQLException {
			loadApplicationDB();
			if(StationTable == null) {
				StationTable = new HashMap<Integer, Station>();
				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery("select * from Station");
				while(rs.next()){
					StationTable.put(rs.getInt(1), new Station(rs));
				}
			}
			return StationTable;
		}
	}
	
	public static class TransitLines {
		static HashMap<String, TransitLine[]> TransitLineTable;
		
		public static TransitLine get(String transitLineName, int reverseLine) throws SQLException {
			if(getAll().get(transitLineName) == null) {
				return null;
			}
			return getAll().get(transitLineName)[reverseLine];
		}
		public static ArrayList<TransitLine> getAsList()  throws SQLException {
			ArrayList<TransitLine[]> tlsr = new ArrayList<TransitLine[]>(getAll().values());
			ArrayList<TransitLine> tls = new ArrayList<TransitLine>();
			for(TransitLine[] x : tlsr) {
				tls.add(x[0]);
				tls.add(x[1]);
			}
			Collections.sort(tls);
			return tls;
		}
		
		public static HashMap<String, TransitLine[]> getAll() throws SQLException {
			loadApplicationDB();
			if(TransitLineTable == null) {
				TransitLineTable = new HashMap<String, TransitLine[]>();
				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery("select * from TransitLine");
				while(rs.next()){
					if(TransitLineTable.get(rs.getString(1)) == null) {
						TransitLineTable.put(rs.getString(1), new TransitLine[2]);
					}
					TransitLineTable.get(rs.getString(1))[rs.getInt("reverseLine")] = new TransitLine(rs);
				}
			}
			return TransitLineTable;
		}
		
	}
	
	public static class TransitStops {
		static HashMap<TransitLine, HashMap<Integer, TransitStop>> TransitStopTable;
		
		public static TransitStop get(TransitLine TL_key, int stopID) throws SQLException {
			System.out.println("TL KEY "+TL_key.transitLineName);
			HashMap<Integer, TransitStop> xx = getAll().get(TL_key);
			TransitStop ts = xx.get(stopID);
			return ts;
		}
		public static TransitStop get(String transitLineName, int reverseLine, int stopID) throws SQLException {
			return get(TransitLine.getKey(transitLineName, reverseLine), stopID);
		}
		
		static HashMap<TransitLine, HashMap<Integer, TransitStop>> getAll() throws SQLException {
			loadApplicationDB();
			if(TransitStopTable == null) {
				TransitStopTable = new HashMap<TransitLine, HashMap<Integer, TransitStop>>();
				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery("select * from TransitStop");

				while(rs.next()){
					TransitLine TL_key = TransitLine.getKey(rs); 
					if(TransitStopTable.get(TL_key) == null) {

						TransitStopTable.put(TL_key, new HashMap<Integer, TransitStop>());
					}
					TransitStopTable.get(TL_key).put(rs.getInt("stopID"), new TransitStop(rs));
				}
			}
			return TransitStopTable;
		}
	}

	public static class Schedules {
		static HashMap<TransitLine, HashMap<Timestamp, Schedule>> ScheduleTable;
		
		public static ArrayList<Schedule> getAsList() throws SQLException{
			ArrayList<Schedule> schedules = new ArrayList<Schedule>();
			
			ArrayList<HashMap<Timestamp, Schedule>> schedulesByTransitLineList = new ArrayList<HashMap<Timestamp, Schedule>>(getAll().values());
			for(HashMap<Timestamp, Schedule> schedulesByTimestampList : schedulesByTransitLineList) {
				ArrayList<Schedule> schedulesByTimestamp = new ArrayList<Schedule>(schedulesByTimestampList.values());
				for(Schedule s : schedulesByTimestamp) {
					schedules.add(s);
				}
			}
			return schedules;
		}
		
		public static Schedule get(TransitLine TL_key, Timestamp scheduleDepartureTime) throws SQLException {
			return getAll().get(TL_key).get(scheduleDepartureTime);
		}
		public static Schedule get(String transitLineName, int reverseLine, Timestamp scheduleDepartureTime) throws SQLException {
			return get(TransitLine.getKey(transitLineName, reverseLine), scheduleDepartureTime);
		}
		
		public static HashMap<TransitLine, HashMap<Timestamp, Schedule>> getAll() throws SQLException {
			loadApplicationDB();
			if(ScheduleTable == null) {
				
				ScheduleTable = new HashMap<TransitLine, HashMap<Timestamp, Schedule>>();
				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery("select * from Schedule");
				
				while(rs.next()){

					TransitLine TL_key = TransitLine.getKey(rs); 
					
					if(ScheduleTable.get(TL_key) == null) {
						ScheduleTable.put(TL_key, new HashMap<Timestamp, Schedule>());
					}
					ScheduleTable.get(TL_key).put(rs.getTimestamp("scheduleDepartureTime"), new Schedule(rs));
				}
			}
			return ScheduleTable;
		}
		
		public static void insert(Schedule s) throws SQLException {
			String sql = "INSERT INTO Schedule VALUES(?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, s.transitLineName);
			ps.setBoolean(2, (s.reverseLine == 1 ? true : false));
			ps.setTimestamp(3, s.scheduleDepartureTime);
			ps.setInt(4, s.trainID);
			ps.executeUpdate();
			ScheduleTable = null;
		}
			
	}
	
	
	
	

	
	
	
	public static class Users {
		
		static HashMap<String, User> UserTable;
		
		public static User get(String username) throws SQLException {
			return getAll().get(username);
		}
		
		public static ArrayList<User> getAsList() throws SQLException{
			return new ArrayList<User>(getAll().values());
		}
		static HashMap<String, User> getAll() throws SQLException {
			
			loadApplicationDB();
			if(UserTable == null) {
				UserTable = new HashMap<String, User>();
				
				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery("select * from User");
								
				while(rs.next()){
					
					User newUser = new User(rs);
					UserTable.put(newUser.username, newUser);
				}	
			}	
			
			return UserTable;
		}
	}
    public static class Representatives {
		
		static HashMap<String, Representative> RepresentativeTable;
		
		public static Representative get(String username) throws SQLException {
			return getAll().get(username);
		}
		
		public static ArrayList<Representative> getAsList() throws SQLException{
			return new ArrayList<Representative>(getAll().values());
		}
		static HashMap<String, Representative> getAll() throws SQLException {
			
			loadApplicationDB();
			if(RepresentativeTable == null) {
				RepresentativeTable = new HashMap<String, Representative>();
				
				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery("select * from Representative");
								
				while(rs.next()){
					
					Representative newUser = new Representative(rs);
					RepresentativeTable.put(newUser.username, newUser);
				}	
			}	
			
			return RepresentativeTable;
		}
	}
	
	
	
	
	
	
}
