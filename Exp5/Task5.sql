-- 用一条SQL语句将new_wage表的全部酬劳信息插入到薪资表(wage)


INSERT INTO wage
(
    w_c_id,
    w_amount,
    w_org,
    w_time,
    w_type,
    w_memo,
    w_tax
)
WITH deduplicated AS (
    -- 去重
    SELECT DISTINCT
        c_id_card,
        w_amount,
        w_org,
        w_time,
        w_type,
        w_memo
    FROM new_wage
)
SELECT * FROM (
                  -- 处理全职记录
                  SELECT
                      c.c_id AS w_c_id,
                      d.w_amount,
                      d.w_org,
                      d.w_time,
                      d.w_type,
                      d.w_memo,
                      'N' AS w_tax
                  FROM
                      deduplicated d
                          JOIN client c ON d.c_id_card = c.c_id_card
                  WHERE d.w_type = 1

                  UNION ALL

                  -- 处理兼职记录
                  SELECT
                      c.c_id AS w_c_id,
                      SUM(d.w_amount) AS w_amount,
                      d.w_org,
                      MIN(d.w_time) AS w_time,
                      d.w_type,
                      GROUP_CONCAT(d.w_memo ORDER BY d.w_time) AS w_memo,
                      'N' AS w_tax
                  FROM
                      deduplicated d
                          JOIN client c ON d.c_id_card = c.c_id_card
                  WHERE d.w_type = 2
                  GROUP BY
                      c.c_id,
                      d.w_org,
                      d.w_type,
                      DATE_FORMAT(d.w_time, '%Y-%m')
              ) AS combined_result
ORDER BY
    w_c_id,
    w_org,
    w_time;



/* end of you code */