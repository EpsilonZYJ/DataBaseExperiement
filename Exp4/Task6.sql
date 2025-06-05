-- 6) 查找相似的理财客户
--   请用一条SQL语句实现该查询：







SELECT
    pac,
    pbc,
    common,
    crank
FROM
    (
        SELECT
            p1.pro_c_id AS pac,
            p2.pro_c_id AS pbc,
            COUNT(DISTINCT p1.pro_pif_id) AS common,
            DENSE_RANK() OVER(PARTITION BY p1.pro_c_id
                ORDER BY COUNT(DISTINCT p1.pro_c_id) DESC, p2.pro_c_id ASC) AS crank
        FROM
            property AS p1,
            property AS p2
        WHERE
            p1.pro_type=1 AND
            p2.pro_type=1 AND
            p1.pro_pif_id=p2.pro_pif_id AND
            p1.pro_c_id NOT IN(p2.pro_c_id)
        GROUP BY p1.pro_c_id, p2.pro_c_id
    ) AS similar_table
WHERE
    crank<3
ORDER BY pac ASC,
         crank ASC;




/*  end  of  your code  */