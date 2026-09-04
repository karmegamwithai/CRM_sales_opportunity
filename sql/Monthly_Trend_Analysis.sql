-- How many opportunities were created each month?
SELECT 
	monthname(engage_date) as month_name,
    DATE_FORMAT(engage_date, '%Y-%m') AS month,
    COUNT(*) AS opportunities_created
FROM sales_pipeline
WHERE engage_date IS NOT NULL
GROUP BY 
	DATE_FORMAT(engage_date, '%Y-%m'),
	month_name
ORDER BY month;

-- How much revenue was generated from won opportunities each month?
SELECT 
    DATE_FORMAT(p.close_date, '%Y-%m') AS month,
    SUM(a.revenue) AS won_revenue
FROM sales_pipeline p
inner join accounts a
on p.account = a.account
WHERE deal_stage = 'Won'
  AND close_date IS NOT NULL
GROUP BY DATE_FORMAT(close_date, '%Y-%m')
ORDER BY month;

-- How much potential revenue was lost each month?
SELECT 
    DATE_FORMAT(close_date, '%Y-%m') AS month,
    SUM(close_value) AS lost_revenue
FROM sales_pipeline
WHERE deal_stage = 'Lost'
  AND close_date IS NOT NULL
GROUP BY DATE_FORMAT(close_date, '%Y-%m')
ORDER BY month;

select * from data_dictionary;

-- What is the monthly sales win rate?
SELECT
    DATE_FORMAT(close_date, '%Y-%m') AS month,
    COUNT(CASE WHEN deal_stage = 'Won' THEN 1 END) AS won_opportunities,
    COUNT(CASE WHEN deal_stage = 'Lost' THEN 1 END) AS lost_opportunities,
    ROUND(
        COUNT(CASE WHEN deal_stage = 'Won' THEN 1 END) * 100.0 /
        NULLIF(
            COUNT(CASE WHEN deal_stage IN ('Won', 'Lost') THEN 1 END),
            0
        ),
        2
    ) AS win_rate
FROM sales_pipeline
WHERE close_date IS NOT NULL
GROUP BY DATE_FORMAT(close_date, '%Y-%m')
ORDER BY month;

-- Which month generated the highest closed-won revenue?
SELECT
    DATE_FORMAT(close_date, '%Y-%m') AS month,
    SUM(close_value) AS won_revenue
FROM sales_pipeline
WHERE deal_stage = 'Won'
  AND close_date IS NOT NULL
GROUP BY DATE_FORMAT(close_date, '%Y-%m')
ORDER BY won_revenue DESC
LIMIT 1;

-- Which month had the highest number of won opportunities?
SELECT
    DATE_FORMAT(close_date, '%Y-%m') AS month,
    COUNT(*) AS won_opportunities
FROM sales_pipeline
WHERE deal_stage = 'Won'
  AND close_date IS NOT NULL
GROUP BY DATE_FORMAT(close_date, '%Y-%m')
ORDER BY won_opportunities DESC
LIMIT 1;

-- Which month had the highest win rate?
SELECT
    DATE_FORMAT(close_date, '%Y-%m') AS month,
    COUNT(*) AS won_opportunities
FROM sales_pipeline
WHERE deal_stage = 'Won'
  AND close_date IS NOT NULL
GROUP BY DATE_FORMAT(close_date, '%Y-%m')
ORDER BY won_opportunities DESC
LIMIT 1;

-- What is the month-over-month revenue growth?
WITH monthly_win_rate AS (
    SELECT
        DATE_FORMAT(close_date, '%Y-%m') AS month,
        COUNT(CASE WHEN deal_stage = 'Won' THEN 1 END) AS won_opportunities,
        COUNT(CASE WHEN deal_stage IN ('Won', 'Lost') THEN 1 END) AS closed_opportunities
    FROM sales_pipeline
    WHERE close_date IS NOT NULL
    GROUP BY DATE_FORMAT(close_date, '%Y-%m')
)
SELECT
    month,
    won_opportunities,
    closed_opportunities,
    ROUND(
        won_opportunities * 100.0 /
        NULLIF(closed_opportunities, 0),
        2
    ) AS win_rate
FROM monthly_win_rate
ORDER BY win_rate DESC
LIMIT 1;

-- How has the average deal value changed month over month?
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(close_date, '%Y-%m') AS month,
        SUM(close_value) AS revenue
    FROM sales_pipeline
    WHERE deal_stage = 'Won'
      AND close_date IS NOT NULL
    GROUP BY DATE_FORMAT(close_date, '%Y-%m')
),
revenue_comparison AS (
    SELECT
        month,
        revenue,
        LAG(revenue) OVER (ORDER BY month) AS previous_month_revenue
    FROM monthly_revenue
)
SELECT
    month,
    revenue,
    previous_month_revenue,
    ROUND(
        (revenue - previous_month_revenue) * 100.0 /
        NULLIF(previous_month_revenue, 0),
        2
    ) AS mom_revenue_growth
FROM revenue_comparison
ORDER BY month;

