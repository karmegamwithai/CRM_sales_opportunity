# CRM Sales Opportunity Analytics

## Business Requirements Document

**Project:** CRM Sales Opportunity Analytics
**Tools:** SQL, Power BI
**Domain:** Sales / CRM Analytics

---

## 1. Objective

Build a sales analytics solution using **SQL and Power BI** to analyze CRM sales opportunities, revenue, pipeline, sales agents, regional managers, products, accounts, and monthly trends.

---

## 2. Data Sources

The project will use the following CRM tables:

- `sales_pipeline`
- `sales_teams`
- `accounts`
- `products`
- `regional_offices`

---

## 3. SQL Analysis Requirements

SQL will be used for data cleaning, validation, transformation, and analysis.

### 3.1 Data Quality

Analyze:

- Missing values
- Duplicate records
- Invalid values
- Invalid deal stages
- Invalid dates
- Referential integrity

### 3.2 Executive KPIs

Calculate:

- Total Opportunities
- Won Opportunities
- Lost Opportunities
- Open Opportunities
- Won Revenue
- Lost Value
- Pipeline Value
- Win Rate
- Average Deal Value

### 3.3 Sales Agent Analysis

Analyze:

- Opportunities by Sales Agent
- Won Revenue
- Lost Value
- Pipeline Value
- Win Rate
- Average Deal Value
- Sales Agent Ranking

### 3.4 Regional Manager Analysis

Analyze:

- Opportunities by Manager
- Revenue by Manager
- Pipeline by Region
- Win Rate
- Lost Value
- Revenue per Sales Agent

### 3.5 Product Analysis

Analyze:

- Revenue by Product
- Revenue by Product Series
- Pipeline by Product
- Win Rate
- Average Deal Value
- Actual vs Standard Sales Price

### 3.6 Account Analysis

Analyze:

- Revenue by Account
- Pipeline by Account
- Opportunities by Account
- Win Rate
- Lost Value
- Account Size
- Account Revenue

### 3.7 Monthly Trend Analysis

Analyze:

- Monthly Opportunities
- Monthly Won Revenue
- Monthly Lost Value
- Monthly Pipeline Value
- Monthly Win Rate
- Monthly Average Deal Value

---

## 4. Power BI Requirements

Create an interactive Power BI dashboard with the following pages:

### Page 1 — Executive Overview

- Total Opportunities
- Won Revenue
- Pipeline Value
- Win Rate
- Average Deal Value
- Revenue Trend
- Revenue by Region
- Revenue by Product

### Page 2 — Sales Agent Analysis

- Sales Agent Performance
- Revenue
- Pipeline
- Win Rate
- Agent Ranking

### Page 3 — Regional Manager Analysis

- Manager Performance
- Regional Revenue
- Regional Pipeline
- Win Rate
- Agent Performance

### Page 4 — Product Analysis

- Product Revenue
- Product Pipeline
- Product Series Performance
- Win Rate
- Actual vs Standard Price

### Page 5 — Account Analysis

- Top Accounts
- Account Revenue
- Account Pipeline
- Opportunity Count
- Win Rate

### Page 6 — Monthly Trends

- Monthly Revenue
- Monthly Pipeline
- Monthly Opportunities
- Monthly Win Rate
- Monthly Lost Value

### Page 7 — Data Quality

- Total Records
- Valid Records
- Missing Records
- Duplicate Records
- Invalid Records
- Data Quality %

---

## 5. Power BI Filters

The dashboard should include:

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

## 6. Data Model

Recommended structure:

```text
                    Sales Teams
                        │
                        │
Accounts ───── Sales Pipeline ───── Products
                        │
                        │
                 Regional Office
                        │
                        ▼
                    Power BI
```

---

## 7. Deliverables

### SQL

```text
01_data_quality.sql
02_executive_kpis.sql
03_sales_agent_analysis.sql
04_regional_manager_analysis.sql
05_product_analysis.sql
06_account_analysis.sql
07_monthly_trend_analysis.sql
```

### Power BI

```text
CRM_Sales_Analytics.pbix
```

### Documentation

```text
README.md
Business_Requirements.md
Data_Dictionary.md
KPI_Definitions.md
```

---

## 8. Final Outcome

The project will provide a centralized **CRM Sales Analytics Dashboard** that enables management and sales teams to monitor:

- Sales performance
- Revenue
- Pipeline
- Sales agents
- Regional managers
- Products
- Accounts
- Monthly trends
- Data quality

**Technology Stack:** SQL + Power BI
