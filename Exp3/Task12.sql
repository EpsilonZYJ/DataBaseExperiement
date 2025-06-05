-- 12) 综合客户表(client)、资产表(property)、理财产品表(finances_product)、保险表(insurance)和
--     基金表(fund)，列出客户的名称、身份证号以及投资总金额（即投资本金，
--     每笔投资金额=商品数量*该产品每份金额)，注意投资金额按类型需要查询不同的表，
--     投资总金额是客户购买的各类资产(理财,保险,基金)投资金额的总和，总金额命名为total_amount。
--     查询结果按总金额降序排序。
-- 请用一条SQL语句实现该查询：
SELECT c_name, c_id_card, IFNULL(SUM(t_sum), 0) AS total_amount
FROM client
         LEFT OUTER JOIN
     (
         SELECT pro_c_id, pro_quantity*f_amount AS t_sum
         FROM fund, property
         WHERE fund.f_id=property.pro_pif_id AND property.pro_type=3

         UNION ALL

         SELECT pro_c_id, pro_quantity*i_amount AS t_sum
         FROM insurance, property
         WHERE insurance.i_id=property.pro_pif_id AND property.pro_type=2

         UNION ALL

         SELECT pro_c_id, pro_quantity*p_amount AS t_sum
         FROM finances_product, property
         WHERE finances_product.p_id=property.pro_pif_id AND property.pro_type=1
     ) t_table
     ON t_table.pro_c_id=client.c_id
GROUP BY c_id
ORDER BY total_amount DESC;


/*  end  of  your code  */