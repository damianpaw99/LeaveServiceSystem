package edu.ib.database;

import edu.ib.database.object.Employee;
import edu.ib.database.object.Leave;

import java.lang.reflect.InvocationTargetException;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

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

            leavesList.sort((o1, o2) -> o1.getId().compareTo(o2.getId()));
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

/*
    public List<Employee> getAllEmployees() throws SQLException {
        List<Employee> employeeList=new ArrayList<>();

        Connection conn = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {

            // polaczenie z BD
            conn = DriverManager.getConnection(url, login, password);

            // zapytanie SELECT
            String sql = "SELECT * FROM employees";
            statement = conn.createStatement();

            // wykonanie zapytania SQL
            resultSet = statement.executeQuery(sql);

            // przetworzenie wyniku zapytania
            ClassDatabaseMapper<Employee> leaveClassDatabaseMapper=new ClassDatabaseMapper<>(Employee.class);

            employeeList=leaveClassDatabaseMapper.getObject(resultSet);

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
        return employeeList;
    }

 */


}
