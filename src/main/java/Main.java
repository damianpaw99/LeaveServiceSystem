import edu.ib.database.DBUtil;
import edu.ib.database.DBUtilLeave;

import java.sql.SQLException;

public class Main {
    public static void main(String[] args) {
        DBUtilLeave util=new DBUtilLeave("root","z3!95aDx8","jdbc:mysql://localhost:3306/leave_system?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=CET");
        try {
            util.getAllLeaves();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

    }
}
