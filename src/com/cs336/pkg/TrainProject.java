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
		
		public static void insert(Train t) throws SQLException {
			String sql = "INSERT INTO Train VALUES(?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, t.trainID);
			ps.executeUpdate();
			TrainTable = null;
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
		public static void insert(Station s) throws SQLException {
			String sql = "INSERT INTO Station(stationID, state, city, name) VALUES(?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, s.stationID);
			ps.setString(2, s.state);
			ps.setString(3, s.city);
			ps.setString(4, s.name);
			ps.executeUpdate();
			StationTable = null;
		}
		
		public static void insert(Station s) throws SQLException {
			String sql = "INSERT INTO Station VALUES(?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, s.stationID);
			ps.setString(2, s.name);
			ps.setString(3, s.city);
			ps.setString(4, s.state);
			ps.executeUpdate();
			StationTable = null;
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
		public static ArrayList<Schedule> getFutureSchedules() throws SQLException{
			ArrayList<Schedule> schedules = getAsList();
			ArrayList<Schedule> newlist = new ArrayList<Schedule>();
			for(Schedule sc : schedules) {
				if(sc.getScheduleStops().get(0).departureTime.isAfter(LocalDateTime.now())) {
					newlist.add(sc);
				}
			}
			return newlist;
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
		public static void update(Schedule s, Schedule ns) throws SQLException {
			String sql = "UPDATE Schedule SET transitLineName=(?), reverseLine=(?), scheduleDepartureTime=(?), trainID=(?) WHERE"
					+ " transitLineName=(?), reverseLine=(?), scheduleDepartureTime=(?), trainID=(?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, ns.transitLineName);
			ps.setBoolean(2, (ns.reverseLine == 1 ? true : false));
			ps.setTimestamp(3, ns.scheduleDepartureTime);
			ps.setInt(4, ns.trainID);
			
			ps.setString(5, s.transitLineName);
			ps.setBoolean(6, (s.reverseLine == 1 ? true : false));
			ps.setTimestamp(7, s.scheduleDepartureTime);
			ps.setInt(8, s.trainID);
			ps.executeUpdate();
			ScheduleTable = null;
		}
			
	}
	
	public static class Reservations {
		static HashMap<Integer, Reservation> ReservationTable;
		
		public static Reservation get(int reservationID) throws SQLException {
			return getAll().get(reservationID);
		}
		public static ArrayList<Reservation> getAsList() throws SQLException {
			ArrayList<Reservation> sls = new ArrayList<Reservation>(getAll().values());
		
			return sls;
		}
		public static HashMap<Integer, Reservation> getAll() throws SQLException {
			loadApplicationDB();
			if(ReservationTable == null) {
				ReservationTable = new HashMap<Integer, Reservation>();
				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery("select * from Reservation");
				while(rs.next()){
					Reservation r = new Reservation(rs);
				
					ReservationTable.put(r.reservationID, r);
				}
			}
			return ReservationTable;
		}
	
		public static void insert(Reservation r) throws SQLException {
			String sql = "INSERT INTO Reservation(cancelled, origin_stationID, destination_stationID,"
					+ " forward_transitLineName, forward_scheduleDepartureTime, forward_reverseLine, forward_trainID, forward_fare,"
					+ " roundTrip,"
					+ " return_transitLineName, return_scheduleDepartureTime, return_reverseLine, return_trainID, return_fare, "
					+ " dateOfCreation, discount, totalFare,"
					+ " title, firstName, lastName, username) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setBoolean(1, false);
			ps.setInt(2, r.origin_stationID);
			ps.setInt(3, r.destination_stationID);
			
			ps.setString(4, r.forward_transitLineName);
			ps.setTimestamp(5, r.forward_scheduleDepartureTime);
			ps.setBoolean(6, (r.forward_reverseLine == 0 ? false : true));
			ps.setInt(7, r.forward_trainID);
			ps.setFloat(8, r.forward_fare);
			
			ps.setBoolean(9, (r.roundTrip == 0 ? false : true));
			
			ps.setString(10, r.return_transitLineName);
			ps.setTimestamp(11, r.return_scheduleDepartureTime);
			ps.setBoolean(12, (r.return_reverseLine == 0 ? false : true));
			ps.setInt(13, r.return_trainID);
			ps.setFloat(14, r.return_fare);
			
			ps.setTimestamp(15, Timestamp.valueOf(LocalDateTime.now()));
			ps.setFloat(16, r.discount);
			ps.setFloat(17, r.totalFare);
			
			ps.setString(18, r.title);
			ps.setString(19, r.firstName);
			ps.setString(20, r.lastName);
			
			ps.setString(21, r.username);
			
			ps.executeUpdate();
			ReservationTable = null;
		} 
		public static void cancel(Reservation r) throws SQLException {
			
			String sql = "UPDATE Reservation SET cancelled = (?) WHERE reservationID = (?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setBoolean(1, true);
			ps.setInt(2, r.reservationID);
			ps.executeUpdate();
			ReservationTable = null;
		}
	}
	
	

	
	
	
	public static class Customers {
		
		static HashMap<String, Customer> CustomerTable;
		
		public static Customer get(String username) throws SQLException {
			return getAll().get(username);
		}
		
		public static ArrayList<Customer> getAsList() throws SQLException{
			return new ArrayList<Customer>(getAll().values());
		}
		static HashMap<String, Customer> getAll() throws SQLException {
			
			loadApplicationDB();
			if(CustomerTable == null) {
				CustomerTable = new HashMap<String, Customer>();
				
				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery("select * from Customer");
								
				while(rs.next()){
					
					Customer newUser = new Customer(rs);
					CustomerTable.put(newUser.username, newUser);
				}	
			}	
			
			return CustomerTable;
		}
		
		public static void insert(Customer u) throws SQLException {
			String sql = "INSERT INTO Customer(username, password, firstName, lastName, emailAddress) VALUES(?, ?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, u.username);
			ps.setString(2, u.password);
			ps.setString(3,u.firstName);
			ps.setString(4, u.lastName);
			ps.setString(5, u.emailAddress);
			ps.executeUpdate();
			CustomerTable = null;
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
					System.out.println("REEE");
					System.out.println(rs.getString("SSN"));
					Representative newUser = new Representative(rs);
					
					RepresentativeTable.put(newUser.username, newUser);
				}	
			}	
			
			return RepresentativeTable;
		}
		public static void insert(Representative r) throws SQLException {
			String sql = "INSERT INTO Representative(username, password, firstName, lastName, SSN) VALUES(?, ?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, r.username);
			ps.setString(2, r.password);
			ps.setString(3, r.firstName);
			ps.setString(4, r.lastName);
			ps.setString(5, r.SSN);
			ps.executeUpdate();
			RepresentativeTable = null;
		}
		public static void delete(Representative r) throws SQLException {
			System.out.println("Deleted");
		}
		public static void update(Representative r) throws SQLException {
			System.out.println("Updated");
		}
	}
    
	public static class Questions {
		
		static HashMap<Integer, Question> QuestionTable;
		
		public static Question get(int questionID) throws SQLException {
			return getAll().get(questionID);
		}
		
		public static ArrayList<Question> getAsList() throws SQLException{
			ArrayList<Question> qs = new ArrayList<Question>(getAll().values());
			Collections.sort(qs);
			return qs;
		}
		static HashMap<Integer, Question> getAll() throws SQLException {
			
			loadApplicationDB();
			if(QuestionTable == null) {
				QuestionTable = new HashMap<Integer, Question>();
				
				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery("select * from Question");
								
				while(rs.next()){
					
					Question newUser = new Question(rs);
					QuestionTable.put(newUser.questionID, newUser);
				}	
			}	
			
			return QuestionTable;
		}
		
		public static void insert(Question q) throws SQLException {
			String sql = "INSERT INTO Question (questionText, username, descriptionText) VALUES(?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, q.questionText);
			ps.setString(2, q.username);
			ps.setString(3, q.descriptionText);
			ps.executeUpdate();
			QuestionTable = null;
		}
	}
	
	public static class Answers {
		
		static HashMap<Integer, Answer> AnswerTable;
		
		public static Answer get(int answerID) throws SQLException {
			return getAll().get(answerID);
		}
		
		public static ArrayList<Answer> getAsList() throws SQLException{
			ArrayList<Answer> as = new ArrayList<Answer>(getAll().values());
			Collections.sort(as);
			return as;
		}
		static HashMap<Integer, Answer> getAll() throws SQLException {
			
			loadApplicationDB();
			if(AnswerTable == null) {
				AnswerTable = new HashMap<Integer, Answer>();
				
				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery("select * from Answer");
								
				while(rs.next()){
					
					Answer newUser = new Answer(rs);
					AnswerTable.put(newUser.answerID, newUser);
				}	
			}	
			
			return AnswerTable;
		}
		
		public static void insert(Answer a) throws SQLException {
			String sql = "INSERT INTO Answer (answerText, questionID, username) VALUES(?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, a.answerText);
			ps.setInt(2, a.questionID);
			ps.setString(3, a.username);
			ps.executeUpdate();
			AnswerTable = null;
		}
	}
	
	
	
}
