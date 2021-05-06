package edu.ib.database.object;

import edu.ib.EmployeeException;
import edu.ib.database.DatabaseMappable;

import java.time.LocalDate;

public class Employee implements DatabaseMappable {

    private Integer id;
    private String name;
    private String surname;
    private LocalDate birthDate;
    private String email;
    private Integer employmentYears;

    public Employee(){
    }

    public Employee(Integer id, String name, String surname, LocalDate birthDate, String email, int employmentYears) throws EmployeeException {
        if(!email.matches(".+@.+\\..+")) throw new EmployeeException("Wrong email format",3);
        if(id<=0) throw new EmployeeException("Wrong id value: "+id,0);
        if(name.isEmpty() || name.length()>50) throw new EmployeeException("Wrong name: "+name,1);
        if(surname.isEmpty() || surname.length()>50) throw new EmployeeException("Wrong surname: "+surname,2);
        if(employmentYears<0) throw new EmployeeException("Wrong employment years value: "+employmentYears,4);
        this.id = id;
        this.name = name;
        this.surname = surname;
        if(birthDate.isAfter(LocalDate.now())) throw new EmployeeException("Wrong date"+birthDate.toString(),5);
        this.birthDate = birthDate;
        this.email = email;
        this.employmentYears = employmentYears;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) throws EmployeeException {
        if(id<=0) throw new EmployeeException("Wrong id value: "+id,0);
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) throws EmployeeException {
        if(name.isEmpty() || name.length()>50) throw new EmployeeException("Wrong name: "+name,1);
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) throws EmployeeException {
        if(surname.isEmpty() || surname.length()>50) throw new EmployeeException("Wrong surname: "+surname,2);
        this.surname = surname;
    }

    public LocalDate getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(LocalDate birthDate) throws EmployeeException {
        if(birthDate.isAfter(LocalDate.now())) throw new EmployeeException("Wrong date: "+birthDate.toString(),5);
        this.birthDate = birthDate;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) throws EmployeeException {
        if(!email.matches(".+@.+\\..+")) throw new EmployeeException("Wrong email format",3);
        this.email = email;
    }

    public Integer getEmploymentYears() {
        return employmentYears;
    }

    public void setEmploymentYears(Integer employmentYears) throws EmployeeException {
        if(employmentYears<0) throw new EmployeeException("Wrong employment years value: "+employmentYears,4);
        this.employmentYears = employmentYears;
    }

}
