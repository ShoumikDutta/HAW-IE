package de.haw.ie4lab4;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DbHandler {
  /**
   * Database connection
   */
  private Connection conn;

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
   *          - name of JDBC driver class
   * @param url
   *          - JDBC URL
   * @param user
   *          - DB user name
   * @param password
   *          - DB password
   * @throws SQLException
   */

  public void connectDB(String driverName, String url, String user, String password) throws SQLException {
    System.out.println("Trying to connect to " + url);

    // TODO: connect to the DB!
    try {
		Class.forName(driverName);
	} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	  conn = DriverManager.getConnection(url, user, password);

    // TODO: disable autoCommit!
	  conn.setAutoCommit(false);
	//
    // Print success message and some meta data:
    //
    DatabaseMetaData metaData = conn.getMetaData();
    System.out.println("Connected to DB " + metaData.getURL() + " as user " + metaData.getUserName());
    System.out.println(metaData.getDatabaseProductName() + " " + metaData.getDatabaseMajorVersion() + "."
        + metaData.getDatabaseMinorVersion());
  }

  /**
   * Close the connection
   */
  public void close() {
    /*
     * TODO: rollback the transaction (in real life, you'd want to commit -> but
     * then you cannot call insertNewCustomer() twice.)
     */

    // TODO: close the connection (if it has been initialized)
	  try {
			conn.rollback();
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
  }

  /**
   * Print the list of order numbers for the given customer
   * 
   * @param customer
   *          - Name of customer
   * @throws SQLException
   */
  public void printOrderNumbers(String customer) throws SQLException {
	System.out.println("\n" + customer + "'s orders:");

    // TODO: SQL see assignment 10b-10
    Statement st = conn.createStatement();
    sql= "SELECT o_nr FROM customer c, orders o WHERE c.name = ? AND c.c_id = o.c_id";
	PreparedStatement pst =conn.prepareStatement(sql);
	pst.setString(1, customer);
	ResultSet cursor = pst.executeQuery();
	while (cursor.next()) {
		int i = cursor.getInt(1);
		System.out.print(i+"  ");
		}
	cursor.close();
	st.close();
  }

  /**
   * Print an invoice for the given order. The invoice shall contain every
   * single order item and the total price.
   * 
   * @param orderNumber
   *          - value for o_nr
   * @throws SQLException
   */
  public void printInvoiceForOrder(int orderNumber) throws SQLException {
    System.out.println("\nInvoice for order number " + orderNumber);

    // Optional: You could print customer information here!

    /*
     * TODO: For every order item, print the article name, the article's price
     * per unit, the quantity, and the price of the order item. SQL see
     * assignment 10b-14
     */
    Statement st = conn.createStatement();
	sql= "SELECT name,price , quantity , price * quantity FROM orders o, order_item ort INNER JOIN article art ON ort.a_nr=art.a_nr WHERE o.o_nr=? and ort.o_nr=? ORDER BY name ASC";
	PreparedStatement pst =conn.prepareStatement(sql); 
	pst.setInt(1, orderNumber);
	pst.setInt(2, orderNumber);
	int n = pst.executeUpdate();
	ResultSet cursor = pst.executeQuery();
	double d3=0;		
	while (cursor.next()) {
		// position in cursor starts at 1!
		String s1 = cursor.getString(1);
		double d1 = cursor.getDouble(2);
		int i1 = cursor.getInt(3);
		double d2 = cursor.getDouble(4);
		
		d3+=d2;
		//int i2 = cursor.getInt(2);
		System.out.println(s1+"  "+d1+"  "+i1+"  "+d2+"  ");
		//System.out.println(i2);
		}
	cursor.close();
	st.close();	
	System.out.println("-----------------------");
	
    /*
     * TODO: Print the total price of the order. You can calculate the sum via
     * SQL (see assignment 10b-15), or in Java.
     */
	System.out.println("Order's total price:  "+d3);
    //sql = "";

  }

  /**
   * Insert a new customer
   * 
   * @param id
   *          - customer ID
   * @param name
   *          - customer name
   * @throws SQLException
   */
  public void insertNewCustomer(int id, String name) throws SQLException {
    System.out.println("Trying to insert new customer. id=" + id + ", name=" + name);

    // TODO: insert a new customer with the given values
    Statement st = conn.createStatement();		
	sql = "INSERT INTO customer VALUES (?, ?)";		
	PreparedStatement pst =conn.prepareStatement(sql);
	pst.setInt(1, id);
	pst.setString(2, name);
	pst.execute();			
	st.close();
  }

  /**
   * Change the article's price
   * 
   * @param articleName
   *          - identifies the article
   * @param price
   *          - the new price
   * @throws SQLException
   */
  public void changeArticlePrice(String articleName, double price) throws SQLException {
    System.out.println("Trying to set the price of " + articleName + " to " + price);
    sql = "";
    int n = 0;

    // TODO: change the article's price
    sql = "UPDATE article SET price = ? WHERE name=?";
	PreparedStatement pst =
	conn.prepareStatement(sql);
	pst.setDouble(1, price);
	pst.setString(2, articleName);			
	n = pst.executeUpdate();

    System.out.println("Number of rows affected: " + n);
  }
}
