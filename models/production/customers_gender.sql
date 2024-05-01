SELECT 
  o.gender,
  SUM(oi.sale_price*o.num_of_item) total_revenue,
  SUM(o.num_of_item) total_quantity
FROM {{ref("stgorderitems")}} AS oi
LEFT JOIN{{ref("stgOrders")}} AS o
ON oi.order_id = o.order_id
WHERE oi.status NOT IN ('Cancelled','Returned')
GROUP BY gender
ORDER BY total_revenue DESC