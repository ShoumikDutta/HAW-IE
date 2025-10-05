//package de.haw.ie4lab4;
//
//import java.sql.Statement;
//import java.sql.Connection;
//import java.sql.DatabaseMetaData;
//import java.sql.DriverManager;
//import java.sql.SQLException;
//
//public class DbHandler {
//	/**
//	 * Database connection
//	 */
//	private Connection conn;
//
//
//	public Connection getConn() {
//		return conn;
//	}
//
//	public void setConn(Connection conn) {
//		this.conn = conn;
//	}
//
//	/**
//	 * The current SQL statement
//	 */
//	private String sql;
//
//	/**
//	 * Getter for the current SQL statement
//	 * 
//	 * @return the SQL statement
//	 */
//	public String getSql() {
//		return sql;
//	}
//
//	/**
//	 * Connect to the database.
//	 * 
//	 * @param driverName
//	 *            - name of JDBC driver class
//	 * @param url
//	 *            - JDBC URL
//	 * @param user
//	 *            - DB user name
//	 * @param password
//	 *            - DB password
//	 * @throws SQLException
//	 */
//
//	public void connectDB(String driverName, String url, String user,
//			String password) throws SQLException {
//		System.out.println("Trying to connect to " + url);
//
//		// TODO: connect to the DB!
//		conn = DriverManager.getConnection(driverName, user, password);
//
//		// TODO: disable autoCommit!
//		conn.setAutoCommit(false);
//
//		//
//		// Print success message and some meta data:
//		//
//		DatabaseMetaData metaData = conn.getMetaData();
//		System.out.println("Connected to DB " + metaData.getURL() + " as user "
//				+ metaData.getUserName());
//		System.out.println(metaData.getDatabaseProductName() + " "
//				+ metaData.getDatabaseMajorVersion() + "."
//				+ metaData.getDatabaseMinorVersion());
//	}
//
//	/**
//	 * Close the connection
//	 */
//	public void close() {
//		/*
//		 * TODO: rollback the transaction (in real life, you'd want to commit ->
//		 * but then you cannot call insertNewCustomer() twice.)
//		 */
//		try {
//			conn.commit();
//			if (conn != null) {
//				// TODO: close the connection (if it has been initialized)
//				conn.close();
//			}
//		} catch (SQLException ex) {
//			// TODO Auto-generated catch block
//			ex.printStackTrace();
//		}
//
//	}
//
//	/**
//	 * Print the list of order numbers for the given customer
//	 * 
//	 * @param customer
//	 *            - Name of customer
//	 * @throws SQLException
//	 */
//	public void printOrderNumbers(String customer) throws SQLException {
//		System.out.println(customer + "'s orders:");
//
//		// TODO: SQL see assignment 8b-10
//		sql = " SELECT o_nr AS Ringos_orders FROM (SELECT *FROM CUSTOMER INNER JOIN orders "
//				+
//				"ON CUSTOMER.C_ID= orders.C_ID)" + " WHERE NAME='Ringo'";
//	}
//
//	/**
//	 * Print an invoice for the given order. The invoice shall contain every
//	 * single order item and the total price.
//	 * 
//	 * @param orderNumber
//	 *            - value for o_nr
//	 * @throws SQLException
//	 */
//	public void printInvoiceForOrder(int orderNumber) throws SQLException {
//		System.out.println("Invoice for order number " + orderNumber);
//
//		// Optional: You could print customer information here!
//
//		/*
//		 * TODO: For every order item, print the article name, the article's
//		 * price per unit, the quantity, and the price of the order item. SQL
//		 * see assignment 8b-14
//		 */
//
//		
//		Statement stmt = conn.createStatement();
//		
//		sql = "SELECT   y.name, y.price,y.quantity ,y.price*y.quantity AS Total"
//				+
//
//				"FROM (SELECT * FROM CUSTOMER INNER JOIN orders" +
//
//				"ON CUSTOMER.C_ID = orders.C_ID) x INNER JOIN" +
//
//				"(SELECT * FROM article a INNER JOIN order_item o " +
//
//				"ON a.a_nr = o.a_nr ) y ON  x.O_NR = y.O_NR" +
//
//				"WHERE y.o_nr=5" +
//
//				"GROUP BY  y.name, y.price, y.quantity, y.price*y.quantity" +
//
//				"ORDER BY y.name";
//		
//		stmt.executeUpdate(sql);
//		
//		System.out.println("-----------------------");
//		
//
//		/*
//		 * TODO: Print the total price of the order. You can calculate the sum
//		 * via SQL (see assignment 8b-15), or in Java.
//		 */
//		sql = "SELECT SUM(Total) FROM ( SELECT   y.name, y.price,y.quantity ,y.price*y.quantity AS Total"
//				+
//
//				"FROM (SELECT * FROM CUSTOMER INNER JOIN orders" +
//
//				"ON CUSTOMER.C_ID = orders.C_ID) x INNER JOIN" +
//
//				"(SELECT * FROM article a INNER JOIN order_item o" +
//
//				"ON a.a_nr = o.a_nr ) y ON  x.O_NR = y.O_NR" +
//
//				"WHERE y.o_nr=5 )";
//
//	}
//
//	/**
//	 * Insert a new customer
//	 * 
//	 * @param id
//	 *            - customer ID
//	 * @param name
//	 *            - customer name
//	 * @throws SQLException
//	 */
//	public void insertNewCustomer(int id, String name) throws SQLException {
//		System.out.println("Trying to insert new customer. id=" + id
//				+ ", name=" + name);
//		
////		Statement stmt = conn.createStatement();
//				
//		// TODO: insert a new customer with the given values
//		sql = "INSERT INTO customer " + "VALUES (1002, 'McBeal')";
//		
////		stmt.executeUpdate(sql);
//		
//	}
//
//	/**
//	 * Change the article's price
//	 * 
//	 * @param articleName
//	 *            - identifies the article
//	 * @param price
//	 *            - the new price
//	 * @throws SQLException
//	 */
//	public void changeArticlePrice(String articleName, double price)
//			throws SQLException {
//		System.out.println("Trying to set the price of " + articleName + " to "
//				+ price);
//		// sql = "";
//		int n = 0;
//		double newPrice = 1.5 * price;
//
//		// TODO: change the article's price
//		sql = "update article set price " + newPrice;
//		System.out.println("The SQL query is: " + sql);
//		System.out.println("Number of rows affected: " + n);
//	}
//}





