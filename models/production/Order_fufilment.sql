-- Order Fulfillment Time Analysis
SELECT
  order_id,
  MIN(created_at) AS order_created_at,
  MAX(delivered_at) AS order_delivered_at,
  TIMESTAMP_DIFF(MAX(delivered_at), MIN(created_at), HOUR) AS fulfillment_time_hours
FROM {{ ref('stgOrders') }}
WHERE status = 'Delivered'
GROUP BY 1
