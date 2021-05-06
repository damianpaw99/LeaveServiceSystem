package edu.ib.servlet;

import edu.ib.IncorrectLoginPasswordException;
import edu.ib.Logger;
import edu.ib.database.DBUtil;
import edu.ib.database.DBUtilEmployee;
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

@WebServlet("/EmployeeViewServlet")
public class EmployeeViewServlet extends HttpServlet {


    private DBUtilEmployee dbUtil;
    private HttpSession session;
    private String url="jdbc:mysql://localhost:3306/leave_system?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=CET";


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
                if (command.equals("EDIT")) {

                } else if (command.equals("CANCEL")) {
                    Leave leave=dbUtil.getEmployeeLeave(employeeId,leaveId);
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}
