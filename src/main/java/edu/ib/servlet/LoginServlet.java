package edu.ib.servlet;

import edu.ib.IncorrectLoginPasswordException;
import edu.ib.Logger;
import edu.ib.database.DBUtil;

import javax.servlet.RequestDispatcher;
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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {


    private DBUtil dbUtil;
    private HttpSession session;
    private String url="jdbc:mysql://localhost:3306/leave_system?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=CET";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        session=request.getSession();

        String login=request.getParameter("loginInput");

        try{
            if(!validate(login,request.getParameter("passwordInput"))){
                throw new IncorrectLoginPasswordException("");
            }
            RequestDispatcher dispatcher=request.getRequestDispatcher("/leaves_manager_view.jsp");
            dispatcher.forward(request,response);

        } catch(IncorrectLoginPasswordException e){

            try{
                dbUtil=new DBUtil("logger","loggerPass",url);
                Logger logger=new Logger(dbUtil,login);
                logger.logIn(Logger.hash(request.getParameter("passwordInput")));
                session.setAttribute("logger",logger);

                RequestDispatcher dispatcher=request.getRequestDispatcher("/leaves_employee_view.jsp");
                dispatcher.forward(request,response);

            } catch(IncorrectLoginPasswordException | SQLException | ClassNotFoundException er){
                request.setAttribute("loginError","Błędny login lub hasło");
                RequestDispatcher dispatcher=request.getRequestDispatcher("/login.jsp");
                dispatcher.forward(request,response);
            }


        }




    }

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