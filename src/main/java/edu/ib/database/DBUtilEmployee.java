package edu.ib.database;

import edu.ib.database.object.Leave;

import java.lang.reflect.InvocationTargetException;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 * Method used to connect to database as employee
 */
public class DBUtilEmployee extends DBUtil {

    /**
     * Base constructor
     *
     * @param login    Username
     * @param password User password
     * @param url
     */
    public DBUtilEmployee(String login, String password, String url) {
        super(login, password, url);
    }

    /**
     * Method getting list of leaves of employee
     * @param employeeId Employee id
     * @return List of leaves of employee
     * @throws SQLException Thrown when there was a problem with connection or database query
     */
    public List<Leave> getEmployeeLeaves(int employeeId) throws SQLException {
        List<Leave> leavesList=new ArrayList<>();

        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {

            // polaczenie z BD
            conn = DriverManager.getConnection(url, login, password);

            // zapytanie SELECT
            String sql = "SELECT * FROM employees_leaves WHERE id=?";
            statement = conn.prepareStatement(sql);
            statement.setInt(1,employeeId);

            // wykonanie zapytania SQL
            resultSet = statement.executeQuery();

            // przetworzenie wyniku zapytania
            ClassDatabaseMapper<Leave> leaveClassDatabaseMapper=new ClassDatabaseMapper<>(Leave.class);

            leavesList=leaveClassDatabaseMapper.getObject(resultSet);

            leavesList.sort((o1, o2) -> o2.getLeaveId().compareTo(o1.getLeaveId()));
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } finally {
            // zamkniecie obiektow JDBC
            close(conn, statement, resultSet);
        }
        return leavesList;
    }

    /**
     * Method used to get leave of employee from database
     * @param employeeId Employee id
     * @param leaveId Leave id
     * @return Leave
     * @throws SQLException Thrown when there was a problem with connection or database query
     */
    public Leave getEmployeeLeave(int employeeId, int leaveId) throws SQLException {
        List<Leave> leavesList=new ArrayList<>();

        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {

            // polaczenie z BD
            conn = DriverManager.getConnection(url, login, password);

            // zapytanie SELECT
            String sql = "SELECT * FROM employees_leaves WHERE id=? AND leaveId=?";
            statement = conn.prepareStatement(sql);
            statement.setInt(1,employeeId);
            statement.setInt(2,leaveId);
            // wykonanie zapytania SQL
            resultSet = statement.executeQuery();

            // przetworzenie wyniku zapytania
            ClassDatabaseMapper<Leave> leaveClassDatabaseMapper=new ClassDatabaseMapper<>(Leave.class);

            leavesList=leaveClassDatabaseMapper.getObject(resultSet);

        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } finally {
            // zamkniecie obiektow JDBC
            close(conn, statement, resultSet);
        }
        if(leavesList.size()>0) {
            return leavesList.get(0);
        } else return new Leave();
    }

    /**
     * Method used to add leave to database
     * @param employeeId Employee id
     * @param startDate First date of leave
     * @param endDate Last day of leave
     * @throws SQLException Thrown when there was a problem with connection or database query
     */
    public void addLeave(int employeeId, LocalDate startDate, LocalDate endDate) throws SQLException {
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {

            // polaczenie z BD
            conn = DriverManager.getConnection(url, login, password);

            // zapytanie SELECT
            String sql = "CALL add_leave(?,?,?)";
            statement = conn.prepareStatement(sql);
            statement.setInt(1,employeeId);
            statement.setDate(2, Date.valueOf(startDate));
            statement.setDate(3,Date.valueOf(endDate));

            // wykonanie zapytania SQL
            statement.execute();

        } finally {
            // zamkniecie obiektow JDBC
            close(conn, statement, resultSet);
        }
    }

    /**
     * Method used to change state of leave by employee
     * @param leaveId Leave id
     * @param stateId New state id of leave (1-Zlozono; 2-Zaakceptowany; 3-Odrzucony; 4-Do anulacji; 5-Anulowany;
     *                6-Anulowanie odrzucone; 7-Wycofany; 8-Do edycji; 9-Edytowany; 10-Edycja odrzucona)
     * @throws SQLException Thrown when there was a problem with connection or database query
     */
    public void changeLeaveState(int leaveId,int stateId) throws SQLException {
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {

            // polaczenie z BD
            conn = DriverManager.getConnection(url, login, password);

            // zapytanie SELECT
            String sql = "CALL changeLeaveState(?,?)";
            statement = conn.prepareStatement(sql);
            statement.setInt(1, leaveId);
            statement.setInt(2, stateId);


            // wykonanie zapytania SQL
            statement.execute();

        } finally {
            // zamkniecie obiektow JDBC
            close(conn, statement, resultSet);
        }
    }

    /**
     * Method getting days left of leaves in year which can be used by employee
     * @param employeeId Employee id
     * @param year Year
     * @return Days left of leaves in year for employee
     * @throws SQLException Thrown when there was a problem with connection or database query
     */
    public int daysLeft(int employeeId, int year) throws SQLException {
        int out=0;

        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {

            // polaczenie z BD
            conn = DriverManager.getConnection(url, login, password);

            // zapytanie SELECT
            String sql = "SELECT days_left(?,?)";
            statement = conn.prepareStatement(sql);
            statement.setInt(1,employeeId);
            statement.setInt(2,year);
            // wykonanie zapytania SQL
            resultSet = statement.executeQuery();

            // przetworzenie wyniku zapytania
            resultSet.next();
            out=resultSet.getInt(1);

        } finally {
            // zamkniecie obiektow JDBC
            close(conn, statement, resultSet);
        }
        return out;
    }


}
