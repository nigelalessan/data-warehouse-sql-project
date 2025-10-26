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
