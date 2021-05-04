package edu.ib.database;

import edu.ib.database.object.Leave;

import java.lang.reflect.InvocationTargetException;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class DBUtilLeave extends DBUtil{
    /**
     * Base constructor
     *
     * @param userName     Username
     * @param userPassword User password
     * @param url
     */
    public DBUtilLeave(String userName, String userPassword, String url) {
        super(userName, userPassword, url);
    }


    public List<Leave> getAllLeaves() throws SQLException {
        List<Leave> leavesList=new ArrayList<>();

        Connection conn = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {

            // polaczenie z BD
            conn = DriverManager.getConnection(url, login, password);

            // zapytanie SELECT
            String sql = "SELECT * FROM employees_leaves";
            statement = conn.createStatement();

            // wykonanie zapytania SQL
            resultSet = statement.executeQuery(sql);

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
        return leavesList;
    }

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
            resultSet = statement.executeQuery(sql);

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
        return leavesList;
    }

    public List<Leave> getToAcceptLeaves() throws SQLException {
        List<Leave> leavesList=new ArrayList<>();

        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {

            // polaczenie z BD
            conn = DriverManager.getConnection(url, login, password);

            // zapytanie SELECT
            String sql = "SELECT * FROM employees_leaves_active";
            statement = conn.prepareStatement(sql);

            // wykonanie zapytania SQL
            resultSet = statement.executeQuery(sql);

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
        return leavesList;

    }

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
            statement.execute(sql);

        } finally {
            // zamkniecie obiektow JDBC
            close(conn, statement, resultSet);
        }
    }

    public void changeLeaveState(int leaveId,int stateId) throws SQLException {
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {

            // polaczenie z BD
            conn = DriverManager.getConnection(url, login, password);

            // zapytanie SELECT
            String sql = "CALL changeLeave_state(?,?)";
            statement = conn.prepareStatement(sql);
            statement.setInt(1, leaveId);
            statement.setInt(2, stateId);


            // wykonanie zapytania SQL
            statement.execute(sql);

        } finally {
            // zamkniecie obiektow JDBC
            close(conn, statement, resultSet);
        }
    }
}