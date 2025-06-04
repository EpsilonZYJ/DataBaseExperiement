import java.sql.*;
import java.util.Scanner;

public class Transfer {
    static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://127.0.0.1:3306/finance?allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=UTF8&useSSL=false&serverTimezone=UTC";
    static final String USER = "root";
    static final String PASS = "123123";
    private static final String CARD_QUERY = "SELECT * FROM bank_card WHERE b_number=?;";
    private static final String UPDATE_BALANCE = "UPDATE bank_card SET b_balance=b_balance+? WHERE b_number=?;";
    /**
     * 转账操作
     *
     * @param connection 数据库连接对象
     * @param sourceCard 转出账号
     * @param destCard 转入账号
     * @param amount  转账金额
     * @return boolean
     *   true  - 转账成功
     *   false - 转账失败
     */
    public static boolean transferBalance(Connection connection,
                                          String sourceCard,
                                          String destCard,
                                          double amount){
        try {
            // 事务隔离控制
            connection.setAutoCommit(false);
            connection.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);

            PreparedStatement cardQueryPPS = connection.prepareStatement(CARD_QUERY);

            // 转出账号查询
            cardQueryPPS.setString(1, sourceCard);
            ResultSet sourceResultSet = cardQueryPPS.executeQuery();
            if(!sourceResultSet.next())
                return false;
            String sourceCardType = sourceResultSet.getString("b_type");
            if("信用卡".equals(sourceCardType))
                return false;
            double balance = sourceResultSet.getDouble("b_balance");
            if(balance < amount)
                return false;

            // 转入账号查询
            cardQueryPPS.setString(1, destCard);
            ResultSet destResultSet = cardQueryPPS.executeQuery();
            if(!destResultSet.next())
                return false;
            String destCardType = destResultSet.getString("b_type");

            // 更新余额
            PreparedStatement balanceUpdatePPS = connection.prepareStatement(UPDATE_BALANCE);
            balanceUpdatePPS.setDouble(1, -amount);
            balanceUpdatePPS.setString(2, sourceCard);
            balanceUpdatePPS.executeUpdate();

            if("信用卡".equals(destCardType)){
                balanceUpdatePPS.setDouble(1, -amount);
                balanceUpdatePPS.setString(2, destCard);
                balanceUpdatePPS.executeUpdate();
            }
            else {
                balanceUpdatePPS.setDouble(1, amount);
                balanceUpdatePPS.setString(2, destCard);
                balanceUpdatePPS.executeUpdate();
            }

            connection.commit();
            connection.setAutoCommit(true);
            return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


    }

    // 不要修改main()
    public static void main(String[] args) throws Exception {

        Scanner sc = new Scanner(System.in);
        Class.forName(JDBC_DRIVER);

        Connection connection = DriverManager.getConnection(DB_URL, USER, PASS);

        while(sc.hasNext())
        {
            String input = sc.nextLine();
            if(input.equals(""))
                break;

            String[]commands = input.split(" ");
            if(commands.length ==0)
                break;
            String payerCard = commands[0];
            String  payeeCard = commands[1];
            double  amount = Double.parseDouble(commands[2]);
            if (transferBalance(connection, payerCard, payeeCard, amount)) {
                System.out.println("转账成功。" );
            } else {
                System.out.println("转账失败,请核对卡号，卡类型及卡余额!");
            }
        }
    }

}
