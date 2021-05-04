package edu.ib.database.object;

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

    public Employee(Integer id, String name, String surname, LocalDate birthDate, String email, int employmentYears) {
        if(!email.matches(".+@.\\.+.+")) throw new IllegalArgumentException("Wrong email format:" + email);
        if(id<=0) throw new IllegalArgumentException("Wrong id value: "+id);
        if(name.isEmpty() || name.length()>50) throw new IllegalArgumentException("Wrong name: "+name);
        if(surname.isEmpty() || surname.length()>50) throw new IllegalArgumentException("Wrong surname: "+surname);
        if(employmentYears<0) throw new IllegalArgumentException("Wrong employment years value: "+employmentYears);
        this.id = id;
        this.name = name;
        this.surname = surname;
        this.birthDate = birthDate;
        this.email = email;
        this.employmentYears = employmentYears;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        if(id<=0) throw new IllegalArgumentException("Wrong id value: "+id);
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        if(name.isEmpty() || name.length()>50) throw new IllegalArgumentException("Wrong name: "+name);
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        if(surname.isEmpty() || surname.length()>50) throw new IllegalArgumentException("Wrong surname: "+surname);
        this.surname = surname;
    }

    public LocalDate getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(LocalDate birthDate) {
        this.birthDate = birthDate;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        if(!email.matches(".+@.\\.+.+")) throw new IllegalArgumentException("Wrong email format");
        this.email = email;
    }

    public Integer getEmploymentYears() {
        return employmentYears;
    }

    public void setEmploymentYears(Integer employmentYears) {
        if(employmentYears<0) throw new IllegalArgumentException("Wrong employment years value: "+employmentYears);
        this.employmentYears = employmentYears;
    }

}
