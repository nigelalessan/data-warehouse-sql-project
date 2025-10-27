-- ====================================================================
-- View gold.dim_customers
-- ====================================================================
-- Purpose		: Mengecek customer key yang unique
-- Expectation	: Tidak ada hasil 

SELECT 
    customer_key,
    COUNT(*) AS cnt
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- View gold.dim_products
-- ====================================================================
-- Purpose		: Mengecek customer key yang unique
-- Expectation	: Tidak ada hasil 

SELECT 
    product_key,
    COUNT(*) AS cnt
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- View gold.fact_sales
-- ====================================================================
-- Purpose		: Mengecek data pada view yang tidak memiliki relasi
-- Expectation	: Tidak ada hasil 

SELECT * 
FROM gold.fact_sales fs
LEFT JOIN gold.dim_customers dc
ON dc.customer_key = fs.customer_key
LEFT JOIN gold.dim_products dp
ON dp.product_key = fs.product_key
WHERE dp.product_key IS NULL OR dc.customer_key IS NULL  
