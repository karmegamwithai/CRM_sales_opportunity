-- Which products generate the highest closed-won revenue?
select s.product,sum(a.revenue) total_revenue from 
	accounts a
    inner join sales_pipeline s
    on a.account = s.account
    where s.deal_stage = 'won'
    group by s.product
    order by total_revenue desc;

-- Which products have the highest number of won opportunities?
select product,count(deal_stage) no_won_opp from sales_pipeline
	where deal_stage = 'won'
    group by product
    order by no_won_opp desc;

-- Which products have the highest win rate?
SELECT
    product,
    COUNT(*) AS total_deals,
    SUM(CASE 
            WHEN deal_stage = 'won' THEN 1 
            ELSE 0 
        END) AS won_deals,
    ROUND(
        SUM(CASE 
                WHEN deal_stage = 'won' THEN 1 
                ELSE 0 
            END) * 100.0 / COUNT(*),
        2
    ) AS win_rate
FROM sales_pipeline
GROUP BY product
ORDER BY win_rate DESC;

-- What is the average deal value for each product?
SELECT
    product,
    COUNT(*) AS total_deals,
    ROUND(AVG(close_value), 2) AS average_deal_value
FROM sales_pipeline
GROUP BY product
ORDER BY average_deal_value DESC;

-- Which product series generates the highest revenue?
SELECT
    p.product,
    round(SUM(a.revenue),2) AS total_revenue
FROM sales_pipeline p
inner join accounts a
on p.account = a.account
WHERE deal_stage = 'won'
GROUP BY product
ORDER BY total_revenue DESC;


-- How does actual closed-won deal value compare with the product's standard sales price?
SELECT
    s.product,
    AVG(s.close_value) AS avg_closed_won_value,
    p.sales_price AS standard_sales_price,
    ROUND(AVG(s.close_value) - p.sales_price, 2) AS difference,
    ROUND(
        (AVG(s.close_value) - p.sales_price) * 100.0 / p.sales_price,
        2
    ) AS percentage_difference
FROM sales_pipeline s
INNER JOIN products p
    ON s.product = p.product
WHERE s.deal_stage = 'won'
GROUP BY
    s.product,
    p.sales_price
ORDER BY percentage_difference DESC;