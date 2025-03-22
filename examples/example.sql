-- Color Theme Demo for SQL
/* 
   Multi-line comment showing syntax highlighting
   for SQL in VS Code themes
*/

-- DDL: Create table with various data types
CREATE TABLE customers (
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    birth_date DATE,
    signup_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    credits DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    is_active BIT DEFAULT 1,
    customer_type CHAR(1) CHECK (customer_type IN ('R', 'V', 'P'))
);

-- CTE with window functions and subquery
WITH customer_stats AS (
    SELECT 
        c.customer_id, 
        CONCAT(c.first_name, ' ', c.last_name) AS full_name,
        SUM(o.total_amount) AS total_spent,
        COUNT(o.order_id) AS order_count,
        ROW_NUMBER() OVER (PARTITION BY c.customer_type ORDER BY SUM(o.total_amount) DESC) AS spending_rank
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    WHERE c.is_active = 1 AND o.order_date >= DATEADD(month, -6, GETDATE())
    GROUP BY c.customer_id, c.first_name, c.last_name, c.customer_type
    HAVING COUNT(o.order_id) > 0
)
SELECT 
    cs.customer_id,
    cs.full_name,
    cs.total_spent,
    cs.order_count,
    cs.spending_rank,
    CASE 
        WHEN cs.total_spent > 1000 THEN 'Platinum'
        WHEN cs.total_spent > 500 THEN 'Gold'
        ELSE 'Silver'
    END AS customer_tier,
    (SELECT AVG(total_spent) FROM customer_stats) AS avg_customer_spend
FROM customer_stats cs
WHERE cs.spending_rank <= 10
ORDER BY cs.total_spent DESC;

-- Stored procedure with parameters and variables
CREATE OR REPLACE PROCEDURE update_customer_status(
    IN p_customer_id INT,
    IN p_is_active BIT
)
AS $$
DECLARE
    v_current_status BIT;
    v_update_count INT := 0;
BEGIN
    SELECT is_active INTO v_current_status FROM customers 
    WHERE customer_id = p_customer_id;
    
    IF v_current_status IS DISTINCT FROM p_is_active THEN
        UPDATE customers SET 
            is_active = p_is_active,
            last_updated = CURRENT_TIMESTAMP
        WHERE customer_id = p_customer_id;
        
        GET DIAGNOSTICS v_update_count = ROW_COUNT;
    END IF;
    
    RETURN v_update_count;
END;
$$ LANGUAGE plpgsql;