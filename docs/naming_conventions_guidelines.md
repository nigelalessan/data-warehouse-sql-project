# :memo: Naming Convention Guidelines
This document serves as a guideline for the naming conventions used in this data warehouse.

## :pushpin: General Principles
- **Language** : English
- **Style** : Naming is generally written in `snake_case` style
- **Avoid unclear abbreviations and ambiguity**: Use abbreviations only when they are common and widely understood. *e.g.,* `'id'`, `'desc'`,`'qty'`

## :pushpin: Table Naming Conventions
Each table follows slightly different naming rules depending on the schema where the table is created.

### :3rd_place_medal: Bronze Schemas
The table name must begin with the source system where the data is obtained, and the table name must match the name used in the source system. *e.g.,* `<sourcesystem>_<tablename>`

* `sourcesystem` : The source system name from which the data is extracted, for example `crm` or `erp`.
* `tablename` : The original table name must follow the exact name from the source system without any modifications.
* *Example* : `crm_cust_info`. `crm` is the source system name, while `cust_info` is the original table name obtained from the source system without any modification.

### :2nd_place_medal: Silver Schemas
The naming format remains the same as the previous rules, which is the table name must begin with the source system where the data is obtained, and the table name must match the name used in the source system. *e.g.,* `<sourcesystem>_<tablename>`

* `sourcesystem` : The source system name from which the data is extracted, for example `crm` or `erp`.
* `tablename` : The original table name must follow the exact name from the source system or previous schema without any modifications.
* *Example* : `erp_loc`. `erp` is the source system name, while `loc` is the original table name obtained from the source system without any modification.

### :1st_place_medal: Gold Schemas
In the gold schema, the naming starts with the table type, such as a **fact** or **dimension** table, followed by a meaningful table name that clearly represents the content of the table.. *e.g.,* `<category>_<tablename>`

* `category` : The table type indicating whether it is a **fact** table or a **dimension** table.
* `tablename` : The original table name must follow the exact name from the source system without any modifications.
* *Example* : `dim_customers`. `dim` is the table type which is **dimension** table, while `customers` is table name that represents the content of the table, which in this case contains customer-related data.
