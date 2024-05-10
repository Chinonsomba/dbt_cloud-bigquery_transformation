SELECT 
    p.category,
    p.brand,
    COUNT(oi.id) AS total_products,
    SUM(oi.sale_price * o.num_of_item) AS revenue,
    SUM(o.num_of_item) AS quantity_ordered
FROM 
    {{ ref('stgorderitems') }} AS oi
LEFT JOIN 
    {{ ref('stgOrders') }} AS o 
ON 
    oi.order_id = o.order_id
LEFT JOIN 
    {{ ref('stgproducts') }} AS p
ON 
    oi.product_id = p.id
WHERE 
    oi.status NOT IN ('Cancelled', 'Returned')
GROUP BY 
    p.category, p.brand
ORDER BY 
    3 DESC
