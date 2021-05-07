package edu.ib;

/**
 * Exception used by Employee class, used to signalise, when value of field to be set is incorrect
 */
public class EmployeeException extends Exception{
    /**
     * Code of error
     */
    private final int code;

    /**
     * Basic constructor
     * @param msg Message
     * @param code Code of exception
     */
    public EmployeeException(String msg, int code){
        super(msg);
        this.code=code;
    }

    /**
     * Code of error getter
     * @return Code of error
     */
    public int getCode() {
        return code;
    }
}
