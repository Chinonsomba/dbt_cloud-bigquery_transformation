{{ config(
    materialized='table'
) }}

SELECT * FROM `bigquery-public-data.thelook_ecommerce.distribution_centers` LIMIT 1000