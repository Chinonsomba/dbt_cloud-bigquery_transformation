SELECT
    country,
    COUNT(DISTINCT user_id) AS total_customers,
    SUM(total_female) AS total_female,
    SUM(total_male) AS total_male
FROM (
    SELECT 
        u.country,
        oi.user_id,
        COUNTIF(u.gender = 'F') AS total_female,
        COUNTIF(u.gender = 'M') AS total_male,
    FROM {{ref('stgorderitems')}} AS oi
    INNER JOIN {{ref('stgUsers')}} AS u  
    ON oi.user_id = u.id
    WHERE oi.status NOT IN ('Cancelled', 'Returned')
    GROUP BY 1, 2
) AS customer_gender_distribution
GROUP BY 1
ORDER BY total_customers DESC

