SELECT *
FROM (
    SELECT 
        DATE_TRUNC(DATE(oi.created_at), MONTH) AS order_date,
        SUM(oi.sale_price * o.num_of_item) AS total_revenue,
        COUNT(DISTINCT oi.order_id) AS total_order,
        COUNT(DISTINCT oi.user_id) AS customer_count
    FROM `iconic-glass-418612.dbt_cmba.stgorderitems` AS oi
    LEFT JOIN `iconic-glass-418612.dbt_cmba.stgOrders` AS o 
        ON oi.order_id = o.order_id
    WHERE oi.status NOT IN ('Cancelled','Returned')
    GROUP BY 1
    ORDER BY 1 DESC
) AS model_limit_subq
LIMIT 500
