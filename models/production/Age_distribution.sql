WITH AgeGroups AS (
  SELECT
    u.id AS user_id,
    CASE 
      WHEN u.age < 15 THEN 'Kids'
      WHEN u.age BETWEEN 15 AND 24 THEN 'Teenager'
      WHEN u.age BETWEEN 25 AND 50 THEN 'Adult'
      WHEN u.age > 50 THEN 'Elderly' 
    END AS age_group
  FROM 
    {{ ref('stgUsers') }} AS u
)

SELECT
  age_group,
  COUNT(DISTINCT oi.user_id) AS total_customers
FROM 
  AgeGroups AS ag
LEFT JOIN 
  {{ ref('stgorderitems') }} AS oi
ON 
  ag.user_id = oi.user_id
WHERE 
  oi.status NOT IN ('Cancelled', 'Returned')
GROUP BY 
  age_group
ORDER BY 
  total_customers DESC
