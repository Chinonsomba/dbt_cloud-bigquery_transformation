-- models/customer_data.sql

WITH
customer_data AS (
  SELECT 
    DISTINCT oi.user_id,
    SUM(CASE WHEN u.gender = 'M' THEN 1 ELSE null END) AS male,
    SUM(CASE WHEN u.gender = 'F' THEN 1 ELSE null END) AS female,
    u.country AS country
  FROM {{ ref('stgorderitems') }} AS oi
  INNER JOIN {{ ref('stgUsers') }} AS u  
  ON oi.user_id = u.id
  WHERE oi.status NOT IN ('Cancelled','Returned')
  GROUP BY 1, 4
),

customer_summary AS (
  SELECT
    c.country,
    COUNT(DISTINCT c.user_id) AS customers_count,
    COUNT(c.female) AS female,
    COUNT(c.male) AS male
  FROM customer_data AS c
  GROUP BY 1
)

SELECT * FROM customer_summary
ORDER BY customers_count DESC
