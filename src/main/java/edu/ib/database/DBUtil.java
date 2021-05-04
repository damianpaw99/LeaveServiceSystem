package edu.ib.database;

import java.sql.*;


public abstract class DBUtil {

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

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Connection getConn() {
        return conn;
    }

    public void setConn(Connection conn) {
        this.conn = conn;
    }
}
