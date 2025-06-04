use finance1;
-- 请用一条SQL语句删除client表中没有银行卡的客户信息：

DELETE FROM client WHERE NOT EXISTS(
    SELECT * FROM bank_card WHERE b_c_id=client.c_id
);

/* the end of your code */