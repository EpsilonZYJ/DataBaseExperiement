-- 8) 查询持有两张(含）以上信用卡的用户的名称、身份证号、手机号。
--    请用一条SQL语句实现该查询：


# SELECT c_name, c_id_card, c_phone FROM finance.client WHERE(
#     SELECT b_c_id=client.c_id, COUNT(*) >= 2 FROM finance.bank_card WHERE(
#         b_type='信用卡'
#                                                             )
#     GROUP BY b_c_id=client.c_id
#                                                                );

SELECT c_name, c_id_card, c_phone FROM finance.client WHERE(
    client.c_id IN(
        SELECT b_c_id FROM finance.bank_card WHERE(
            b_type='信用卡'
                                                      ) GROUP BY b_c_id
        HAVING COUNT(*)>=2
        )
                                                               );



/*  end  of  your code  */