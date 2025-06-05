-- 获得兼职总酬劳前三名的客户:

SELECT
    c_name,
    c_id_card,
    SUM(w_amount) AS total_salary
FROM
    client JOIN wage ON client.c_id=wage.w_c_id
WHERE
    w_type=2
GROUP BY c_id
ORDER BY total_salary DESC
    LIMIT 3;


/* end of you code */