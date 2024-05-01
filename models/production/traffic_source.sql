SELECT
  u.traffic_source, 
  COUNT(DISTINCT oi.user_id) total_customer
FROM {{ref('stgorderitems')}} as oi
LEFT JOIN {{ref('stgUsers')}} as u
ON oi.user_id = u.id
WHERE oi.status NOT IN ('Cancelled','Returned')
GROUP BY traffic_source
ORDER BY total_customer DESC