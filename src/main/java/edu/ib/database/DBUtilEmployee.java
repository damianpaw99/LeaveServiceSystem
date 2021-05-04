package edu.ib.database;

import edu.ib.database.object.Employee;
import edu.ib.database.object.Leave;

import java.lang.reflect.InvocationTargetException;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
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

    public void addEmployee(String name, String surname, LocalDate birthDate, String email, int yearsInWork) throws SQLException {

        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {

            // polaczenie z BD
            conn = DriverManager.getConnection(url, login, password);

            // zapytanie SELECT
            String sql = "CALL add_employee(?,?,?,?,?)";
            statement = conn.prepareStatement(sql);
            statement.setString(1,name);
            statement.setString(2,surname);
            statement.setDate(3, Date.valueOf(birthDate));
            statement.setString(4,email);
            statement.setInt(5,yearsInWork);

            // wykonanie zapytania SQL
            statement.execute(sql);

        } finally {
            // zamkniecie obiektow JDBC
            close(conn, statement, resultSet);
        }
    }
}