SELECT customer_id, [col1] + [col2] AS col3
FROM 
(SELECT '12341234' AS customer_id,
    '205' AS draw_no,
    '1' AS History
UNION ALL 
SELECT '12341234' AS customer_id,
    '204' AS draw_no,
    '1' AS History) HistoryTable
PIVOT (
    MAX(HistoryTable.History)
    FOR draw_no IN ( [col1], [col2] )
) AS pv