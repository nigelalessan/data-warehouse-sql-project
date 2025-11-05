# :pushpin: Data Warehouse

## 🌐 Project Overview
This project demonstrates the development of a data warehouse that manages data so it can be analyzed and transformed into valuable insights. The data warehouse in this project is built using SQL Server and implements the Medallion Architecture as the structural foundation for the data warehouse.

## 🧱 Data Architecture
![Data Architecture](docs/data_architecture_diagram.png)
This data architecture adopts the Medallion Architecture, which is divided into three layers: Bronze, Silver, and Gold.
1. Bronze  : Stores raw data ingested directly from local sources without any modifications or transformations
2. Silver  : Performs data cleaning and standardization on all data from the Bronze layer, preparing it for use in the Gold layer.
3. Gold    : Prepares the data required for business analysis by extracting it from the Silver layer.

## 📂 Repository Structure
```
data-warehouse-project/
│
├── datasets/                              # Raw datasets used for the project (ERP and CRM data).
|   ├── source_crm/                        # Contains the CRM dataset.
|   ├── source_erp/                        # Contains the ERP dataset.    
│
├── docs/                                  # Contains the necessary documentation files
│   ├── data_architecture_diagram.png      # Diagram illustrating the Medallion Architecture.
│   ├── data_catalog.md                    # Data catalog that describes the columns used in the Gold layer.
│   ├── data_flow_diagram.png              # Diagram illustrating the data flow and how the data is transformed from the source through each layer.
│   ├── data_schema.png                    # Diagram illustrating how the tables are related in the Star Schema.
│   ├── integration_model.png              # Diagram illustrating the relationships or integration between the ERP and CRM datasets.
│   ├── naming_conventions_guidelines.md   # The naming conventions used as a guideline for naming in this project.
│
├── scripts/                               # Folder containing SQL scripts for each layer.
│   ├── bronze/                            # Script for importing or ingesting raw data from the source.
│   ├── silver/                            # Scripts for cleaning and transforming data
│   ├── gold/                              # Script used to create views for performing analysis.
|   ├── init_database.sql                  # Script for creating or initializing the database and setting up its schema.
│
├── tests/                                 # Contains scripts used to test each layer according to its corresponding layer script.
│
├── README.md                              # Project overview 
├── LICENSE                                # License
├── .gitignore                             # Files and directories to be ignored by Git
└── requirements.txt                       # Dependencies and requirements for the project
```
---
