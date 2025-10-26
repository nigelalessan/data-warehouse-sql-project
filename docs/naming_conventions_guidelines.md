# :memo: Naming Convention Guidelines
This document serves as a guideline for the naming conventions used in this data warehouse.
## :pushpin: General Principles
- **Language** : English
- **Style** : Naming is generally written in `snake_case` style
- **Avoid unclear abbreviations and ambiguity**: Use abbreviations only when they are common and widely understood. e.g. `'id'`, `'desc'`,`'qty'`

## :pushpin: Table Naming Conventions
Each table follows slightly different naming rules depending on the schema where the table is created.
### :3rd_place_medal: Bronze Schemas
The table name must begin with the source system where the data is obtained, and the table name must match the name used in the source system. *Example* : `<sourcesystem>_<tablename>`

* `sourcesystem` : The source system name from which the data is extracted, for example `crm` or `erp`.
* `tablename` : The original table name must follow the exact name from the source system without any modifications.
* Example : `erp_cust_info`. `erp` is the source system name, while `cust_info` is the original table name obtained from the source system without any modification.

