SELECT 
    o.product_id AS goods_id,
    ISNULL(ISNULL(c.person_id, p.person_id), 1) AS person_id, 
    o.date,
    CASE 
        WHEN pfc.id IS NOT NULL THEN 'Sale'
        WHEN ptp.id IS NOT NULL THEN 'Purchase'
        ELSE 'Write-off'
    END AS operation_type,
    o.amount,
    CASE 
        WHEN pfc.id IS NOT NULL THEN o.amount * g.sale_price
        WHEN ptp.id IS NOT NULL THEN o.amount * g.purchase_price
        ELSE 0
    END AS total_value,
    CASE 
        WHEN pfc.id IS NOT NULL THEN o.amount * g.sale_price
        WHEN ptp.id IS NOT NULL THEN o.amount * g.purchase_price
        ELSE 0
    END AS payment_amount,
    CASE 
        WHEN pfc.id IS NOT NULL THEN 'From Customer'
        WHEN ptp.id IS NOT NULL THEN 'To Provider'
        ELSE NULL
    END AS payment_type,
    ISNULL(c.debt, 0) AS debt
FROM Operations o
JOIN Goods g ON o.product_id = g.id
LEFT JOIN Payment_From_Customer pfc ON o.id = pfc.operation_id
LEFT JOIN Payment_To_Provider ptp ON o.id = ptp.operation_id
LEFT JOIN Customer c ON pfc.customer_id = c.id
LEFT JOIN Provider p ON ptp.provider_id = p.id
WHERE 
    (c.debt <= 900 OR c.debt IS NULL) 
    AND o.amount <= (
        SELECT ISNULL(SUM(o2.amount), 0)
        FROM Operations o2
        WHERE o2.product_id = g.id
        GROUP BY o2.product_id
    );
