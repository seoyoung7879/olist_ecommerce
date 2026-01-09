CREATE OR REPLACE VIEW view_customer_rfm AS
SELECT 
    c.customer_unique_id,
    -- Recency: 최근 구매일로부터 며칠 지났는가? (기준일은 데이터의 마지막 날짜인 2018-10-17로 가정)
    DATEDIFF('2018-10-17', MAX(o.order_purchase_timestamp)) AS recency,
    -- Frequency: 구매 횟수 (주문 건수)
    COUNT(DISTINCT o.order_id) AS frequency,
    -- Monetary: 총 구매 금액 (결제 금액 합계)
    SUM(p.payment_value) AS monetary
FROM 
    olist_customers_dataset c
JOIN 
    olist_orders_dataset o ON c.customer_id = o.customer_id
JOIN 
    olist_order_payments_dataset p ON o.order_id = p.order_id
WHERE 
    o.order_status = 'delivered' -- 배송 완료된 건만 인정
GROUP BY 
    c.customer_unique_id;
SELECT * FROM view_customer_rfm LIMIT 10;
