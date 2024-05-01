SELECT
  CASE 
    WHEN u.age < 15 THEN 'Kids'
    WHEN u.age BETWEEN 15 AND 24 THEN 'Teenager'
    WHEN u.age BETWEEN 25 AND 50 THEN 'Adult'
    WHEN u.age > 50 THEN 'Elderly' 
  END AS age_group,
  COUNT(DISTINCT oi.user_id) AS total_customers,
   FROM {{ ref('stgorderitems') }} AS oi
LEFT JOIN {{ ref('stgUsers') }} AS u
ON oi.user_id = u.id
WHERE oi.status NOT IN ('Cancelled', 'Returned')
GROUP BY 1
ORDER BY total_customers DESC
