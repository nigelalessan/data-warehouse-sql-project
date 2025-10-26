# :memo: Naming Convention Guidelines
This document serves as a guideline for the naming conventions used in this data warehouse.

## :pushpin: General Principles
- **Language** : English
- **Style** : Naming is generally written in `snake_case` style
- **Avoid unclear abbreviations and ambiguity**: Use abbreviations only when they are common and widely understood. *e.g.,* `'id'`, `'desc'`,`'qty'`

## :pushpin: Table Naming Conventions
Each table follows slightly different naming rules depending on the schema where the table is created.

### :3rd_place_medal: Bronze Schema
The table name must begin with the source system where the data is obtained, and the table name must match the name used in the source system. *e.g.,* **`<sourcesystem>_<tablename>`**

* `sourcesystem` : The source system name from which the data is extracted, for example `crm` or `erp`.
* `tablename` : The original table name must follow the exact name from the source system without any modifications.
* *Example* : `crm_cust_info`. `crm` is the source system name, while `cust_info` is the original table name obtained from the source system without any modification.

#### **Glossary**

| Pattern | Meaning      | Example(s)      |
|---------|--------------|-----------------|
| `crm_`  | crm source   | `crm_cust_info` |
| `erp_`  | erp source   | `erp_loc_a101`  |


### :2nd_place_medal: Silver Schema
The naming format remains the same as the previous rules, which is the table name must begin with the source system where the data is obtained, and the table name must match the name used in the source system. *e.g.,* **`<sourcesystem>_<tablename>`**

* `sourcesystem` : The source system name from which the data is extracted, for example `crm` or `erp`.
* `tablename` : The original table name must follow the exact name from the source system or previous schema without any modifications.
* *Example* : `erp_loc`. `erp` is the source system name, while `loc` is the original table name obtained from the source system without any modification.

### :1st_place_medal: Gold Schema
In the gold schema, the naming starts with the table type, such as a **fact** or **dimension** table, followed by a meaningful table name that clearly represents the content of the table.. *e.g.,* `<category>_<tablename>`

* `category` : The table type indicating whether it is a **fact** table or a **dimension** table.
* `tablename` : The original table name must follow the exact name from the source system without any modifications.
* *Example* : `dim_customers`. `dim` is the table type which is **dimension** table, while `customers` is table name that represents the content of the table, which in this case contains customer-related data.

#### **Glossary**

| Pattern | Meaning           | Example(s)      |
|---------|-------------------|-----------------|
| `dim_`  | dimension table   | `dim_customer`  |
| `fact_` | fact table        | `fact_sales`    |

## :pushpin: **Column Naming Conventions**

### Derivative Column
For derivative columns, use meaningful names or commonly used abbreviations to avoid ambiguity. *e.g.,* `qty` for quantity, `dt` for date, `addr` for address.
- *Example* : `cat_id`. `cat` for category dan `id` for id

### **Surrogate Keys**  
The naming of surrogate key columns must start with the table name, followed by `_key`. *e.g.,* **`<table_name>_key`**  
  - `<table_name>`: The table name used.  
  - `_key`: The suffix used to define the surrogate key.  
  - *Example* : `product_key`. Surrogate key in the `dim_product` table.
  
### **Technical Columns**
For technical columns such as metadata generated automatically within the data warehouse, use the prefix “dwh_” to indicate that the column is created in the data warehouse and does not come from the source system. *e.g.,* **`dwh_<column_name>`**  
  - `dwh_`: A prefix used to indicate that the column is created in the data warehouse, not sourced from the source system..  
  - `<column_name>`: A column name that indicates the function or purpose of the column.  
  - *Example* : `dwh_created_date`. A column used by the data warehouse to capture the date when the data was created.
 
## :pushpin: **Stored Procedure**

- Stored procedure naming must follow the primary rule by including `load` first, followed by the target schema to be loaded `schema`. *e.g.,* **`load_<schema>`**
  
  - `<schema>`: A representation of the target schema to be loaded, such as `bronze`, `silver`, or `gold`.
  - *Example* : `load_bronze`. Used to store the stored procedures for loading data into the bronze schema.
  


# Data Catalog

