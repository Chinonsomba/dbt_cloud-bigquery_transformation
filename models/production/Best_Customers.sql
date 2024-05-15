
SELECT 
  oi.user_id,
  u.email,
  SUM(oi.sale_price*o.num_of_item) total_purchase
FROM{{ref("stgorderitems")}} oi
  LEFT JOIN {{ref("stgUsers")}} u ON oi.user_id = u.id
    JOIN {{ref("stgOrders")}} o ON oi.order_id = o.order_id
WHERE oi.status NOT IN ('Cancelled','Returned')
GROUP BY 1, 2
ORDER BY 3 DESC