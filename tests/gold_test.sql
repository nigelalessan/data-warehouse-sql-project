use master
use DataWarehouse

-- Purpose		: Mengecek duplicate pada cst_id
-- Expectation	: Tidak ada hasil

SELECT 
	cst_id,
	COUNT(*) AS cnt
FROM(
SELECT
	ci.cst_id,
	ci.cst_key,
	ci.cst_firstname,
	ci.cst_lastname,
	ci.cst_marital_status,
	ci.cst_gndr,
	ci.cst_create_date,
	la.cntry,
	ca.bdate
FROM silver.crm_cust_info AS ci
LEFT JOIN silver.erp_loc_a101 AS la
ON ci.cst_key = la.cid
LEFT JOIN silver.erp_cust_az12 AS ca
ON ci.cst_key = ca.cid) t
GROUP BY cst_id
HAVING COUNT(*) > 0

-- Purpose		: Mengecek data integration

SELECT DISTINCT
	ci.cst_gndr,
	ca.gen,
	CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
		 ELSE COALESCE(ca.gen, 'n/a')
	END AS new_gndr
FROM silver.crm_cust_info AS ci
LEFT JOIN silver.erp_loc_a101 AS la
ON ci.cst_key = la.cid
LEFT JOIN silver.erp_cust_az12 AS ca
ON ci.cst_key = ca.cid

-- Purpose		: Mengecek duplicate pada prd_key
-- Expectation	: Tidak ada hasil

SELECT 
	product_code,
	COUNT(*)
FROM(
SELECT
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
WHERE pi.prd_end_dt IS NULL) t
GROUP BY product_code
HAVING COUNT(*) > 1

SELECT *
FROM gold.dim_products

-- Purpose		: Mengecek data gold.fact_sales

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


SELECT
	sls_prd_key,
	COUNT(*) cnt
FROM silver.crm_sales_details
GROUP BY sls_prd_key
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC

SELECT *
FROM gold.fact_sales AS fs
LEFT JOIN gold.dim_customers AS dc
ON fs.customer_key = dc.customer_key
LEFT JOIN gold.dim_products AS dp
ON fs.product_key = dp.product_key 
WHERE fs.product_key IS NULL
