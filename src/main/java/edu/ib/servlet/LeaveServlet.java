package edu.ib.servlet;

import edu.ib.IncorrectLoginPasswordException;
import edu.ib.Logger;
import edu.ib.database.DBUtilEmployee;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

@WebServlet("/LeaveServlet")
public class LeaveServlet extends HttpServlet {

    private DBUtilEmployee dbUtil;
    private String url="jdbc:mysql://localhost:3306/leave_system?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=CET";
    private HttpSession session;


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            session=request.getSession();
            session.removeAttribute("logger");
            RequestDispatcher dispatcher=request.getRequestDispatcher("/index.html");
            dispatcher.forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        dbUtil= new DBUtilEmployee("employee","employeePass",url);
        session=request.getSession();
        Logger logger= (Logger) session.getAttribute("logger");
        try {
            int employeeId=logger.getEmployeeLoggedId();
            LocalDate startDate=LocalDate.parse(request.getParameter("startDateInput"));
            if(startDate.isBefore(LocalDate.now().plusDays(1))){
                request.setAttribute("startError","Niepoprawna data początkowa");
                throw new IllegalArgumentException("Illegal startDate");
            }
            LocalDate endDate=LocalDate.parse(request.getParameter("endDateInput"));
            if(endDate.isBefore(startDate) || endDate.isBefore(LocalDate.now().plusDays(1))){
                request.setAttribute("startError","Niepoprawna data końcowa");
                throw new IllegalArgumentException("Illegal endDate");
            }
            dbUtil.addLeave(employeeId,startDate,endDate);
            RequestDispatcher dispatcher=request.getRequestDispatcher("leaves_employee_view.jsp");
            dispatcher.forward(request,response);
        } catch (IncorrectLoginPasswordException | NullPointerException e) {
            e.printStackTrace();
            request.setAttribute("otherError","Zaloguj się ponownie!");
            RequestDispatcher dispatcher=request.getRequestDispatcher("/leave_form.jsp");
            dispatcher.forward(request,response);
        } catch (DateTimeParseException e){
            e.printStackTrace();
            request.setAttribute("otherError","Błędny format daty początkowej lub końcowej!");
            RequestDispatcher dispatcher=request.getRequestDispatcher("/leave_form.jsp");
            dispatcher.forward(request,response);
        } catch (SQLException e) {
            e.printStackTrace();
            if(e.getSQLState().equals("450001")) {
                request.setAttribute("otherError", "Przekroczono liczbę dni urlopu!");
            } else if(e.getSQLState().equals("450000")){
                request.setAttribute("otherError","Urlop na przełomie lat - stwórz 2 osobne wnioski o urlop");
            } else  {
                request.setAttribute("otherError","Wystąpił błąd, spróbuj ponownie później");
            }
            RequestDispatcher dispatcher=request.getRequestDispatcher("/leave_form.jsp");
            dispatcher.forward(request,response);
        } catch (IllegalArgumentException e){
            RequestDispatcher dispatcher=request.getRequestDispatcher("leave_form.jsp");
            dispatcher.forward(request,response);
        }
    }
}
