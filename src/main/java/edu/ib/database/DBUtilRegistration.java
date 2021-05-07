package edu.ib.database;

import java.sql.*;
import java.time.LocalDate;

/**
 * Class used to create new employee account in database
 */
public class DBUtilRegistration extends DBUtil{

    /**
     * Base constructor
     *
     * @param login    Username
     * @param password User password
     * @param url Url of database
     */
    public DBUtilRegistration(String login, String password, String url) {
        super(login, password, url);
    }

    /**
     * Method adding new employee
     * @param name Name of employee
     * @param surname Surname of employee
     * @param birthDate Date of birth of employee
     * @param email Email of employee
     * @param yearsInWork Years of employment
     * @param login Login
     * @param hashedPassword Password
     * @throws SQLException Thrown when there was a problem with connection or database query
     */
    public void addEmployee(String name, String surname, LocalDate birthDate, String email, int yearsInWork, String login, String hashedPassword) throws SQLException {

        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {

            // polaczenie z BD
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, this.login, this.password);

            // zapytanie SELECT
            String sql = "CALL add_employee(?,?,?,?,?,?,?)";
            statement = conn.prepareStatement(sql);
            statement.setString(1,name);
            statement.setString(2,surname);
            statement.setDate(3, Date.valueOf(birthDate));
            statement.setString(4,email);
            statement.setInt(5,yearsInWork);
            statement.setString(6,login);
            statement.setString(7,hashedPassword);

            // wykonanie zapytania SQL
            statement.execute();

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            // zamkniecie obiektow JDBC
            close(conn, statement, resultSet);
        }
    }
}
