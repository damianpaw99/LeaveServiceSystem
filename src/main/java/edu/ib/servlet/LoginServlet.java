package edu.ib.servlet;

import edu.ib.IncorrectLoginPasswordException;
import edu.ib.Logger;
import edu.ib.database.DBUtil;
import edu.ib.database.DBUtilManager;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Servlet used to control login.jsp
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {


    /**
     * DButil used to communicate with database
     */
    private DBUtil dbUtil;
    /**
     * Database url
     */
    private String url="jdbc:mysql://localhost:3306/leave_system?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=CET";;
    /**
     * Session object
     */
    private HttpSession session;

    /**
     * doPost method
     * Tries to log in manager or employee, saves it in session object
     * When logging in is failed creates error warnings and reloads page
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        session=request.getSession();

        String login=request.getParameter("loginInput");

        try{
            if(!validate(login,request.getParameter("passwordInput"))){
                throw new IncorrectLoginPasswordException("");
            }
            dbUtil=new DBUtilManager(login,request.getParameter("passwordInput"),url);
            session.setAttribute("dbUtil",dbUtil);
            //RequestDispatcher dispatcher=request.getRequestDispatcher("ManagerAllServlet");

            //dispatcher.forward(request,response);
            response.sendRedirect("ManagerAllServlet");

        } catch(IncorrectLoginPasswordException e){

            try{
                dbUtil=new DBUtil("logger","loggerPass",url);
                Logger logger=new Logger(dbUtil,login);
                logger.logIn(Logger.hash(request.getParameter("passwordInput")));
                session.setAttribute("employeeLogin",login);
                session.setAttribute("logger",logger);

                //RequestDispatcher dispatcher=request.getRequestDispatcher("EmployeeViewServlet");
                //dispatcher.forward(request,response);
                response.sendRedirect("EmployeeViewServlet");


            } catch(IncorrectLoginPasswordException | SQLException | ClassNotFoundException er){
                request.setAttribute("loginError","Błędny login lub hasło");
                RequestDispatcher dispatcher=request.getRequestDispatcher("/login.jsp");
                dispatcher.forward(request,response);
            }


        }




    }

    /**
     * Method used to check database login and password for manager
     * @param name Login
     * @param pass Password
     * @return Boolean value if it was correct
     */
    private boolean validate(String name, String pass) {
        boolean status = false;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

        } catch (ClassNotFoundException e) {
            e.printStackTrace();

        }

        Connection conn = null;

        try {

            conn = DriverManager.getConnection(url, name, pass);
            status = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
}
