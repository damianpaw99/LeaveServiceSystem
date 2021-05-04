package edu.ib;

import edu.ib.database.DBUtil;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;

public class Logger {

    private int employeeLoggedId;
    /**
     * Object used to connect to database
     */
    private DBUtil dbUtil;

    private final String login;
    /**
     * Boolean, which contains information about logging in (if it is successful or not)
     */
    private boolean loggedIn = false;

    /**
     * Base constructor
     *
     * @param dbUtil     DBUtil class object, used to connect to database
     * @param login      Login of person
     */
    public Logger(DBUtil dbUtil, String login) {
        this.login=login;
        this.dbUtil = dbUtil;
    }

    /**
     * Method logging person
     *
     * @param hashedPassword Password hashed with Logger.hash()
     * @throws IncorrectLoginPasswordException Exception thrown, when login or password are incorect
     * @throws SQLException                Exception thrown, when there was a problem with database
     */
    public void logIn(String hashedPassword) throws IncorrectLoginPasswordException, SQLException, ClassNotFoundException {
        ResultSet result=null;
        PreparedStatement statement=null;
        Connection conn=null;
        conn= DriverManager.getConnection(dbUtil.getUrl(),dbUtil.getLogin(),dbUtil.getPassword());
        String sql = "SELECT check_pass(?,?)";
        statement=conn.prepareStatement(sql);
        statement.setString(1,login);
        statement.setString(2,hashedPassword);
        result=statement.executeQuery();
        result.next();
        if (result.getInt(1) == 0) {
            throw new IncorrectLoginPasswordException("Wrong login or password");
        } else {
            loggedIn = true;
            employeeLoggedId =result.getInt(1);
        }
    }

    /**
     * Method used to hash password using SHA-1
     *
     * @param pass Password to hash
     * @return Hashed password
     */
    public static String hash(String pass) {
        MessageDigest md;
        StringBuilder sb = new StringBuilder();
        try {
            md = MessageDigest.getInstance("SHA-1");
            md.update(pass.getBytes());
            byte[] bytes = md.digest();
            for (int i = 0; i < bytes.length; i++) {
                sb.append(Integer.toString((bytes[i] & 0xFF) + 0x100, 16)).substring(1);
            }
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        return sb.toString();
    }

    /**
     * Login getter return only when person successfully logged in
     *
     * @return Login
     * @throws IncorrectLoginPasswordException Thrown when person is not logged in
     */
    public String getLogin() throws IncorrectLoginPasswordException {
        if (loggedIn) {
            return login;
        } else throw new IncorrectLoginPasswordException("Person is not logged in!");
    }

    public int getEmployeeLoggedId() throws IncorrectLoginPasswordException {
        if (loggedIn) {
            return employeeLoggedId;
        } else throw new IncorrectLoginPasswordException("Person is not logged in!");
    }
}
