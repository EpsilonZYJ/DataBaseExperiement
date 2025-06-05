-- 对身份证号为C的客户2024年的酬劳代扣税

UPDATE wage w
    JOIN client c ON w.w_c_id = c.c_id
    JOIN (
        SELECT
            w_c_id,
            SUM(w_amount) as total_salary,
            GREATEST(SUM(w_amount) - 60000, 0) * 0.2 as total_tax
        FROM wage
                 JOIN client ON wage.w_c_id = client.c_id
        WHERE client.c_id_card = '420108199702144323'
          AND YEAR(wage.w_time) = 2023
        GROUP BY w_c_id
    ) tax_calc ON w.w_c_id = tax_calc.w_c_id
SET
    w.w_amount = w.w_amount - (tax_calc.total_tax * (w.w_amount / tax_calc.total_salary)),
    w.w_tax = IF(tax_calc.total_tax > 0, 'Y', 'N')
WHERE
    c.c_id_card = '420108199702144323'
  AND YEAR(w.w_time) = 2023;



/* end of you code */