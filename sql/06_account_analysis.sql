-- Which accounts generate the highest closed-won revenue?
SELECT
    s.account,
    SUM(s.close_value) AS closed_won_revenue
FROM sales_pipeline s
WHERE s.deal_stage = 'won'
GROUP BY s.account
ORDER BY closed_won_revenue DESC;

-- Which sectors generate the highest sales revenue?
SELECT
    a.sector,
    SUM(s.close_value) AS total_sales_revenue
FROM sales_pipeline s
INNER JOIN accounts a
    ON s.account = a.account
WHERE s.deal_stage = 'won'
GROUP BY a.sector
ORDER BY total_sales_revenue DESC;

-- How does account size—revenue and number of employees—relate to sales performance?
SELECT
    a.account,
    a.revenue AS account_revenue,
    a.employees,
    COUNT(s.account) AS won_deals,
    SUM(s.close_value) AS closed_won_revenue,
    ROUND(AVG(s.close_value), 2) AS avg_deal_value
FROM accounts a
INNER JOIN sales_pipeline s
    ON a.account = s.account
WHERE s.deal_stage = 'won'
GROUP BY
    a.account,
    a.revenue,
    a.employees
ORDER BY closed_won_revenue DESC;

-- Which accounts have opportunities stuck in the pipeline or lost, and what are their deal stages and potential values?
SELECT
    s.account,
    s.deal_stage,
    s.close_value AS potential_value
FROM sales_pipeline s
WHERE s.deal_stage <> 'won'
ORDER BY s.account, s.close_value DESC;
select * from sales_pipeline;
