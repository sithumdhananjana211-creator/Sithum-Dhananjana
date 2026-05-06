# Sithum-Dhananjana
A complete MySQL database system for property management, including data modeling (ERDs), schema creation, and reporting.

# Property Management Database System

# Project Overview
This project is a complete MySQL database solution designed to manage rental properties, tenants, and financial transactions. It demonstrates a practical application of data modeling and SQL development.

# Technical Refactoring (A+ Grade Work)
The primary focus of this version was **refactoring for efficiency**. 
* I replaced traditional lookup tables with **MySQL ENUM types** for property statuses (`property_states`) and property types (`type_name`).
* This approach ensures strict data integrity, preventing invalid entries and simplifying the query logic.

# Key Database Features
* **Complex Data Modeling**: Designed a fully normalized schema that handles multiple entities including Properties, Tenants, Leases, Payments, and Maintenance Requests.
* **Data Validation**: Implemented `REGEXP` constraints to ensure phone numbers are stored in a consistent numeric format.
* **Advanced SQL Queries**:
    * **Joins**: Linking tenants to specific property addresses for active leases.
    * **Aggregations**: Calculating total revenue paid per tenant using `SUM` and `GROUP BY`.
    * **Filters**: Automated reporting for pending payments, urgent maintenance requests, and vacant properties.

# How to Use
1. Clone the repository.
2. Run the `schema_and_data.sql` file in your MySQL environment.
3. Explore the pre-written reporting queries at the bottom of the script.
