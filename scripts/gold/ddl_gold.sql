/*

Create Views
===================================================================================================

Script:
	This script is used to perform DDL operations in the gold schema by creating views, consisting of 
	three tables: dim_customers, dim_products, and fact_sales.
*/



IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
    DROP VIEW gold.dim_customers;
GO

-- =================================================================
-- Create View gold.dim_customers
-- =================================================================

CREATE VIEW gold.dim_customers AS
SELECT
	ROW_NUMBER() OVER(ORDER BY ci.cst_id) AS customer_key, -- Surrogate Key
	ci.cst_id AS customer_id,
	ci.cst_key AS customer_code,
	ci.cst_firstname AS first_name,
	ci.cst_lastname AS last_name,
	ca.bdate AS birthdate,
	la.cntry AS country,
	ci.cst_marital_status AS marital_status,
	CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
		 ELSE COALESCE(ca.gen, 'n/a')
	END AS gender,
	ci.cst_create_date AS create_date
FROM silver.crm_cust_info AS ci
LEFT JOIN silver.erp_loc_a101 AS la
ON ci.cst_key = la.cid
LEFT JOIN silver.erp_cust_az12 AS ca
ON ci.cst_key = ca.cid

GO

IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
    DROP VIEW gold.dim_products;
GO

-- =================================================================
-- Create View gold.dim_products
-- =================================================================

CREATE VIEW gold.dim_products AS
SELECT
	ROW_NUMBER() OVER(ORDER BY pi.prd_start_dt, pi.prd_key) AS product_key, -- Surrogate Key
	pi.prd_id AS product_id,
	pi.prd_key AS product_code,
	pi.prd_nm AS product_name,
	pi.cat_id AS category_id,
	pc.cat AS category,
	pc.subcat AS subcategory,
	pi.prd_line AS product_line,
	pc.maintenance,
	pi.prd_cost AS cost,
	pi.prd_start_dt AS start_date
FROM silver.crm_prd_info AS pi
LEFT JOIN silver.erp_px_cat_g1v2 AS pc
ON pi.cat_id = pc.id
WHERE pi.prd_end_dt IS NULL

GO

IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;
GO

-- =================================================================
-- Create View gold.dim_customers
-- =================================================================

CREATE VIEW gold.fact_sales AS
SELECT
	sls_ord_num AS order_number,
	dp.product_key,
	dc.customer_key,
	sls_order_dt AS order_date,
	sls_ship_dt AS ship_date,
	sls_due_dt AS due_date,
	sls_sales AS sales_amount,
	sls_quantity AS quantity,
	sls_price AS price
FROM silver.crm_sales_details AS sd
LEFT JOIN gold.dim_products AS dp
ON sd.sls_prd_key = dp.product_code
LEFT JOIN gold.dim_customers AS dc
ON sd.sls_cust_id = dc.customer_id

GO
