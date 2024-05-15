WITH OrderQuantities AS (
  SELECT
    p.brand AS brand,
    p.category As category,
    COUNTIF(oi.status = 'Cancelled') AS Cancelled,
    COUNTIF(oi.status = 'Returned') AS Returned
  FROM 
    {{ ref("stgorderitems") }} AS oi
  INNER JOIN 
    {{ ref("stgproducts") }} AS p
  ON 
    oi.product_id = p.id
  GROUP BY 
    brand, category
)

SELECT
  brand,
  category,
  Cancelled,
  Returned,
  CASE
    WHEN (Cancelled + Returned) = 0 THEN 0
    ELSE (Returned / (Cancelled + Returned)) * 100
  END AS ReturnRatePercentage
FROM 
  OrderQuantities
ORDER BY 
  Cancelled DESC
