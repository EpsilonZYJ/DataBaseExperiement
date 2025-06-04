-- 13) 综合客户表(client)、资产表(property)、理财产品表(finances_product)、
--     保险表(insurance)、基金表(fund)和投资资产表(property)，
--     列出所有客户的编号、名称和总资产，总资产命名为total_property。
--     总资产为储蓄卡余额，投资总额，投资总收益的和，再扣除信用卡透支的金额
--     (信用卡余额即为透支金额)。客户总资产包括被冻结的资产。
--    请用一条SQL语句实现该查询：

SELECT
    c_id, c_name,
    IFNULL(SUM(tt_sum), 0) + IFNULL(SUM(balance_sum), 0)
        - IFNULL(SUM(over_sum), 0) + IFNULL(SUM(income_sum), 0) AS total_property
FROM finance.client
LEFT OUTER JOIN
     (
         SELECT pro_c_id, SUM(t_sum) AS tt_sum
         FROM
             (
                 SELECT pro_c_id, SUM(pro_quantity*f_amount) AS t_sum
                 FROM finance.fund, finance.property
                 WHERE fund.f_id=property.pro_pif_id AND property.pro_type=3
                 GROUP BY pro_c_id

                 UNION ALL

                 SELECT pro_c_id, SUM(pro_quantity*i_amount) AS t_sum
                 FROM finance.insurance, finance.property
                 WHERE insurance.i_id=property.pro_pif_id AND property.pro_type=2
                 GROUP BY pro_c_id

                 UNION ALL

                 SELECT pro_c_id, SUM(pro_quantity*p_amount) AS t_sum
                 FROM finance.finances_product, finance.property
                 WHERE finances_product.p_id=property.pro_pif_id AND property.pro_type=1
                 GROUP BY pro_c_id
             ) AS tt_table
         GROUP BY pro_c_id
     ) t_table
     ON t_table.pro_c_id=client.c_id
LEFT OUTER JOIN
    (
        SELECT b_c_id, SUM(b_balance) AS balance_sum
        FROM finance.bank_card
        WHERE b_type='储蓄卡'
        GROUP BY b_c_id
    ) balance_table
    ON balance_table.b_c_id=client.c_id
LEFT OUTER JOIN
    (
        SELECT b_c_id, SUM(b_balance) AS over_sum
        FROM finance.bank_card
        WHERE  b_type='信用卡'
        GROUP BY b_c_id
    ) over_table
    ON over_table.b_c_id=client.c_id
LEFT OUTER JOIN
    (
        SELECT pro_c_id, SUM(pro_income) AS income_sum
        FROM finance.property
        GROUP BY pro_c_id
    ) income_table
    ON income_table.pro_c_id=client.c_id
GROUP BY c_id;





/*  end  of  your code  */