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







}
