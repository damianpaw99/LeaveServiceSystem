package edu.ib.servlet;

import edu.ib.database.DBUtil;
import edu.ib.database.DBUtilManager;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/AllEmployeesServlet")
public class AllEmployeesServlet extends HttpServlet {


    private DBUtilManager dbUtil;
    private String url="jdbc:mysql://localhost:3306/leave_system?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=CET";;
    private HttpSession session;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        session=request.getSession();
        dbUtil=(DBUtilManager) session.getAttribute("dbUtil");
        String command=request.getParameter("command");
        if(command==null){
            try {
                request.setAttribute("EMPLOYEE_LIST",dbUtil.getAllEmployees());
                RequestDispatcher dispatcher=request.getRequestDispatcher("employees_manager_view.jsp");
                dispatcher.forward(request,response);
            } catch (SQLException throwables) {
                throwables.printStackTrace();
                throw new ServletException(throwables);
            }
        } else if(command.equals("LOG OUT")){
            session.removeAttribute("dbUtil");
            RequestDispatcher dispatcher=request.getRequestDispatcher("/index.html");
            dispatcher.forward(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}
