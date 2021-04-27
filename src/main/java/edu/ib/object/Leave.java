package edu.ib.object;

import java.time.LocalDate;

public class Leave {

    private String employeeName;
    private String employeeSurname;
    private LocalDate startDate;
    private LocalDate endDate;
    private LocalDate statusDate;
    private String status;



    public Leave(){
    }

    public Leave(String employeeName, String employeeSurname, LocalDate startDate, LocalDate endDate, LocalDate statusDate, String status) {
        if(employeeName.isEmpty() || employeeName.length()>50) throw new IllegalArgumentException("Wrong employeeName: "+employeeName);
        if(employeeSurname.isEmpty() || employeeSurname.length()>50) throw new IllegalArgumentException("Wrong employeeName: "+employeeName);
        this.employeeName = employeeName;
        this.employeeSurname = employeeSurname;
        this.startDate = startDate;
        this.endDate = endDate;
        this.statusDate = statusDate;
        this.status = status;
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

    public LocalDate getStatusDate() {
        return statusDate;
    }

    public void setStatusDate(LocalDate statusDate) {
        this.statusDate = statusDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