package de.haw.ie4lab4;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.sun.glass.ui.Cursor;

public class DbHandler {
	/**
	 * Database connection
	 */
	private Connection conn;
	private PreparedStatement statement;
	private ResultSet cursor;
	/**
	 * The current SQL statement
	 */
	private String sql;

	/**
	 * Getter for the current SQL statement
	 * 
	 * @return the SQL statement
	 */
	public String getSql() {
		return sql;
	}

	/**
	 * Connect to the database.
	 * 
	 * @param driverName
	 *            - name of JDBC driver class
	 * @param url
	 *            - JDBC URL
	 * @param user
	 *            - DB user name
	 * @param password
	 *            - DB password
	 * @throws SQLException
	 */

	
	public void connectDB(String driverName, String url, String user,
			String password) throws SQLException {
		System.out.println("Trying to connect to " + url);

		// TODO: connect to the DB!
		conn = DriverManager.getConnection(driverName, user, password);

		// TODO: disable autoCommit!
		conn.setAutoCommit(false);

		//
		// Print success message and some meta data:
		//
		DatabaseMetaData metaData = conn.getMetaData();
		System.out.println("Connected to database " + metaData.getURL());
		System.out.println("Your user name: "	+ metaData.getUserName());
	}


	/**
	 * Close the connection
	 */
	public void close() {
		/*
		 * TODO: rollback the transaction (in real life, you'd want to commit ->
		 * but then you cannot call insertNewCustomer() twice.)
		 */
		try {
			if (this.conn != null) {
				conn.rollback();
				// TODO: close the connection (if it has been initialized)
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Print the list of order numbers for the given customer
	 * 
	 * @param customer
	 *            - Name of customer
	 * @throws SQLException
	 */
	public void printOrderNumbers(String customer) throws SQLException {
		System.out.println(customer + "'s orders:");
		// TODO: SQL see assignment 8b-10
		sql = "SELECT O_NR FROM ORDERS WHERE C_ID = (SELECT C_ID FROM CUSTOMER WHERE NAME = ?)";

		statement = conn.prepareStatement(sql);
		
		statement.setString(1, customer);
		
		cursor = statement.executeQuery();

		
		while (cursor.next()) {
			System.out.println( cursor.getString(1));
		}
	}

	/**
	 * Print an invoice for the given order. The invoice shall contain every
	 * single order item and the total price.
	 * 
	 * @param orderNumber
	 *            - value for o_nr
	 * @throws SQLException
	 */
	public void printInvoiceForOrder(int orderNumber) throws SQLException {

		System.out.println("Invoice for order number " + orderNumber);
		// Optional: You could print customer information here!
		/*
		 * TODO: For every order item, print the article name, the article's
		 * price per unit, the quantity, and the price of the order item. SQL
		 * see assignment 8b-14
		 */
		sql = "SELECT a.name, a.price, b.quantity,"
				+ "a.price*b.quantity AS Total " + "FROM article a "
				+ "JOIN order_item b ON (a.a_nr=b.a_nr) " + "WHERE b.o_nr = ? "
				+ "ORDER BY a.name";
		statement = conn.prepareStatement(sql);
		statement.setLong(1, orderNumber);
		cursor = statement.executeQuery();
		double total = 0;
		int i = 1;
		while (cursor.next()) {
			System.out.print(cursor.getString(1) + "\t");
			System.out.print(cursor.getString(2) + "\t");
			System.out.print(cursor.getString(3) + "\t");
			System.out.println(cursor.getString(4));
			total += cursor.getDouble(4);
		}
		System.out.println("-----------------------");
		/*
		 * TODO: Print the total price of the order. You can calculate the sum
		 * via SQL (see assignment 8b-15), or in Java.
		 */
		sql = "";
		System.out.println("Sum of order = " + total);

	}

	/**
	 * Insert a new customer
	 * 
	 * @param id
	 *            - customer ID
	 * @param name
	 *            - customer name
	 * @throws SQLException
	 */
	public void insertNewCustomer(int id, String name) throws SQLException {
		System.out.println("Trying to insert new customer. id=" + id
				+ ", name=" + name);
		// TODO: insert a new customer with the given values
		sql = "INSERT INTO CUSTOMER VALUES ( ?,?)";
		statement = conn.prepareStatement(sql);
		statement.setLong(1, id);
		statement.setString(2, name);
		// insert the data
		statement.executeUpdate();
	}

	/**
	 * Change the article's price
	 * 
	 * @param articleName
	 *            - identifies the article
	 * @param price
	 *            - the new price
	 * @throws SQLException
	 */
	public void changeArticlePrice(String articleName, double price)
			throws SQLException {
		System.out.println("Trying to set the price of " + articleName + " to "
				+ price);
		sql = "";
		int n = 0;
		// TODO: change the article's price
		sql = "update article set PRICE = ? where NAME = ?";
		statement = conn.prepareStatement(sql);
		statement.setDouble(1, price);
		statement.setString(2, articleName);
		n = statement.executeUpdate();
		System.out.println("Number of rows affected: " + n);
	}

}
