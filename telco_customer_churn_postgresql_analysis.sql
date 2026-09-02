-- Total Customers
select count(distinct customer_id) from customer;

--chruned customers
select count(*) from customer
where churn = 'Yes';

--gender wise total customers, chrun count and churn percentage
select gender, count(*) as total_customers,
sum(case when churn='Yes' then 1 else 0 end) as churn_count,
round(100*sum(case when churn='Yes' then 1 else 0 end)/count(*),2) as churn_percentage
from customer
group by gender
order by churn_percentage desc;

--seniorcitizen wise total customers, chrun count and churn percentage
select senior_citizen , count(*) as total_customers,
sum(case when churn='Yes' then 1 else 0 end) as churn_count,
round(100*sum(case when churn='Yes' then 1 else 0 end)/count(*),2) as churn_percentage
from customer
group by senior_citizen
order by churn_percentage desc;

--partner wise total customers,churn count,churn percentage
select partner, count(*) as total_customers,
sum(case when churn='Yes' then 1 else 0 end) as churn_count,
round(100*sum(case when churn='Yes' then 1 else 0 end)/count(*),2) as churn_percentage
from customer
group by partner
order by churn_percentage desc;

--dependents wise total customers,churn count,churn percentage
select dependents, count(*) as total_customers,
sum(case when churn='Yes' then 1 else 0 end) as churn_count,
round(100*sum(case when churn='Yes' then 1 else 0 end)/count(*),2) as churn_percentage
from customer
group by dependents
order by churn_percentage desc;

--contract wise total-cusomers, churn count and churn percentage
select contract, count(*) as total_customers,
sum(case when churn='Yes' then 1 else 0 end) as chrun_count,
round(100*sum(case when churn='Yes' then 1 else 0 end)/count(*),2) as churn_percentage
from customer
group by contract
order by churn_percentage desc;

--paymentmethod wise total customers, chrun count and churn percentage
select payment_method, count(*) as total_customers,
sum(case when churn='Yes' then 1 else 0 end) as chrun_count,
round(100*sum(case when churn='Yes' then 1 else 0 end)/count(*),2) as churn_percentage
from customer
group by payment_method
order by churn_percentage desc;

--paperless billing wise total customers, churn_count and churn percentage
select paperless_billing, count(*) as total_customers,
sum(case when churn = 'Yes' then 1 else 0 end) as churn_count,
round(100*sum(case when churn = 'Yes' then 1 else 0 end)/count(*),2) as churn_percentage
from customer
group by paperless_billing
order by churn_percentage desc;

--Does monthly charge level influence customer churn?
with customer_segment as (
select 
monthly_charges,
churn,
case
	when monthly_charges > avg(monthly_charges) over() then 'above average'
	when monthly_charges < avg(monthly_charges) over() then 'below average'
	else 'equal to average'
end as monthly_segment
from customer
)
select monthly_segment,
count(*) as total_customers,
sum(case when churn='Yes' then 1 else 0 end) as chrun_count,
round(100*sum(case when churn='Yes' then 1 else 0 end)/count(*),2) as churn_percentage
from customer_segment
group by monthly_segment
order by churn_percentage desc;

--How does customer churn vary across tenure and total spending levels?
with averages as (
select
	avg(tenure) as avg_tenure,
	avg(total_charges) as avg_total_charges
from customer
)
select
	case
		when tenure < avg_tenure and total_charges < avg_total_charges then 'Low Tenure - Low Charges'
		when tenure < avg_tenure and total_charges >= avg_total_charges then 'Low Tenure - High Charges'
		when tenure >= avg_tenure and total_charges < avg_total_charges then 'High Tenure - Low Charges'
		else 'High Tenure - High Charges'
	end as customer_segment,
	count(*) as customer_count,
	sum(case when churn = 'Yes' then 1 else 0 end) as churn_count,
	round(100*sum(case when churn = 'Yes' then 1 else 0 end)/count(*),2) as ch
	

-- Service adoption impact on churn
with service_counts as(
select
	customer_id,
	(
		case when phone_service = 'Yes' then 1 else 0 end +
		case when multiple_lines = 'Yes' then 1 else 0 end +
		case when internet_service != 'No' then 1 else 0 end +
		case when online_security = 'Yes' then 1 else 0 end +
		case when online_backup = 'Yes' then 1 else 0 end +
		case when device_protection = 'Yes' then 1 else 0 end +
		case when tech_support = 'Yes' then 1 else 0 end +
		case when streaming_tv = 'Yes' then 1 else 0 end +
		case when streaming_movies = 'Yes' then 1 else 0 end 
	) as total_services,
	churn
from customer
)

select
	total_services,
	count(*) as total_customers,
	sum(case when churn = 'Yes' then 1 else 0 end) as churn_count,
	round(100*sum(case when churn = 'Yes' then 1 else 0 end)/count(*),2) as churn_percentage
from service_counts
group by total_services
order by total_services;

---cohort analysis by tenure and their characterstics
with cohorts as (
select 
	case
		when tenure<=6 then '0-6 months'
		when tenure<=12 then '6-12 months'
		when tenure<=24 then '1-2 years'
		when tenure<=36 then '2-3 years'
		else '3+ years'
	end as cohort,
	customer_id,
	monthly_charges,
	total_charges,
	churn
from customer
)
select 
cohort,
count(*) as total_customers,
round(sum(monthly_charges::numeric),2) as total_monthly_revenue,
round(avg(monthly_charges::numeric),2) as average_monthly_revenue,
round(sum(total_charges::numeric),2) as total_lifetime_revenue,
round(avg(total_charges::numeric),2) as average_lifetime_revenue,
sum(case when churn = 'Yes' then 1 else 0 end) as churn_count,
round(100*sum(case when churn = 'Yes' then 1 else 0 end)/count(*),2) as churn_percentage
from cohorts
group by cohort
order by cohort asc;

	


