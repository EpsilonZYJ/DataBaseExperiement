-- 4) 	查找相似的理财产品

--   请用一条SQL语句实现该查询：

SELECT
    pro_pif_id,
    cc,
    prank
FROM
    (
        SELECT
            pro_pif_id,
            COUNT(DISTINCT pro_c_id) AS cc,
            DENSE_RANK() OVER (ORDER BY COUNT(DISTINCT pro_c_id) DESC) AS prank
        FROM
            property
        WHERE
            pro_pif_id IN
            (
                SELECT DISTINCT pro_pif_id
                FROM
                    property
                WHERE
                    pro_c_id IN
                    (
                        SELECT DISTINCT pro_c_id
                        FROM property
                        WHERE
                            pro_pif_id=14 AND
                            pro_type=1
                    )
                  AND pro_type=1
            )
          AND pro_pif_id NOT IN(14)
          AND pro_type=1
        GROUP BY pro_pif_id
    ) AS tmp
WHERE prank<=3
ORDER BY prank ASC,
         pro_pif_id ASC;


-- 找出买过14号理财产品的人
# SELECT DISTINCT pro_c_id
# FROM finance.property
#                 WHERE
#                    pro_pif_id=14 AND
#                    pro_type=1

-- 找出买过14号的客户买的其它理财产品
# SELECT DISTINCT pro_pif_id
# FROM
#     finance.property
# WHERE
#     pro_c_id IN
#     (
#         SELECT DISTINCT pro_c_id
#         FROM finance.property
#                 WHERE
#                    pro_pif_id=14 AND
#                    pro_type=1
#     )
#     AND pro_type=1

-- 计算相似度和人数
# SELECT
#     pro_pif_id,
#     COUNT(DISTINCT pro_c_id) AS cc,
#     DENSE_RANK() OVER (ORDER BY COUNT(DISTINCT pro_c_id) DESC) AS prank
# FROM
#     finance.property
# WHERE
#     pro_pif_id IN
#     (
#         SELECT DISTINCT pro_pif_id
#         FROM
#             finance.property
#         WHERE
#             pro_c_id IN
#             (
#                 SELECT DISTINCT pro_c_id
#                 FROM finance.property
#                 WHERE
#                    pro_pif_id=14 AND
#                    pro_type=1
#             )
#           AND pro_type=1
#     )
#    AND pro_pif_id NOT IN(14)
# GROUP BY pro_pif_id



/*  end  of  your code  */