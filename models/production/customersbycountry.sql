WITH CTE AS (
  SELECT
    DISTINCT oi.user_id,
    SUM(CASE WHEN u.gender = 'M' THEN 1 ELSE 0 END) AS male,
    SUM(CASE WHEN u.gender = 'F' THEN 1 ELSE 0 END) AS female,
    u.country AS country
  FROM `iconic-glass-418612.dbt_cmba.stgorderitems` AS oi
  INNER JOIN `iconic-glass-418612.dbt_cmba.stgUsers` AS u ON oi.user_id = u.id
  WHERE oi.status NOT IN ('Cancelled', 'Returned')
  GROUP BY country, user_id
  ORDER BY country DESC
)

SELECT *
FROM CTE
LIMIT 500
