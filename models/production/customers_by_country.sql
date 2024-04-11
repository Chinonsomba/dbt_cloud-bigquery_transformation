WITH
cust AS (
  SELECT 
    DISTINCT oi.user_id,
    SUM(CASE WHEN u.gender = 'M' THEN 1 ELSE null END) AS male,
    SUM(CASE WHEN u.gender = 'F' THEN 1 ELSE null END) AS female,
    u.country AS country
  FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
  INNER JOIN `bigquery-public-data.thelook_ecommerce.users` AS u  
  ON oi.user_id = u.id
  WHERE oi.status NOT IN ('Cancelled','Returned')
  GROUP BY 1, 4
