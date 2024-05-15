SELECT 
  DATE_TRUNC(DATE(oi.created_at),MONTH) AS order_date,
  SUM(oi.sale_price*o.num_of_item) AS revenue,
  COUNT(DISTINCT oi.order_id) AS order_count,
  COUNT(DISTINCT oi.user_id) AS customers_purchased
FROM {{ref('stgorderitems')}} AS oi
LEFT JOIN {{ref('stgOrders')}} AS o 
ON oi.order_id = o.order_id
WHERE oi.status NOT IN ('Cancelled','Returned')
GROUP BY 1
ORDER BY 1 DESC