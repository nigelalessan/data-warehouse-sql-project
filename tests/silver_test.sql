/*
Purpose	: SILVER SCHEMA TABLE DATA QUALITY CHECK
Table	: crm_cust_info
*/

-- Purpose		: Mengecek nulls atau duplikat pada primary key
-- Expectation	: Tidak ada hasil(Untuk Kedua)

SELECT 
	cst_id, 
	count(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING count(*) > 1 or cst_id IS NULL

-- Case	Found	: Terdapat record yang memiliki banyak nilai null kecuali cst_key
-- Purpose		: Menghapus null pada table silver.crm_cust_info yang hanya memiliki cst_key

DELETE FROM silver.crm_cust_info
WHERE cst_key = 'PO25'

-- Purpose		: Mengecek record yang null kembali
-- Expectation	: Tidak ada hasil

SELECT *
FROM silver.crm_cust_info
WHERE cst_key = 'PO25'

-- Purpose		: Check extra spaces
-- Expectation	: Tidak ada hasil

SELECT cst_lastname -- ganti nama column
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname) -- ganti nama column kondisi

-- Purpose		: Data Standarization & Consistency
-- Expectation	: Male, Female, n/a

SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info

/*
Purpose	: SILVER SCHEMA TABLE DATA QUALITY CHECK
Table	: crm_prd_info
*/

-- Purpose		: Mengecek nulls atau duplikat pada primary key
-- Expectation	: Tidak ada hasil

SELECT
	prd_id,
	COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL

-- Purpose		: Check extra spaces 
-- Expectation	: Tidak ada hasil

SELECT prd_nm -- ganti nama column
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm) -- ganti nama column kondisi

-- Purpose		: Mengecek null atau angka negatif
-- Expectation	: Tidak ada hasil

SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

-- Purpose		: Data Standarization & Consistency
-- Expectation	: Mountain, Other Sales, Road, Touring, n/a

SELECT DISTINCT prd_line
FROM silver.crm_prd_info

-- Purpose		: Mengecek tanggal invalid/tidak sesuai
-- Expectation	: Tidak ada hasil

SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt

/*
Purpose	: SILVER SCHEMA TABLE DATA QUALITY CHECK
Table	: crm_sales_details
*/

-- Purpose		: Check extra spaces
-- Expectation	: Tidak ada hasil

SELECT sls_ord_num -- ganti nama column
FROM silver.crm_sales_details
WHERE sls_prd_key != TRIM(sls_prd_key) -- ganti nama column kondisi

-- Purpose		: Mengecek tanggal invalid/tidak sesuai
-- Expectation	: Error (Terdapat error karena tipe data sudah dirubah menjadi DATE bukan lagi INT)

SELECT NULLIF(sls_order_dt, 0) AS sls_order_dt
FROM silver.crm_sales_details
WHERE sls_order_dt <= 0 OR LEN(sls_order_dt) != 8 OR sls_order_dt > 20500101 OR sls_order_dt < 19000101

-- Purpose		: Mengecek tanggal invalid/tidak sesuai
-- Expectation	: Tidak ada hasil

SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt

-- Purpose		: Mengecek tanggal invalid/tidak sesuai
-- Expectation	: Tidak ada hasil

SELECT
	sls_sales,
	sls_quantity,
	sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
	OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
	OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price

/*
Purpose	: SILVER SCHEMA TABLE DATA QUALITY CHECK
Table	: erp_cust_az12
*/

-- Purpose		: Mengecek tanggal invalid/tidak sesuai
-- Expected		: Tidak ada hasil

SELECT *
FROM silver.erp_cust_az12
WHERE bdate <'1930-01-01' OR bdate > GETDATE()

-- Purpose		: Data Standardization & Consistency
-- Expected		: Male, Female, n/a

SELECT DISTINCT gen
FROM silver.erp_cust_az12

/*
Purpose	: SILVER SCHEMA TABLE DATA QUALITY CHECK
Table	: crm_erp_loc_a101
*/

-- Purpose		: Data Standardization & Consistency
-- Expectation	: Australia, Canada, France, Germany, United Kingdom, United States, n/a

SELECT DISTINCT cntry
FROM silver.erp_loc_a101

/*
Purpose	: SILVER SCHEMA TABLE DATA QUALITY CHECK
Table	: erp_px_cat_g1v2
*/

-- Purpose		: Check extra spaces
-- Expectation	: Tidak ada hasil

SELECT *
FROM silver.erp_px_cat_g1v2
WHERE maintenance != TRIM(maintenance)


-- Purpose		: Data Standardization & Consistency
-- Expectation	: No, Yes

SELECT DISTINCT maintenance
FROM silver.erp_px_cat_g1v2
