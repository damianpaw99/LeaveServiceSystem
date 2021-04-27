package edu.ib;



import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ClassDatabaseMapper<T> {

    private Class<T> tClass;

    public ClassDatabaseMapper(Class<T> tClass){
        if(tClass==null) throw new NullPointerException("tClass can't be null");
        this.tClass=tClass;
    }

    public List<T> getObject(ResultSet resultSet) throws SQLException, IllegalAccessException, InvocationTargetException, InstantiationException, NoSuchMethodException {
        List<T> list=new ArrayList<>();

        Field[] classFields= tClass.getFields();
        int [] columnsId=new int[classFields.length];
        //Method[] methodsList=new Method[classFields.length];
        for(int i=0;i<classFields.length;i++){
            try {
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
                    switch (classFields[columnsId[i]].getClass().getName()){
                        case "Integer":
                            classFields[columnsId[i]].set(temp,resultSet.getInt(columnsId[i]));
                            break;
                        case "String":
                            classFields[columnsId[i]].set(temp,resultSet.getString(columnsId[i]));
                            break;
                        case "Double":
                            classFields[columnsId[i]].set(temp,resultSet.getDouble(columnsId[i]));
                            break;
                        case "Boolean":
                            classFields[columnsId[i]].set(temp,resultSet.getBoolean(columnsId[i]));
                            break;
                        case "LocalDate":
                            classFields[columnsId[i]].set(temp, LocalDate.parse(resultSet.getDate(columnsId[i]).toString()));
                            break;
                        case "LocalDateTime":
                            classFields[columnsId[i]].set(temp, LocalDateTime.parse(resultSet.getDate(columnsId[i]).toString()));
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
