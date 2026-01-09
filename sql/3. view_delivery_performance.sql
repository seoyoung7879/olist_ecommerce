CREATE OR REPLACE VIEW view_delivery_performance AS
SELECT 
    c.customer_state AS state,
    -- 평균 배송 소요 시간 (일 단위)
    AVG(DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp)) AS avg_delivery_days,
    -- 예상 배송일 대비 지연율 (지연된 건수 / 전체 건수)
    SUM(CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1 ELSE 0 END) / COUNT(*) * 100 AS delay_rate,
    -- 총 주문 건수
    COUNT(*) AS total_orders
FROM 
    olist_orders_dataset o
JOIN 
    olist_customers_dataset c ON o.customer_id = c.customer_id
WHERE 
    o.order_status = 'delivered'
    AND o.order_delivered_customer_date IS NOT NULL
GROUP BY 
    c.customer_state;
SELECT * FROM view_delivery_performance LIMIT 10;