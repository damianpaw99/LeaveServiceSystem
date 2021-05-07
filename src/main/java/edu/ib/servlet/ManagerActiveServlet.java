package edu.ib.servlet;

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

/**
 * Servlet used to control active_leaves_view.jsp
 */
@WebServlet("/ManagerActiveServlet")
public class ManagerActiveServlet extends HttpServlet {

    /**
     * DButil used to communicate with database
     */
    private DBUtilManager dbUtil;
    /**
     * Database url
     */
    private String url="jdbc:mysql://localhost:3306/leave_system?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=CET";;
    /**
     * Session object
     */
    private HttpSession session;

    /**
     * doGet method
     * Loads active leaves from database, changes change of leaves or logs out user based on "command"
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        session = request.getSession();

        dbUtil = (DBUtilManager) session.getAttribute("dbUtil");
        String command = request.getParameter("command");
        if (command != null) {

            switch (command) {
                case "ACCEPT": {
                    int leaveId = Integer.parseInt(request.getParameter("leaveID"));
                    try {
                        Leave leave = dbUtil.getEmployeeLeave(leaveId);
                        String leaveState = leave.getStatus();
                        switch (leaveState) {
                            case "Złożony":
                                dbUtil.changeLeaveState(leaveId, 2);
                                break;
                            case "Do anulacji":
                                dbUtil.changeLeaveState(leaveId, 5);
                                break;
                            case "Do edycji":
                                dbUtil.changeLeaveState(leaveId, 9);
                                break;
                        }
                    } catch (SQLException throwables) {
                        throwables.printStackTrace();
                        throw new ServletException(throwables);
                    }
                    break;
                }
                case "DECLINE": {
                    int leaveId = Integer.parseInt(request.getParameter("leaveID"));
                    try {
                        Leave leave = dbUtil.getEmployeeLeave(leaveId);
                        String leaveState = leave.getStatus();
                        switch (leaveState) {
                            case "Złożony":
                                dbUtil.changeLeaveState(leaveId, 3);
                                break;
                            case "Do anulacji":
                                dbUtil.changeLeaveState(leaveId, 6);
                                break;
                            case "Do edycji":
                                dbUtil.changeLeaveState(leaveId, 10);
                                break;
                        }
                    } catch (SQLException throwables) {
                        throwables.printStackTrace();
                        throw new ServletException(throwables);
                    }
                    break;
                }
                case "LOG OUT":
                    session.removeAttribute("dbUtil");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/index.html");
                    dispatcher.forward(request, response);
                    return;
            }
            try {
                List<Leave> list=dbUtil.getToAcceptLeaves();
                request.setAttribute("LEAVES_LIST",list);
                RequestDispatcher dispatcher=request.getRequestDispatcher("active_leaves_view.jsp");
                dispatcher.forward(request,response);
            } catch (SQLException throwables) {
                throwables.printStackTrace();
                throw new ServletException(throwables);
            }
        } else {
            try {
                List<Leave> list=dbUtil.getToAcceptLeaves();
                request.setAttribute("LEAVES_LIST",list);
                RequestDispatcher dispatcher=request.getRequestDispatcher("active_leaves_view.jsp");
                dispatcher.forward(request,response);
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }

    }
