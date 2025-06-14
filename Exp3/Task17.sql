-- 17 查询2022年2月购买基金的高峰期。至少连续三个交易日，所有投资者购买基金的总金额超过100万(含)，则称这段连续交易日为投资者购买基金的高峰期。只有交易日才能购买基金,但不能保证每个交易日都有投资者购买基金。2022年春节假期之后的第1个交易日为2月7日,周六和周日是非交易日，其余均为交易日。请列出高峰时段的日期和当日基金的总购买金额，按日期顺序排序。总购买金额命名为total_amount。
--    请用一条SQL语句实现该查询：


SELECT pro_purchase_time, total_amount
FROM(
        SELECT pro_purchase_time, total_amount, time_rank
        FROM(
                SELECT
                    pro_purchase_time,
                    SUM(pro_quantity*f_amount) AS total_amount,
                    WEEK(pro_purchase_time)*5+DAYOFWEEK(pro_purchase_time) AS time_rank
                FROM property, fund
                WHERE
                    property.pro_pif_id=fund.f_id AND
                    property.pro_type=3 AND
                    MONTH(pro_purchase_time)=2
                GROUP BY pro_purchase_time
            ) table1
        WHERE
            total_amount>=1000000
    ) table2
WHERE
    (
        time_rank - 1 IN (
            SELECT time_rank
            FROM (
                     SELECT
                         pro_purchase_time,
                         SUM(pro_quantity*f_amount) AS total_amount,
                         WEEK(pro_purchase_time)*5+DAYOFWEEK(pro_purchase_time) AS time_rank
                     FROM property, fund
                     WHERE
                         property.pro_pif_id=fund.f_id AND
                         property.pro_type=3
                     GROUP BY pro_purchase_time
                 ) table1
            WHERE total_amount >= 1000000
        )
            AND
        time_rank + 1 IN (
            SELECT time_rank
            FROM (
                     SELECT
                         pro_purchase_time,
                         SUM(pro_quantity*f_amount) AS total_amount,
                         WEEK(pro_purchase_time)*5+DAYOFWEEK(pro_purchase_time) AS time_rank
                     FROM property, fund
                     WHERE
                         property.pro_pif_id=fund.f_id AND
                         property.pro_type=3
                     GROUP BY pro_purchase_time
                 ) table1
            WHERE total_amount >= 1000000
        )
        )
   OR (
    time_rank - 1 IN (
        SELECT time_rank
        FROM (
                 SELECT
                     pro_purchase_time,
                     SUM(pro_quantity*f_amount) AS total_amount,
                     WEEK(pro_purchase_time)*5+DAYOFWEEK(pro_purchase_time) AS time_rank
                 FROM property, fund
                 WHERE
                     property.pro_pif_id=fund.f_id AND
                     property.pro_type=3
                 GROUP BY pro_purchase_time
             ) table1
        WHERE total_amount >= 1000000
    )
        AND
    time_rank - 2 IN (
        SELECT time_rank
        FROM (
                 SELECT
                     pro_purchase_time,
                     SUM(pro_quantity*f_amount) AS total_amount,
                     WEEK(pro_purchase_time)*5+DAYOFWEEK(pro_purchase_time) AS time_rank
                 FROM property, fund
                 WHERE
                     property.pro_pif_id=fund.f_id AND
                     property.pro_type=3
                 GROUP BY pro_purchase_time
             ) table1
        WHERE total_amount >= 1000000
    )
    )
   OR (
    time_rank + 1 IN (
        SELECT time_rank
        FROM (
                 SELECT
                     pro_purchase_time,
                     SUM(pro_quantity*f_amount) AS total_amount,
                     WEEK(pro_purchase_time)*5+DAYOFWEEK(pro_purchase_time) AS time_rank
                 FROM property, fund
                 WHERE
                     property.pro_pif_id=fund.f_id AND
                     property.pro_type=3
                 GROUP BY pro_purchase_time
             ) table1
        WHERE total_amount >= 1000000
    )
        AND
    time_rank + 2 IN (
        SELECT time_rank
        FROM (
                 SELECT
                     pro_purchase_time,
                     SUM(pro_quantity*f_amount) AS total_amount,
                     WEEK(pro_purchase_time)*5+DAYOFWEEK(pro_purchase_time) AS time_rank
                 FROM property, fund
                 WHERE
                     property.pro_pif_id=fund.f_id AND
                     property.pro_type=3
                 GROUP BY pro_purchase_time
             ) table1
        WHERE total_amount >= 1000000
    )
    );




/*  end  of  your code  */