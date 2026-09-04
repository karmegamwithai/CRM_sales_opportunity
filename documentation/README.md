# CRM Sales Opportunity Analytics

## 📊 Project Overview

CRM Sales Opportunity Analytics is a data analytics project designed to analyze sales opportunities, revenue, pipeline performance, sales agents, regional managers, products, accounts, and monthly sales trends.

The project uses **SQL** for data cleaning and analysis and **Power BI** for interactive dashboards and business reporting.

---

## 🎯 Objectives

- Analyze CRM sales performance
- Track revenue and pipeline value
- Measure sales agent performance
- Analyze regional manager performance
- Identify top-performing products
- Analyze account-level sales performance
- Monitor monthly sales trends
- Validate data quality

---

## 🛠️ Tools & Technologies

- **SQL** – Data cleaning, transformation, validation, and analysis
- **Power BI** – Dashboard development and visualization
- **PostgreSQL / MySQL** – Database analysis
- **GitHub** – Project documentation and version control

---

## 🗂️ Data Sources

The project contains the following tables:

| Table              | Description                              |
| ------------------ | ---------------------------------------- |
| `sales_pipeline`   | Sales opportunities and deal information |
| `sales_teams`      | Sales agents and regional managers       |
| `accounts`         | Customer/account information             |
| `products`         | Product and pricing information          |
| `regional_offices` | Regional office information              |

---

## 🔍 SQL Analysis

SQL analysis is organized into the following sections:

### 1. Data Quality

- Missing values
- Duplicate records
- Invalid values
- Invalid deal stages
- Invalid dates
- Referential integrity

### 2. Executive KPIs

- Total Opportunities
- Won Opportunities
- Lost Opportunities
- Open Opportunities
- Won Revenue
- Lost Value
- Pipeline Value
- Win Rate
- Average Deal Value

### 3. Sales Agent Analysis

- Agent performance
- Won revenue
- Pipeline value
- Lost value
- Win rate
- Average deal value
- Agent ranking

### 4. Regional Manager Analysis

- Manager performance
- Regional revenue
- Regional pipeline
- Win rate
- Sales agent performance

### 5. Product Analysis

- Product revenue
- Product pipeline
- Product series performance
- Win rate
- Average deal value
- Actual vs standard sales price

### 6. Account Analysis

- Account revenue
- Account pipeline
- Opportunity count
- Win rate
- Lost value
- Account size

### 7. Monthly Trend Analysis

- Monthly opportunities
- Monthly revenue
- Monthly pipeline
- Monthly lost value
- Monthly win rate
- Monthly average deal value

---

## 📈 Power BI Dashboard

The Power BI report contains the following pages:

### Executive Overview

Provides an overall view of sales performance using key KPIs and charts.

### Sales Agent Analysis

Shows individual sales agent performance, revenue, pipeline, and rankings.

### Regional Manager Analysis

Analyzes performance across managers and regions.

### Product Analysis

Provides insights into product revenue, pipeline, product series, and pricing.

### Account Analysis

Highlights top accounts, revenue, pipeline, and opportunities.

### Monthly Trends

Shows changes in revenue, pipeline, opportunities, and win rate over time.

### Data Quality

Provides an overview of record validity, missing data, duplicates, and data quality percentage.

---

## 🎛️ Dashboard Filters

The Power BI dashboard supports filtering by:

- Year
- Month
- Deal Stage
- Sales Agent
- Manager
- Region
- Product
- Product Series
- Account
- Sector

---

## 🧩 Data Model

The project follows a relational data model where sales opportunities are connected with sales teams, accounts, products, and regional offices.

```text
Sales Teams
     │
     ├──────────────┐
     │              │
Accounts        Regional Offices
     │              │
     └──────┬───────┘
            │
     Sales Pipeline
            │
         Products
            │
         Power BI
```

---

## 📁 Project Structure

```text
CRM-Sales-Opportunity-Analytics/
│
├── sql/
│   ├── 01_data_quality.sql
│   ├── 02_executive_kpis.sql
│   ├── 03_sales_agent_analysis.sql
│   ├── 04_regional_manager_analysis.sql
│   ├── 05_product_analysis.sql
│   ├── 06_account_analysis.sql
│   └── 07_monthly_trend_analysis.sql
│
├── powerbi/
│   └── CRM_sales_opportunities.pbix
│
├── documentation/
│   ├── Business_Requirements.md
│   └── README.md
│
└── requirements.txt
```

---

## 📌 Key KPIs

| KPI                 | Description                                  |
| ------------------- | -------------------------------------------- |
| Total Opportunities | Total number of sales opportunities          |
| Won Revenue         | Revenue from won opportunities               |
| Lost Value          | Value of lost opportunities                  |
| Pipeline Value      | Value of active opportunities                |
| Win Rate            | Percentage of opportunities successfully won |
| Average Deal Value  | Average value of sales opportunities         |

---

## 💡 Business Value

This project helps sales teams and management:

- Monitor overall sales performance
- Identify high-performing sales agents
- Compare regional performance
- Identify profitable products
- Understand key customer accounts
- Track pipeline performance
- Monitor monthly sales trends
- Improve data quality and reporting

---

## 🚀 Project Outcome

The final solution provides a centralized **CRM Sales Analytics Dashboard** that combines SQL-based analysis with Power BI visualization.

It enables decision-makers to quickly understand:

**Revenue → Pipeline → Sales Agents → Regions → Products → Accounts → Trends**

---

## 👨‍💻 Author

**Karmegam J**

Data Analyst | Data Scientist | SQL | Power BI | Python

---
