-- 5) 查询任意两个客户的相同理财产品数
--   请用一条SQL语句实现该查询：

SELECT
    p1.pro_c_id AS pro_c_id,
    p2.pro_c_id AS pro_c_id,
    COUNT(p1.pro_pif_id) AS total_count
FROM
    property AS p1,
    property AS p2
WHERE
    p1.pro_type=1 AND
    p2.pro_type=1 AND
    p1.pro_pif_id=p2.pro_pif_id AND
    p1.pro_c_id NOT IN(p2.pro_c_id)
GROUP BY p1.pro_c_id, p2.pro_c_id
HAVING COUNT(p1.pro_c_id)>=2
ORDER BY p1.pro_c_id ASC;





/*  end  of  your code  */