CREATE OR REPLACE VIEW view_monthly_sales AS
SELECT 
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(p.payment_value) AS total_revenue
FROM 
    olist_orders_dataset o
JOIN 
    olist_order_payments_dataset p ON o.order_id = p.order_id
WHERE 
    o.order_status = 'delivered'
GROUP BY 
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
ORDER BY 
    order_month;
SELECT * FROM view_monthly_sales LIMIT 10;