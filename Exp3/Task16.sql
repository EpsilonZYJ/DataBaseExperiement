-- 16) 查询持有相同基金组合的客户对，如编号为A的客户持有的基金，编号为B的客户也持有，反过来，编号为B的客户持有的基金，编号为A的客户也持有，则(A,B)即为持有相同基金组合的二元组，请列出这样的客户对。为避免过多的重复，如果(1,2)为满足条件的元组，则不必显示(2,1)，即只显示编号小者在前的那一对，这一组客户编号分别命名为c_id1,c_id2。

-- 请用一条SQL语句实现该查询：

-- 查询两者相交的总数

SELECT DISTINCT
    a.pro_c_id AS c_id1,
    b.pro_c_id AS c_id2
FROM finance.property a
CROSS JOIN finance.property b
WHERE a.pro_type=3 AND
      b.pro_type=3 AND
      a.pro_c_id<b.pro_c_id AND
      NOT EXISTS(
          SELECT *
          FROM finance.property a1
          WHERE a1.pro_type=3 AND
                a1.pro_c_id=a.pro_c_id AND
                NOT EXISTS(
                    SELECT *
                    FROM finance.property b1
                    WHERE b1.pro_type=3 AND
                          b1.pro_c_id=b.pro_c_id AND
                          b1.pro_pif_id=a1.pro_pif_id
                )
      )AND
      NOT EXISTS(
          SELECT *
          FROM finance.property b2
          WHERE b2.pro_type=3 AND
                b2.pro_c_id=b.pro_c_id AND
                NOT EXISTS(
                    SELECT *
                    FROM finance.property a2
                    WHERE a2.pro_type=3 AND
                          a2.pro_c_id=a.pro_c_id AND
                          a2.pro_pif_id=b2.pro_pif_id
                )
      );





/*  end  of  your code  */