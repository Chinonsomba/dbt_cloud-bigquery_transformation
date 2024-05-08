SELECT 
  o.gender,
  SUM(oi.sale_price * o.num_of_item) AS total_revenue,
  SUM(o.num_of_item) AS total_quantity
FROM {{ref('stgOrders')}} AS o
JOIN {{ref('stgorderitems')}} AS oi ON oi.order_id = o.order_id
WHERE oi.status NOT IN ('Cancelled', 'Returned')
GROUP BY o.gender
ORDER BY total_revenue DESC


