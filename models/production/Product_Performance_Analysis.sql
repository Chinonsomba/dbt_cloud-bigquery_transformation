    SELECT
      category,
      brand,
      distribution_center_id,
      COUNT(id) AS total_products,
      SUM(retail_price) AS total_revenue
    FROM `iconic-glass-418612`.`dbt_cmba`.`stgproducts`
    GROUP BY 1, 2, 3