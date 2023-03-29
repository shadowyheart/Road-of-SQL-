;WITH most_recent_ticket_purchase_history AS
    (
    SELECT r.customer_id,
    d.dim_draw_id,
    d.draw_no,
    SUM(w.wager_commission + w.wager_cost) AS total_value,
     LAG(SUM(w.wager_commission + w.wager_cost)) OVER( ORDER BY r.customer_id,d.draw_no) AS pivdrawvalue,
    RANK() OVER(PARTITION BY r.customer_id ORDER BY d.draw_no desc) as draw_purchase_order
FROM [Ticket Sales] r
LEFT JOIN Draw d ON r.dim_draw_id = d.dim_draw_id
LEFT JOIN Wager w ON w.ticket_id = r.ticket_id
GROUP BY r.customer_id, d.dim_draw_id, d.draw_no
)
SELECT customer_id,
        concat(ISNULL([195],0),ISNULL([196],0),ISNULL([197],0),ISNULL([198],0),ISNULL([199],0),ISNULL([200],0),
        ISNULL([201],0),ISNULL([202],0),ISNULL([203],0),ISNULL([204],0),ISNULL([205],0)) AS col8
FROM 
(SELECT piv.customer_id, rec.draw_no AS drawNo, 
      CASE WHEN rec.draw_no is NULL then 0 ELSE 1 END AS indraw,
      CASE WHEN total_value = pivdrawvalue THEN 0 
           WHEN total_value > pivdrawvalue THEN '+'
           WHEN total_value < pivdrawvalue THEN '-'
        END AS value_change
FROM
(SELECT
d.draw_no, h.customer_id
FROM (SELECT draw_no FROM Draw WHERE draw_no between 195 and 205) d CROSS APPLY (SELECT customer_id FROM Customer
) h ) piv
LEFT JOIN most_recent_ticket_purchase_history rec ON piv.draw_no = rec.draw_no AND piv.customer_id = rec.customer_id --ORDER BY h.customer_id, d.draw_no DESC
) rowstable
PIVOT (
    MAX(rowstable.value_change)
    FOR rowstable.drawNo IN ([195], [196], [197], [198], [199], [200], [201], [202], [203], [204], [205])
) AS p
ORDER BY p.customer_id


;WITH most_recent_ticket_purchase_history AS
    (
    SELECT r.customer_id,
    d.dim_draw_id,
    d.draw_no,
    SUM(w.wager_commission + w.wager_cost) AS total_value,
    LAG(SUM(w.wager_commission + w.wager_cost)) OVER( ORDER BY r.customer_id,d.draw_no) AS pivdrawvalue,
    RANK() OVER(PARTITION BY r.customer_id ORDER BY d.draw_no desc) as draw_purchase_order
FROM [Ticket Sales] r
LEFT JOIN Draw d ON r.dim_draw_id = d.dim_draw_id
LEFT JOIN Wager w ON w.ticket_id = r.ticket_id
GROUP BY r.customer_id, d.dim_draw_id, d.draw_no
)
SELECT * 
FROM 
(SELECT piv.customer_id, rec.draw_no AS drawNo, 
      CASE WHEN rec.draw_no is NULL then 0 ELSE 1 END AS indraw,
      CASE WHEN total_value = pivdrawvalue THEN 0 
           WHEN total_value > pivdrawvalue THEN '+'
           WHEN total_value < pivdrawvalue THEN '-'
        END AS value_change
FROM
(SELECT
d.draw_no, h.customer_id
FROM (SELECT draw_no FROM Draw WHERE draw_no between 195 and 205) d CROSS APPLY (SELECT customer_id FROM Customer
) h ) piv
LEFT JOIN most_recent_ticket_purchase_history rec ON piv.draw_no = rec.draw_no AND piv.customer_id = rec.customer_id --ORDER BY h.customer_id, d.draw_no DESC
) rowstable
PIVOT (
    MAX(rowstable.value_change)
    FOR [rowstable.drawNo] IN ([195], [196], [197], [198], [199], [200], [201], [202], [203], [204], [205])
) AS p
ORDER BY p.customer_id