

WITH yearly_orders AS (
  SELECT
    EXTRACT(YEAR FROM created_at) AS order_year,
    COUNT(*) AS num_orders
  FROM 
    {{ ref('stgOrders') }}
  GROUP BY 
    order_year
)

SELECT
   order_year,
   num_orders
FROM  
    yearly_orders
ORDER BY 
    order_year