-- How has the average sales cycle changed month over month?
WITH monthly_deals AS (
    SELECT
        DATE_FORMAT(close_date, '%Y-%m') AS month,
        SUM(close_value) AS total_revenue,
        COUNT(*) AS won_opportunities
    FROM sales_pipeline
    WHERE deal_stage = 'Won'
      AND close_date IS NOT NULL
    GROUP BY DATE_FORMAT(close_date, '%Y-%m')
),
avg_deals AS (
    SELECT
        month,
        total_revenue,
        won_opportunities,
        total_revenue / NULLIF(won_opportunities, 0) AS avg_deal_value
    FROM monthly_deals
)
SELECT
    month,
    ROUND(avg_deal_value, 2) AS avg_deal_value,
    ROUND(
        LAG(avg_deal_value) OVER (ORDER BY month),
        2
    ) AS previous_month_avg_deal_value,
    ROUND(
        (
            avg_deal_value -
            LAG(avg_deal_value) OVER (ORDER BY month)
        ) * 100.0 /
        NULLIF(
            LAG(avg_deal_value) OVER (ORDER BY month),
            0
        ),
        2
    ) AS mom_change_percentage
FROM avg_deals
ORDER BY month;

-- Which products generated the highest revenue each month?
WITH monthly_sales_cycle AS (
    SELECT
        DATE_FORMAT(close_date, '%Y-%m') AS month,
        AVG(DATEDIFF(close_date, engage_date)) AS avg_sales_cycle
    FROM sales_pipeline
    WHERE close_date IS NOT NULL
      AND engage_date IS NOT NULL
      AND deal_stage IN ('Won', 'Lost')
    GROUP BY DATE_FORMAT(close_date, '%Y-%m')
)
SELECT
    month,
    ROUND(avg_sales_cycle, 2) AS avg_sales_cycle_days,
    ROUND(
        LAG(avg_sales_cycle) OVER (ORDER BY month),
        2
    ) AS previous_month_cycle_days,
    ROUND(
        avg_sales_cycle -
        LAG(avg_sales_cycle) OVER (ORDER BY month),
        2
    ) AS change_in_days
FROM monthly_sales_cycle
ORDER BY month;

-- Which sales agents generated the highest revenue each month?
WITH monthly_product_revenue AS (
    SELECT
        DATE_FORMAT(s.close_date, '%Y-%m') AS month,
        p.product,
        p.series,
        SUM(s.close_value) AS revenue
    FROM sales_pipeline s
    INNER JOIN products p
        ON s.product = p.product
    WHERE s.deal_stage = 'Won'
      AND s.close_date IS NOT NULL
    GROUP BY
        DATE_FORMAT(s.close_date, '%Y-%m'),
        p.product,
        p.series
),
ranked_products AS (
    SELECT
        month,
        product,
        series,
        revenue,
        RANK() OVER (
            PARTITION BY month
            ORDER BY revenue DESC
        ) AS revenue_rank
    FROM monthly_product_revenue
)
SELECT
    month,
    product,
    series,
    revenue
FROM ranked_products
WHERE revenue_rank = 1
ORDER BY month;

-- Which regional office generated the highest revenue each month?
WITH monthly_agent_revenue AS (
    SELECT
        DATE_FORMAT(s.close_date, '%Y-%m') AS month,
        s.sales_agent,
        SUM(s.close_value) AS revenue
    FROM sales_pipeline s
    INNER JOIN sales_teams t
        ON s.sales_agent = t.sales_agent
    WHERE s.deal_stage = 'Won'
      AND s.close_date IS NOT NULL
    GROUP BY
        DATE_FORMAT(s.close_date, '%Y-%m'),
        s.sales_agent
),
ranked_agents AS (
    SELECT
        month,
        sales_agent,
        revenue,
        RANK() OVER (
            PARTITION BY month
            ORDER BY revenue DESC
        ) AS revenue_rank
    FROM monthly_agent_revenue
)
SELECT
    month,
    sales_agent,
    revenue
FROM ranked_agents
WHERE revenue_rank = 1
ORDER BY month;

-- What percentage of total annual revenue was generated by each month?
WITH monthly_region_revenue AS (
    SELECT
        DATE_FORMAT(s.close_date, '%Y-%m') AS month,
        t.regional_office,
        SUM(s.close_value) AS revenue
    FROM sales_pipeline s
    INNER JOIN sales_teams t
        ON s.sales_agent = t.sales_agent
    WHERE s.deal_stage = 'Won'
      AND s.close_date IS NOT NULL
    GROUP BY
        DATE_FORMAT(s.close_date, '%Y-%m'),
        t.regional_office
),
ranked_regions AS (
    SELECT
        month,
        regional_office,
        revenue,
        RANK() OVER (
            PARTITION BY month
            ORDER BY revenue DESC
        ) AS revenue_rank
    FROM monthly_region_revenue
)
SELECT
    month,
    regional_office,
    revenue
FROM ranked_regions
WHERE revenue_rank = 1
ORDER BY month;