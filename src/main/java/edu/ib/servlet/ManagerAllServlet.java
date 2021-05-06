package edu.ib.servlet;

import edu.ib.database.ClassDatabaseMapper;
import edu.ib.database.DBUtil;
import edu.ib.database.DBUtilManager;
import edu.ib.database.object.Leave;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/ManagerAllServlet")
public class ManagerAllServlet extends HttpServlet {

    private DBUtilManager dbUtil;
    private String url="jdbc:mysql://localhost:3306/leave_system?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=CET";
    private HttpSession session;


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        session=request.getSession();
        String command=request.getParameter("command");
        if(command==null) {
            dbUtil = (DBUtilManager) session.getAttribute("dbUtil");
            try {
                List<Leave> list = dbUtil.getAllLeaves();
                request.setAttribute("LEAVES_LIST", list);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/leaves_manager_view.jsp");
                dispatcher.forward(request, response);
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        } else {
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
