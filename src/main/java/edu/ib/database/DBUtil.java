package edu.ib.database;

import java.sql.*;

/**
 * Class containing base structures to communicate with database
 */
public class DBUtil {

    /**
     * Username
     */
    protected String login;
    /**
     * User password
     */
    protected String password;


    protected String url;
    /**
     * Connection class object
     */
    private Connection conn = null;

    /**
     * Base constructor
     *
     * @param login     Username
     * @param password User password
     */
    public DBUtil(String login, String password, String url) {
        this.login = login;
        this.password = password;
        this.url=url;
    }

    /**
     * Method used to connect to database
     *
     * @throws SQLException Thrown, when there was a problem with database or login or password was incorrect
     */
    public void dbConnect() throws SQLException, ClassNotFoundException {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw e;
        }

        try {
            conn = DriverManager.getConnection(url);
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }

    }

    /**
     * Method used to disconnect
     *
     * @throws SQLException Thrown, when there was a problem database
     */
    public void dbDisconnect() throws SQLException {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (Exception e) {
            throw e;
        }
    }

    /**
     * Method closing object used to communicating with database
     * @param conn Connection object
     * @param statement Statement object
     * @param resultSet ResultSet object
     */
    protected static void close(Connection conn, Statement statement, ResultSet resultSet) {

        try {

            if (resultSet != null)
                resultSet.close();

            if (statement != null)
                statement.close();

            if (conn != null)
                conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * login getter
     * @return Login
     */
    public String getLogin() {
        return login;
    }

    /**
     * Login setter
     * @param login Login
     */
    public void setLogin(String login) {
        this.login = login;
    }

    /**
     * Password getter
     * @return Password
     */
    public String getPassword() {
        return password;
    }

    /**
     * Password setter
     * @param password Password
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * Url of database getter
     * @return Url of database
     */
    public String getUrl() {
        return url;
    }

    /**
     * Url of database setter
     * @param url Url of database
     */
    public void setUrl(String url) {
        this.url = url;
    }

    /**
     * Connection getter
     * @return connection
     */
    public Connection getConn() {
        return conn;
    }

    /**
     * Connection setter
     * @param conn Connection
     */
    public void setConn(Connection conn) {
        this.conn = conn;
    }



}
