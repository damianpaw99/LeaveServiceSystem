package edu.ib.database.object;

import edu.ib.EmployeeException;
import edu.ib.database.DatabaseMappable;

import java.time.LocalDate;

/**
 * Class mapping employee from database
 */
public class Employee implements DatabaseMappable {
    /**
     * Employee id
     */
    private Integer id;
    /**
     * Employee name
     */
    private String name;
    /**
     * Employee surname
     */
    private String surname;
    /**
     * Employee date of birth
     */
    private LocalDate birthDate;
    /**
     * Employee email
     */
    private String email;
    /**
     * Employee years of employment
     */
    private Integer employmentYears;

    /**
     * Default constructor
     */
    public Employee(){
    }

    /**
     * Employee complete constructor
     * @param id Employee id
     * @param name Employee name
     * @param surname Employee surname
     * @param birthDate Employee date of birth
     * @param email Employee email
     * @param employmentYears Employee years of employment
     * @throws EmployeeException Exception thrown if one of field values is going to be assigned incorrect data
     */
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

    /**
     * Id getter
     * @return Employee id
     */
    public Integer getId() {
        return id;
    }

    /**
     * Id setter
     * @param id Employee id
     * @throws EmployeeException Thrown, when id value is lower or equal 0
     */
    public void setId(Integer id) throws EmployeeException {
        if(id<=0) throw new EmployeeException("Wrong id value: "+id,0);
        this.id = id;
    }

    /**
     * Name getter
     * @return Employee name
     */
    public String getName() {
        return name;
    }

    /**
     * Name setter
     * @param name Employee name
     * @throws EmployeeException Thrown when name has empty String or name length is larger than 50
     */
    public void setName(String name) throws EmployeeException {
        if(name.isEmpty() || name.length()>50) throw new EmployeeException("Wrong name: "+name,1);
        this.name = name;
    }

    /**
     * Surname getter
     * @return Employee surname
     */
    public String getSurname() {
        return surname;
    }

    /**
     * Surname setter
     * @param surname Surname
     * @throws EmployeeException Thrown when surname has empty String or surname length is larger than 50
     */
    public void setSurname(String surname) throws EmployeeException {
        if(surname.isEmpty() || surname.length()>50) throw new EmployeeException("Wrong surname: "+surname,2);
        this.surname = surname;
    }

    /**
     * Date of birth getter
     * @return Employee date of birth
     */
    public LocalDate getBirthDate() {
        return birthDate;
    }

    /**
     * Date of birth setter
     * @param birthDate Date of birth
     * @throws EmployeeException Thrown when date of birth is after current date
     */
    public void setBirthDate(LocalDate birthDate) throws EmployeeException {
        if(birthDate.isAfter(LocalDate.now())) throw new EmployeeException("Wrong date: "+birthDate.toString(),5);
        this.birthDate = birthDate;
    }

    /**
     * Email getter
     * @return Email
     */
    public String getEmail() {
        return email;
    }

    /**
     * Email setter
     * @param email Email
     * @throws EmployeeException Thrown if email format is incorrect (.+@.+\..+)
     */
    public void setEmail(String email) throws EmployeeException {
        if(!email.matches(".+@.+\\..+")) throw new EmployeeException("Wrong email format",3);
        this.email = email;
    }

    /**
     * Years of employment getter
     * @return Years of employment
     */
    public Integer getEmploymentYears() {
        return employmentYears;
    }

    /**
     * Years of employment setter
     * @param employmentYears Years of employment
     * @throws EmployeeException Thrown if employmentYears value is lower than 0
     */
    public void setEmploymentYears(Integer employmentYears) throws EmployeeException {
        if(employmentYears<0) throw new EmployeeException("Wrong employment years value: "+employmentYears,4);
        this.employmentYears = employmentYears;
    }

}
