-- 1) 查询销售总额前三的理财产品
--   请用一条SQL语句实现该查询：

SELECT
    pyear,
    rk,
    p_id,
    sumamount
FROM
    (
        SELECT
            YEAR(pro_purchase_time) AS pyear,
            RANK() OVER (PARTITION BY YEAR(pro_purchase_time)
            ORDER BY SUM(finances_product.p_amount*property.pro_quantity) DESC) AS rk,
            p_id,
            SUM(finances_product.p_amount*property.pro_quantity) sumamount
        FROM
            finances_product,
            property
        WHERE
            pro_type=1 AND
            YEAR(pro_purchase_time) IN (2010, 2011) AND
            finances_product.p_id=property.pro_pif_id
        GROUP BY YEAR(pro_purchase_time), p_id
    ) table1
WHERE rk<=3
ORDER BY pyear ASC,
         rk ASC,
         p_id ASC;






/*  end  of  your code  */