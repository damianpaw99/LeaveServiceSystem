package edu.ib;

public class EmployeeException extends Exception{

    private final int code;

    public EmployeeException(String msg, int code){
        super(msg);
        this.code=code;
    }

    public int getCode() {
        return code;
    }
}
