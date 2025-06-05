-- 2) 投资积极且偏好理财类产品的客户
--   请用一条SQL语句实现该查询：

SELECT DISTINCT table1.pro_c_id AS pro_c_id
FROM
    (
        SELECT pro_c_id, COUNT(DISTINCT pro_pif_id) AS ptype_num
        FROM property
        WHERE property.pro_type=1
        GROUP BY pro_c_id
    )table1
        LEFT OUTER JOIN
    (
        SELECT pro_c_id, COUNT(DISTINCT pro_pif_id) AS ftype_num
        FROM property
        WHERE property.pro_type=3
        GROUP BY pro_c_id
    )table2
    ON table1.pro_c_id=table2.pro_c_id
WHERE
    ptype_num>=3 AND
    ftype_num<ptype_num
ORDER BY pro_c_id ASC;



/*  end  of  your code  */