-- How many total records are present in the sales_pipeline table?
select count(*) from sales_pipeline;

-- Are there any duplicate opportunity_id values?
select opportunity_id, count(*) as duplicate_value from sales_pipeline
	group by opportunity_id having count(*) >1;

-- Are there any missing values in the sales_pipeline table?
select 
	sum(opportunity_id is null) as missing_opportunity_id,
    sum(sales_agent is null) as missing_sales_agent,
    sum(product is null) as missing_product,
    sum(account is null) as missing_account,
    sum(deal_stage is null) as missing_deal_stage,
    sum(engage_date is null) as missing_engage_date,
    sum(close_date is null) as missing_close_date,
    sum(close_value is null) as missing_close_value
    from sales_pipeline ;
    
-- Check blank/empty string values
SELECT 
    SUM(TRIM(opportunity_id) = '') AS blank_opportunity_id,
    SUM(TRIM(sales_agent) = '') AS blank_sales_agent,
    SUM(TRIM(product) = '') AS blank_product,
    SUM(TRIM(account) = '') AS blank_account,
    SUM(TRIM(deal_stage) = '') AS blank_deal_stage
FROM sales_pipeline;

-- Check valid deal stages
SELECT 
    deal_stage,
    COUNT(*) AS record_count
FROM sales_pipeline
GROUP BY deal_stage
ORDER BY record_count DESC;

-- Find invalid deal stages
SELECT *
FROM sales_pipeline
WHERE deal_stage NOT IN (
    'Won',
    'Lost',
    'Engaging',
    'Prospecting'
);

-- Check negative close_value
SELECT *
FROM sales_pipeline
WHERE close_value < 0;

-- Check zero close_value
SELECT *
FROM sales_pipeline
WHERE close_value = 0;

-- Check missing or invalid close values for Won deals
SELECT *
FROM sales_pipeline
WHERE deal_stage = 'Won'
  AND (close_value IS NULL OR close_value <= 0);
  
-- Check close values for Lost deals
SELECT *
FROM sales_pipeline
WHERE deal_stage = 'Lost'
  AND close_value IS NOT NULL
  AND close_value > 0;
  
-- Check date validity
SELECT *
FROM sales_pipeline
WHERE close_date < engage_date;

-- Check missing dates
SELECT 
    SUM(engage_date IS NULL) AS missing_engage_date,
    SUM(close_date IS NULL) AS missing_close_date
FROM sales_pipeline;

-- Check future dates
SELECT *
FROM sales_pipeline
WHERE engage_date > CURDATE()
   OR close_date > CURDATE();
   
-- Check duplicate opportunities with different information
SELECT 
    opportunity_id,
    COUNT(DISTINCT sales_agent) AS different_agents,
    COUNT(DISTINCT product) AS different_products,
    COUNT(DISTINCT account) AS different_accounts,
    COUNT(DISTINCT deal_stage) AS different_stages
FROM sales_pipeline
GROUP BY opportunity_id
HAVING COUNT(*) > 1;

-- Data-quality summary
SELECT
    COUNT(*) AS total_records,

    SUM(opportunity_id IS NULL) AS missing_opportunity_id,
    SUM(sales_agent IS NULL) AS missing_sales_agent,
    SUM(product IS NULL) AS missing_product,
    SUM(account IS NULL) AS missing_account,
    SUM(deal_stage IS NULL) AS missing_deal_stage,
    SUM(engage_date IS NULL) AS missing_engage_date,
    SUM(close_date IS NULL) AS missing_close_date,
    SUM(close_value IS NULL) AS missing_close_value,

    COUNT(DISTINCT opportunity_id) AS unique_opportunities,

    SUM(close_value < 0) AS negative_close_values,
    SUM(close_value = 0) AS zero_close_values,

    SUM(close_date < engage_date) AS invalid_date_records

FROM sales_pipeline;


    
