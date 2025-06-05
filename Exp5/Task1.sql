-- 将客户年度从各单位获得的酬劳进行排序

SELECT
    c_name,
    EXTRACT(YEAR FROM w.w_time) AS year,
    c_id_card,
    COALESCE(SUM(CASE WHEN w.w_type = 1 THEN w.w_amount ELSE 0 END), 0) AS full_t_amount,
    COALESCE(SUM(CASE WHEN w.w_type = 2 THEN w.w_amount ELSE 0 END), 0) AS part_t_amount
FROM
    client AS c
        JOIN wage AS w ON c.c_id = w.w_c_id
GROUP BY
    c.c_name,
    EXTRACT(YEAR FROM w.w_time),
ORDER BY
    full_t_amount+part_t_amount DESC;


/* end of you code */