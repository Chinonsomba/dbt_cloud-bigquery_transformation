
SELECT
    product_category,
    product_brand,
    Avg(cost) as Avg_cost,
    Avg(product_retail_price) as Avg_retail_price
FROM
    {{ ref('stginventoryitems') }}
GROUP BY 
    1,2
ORDER BY
    Avg_cost, Avg_retail_price

    