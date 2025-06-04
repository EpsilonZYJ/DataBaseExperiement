-- 19) 以日历表格式列出2022年2月每周每日基金购买总金额，输出格式如下：
-- week_of_trading Monday Tuesday Wednesday Thursday Friday
--               1
--               2
--               3
--               4
--   请用一条SQL语句实现该查询：

SELECT
    week_of_trading,
    SUM(IF(dfw=2, total_amount, NULL)) Monday,
    SUM(IF(dfw=3, total_amount, NULL)) Tuesday,
    SUM(IF(dfw=4, total_amount, NULL)) Wednesday,
    SUM(IF(dfw=5, total_amount, NULL)) Thursday,
    SUM(IF(dfw=6, total_amount, NULL)) Friday
FROM(
        SELECT
            WEEK(pro_purchase_time)-WEEK('2022-02-01') week_of_trading,
            DAYOFWEEK(pro_purchase_time) dfw,
            SUM(pro_quantity*f_amount) AS total_amount
        FROM finance.property, finance.fund
        WHERE
            property.pro_pif_id=fund.f_id AND
            property.pro_type=3 AND
            pro_purchase_time LIKE '2022-02-%'
        GROUP BY pro_purchase_time
    ) table1
GROUP BY week_of_trading;





/*  end  of  your code  */