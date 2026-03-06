# Northwind-Traders-Data-Architecture
End-to-End Data Architecture and Business Intelligence model for Northwind Traders. Analyzed 830 transactions to validate $1.27M in net revenue using MySQL and Power BI.

## 📌 Executive Overview
This repository contains an end-to-end Data Engineering and Business Intelligence solution for Northwind Traders. The objective of this project was to transition raw, disconnected operational data (July 2013 – May 2015) into a validated, centralized MySQL database, and subsequently model it in Power BI to extract actionable business strategies. 

By applying strict data governance and the Principle of Least Privilege during the database build, this project ensures that all aggregated metrics are mathematically validated at the row level before visualization.

## 📊 Core Business Impact (The Bottom Line)
The interactive Power BI model yielded the following validated performance benchmarks:
* **Net Revenue:** $1.27M
* **Transaction Volume:** 830 Total Orders
* **Average Order Value (AOV):** $1.53K
* **Workforce Efficiency Baseline:** 92 Orders per Employee

## 📂 Strategic Deliverables
I structured the documentation into two distinct tiers to serve both business leadership and technical management. *(Click the links below to view the PDF documents).*

1. [**The Executive Stakeholder Brief**](main/Documentation/) 
   * A 1-page strategic summary detailing the $1.27M revenue drivers, the operational cost of 15%-25% discounting, and actionable recommendations for recovering margin on the $78.24 average freight cost.
2. [**The Technical Architecture Guide**](./Documentation/Northwind_Technical_Architecture.pdf) 
   * A comprehensive 9-page manual detailing the AAR and SDD frameworks, MySQL user provisioning, Star Schema implementation, and DAX logic (including `SUMX` iterator validation).

## 🛠️ Technical Stack & Methodology
* **Database Management:** MySQL (Provisioned via root, executed via dedicated restricted user connection).
* **Data Transformation:** SQL (DDL/DML), Power Query.
* **Data Modeling:** Power BI (Optimized Star Schema: 1 Fact Table, 5 Dimension Tables).
* **Analytical Frameworks:** Ask, Analyze, Recommend (AAR) & Solution Design Document (SDD).

## 🗂️ Repository Structure
* `/Data` - Contains the raw CSV files used for the initial data load.
* `/Scripts` - Contains the SQL scripts for database creation, user provisioning, ETL processes, and sanity checks.
* `/Dashboard` - Contains the raw `.pbix` Power BI file and `.pdf` as a report.
* `/Documentation` - Contains the PDF portfolio documents (Executive Brief & Technical Guide).

## 🚀 How to Navigate This Project
For recruiters and business leaders, I highly recommend starting with the **Executive Stakeholder Brief** in the Documentation folder. For data engineering peers and technical managers, the **Scripts** folder and **Technical Architecture Guide** provide full visibility into the backend methodology and data integrity protocols.
