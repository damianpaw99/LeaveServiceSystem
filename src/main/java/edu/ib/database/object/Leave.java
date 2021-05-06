package edu.ib.database.object;

import edu.ib.database.DatabaseMappable;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class Leave implements DatabaseMappable {


    private Integer id;
    private Integer leaveId;
    private String employeeName;
    private String employeeSurname;
    private LocalDate startDate;
    private LocalDate endDate;
    private LocalDateTime statusDate;
    private String status;


    public Leave(){
    }

    public Leave(String employeeName, String employeeSurname, LocalDate startDate, LocalDate endDate, LocalDateTime statusDate, String status) {
        if(employeeName.isEmpty() || employeeName.length()>50) throw new IllegalArgumentException("Wrong employeeName: "+employeeName);
        if(employeeSurname.isEmpty() || employeeSurname.length()>50) throw new IllegalArgumentException("Wrong employeeName: "+employeeName);
        this.employeeName = employeeName;
        this.employeeSurname = employeeSurname;
        this.startDate = startDate;
        this.endDate = endDate;
        this.statusDate = statusDate;
        this.status = status;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getLeaveId() {
        return leaveId;
    }

    public void setLeaveId(Integer leaveId) {
        this.leaveId = leaveId;
    }

    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        if(employeeName.isEmpty() || employeeName.length()>50) throw new IllegalArgumentException("Wrong employeeName: "+employeeName);
        this.employeeName = employeeName;
    }

    public String getEmployeeSurname() {
        return employeeSurname;
    }

    public void setEmployeeSurname(String employeeSurname) {
        if(employeeSurname.isEmpty() || employeeSurname.length()>50) throw new IllegalArgumentException("Wrong employeeName: "+employeeName);
        this.employeeSurname = employeeSurname;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public LocalDateTime getStatusDate() {
        return statusDate;
    }

    public void setStatusDate(LocalDateTime statusDate) {
        this.statusDate = statusDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }


    public boolean isEmployeeDeletable(){
        return (startDate.isAfter(LocalDate.now().plusDays(2)) &&  status.equals("Zaakceptowany")) || status.equals("Złożony");
    }

    public boolean isEditable(){
        return startDate.isAfter(LocalDate.now().plusDays(2)) && (status.equals("Zaakceptowany"));
    }

    public boolean hasDecision(){
        return status.equals("Złożony") || status.equals("Do anulacji") || status.equals("Do edycji");
    }
}
