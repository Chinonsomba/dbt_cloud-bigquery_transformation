SELECT
  u.country AS country,
  SUM(oi.sale_price * o.num_of_item) AS total_revenue,
  SUM(o.num_of_item) AS total_quantity_ordered
FROM {{ref('stgorderitems')}} AS oi
INNER JOIN {{ref('stgUsers')}} AS u  
ON oi.user_id = u.id
INNER JOIN {{ref('stgOrders')}} AS o
ON oi.order_id = o.order_id
WHERE oi.status NOT IN ('Cancelled','Returned')
GROUP BY 1
ORDER BY total_revenue DESC

