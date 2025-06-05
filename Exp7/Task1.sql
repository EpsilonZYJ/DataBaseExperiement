use finance;
-- 创建包含所有保险资产记录的详细信息的视图v_insurance_detail，包括购买客户的名称、客户的身份证号、保险名称、保障项目、商品状态、商品数量、保险金额、保险年限、商品收益和购买时间。
-- 请用1条SQL语句完成上述任务：

CREATE VIEW
    v_insurance_detail
AS
    SELECT
        c_name,
        c_id_card,
        i_name,
        i_project,
        pro_status,
        pro_quantity,
        i_amount,
        i_year,
        pro_income,
        pro_purchase_time
    FROM
        finance.client AS c
        JOIN finance.property AS p ON c.c_id=p.pro_c_id AND p.pro_type=2
        JOIN finance.insurance AS i ON i.i_id=p.pro_pif_id;


/*   end  of your code  */