;WITH most_recent_ticket_purchase_history AS
    (
    SELECT r.customer_id,
    d.dim_draw_id,
    d.draw_no,
    SUM(w.wager_commission + w.wager_cost) AS total_value,
    RANK() OVER(PARTITION BY r.customer_id ORDER BY d.draw_no desc) as draw_purchase_order
FROM [Ticket Sales] r
LEFT JOIN Draw d ON r.dim_draw_id = d.dim_draw_id
LEFT JOIN Wager w ON w.ticket_id = r.ticket_id
GROUP BY r.customer_id, d.dim_draw_id, d.draw_no
)
SELECT customer_id,
        concat(ISNULL([col1],0),ISNULL([col2],0),ISNULL([col3],0),ISNULL([col4],0),ISNULL([col5],0),ISNULL([col6],0),
        ISNULL([col7],0),ISNULL([col8],0),ISNULL([col9],0),ISNULL([col10],0),ISNULL([col11],0)) AS col12
FROM 
(SELECT piv.customer_id, rec.draw_no AS drawNo, 
      CASE WHEN rec.draw_no is NULL then 0 ELSE 1 END AS indraw
FROM
(SELECT
d.draw_no, h.customer_id
FROM (SELECT draw_no FROM Draw WHERE draw_no between 195 and 205) d CROSS APPLY (SELECT customer_id FROM Customer
) h ) piv
LEFT JOIN most_recent_ticket_purchase_history rec ON piv.draw_no = rec.draw_no AND piv.customer_id = rec.customer_id --ORDER BY h.customer_id, d.draw_no DESC
) rowstable
PIVOT (
    MAX(rowstable.indraw)
    FOR rowstable.drawNo IN ([col1], [col2], [col3], [col4], [col5], [col6], [col7], [col8], [col9], [col10], [col11])
) AS p
ORDER BY p.customer_id