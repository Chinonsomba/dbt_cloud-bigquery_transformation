-- Customer Segmentation
WITH customer_segments AS (
  SELECT
    u.id AS user_id,
    u.gender,
    u.age,
    u.country,
    o.status AS order_status,
    COUNT(DISTINCT o.order_id) AS order_count,
    SUM(oi.sale_price) AS total_spent
  FROM {{ ref('stgOrders') }} AS o
  INNER JOIN {{ ref('stgUsers') }} AS u ON o.user_id = u.id
  LEFT JOIN {{ ref('stgorderitems') }} AS oi ON o.order_id = oi.order_id
  GROUP BY 1, 2, 3, 4, 5
)

SELECT
  gender,
  AVG(age) AS avg_age,
  country,
  COUNT(DISTINCT user_id) AS total_customers,
  SUM(order_count) AS total_orders,
  SUM(total_spent) AS total_spent
FROM customer_segments
GROUP BY 1, 3
