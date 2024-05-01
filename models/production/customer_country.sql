SELECT
    country,
    COUNT(DISTINCT user_id) AS total_customers,
    SUM(female_count) AS female_customers,
    SUM(male_count) AS male_customers
FROM (
    SELECT 
        u.country,
        oi.user_id,
        COUNTIF(u.gender = 'F') AS female_count,
        COUNTIF(u.gender = 'M') AS male_count
    FROM {{ref('stgorderitems')}} AS oi
    INNER JOIN {{ref('stgUsers')}} AS u  
    ON oi.user_id = u.id
    WHERE oi.status NOT IN ('Cancelled', 'Returned')
    GROUP BY 1, 2
) AS customer_gender_distribution
GROUP BY 1
ORDER BY total_customers DESC
