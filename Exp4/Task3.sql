-- 3) 查询购买了所有畅销理财产品的客户
--   请用一条SQL语句实现该查询：



SELECT DISTINCT pro_c_id
FROM finance.property AS p_query
WHERE
    pro_type=1 AND
    NOT EXISTS(
        SELECT pro_pif_id
        FROM
            (
                SELECT pro_pif_id
                FROM finance.property
                WHERE pro_type=1
                GROUP BY pro_pif_id
                HAVING COUNT(DISTINCT pro_c_id)>2
            ) AS popular_products
        WHERE pro_pif_id NOT IN
              (
                  SELECT pro_pif_id
                  FROM finance.property AS p_tmp
                  WHERE
                      pro_type=1 AND
                      p_tmp.pro_c_id=p_query.pro_c_id
              )
    )
ORDER BY pro_c_id ASC;


/*  end  of  your code  */