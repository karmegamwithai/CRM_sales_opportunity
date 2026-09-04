-- Which regional office generates the highest closed-won revenue?
select t.regional_office,sum(a.revenue) as closed_won_revenue
	from sales_pipeline s
    inner join sales_teams t
    inner join accounts a
    on s.sales_agent = t.sales_agent and s.account = a.account 
    where deal_stage = 'won'
    group by
		t.regional_office
	order by
		closed_won_revenue desc;
        
-- Which regional office has the highest opportunity win rate?
with high_win as 
( select count(case when p.deal_stage ='won' then 1 end ) as total_won,
	count(p.deal_stage) as total_count,t.regional_office as reg_office
    from sales_pipeline p
    inner join sales_teams t
    on p.sales_agent = t.sales_agent
    group by 
		reg_office
)
select reg_office, total_won*100/total_count as high_win_rate from high_win
	order by
		high_win_rate desc;
	

-- How many sales agents work under each manager?
select * from sales_teams;
select distinct manager, count(sales_agent)as num_of_agents from sales_teams
	group by manager
    order by num_of_agents desc;

-- Which managers have the highest total closed-won revenue?
select t.manager,sum(a.revenue) as total_revenue
	from sales_teams t
    inner join sales_pipeline p
    inner join accounts a
    on t.sales_agent = p.sales_agent and p.account = a.account
    where p.deal_stage = 'won'
    group by 
		t.manager
	order by
		total_revenue desc;
        
-- Which managers have the highest average win rate across their sales teams?
with avg_win_rate as
( select t.manager manager,count(case when p.deal_stage = 'won' then 1 end) as total_won, count(p.deal_stage) as total
	from sales_teams t
    inner join sales_pipeline p
    on t.sales_agent = p.sales_agent
    group by 
		t.manager
)
select manager,total_won*100/total as avg_win_rate from avg_win_rate
	order by 
		avg_win_rate desc;