## Overview
The gold layer contains tables that store data from the silver layer in the form of **views**, representing business needs and enabling business-related queries. In the gold layer, there are two types of tables: **dimension** and **fact**.
## Gold Schema
In this gold schema, there are three tables: fact_sales, dim_products, and dim_customers.
### gold.dim_customers
- This table is used to store integrated customer data sourced from the CRM system (**crm_cust_info**) and ERP system (**erp.loc_a102 and erp.cust_az12**)
- | Column Name      | Data Type     | Description                                                                                                |
  |------------------|---------------|------------------------------------------------------------------------------------------------------------|
  | customer_key     | BIGINT        | This column contains a unique surrogate key used as the primary key in the table to identify each record.  |
  | customer_id      | INT           | Unique numerical identifier assigned to each customer.                                                     |
  | customer_code    | NVARCHAR(50)  | Alphanumeric identifier representing the customer, used for tracking and referencing.                      |
  | first_name       | NVARCHAR(50)  | The customer's first name.                                                                                 |
  | last_name        | NVARCHAR(50)  | The customer's last name.                                                                                  |
  | birthdate        | DATE          | The date of birth of the customer, formatted as YYYY-MM-DD (*e.g.*, 1999-01-01).                           |
  | country          | NVARCHAR(50)  | The country of residence.                                                                                  |
  | marital_status   | NVARCHAR(50)  | The marital status of the customer (*e.g.*, 'Married', 'Single').                                          |
  | gender           | NVARCHAR(50)  | The gender of the customer (*e.g.*, 'Male', 'Female', 'n/a').                                              |
  | create_date      | DATE          | The date and time when the customer record was created in the system                                       |

### gold.dim_products
- This table is used to store integrated product data sourced from the CRM system (**crm_prd_info**) and the ERP system (**erp.px_cat_g1v2**)
- | Column Name         | Data Type     | Description                                                                                              |
  |---------------------|---------------|----------------------------------------------------------------------------------------------------------|
  | product_key         | BIGINT        | This column contains a unique surrogate key used as the primary key in the table to identify each record.|
  | product_id          | INT           | A unique identifier assigned to the product for internal tracking and referencing.                       |
  | product_code        | NVARCHAR(50)  | A structured alphanumeric code representing the product, often used for categorization or inventory.     |
  | product_name        | NVARCHAR(50)  | Descriptive name of the product, including key details such as type, color, and size.                    |
  | category_id         | NVARCHAR(50)  | A unique identifier for the product's category, linking to its high-level classification.                |
  | category            | NVARCHAR(50)  | The broader classification of the product (*e.g.*, Bikes, Components) to group related items.            |
  | subcategory         | NVARCHAR(50)  | A more detailed classification of the product within the category, such as product type.                 |
  | product_line        | NVARCHAR(50)  | The specific product line or series to which the product belongs (*e.g.*, Road, Mountain).               |
  | maintenance         | NVARCHAR(50)  | Indicates whether the product requires maintenance (*e.g.*, 'Yes', 'No').                                |
  | cost                | INT           | The cost or base price of the product, measured in monetary units.                                       |
  | start_date          | DATE          | The date when the product became available for sale or use, stored in                                    |

### gold.fact_sales
- This table stores transaction records that involve both users and products. It is created by joining multiple tables using the left join method: **fact_sales**, **dim_products**, and **dim_customers**.
- | Column Name     | Data Type     | Description                                                                                     |
  |-----------------|---------------|-------------------------------------------------------------------------------------------------|
  | order_number    | NVARCHAR(50)  | A unique alphanumeric identifier for each sales order (*e.g.*, 'SO43697').                      |
  | product_key     | BIGINT        | Surrogate key linking the order to the product dimension table.                                 |
  | customer_key    | BIGINT        | Surrogate key linking the order to the customer dimension table.                                |
  | order_date      | DATE          | The date when the order was placed.                                                             |
  | ship_date       | DATE          | The date when the order was shipped to the customer.                                            |
  | due_date        | DATE          | The date when the order payment was due.                                                        |
  | sales_amount    | INT           | The total monetary value of the sale for the line item, in whole currency units (*e.g.*, 25).   |
  | quantity        | INT           | The number of units of the product ordered for the line item (*e.g.*, 1).                       |
  | price           | INT           | The price per unit of the product for the line item, in whole currency units (*e.g.*, 25).      |
