package edu.ib.servlet;

import edu.ib.EmployeeException;
import edu.ib.Logger;
import edu.ib.database.DBUtil;
import edu.ib.database.DBUtilEmployee;
import edu.ib.database.DBUtilRegistration;
import edu.ib.database.object.Employee;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

@WebServlet("/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {

    private DBUtilRegistration dbUtil;
    private String url="jdbc:mysql://localhost:3306/leave_system?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=CET";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            dbUtil=new DBUtilRegistration("create","createPass",url);
        try{
            Employee employee=new Employee();
            employee.setName(request.getParameter("inputFirstName"));
            employee.setSurname(request.getParameter("inputSurname"));
            employee.setEmail(request.getParameter("inputEmail"));
            employee.setBirthDate(LocalDate.parse(request.getParameter("inputBirth")));
            employee.setEmploymentYears(Integer.valueOf(request.getParameter("inputSeniority")));
            String login=request.getParameter("loginInput");
            String pass= Logger.hash(request.getParameter("passwordInput"));
            String pass1=Logger.hash(request.getParameter("repeatPassword"));

            if (!pass.equals(pass1)) throw new IllegalArgumentException("Password are not the same");

            dbUtil.addEmployee(employee.getName(),employee.getSurname(),employee.getBirthDate(), employee.getEmail(),employee.getEmploymentYears(),login,pass);
            pass="";
            pass1="";

            RequestDispatcher dispatcher=request.getRequestDispatcher("/index.html");
            dispatcher.forward(request,response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("loginError","Podany login jest już zajęty");
            RequestDispatcher dispatcher=request.getRequestDispatcher("/registration.jsp");
            dispatcher.forward(request,response);
        } catch(EmployeeException e){
            switch (e.getCode()){
                case 1:
                case 2:
                    break;
                case 3:
                    request.setAttribute("emailError","Błędny adres email");
                    break;
                case 4:
                    request.setAttribute("yearsError","Błędna wartość lat pracy");
                    break;
                default:
                    throw new ServletException(e);
            }
            RequestDispatcher dispatcher=request.getRequestDispatcher("/registration.jsp");
            dispatcher.forward(request,response);

        } catch (DateTimeParseException e){
            e.getStackTrace();
            request.setAttribute("dateError","Błędna data urodzenia");
            RequestDispatcher dispatcher=request.getRequestDispatcher("/registration.jsp");
            dispatcher.forward(request,response);
        } catch(IllegalArgumentException e){
            request.setAttribute("passwordError","Hasła nie są identyczne!");
        }


    }
}
