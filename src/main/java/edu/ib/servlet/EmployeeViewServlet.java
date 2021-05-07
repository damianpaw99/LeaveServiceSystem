package edu.ib.servlet;

import edu.ib.IncorrectLoginPasswordException;
import edu.ib.Logger;
import edu.ib.database.DBUtil;
import edu.ib.database.DBUtilEmployee;
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
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * Servlet used to control leaves_employee_view.jsp
 */
@WebServlet("/EmployeeViewServlet")
public class EmployeeViewServlet extends HttpServlet {


    /**
     * DButil used to communicate with database
     */
    private DBUtilEmployee dbUtil;
    /**
     * Database url
     */
    private String url="jdbc:mysql://localhost:3306/leave_system?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=CET";;
    /**
     * Session object
     */
    private HttpSession session;

    /**
     * doGet
     * Shows employee leave, logs out, edits on cancels leave base on "command" and "method"
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        dbUtil=new DBUtilEmployee("employee","employeePass",url);
        String method=request.getParameter("method");
        String command=request.getParameter("command");
        session = request.getSession();
        if(method==null && command==null) {
                Logger logger=(Logger)session.getAttribute("logger");
                try {
                    int employeeId = logger.getEmployeeLoggedId();
                    List<Leave> list=dbUtil.getEmployeeLeaves(employeeId);
                    request.setAttribute("LEAVES_LIST",list);
                    RequestDispatcher dispatcher=request.getRequestDispatcher("/leaves_employee_view.jsp");
                    dispatcher.forward(request,response);

                }catch(IncorrectLoginPasswordException | SQLException e) {
                    e.printStackTrace();
                }
        } else if(method!=null && method.equals("LOG OUT")) {

            session.removeAttribute("logger");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/index.html");
            dispatcher.forward(request, response);

        } else if(command!=null){
            try {
                Logger logger=(Logger) session.getAttribute("logger");
                int employeeId = logger.getEmployeeLoggedId();
                int leaveId = Integer.parseInt(request.getParameter("leaveID"));
                Leave leave=dbUtil.getEmployeeLeave(employeeId,leaveId);

                if (command.equals("EDIT")) {
                    request.setAttribute("startValue",leave.getStartDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
                    request.setAttribute("endValue", leave.getEndDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
                    request.setAttribute("leaveId",String.valueOf(leave.getLeaveId()));
                    RequestDispatcher dispatcher=request.getRequestDispatcher("LeaveServlet");
                    dispatcher.forward(request,response);

                } else if (command.equals("CANCEL")) {

                    if(leave.getStatus().equals("Złożony")){
                        dbUtil.changeLeaveState(leaveId,7);
                    } else {
                        dbUtil.changeLeaveState(leaveId,4);
                    }
                    request.setAttribute("LEAVES_LIST",dbUtil.getEmployeeLeaves(employeeId));
                    request.getRequestDispatcher("leaves_employee_view.jsp").forward(request,response);

                }

            } catch (IncorrectLoginPasswordException e) {

            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }

    /**
     * doPost method
     * The same as doGet
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}
