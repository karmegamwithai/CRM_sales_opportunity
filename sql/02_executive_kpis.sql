-- EXECUTIVE KPIS

-- What is the total number of sales opportunities in the pipeline?
select count(*) from sales_pipeline;

-- What is the total closed-won revenue generated?
select sum(a.revenue) as total_closed_won_revenue,s.deal_stage
	from accounts a
    inner join sales_pipeline s
    on a.account = s.account 
    where s.deal_stage ='won';

-- What is the average deal value for closed-won opportunities?
select avg(close_value) from sales_pipeline where deal_stage = 'won';

-- What is the total number of closed-won and closed-lost opportunities?
select * from sales_pipeline;
with CTE as 
( select count(case when deal_stage = 'won' then 1 end) as won_sales,
		count(case when deal_stage = 'lost' then 1 end) as lost_sales from sales_pipeline
)
select * from CTE;

-- What is the overall win rate of sales opportunities?
with win_rate as 
( select sum( case when deal_stage = 'won' then 1 else 0 end)*100/count(deal_stage) as 
	calculate_from_win_rate from sales_pipeline
)
select * from win_rate;

-- What is the total pipeline value across all opportunities?
select sum(close_value) from sales_pipeline;

-- What is the average sales cycle length from engagement date to close date?
select avg(datediff(close_date,engage_date)) as avg_sales_cycle from sales_pipeline;

-- How has closed-won revenue changed month-over-month?
select s.deal_stage, monthname(s.close_date) as month,sum(a.revenue ) as monthy_revenue
	from sales_pipeline s
    inner join accounts a 
    where s.deal_stage = 'won'
    group by
		s.deal_stage,
        month(s.close_date),
		monthname(s.close_date)
	order by 
		monthname(s.close_date);
	