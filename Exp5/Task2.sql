-- 统计各单位不计兼职的薪资总额、月平均薪资、最高薪资、最低薪资、中位薪资,查询结果按总金额降序排序

WITH med_wage AS(
    -- 求出每个人的年均薪资
    WITH person_avg_wage AS (
        SELECT
            c1.c_id,
            w1.w_org,
            AVG(w1.w_amount) AS avg_wage_per_person
        FROM client c1
                 INNER JOIN wage w1 ON c1.c_id = w1.w_c_id
        WHERE w1.w_type = 1
        GROUP BY c1.c_id, w1.w_org
    ),
         -- 用年均薪资排序
         ranked_wages AS (
             SELECT
                 w_org,
                 avg_wage_per_person,
                 ROW_NUMBER() OVER (PARTITION BY w_org ORDER BY avg_wage_per_person) AS rn,
                 COUNT(*) OVER (PARTITION BY w_org) AS total_count
             FROM person_avg_wage
         )
    -- 查找中位数
    SELECT
        w_org,
        ROUND(AVG(avg_wage_per_person), 2) AS median_wage
    FROM ranked_wages
    WHERE
        CASE
            WHEN total_count % 2 = 1 THEN rn = (total_count + 1) / 2
            ELSE rn IN (total_count / 2, total_count / 2 + 1)
            END
    GROUP BY w_org
)
SELECT
    w.w_org,
    SUM(w.w_amount) AS total_amount,
    ROUND(COALESCE(SUM(CASE WHEN w.w_type=1 THEN w.w_amount ELSE 0 END), 0)/COUNT(DISTINCT w_c_id)/COUNT(DISTINCT DATE_FORMAT(w.w_time, '%Y-%m')), 2) AS average_wage,
    MAX(CASE WHEN w.w_type=1 THEN w.w_amount ELSE 0 END) AS max_wage,
    MIN(CASE WHEN w.w_type=1 THEN w.w_amount ELSE 0 END) AS min_wage,
    median_wage AS mid_wage
FROM client AS c
         JOIN wage AS w ON c.c_id=w.w_c_id
         JOIN med_wage m ON w.w_org=m.w_org
WHERE w.w_type=1
GROUP BY w.w_org
ORDER BY total_amount DESC;




/* end of you code */