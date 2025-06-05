-- 找兼职酬劳的前三单位,降序输出,不需要考虑并列排名情形

SELECT
    w_org,
    SUM(w_amount) AS total_salary
FROM
    client AS c
    JOIN wage AS w ON c.c_id=w.w_c_id
WHERE
    w.w_type=2
GROUP BY w.w_org
ORDER BY total_salary DESC
LIMIT 3;


/* end of you code */