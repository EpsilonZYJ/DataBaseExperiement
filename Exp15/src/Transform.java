import java.sql.*;

public class Transform {
    static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://127.0.0.1:3306/sparsedb?allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=UTF8&useSSL=false&serverTimezone=UTC";
    static final String USER = "root";
    static final String PASS = "123123";
    private static final String INSERT_SQL = "INSERT INTO sc VALUE(?, ?, ?);";
    private static final String QUERY_SQL = "SELECT * FROM entrance_exam;";
    private static final String[] subjectArray = {"chinese", "math", "English", "physics", "chemistry", "biology", "history", "geography", "politics"};

    /**
     * 向sc表中插入数据
     *
     */
    public static int insertSC(Connection connection, int sno, String col_name, String col_value){
        int ret = 0;
        try {
            PreparedStatement pps = connection.prepareStatement(INSERT_SQL);
            pps.setInt(1, sno);
            pps.setString(2, col_name);
            pps.setString(3, col_value);
            ret = pps.executeUpdate();
            pps.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return ret;
    }

    public static void main(String[] args) throws SQLException {
        Connection connection = null;

        try {
            Class.forName(JDBC_DRIVER);
            connection = DriverManager.getConnection(DB_URL, USER, PASS);
            Statement entrancePPS = connection.createStatement();
            ResultSet rawData = entrancePPS.executeQuery(QUERY_SQL);
            while(rawData.next()){
                int sno = rawData.getInt("sno");
                for(String sname: subjectArray){
                    String value = rawData.getString(sname);
                    if(value != null)
                        insertSC(connection, sno, sname.toLowerCase(), value);
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        } finally{
            if(connection != null){
                connection.close();
            }
        }
    }
}