package edu.ib.database.object;

import edu.ib.database.DatabaseMappable;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * Class mapping leave from database
 */
public class Leave implements DatabaseMappable {

    /**
     * Employee id
     */
    private Integer id;
    /**
     * Leave id
     */
    private Integer leaveId;
    /**
     * Employee name
     */
    private String employeeName;
    /**
     * Employee surname
     */
    private String employeeSurname;
    /**
     * Date of first day of leave
     */
    private LocalDate startDate;
    /**
     * Date of last day of leave
     */
    private LocalDate endDate;
    /**
     * Date of granting status
     */
    private LocalDateTime statusDate;
    /**
     * Status of leave
     */
    private String status;

    /**
     * Basic constructor
     */
    public Leave(){
    }

    /**
     *
     * @param employeeName Name of employee
     * @param employeeSurname Surname of employee
     * @param startDate Date of first day of leave
     * @param endDate Date of last day of leave
     * @param statusDate Date of granting status
     * @param status Status of leave
     */
    public Leave(String employeeName, String employeeSurname, LocalDate startDate, LocalDate endDate, LocalDateTime statusDate, String status) {
        if(employeeName.isEmpty() || employeeName.length()>50) throw new IllegalArgumentException("Wrong employeeName: "+employeeName);
        if(employeeSurname.isEmpty() || employeeSurname.length()>50) throw new IllegalArgumentException("Wrong employeeName: "+employeeName);
        this.employeeName = employeeName;
        this.employeeSurname = employeeSurname;
        if(startDate.isAfter(endDate)) throw new IllegalArgumentException("End date can't be before start date");
        this.startDate = startDate;
        this.endDate = endDate;
        this.statusDate = statusDate;
        this.status = status;
    }

    /**
     * Employee id getter
     * @return Employee di
     */
    public Integer getId() {
        return id;
    }

    /**
     * Employee setter
     * @param id Employee id
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * Id getter
     * @return Id
     */
    public Integer getLeaveId() {
        return leaveId;
    }

    /**
     * Id setter
     * @param leaveId Id
     */
    public void setLeaveId(Integer leaveId) {
        this.leaveId = leaveId;
    }

    /**
     * Employee name getter
     * @return Employee name
     */
    public String getEmployeeName() {
        return employeeName;
    }

    /**
     * Employee name setter
     * @param employeeName Employee name
     */
    public void setEmployeeName(String employeeName) {
        if(employeeName.isEmpty() || employeeName.length()>50) throw new IllegalArgumentException("Wrong employeeName: "+employeeName);
        this.employeeName = employeeName;
    }

    /**
     * Employee surname getter
     * @return Employee surname
     */
    public String getEmployeeSurname() {
        return employeeSurname;
    }
    /**
     * Employee surname setter
     * @param employeeSurname Employee surname
     */
    public void setEmployeeSurname(String employeeSurname) {
        if(employeeSurname.isEmpty() || employeeSurname.length()>50) throw new IllegalArgumentException("Wrong employeeName: "+employeeName);
        this.employeeSurname = employeeSurname;
    }

    /**
     * First date of leave getter
     * @return First date of leave
     */
    public LocalDate getStartDate() {
        return startDate;
    }

    /**
     * First date of leave setter
     * @param startDate First day of leave
     */
    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    /**
     * End date of leave getter
     * @return End date of leave
     */
    public LocalDate getEndDate() {
        return endDate;
    }

    /**
     * End date of leave setter
     * @param endDate End date of leave
     */
    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    /**
     * Date of granting status getter
     * @return Date of granting status
     */
    public LocalDateTime getStatusDate() {
        return statusDate;
    }

    /**
     * Date of granting status setter
     * @param statusDate Date of granting status
     */
    public void setStatusDate(LocalDateTime statusDate) {
        this.statusDate = statusDate;
    }

    /**
     * Status getter
     * @return Status
     */
    public String getStatus() {
        return status;
    }

    /**
     * Status setter
     * @param status Status
     */
    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * Method checking if leave is deletable by employee
     * @return Value if employee can delete this leave
     */
    public boolean isEmployeeDeletable(){
        return (startDate.isAfter(LocalDate.now().plusDays(2)) &&  status.equals("Zaakceptowany")) || status.equals("Złożony");
    }
    /**
     * Method checking if leave is editable by employee
     * @return Value if employee can edit this leave
     */
    public boolean isEditable(){
        return startDate.isAfter(LocalDate.now().plusDays(2)) && (status.equals("Zaakceptowany"));
    }

    /**
     * Method checking if manager has to make decision about leave
     * @return Value if manager has to make decision about leave
     */
    public boolean hasDecision(){
        return status.equals("Złożony") || status.equals("Do anulacji") || status.equals("Do edycji");
    }
}
