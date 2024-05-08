SELECT 
  DATE_TRUNC(oi.created_at, YEAR) AS order_date,
  SUM(oi.sale_price * o.num_of_item) AS revenue,
  COUNT(DISTINCT oi.order_id) AS total_order,
  COUNT(DISTINCT oi.user_id) AS total_customers
FROM 
  {{ ref('stgorderitems') }} AS oi
LEFT JOIN 
  {{ ref('stgOrders') }} AS o 
ON 
  oi.order_id = o.order_id
WHERE 
  oi.status NOT IN ('Cancelled', 'Returned')
GROUP BY 
  order_date
ORDER BY 
  order_date DESC
