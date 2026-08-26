# Data Warehouse and Analytics Project

Welcome to the **Data Warehouse and Analytics Project** repository!<br>
This project demonstrates a comprehensive  data warehousing and analytics solution, from building a data warehouse to generating actionable insights. Designed as a portfolio project highlights industry best practices in data engineering and analytics.

---
## Data Architecture
The data architecture for this project follows Medallion Architecture Bronze, Silver, and Gold layers:
![Data Architecture](/docs/data_architecture.png)
1. **Bronze Layer**: Stores raw data as-is from the source systems. Data is ingested from CSV Files into SQL Server Database.
2. **Silver Layer**: This layer includes data cleansing, standardization, and normalization processes to prepare data for analysis.
3. **Gold Layer**: Houses business-ready data modeled into a star schema required for reporting and analytics.

---
## Project Overview

This project involves:

1. **Data Architecture**: Designing a Modern Data Warehouse using Medallion Architecture **Bronze**,**Silver**, and **Gold** layers.
2. **ETL Pipelines**: Extracting, transforming and loading data from source systems into the warehouse.
3. **Data Modelling**: Developing fact and dimension tables optimized for analytical queries.
4. **Analytics and Reporting**: Creating SQL-based reports and dashboards for actionable insights.

This repository is an excellent resource for professionals and students looking to showcase expertise in:
- SQL Development
- Data Architecture
- Data Engineering
- ETL Pipeline Developer
- Data Modelling
- Data Analytics

---
## 🔗Important Links & Tools:

- **[Datasets](https://github.com/TheDataCubator/sql_data_warehouse_project/tree/bd1e64fad09770549473975ed3b65216eb504c80/datasets)**: Access to the project dataset(csv files).
- **[SQL Server Express](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)**: Lightweight server for hosting your SQL database.
- **[SQL Server Management Studio (SSMS)](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16)**: GUI for managing and interacting with databases.
- **[Git Repository](https://github.com/)**: Set up a GitHub account and repository to manage, version, and collaborate on your code efficiently.
- **[DrawIO](https://www.drawio.com/)**: Design data architecture, models, flows, and diagrams.
- **[Notion](https://www.notion.com/templates/sql-data-warehouse-project)**: Get the Project Tempalte from Notion

---

## Project Requirements

### Building the Data Warehouse (Data Engineering)

### Objective
Develop a modern data warehouse using SQL Server to consolidate sales data, enabling analytical reporting and informed decision-making.

#### Specifications
- **Data Sources**: Import data from two source systems (ERP and CRM) provided as CSV files.
- **Data Quality**: Cleanse and resolve data quality issues prior to analysis.
- **Integration**: Combine both sources into a single, user-friendly data model designed for analytical queries.
- **Scope**: Focus on the latest dataset only; historization of data is not required.
- **Documentation**: Provide clear documentation of the data model to support both business stakeholders and analytics teams.

---

### BI: Analytics & Reporting (Data Analytics)

### 🎯Objective
Develop SQL-based analytics to deliver detailed insights into:
- **Customer Behavior**
- **Product Performance**
- **Sales Trends**

These insights empower stakeholders with key business metrics, enabling strategic decision-making.

---
### Repository Structure
```
data-warehouse-project/
│
├── datasets/                           # Raw datasets used for the project (ERP and CRM data)
│
├── docs/                               # Project documentation and architecture details
│   ├── analyse_source_systems.md       # Acquiring relevant information before performing data connections
│   ├── ETL Diagram.png                 # shows all different techniques and methods of ETL
│   ├── data_architecture.png           # shows the project's architecture
│   ├── integration_model.png           # shows how data are connected
│   ├── data_catalog.md                 # Catalog of datasets, including field descriptions and metadata
│   ├── data_flow_diagram.png           # data flow diagram
│   ├── data_mart.png                   # data models (star schema)
│   ├── naming_conventions.md           # Consistent naming guidelines for tables, columns, and files
│   ├── data_layers.pdf                 # A one-slide-deck reference guide explaining the Bronze/Silver/Gold medallion data architecture — covering each layer's purpose, workflow, and a source-system interview checklist for onboarding new data sources.
│
├── scripts/                            # SQL scripts for ETL and transformations
│   ├── bronze/                         # Scripts for extracting and loading raw data
│   ├── silver/                         # Scripts for cleaning and transforming data
│   ├── gold/                           # Scripts for creating analytical models
│
├── tests/                              # Test scripts and quality files
│
├── README.md                           # Project overview and instructions
├── LICENSE                             # License information for the repository

```

---

## License

This project is licensed under the [MIT LICENSE](LICENSE). You are free to use, modify, and share this project with proper attribution.

## About Me

Thanks for visiting! I'm **Mustafa**, an insurance operations professional on a mission to master data analytics and turn raw data into real insights.


[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/mustafa-muntak)
