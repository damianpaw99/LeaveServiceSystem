package edu.ib.database;



import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Class mapping data from resultSet (columns in resultSet name has to have the same name as T class fields)
 * @param <T> Class to which object will be mapped
 */
public class ClassDatabaseMapper<T extends DatabaseMappable> {
    /**
     * Class to which object will be mapped
     */
    private Class<T> tClass;

    /**
     * Basic constructor
     * @param tClass Class to which object will be mapped
     */
    public ClassDatabaseMapper(Class<T> tClass){
        if(tClass==null) throw new NullPointerException("tClass can't be null");
        this.tClass=tClass;
    }

    /**
     * Method creating List of T objects from resultSet
     * @param resultSet Resultset with data from database
     * @return List ob T objects
     * @throws SQLException
     * @throws IllegalAccessException
     * @throws InvocationTargetException
     * @throws InstantiationException
     * @throws NoSuchMethodException
     */
    public List<T> getObject(ResultSet resultSet) throws SQLException, IllegalAccessException, InvocationTargetException, InstantiationException, NoSuchMethodException {
        List<T> list=new ArrayList<>();

        Field[] classFields= tClass.getDeclaredFields();
        int [] columnsId=new int[classFields.length];
        //Method[] methodsList=new Method[classFields.length];
        for(int i=0;i<classFields.length;i++){
            try {
                classFields[i].setAccessible(true);
                columnsId[i] = resultSet.findColumn(classFields[i].getName());
            } catch(SQLException e){
                e.getStackTrace();
                columnsId[i]=-1;
            }
            //String methodName="get"+classFields[i].getName().substring(0,1).toUpperCase()+classFields[i].getName().substring(1, classFields.length);
            //methodsList[i]= object.getMethod("get"+classFields[i].getName(),classFields[i].getType());
        }
        while(resultSet.next()){
            T temp= (T) tClass.getConstructor().newInstance();
            for(int i=0;i<columnsId.length;i++){
                if(columnsId[i]!=-1){
                    String test=classFields[i].getType().getSimpleName();
                    switch (classFields[i].getType().getSimpleName()){
                        case "Integer":
                            classFields[i].set(temp,resultSet.getInt(columnsId[i]));
                            break;
                        case "String":
                            classFields[i].set(temp,resultSet.getString(columnsId[i]));
                            break;
                        case "Double":
                            classFields[i].set(temp,resultSet.getDouble(columnsId[i]));
                            break;
                        case "Boolean":
                            classFields[i].set(temp,resultSet.getBoolean(columnsId[i]));
                            break;
                        case "LocalDate":
                            classFields[i].set(temp, LocalDate.parse(resultSet.getDate(columnsId[i]).toString()));
                            break;
                        case "LocalDateTime":
                            classFields[i].set(temp, LocalDateTime.parse(resultSet.getTimestamp(columnsId[i]).toString(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.n")));
                            break;
                        default:
                            throw new IllegalArgumentException("Błąd klasy");
                    }

                }
            }
            list.add(tClass.cast(temp));
        }
        return list;
    }

}
