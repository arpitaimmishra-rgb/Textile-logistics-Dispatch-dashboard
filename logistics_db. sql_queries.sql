select * from logistics_db.logistics_db;

-- Change the Column Name
alter table logistics_db.logistics_db
rename column ï»¿Dispatch_ID to Dispatch_ID;

-- check null & blanks--
select 
sum(case when Dispatch_ID is null then 1 else 0 end) as dispatch_id_nulls,
sum(case when Yarn_Type is null then 1 else 0 end) as yarn_type_nulls,
sum(case when Denier is null then 1 else 0 end) as denier_nulls,
sum(case when Packaging is null then 1 else 0 end) as packaging_nulls,
sum(case when Quantity is null then 1 else 0 end) as quantity_nulls,
sum(case when Vendor_Name is null then 1 else 0 end) as vendor_nulls,
sum(case when Customer_Name is null then 1 else 0 end) as customer_nulls,
sum(case when Destination_City is null then 1 else 0 end) as city_nulls,
sum(case when Vehicle_Number is null then 1 else 0 end) as vehicle_nulls,
sum(case when Delivery_Status is null then 1 else 0 end) as status_nulls,
sum(case when Delay_Reason is null or Delay_Reason = '' then 1 else 0 end) as delay_reason_nulls,
sum(case when Cost_INR is null or Cost_INR = 0 then 1 else 0 end) as cost_nulls
from logistics_db.logistics_db;


-- Totale no. of records--
select count(*) from logistics_db.logistics_db;

-- Count of each delivery status--

select Delivery_Status, count(*) 
from logistics_db.logistics_db 
group by Delivery_Status;

-- Delivery Status Percantage--

select 
    Delivery_Status,
    count(*) AS Total,
    round(count(*) * 100.0 / (select count(*) from logistics_db.logistics_db), 2) AS Percentage
from logistics_db.logistics_db
group by Delivery_Status;

-- Delay reason breakdown--

select delay_reason, count(*) AS total
from logistics_db.logistics_db
where delivery_status = 'Delayed'
group by delay_reason
order by total desc;

-- city wise failed deliveries--

select destination_city, count(*) AS failed
from logistics_db.logistics_db
where delivery_status = 'Failed'
group by destination_city
order by failed desc
limit 5;

-- vender analysis--

select vendor_name, 
count(*) AS total_orders,
sum(case when delivery_status = 'Failed' then 1 else 0 end) AS failed,
round(sum(case when delivery_status = 'Failed' then 1 else 0 end) * 100.0 / count(*), 2) AS fail_rate
from logistics_db.logistics_db
group by vendor_name
order by fail_rate desc
limit 5;

-- Customer analysis--

select customer_name,
count(*) AS total_orders,
sum(case when delivery_status = 'Failed' then 1 else 0 end) As failed,
round(sum(case when delivery_status = 'Failed' then 1 else 0 end) * 100.0 / count(*), 2) AS fail_rate
from logistics_db.logistics_db
group by customer_name
order by fail_rate desc
limit 5;

-- cost Analysis --

select yarn_type,
round(avg(cost_inr), 2) as avg_cost,
round(min(cost_inr), 2) as min_cost,
round(max(cost_inr), 2) as max_cost,
sum(total_weight_kg) as total_weight
from logistics_db.logistics_db
group by yarn_type;

-- Monthwise trends--

select 
substring(dispatch_date, 4, 7) as month_year,
count(*) as total_orders,
sum(case when delivery_status = 'On Time' then 1 else 0 end) as on_time,
sum(case when delivery_status = 'Failed' then 1 else 0 end) as failed
from logistics_db.logistics_db
group by month_year
order by min(dispatch_date);


-- vehicle wise performance--

select vehicle_number,
count(*) as total_trips,
sum(case when delivery_status = 'Failed' then 1 else 0 end) as failed,
round(sum(case when delivery_status = 'Failed' then 1 else 0 end) * 100.0 / count(*), 2) as fail_rate
from logistics_db.logistics_db
group by vehicle_number
order by fail_rate desc
limit 10;


-- city wise avg cost--

select destination_city,
round(avg(cost_inr), 2) as avg_cost,
count(*) as total_orders
from logistics_db.logistics_db
group by destination_city
order by avg_cost desc;


-- vendor wise total weight dispatched--

select vendor_name,
sum(total_weight_kg) as total_weight,
count(*) as total_orders,
round(avg(cost_inr), 2) as avg_cost
from logistics_db.logistics_db
group by vendor_name
order by total_weight desc;


-- customer wise total orders and weight--

select customer_name,
count(*) as total_orders,
sum(total_weight_kg) as total_weight,
round(avg(cost_inr), 2) as avg_cost
from logistics_db.logistics_db
group by customer_name
order by total_orders desc;

-- Delay reason wise count full--

select delay_reason,
count(*) as total,
round(count(*) * 100.0 / (select count(*) from logistics_db.logistics_db where delivery_status != 'On Time'), 2) as pct
from logistics_db.logistics_db
where delivery_status != 'On Time'
group by delay_reason
order by total desc;

-- monthly cost trend analysis--

select substring(dispatch_date, 4, 7) as month_year,
round(sum(cost_inr), 2) as total_cost,
count(*) as total_orders
from logistics_db.logistics_db
group by month_year
order by min(dispatch_date);

-- packaging wise performance Analysis--

select packaging,
count(*) as total,
sum(case when delivery_status = 'Failed' then 1 else 0 end) as failed,
round(avg(cost_inr), 2) as avg_cost
from logistics_db.logistics_db
group by packaging
order by total desc;

-- delay reason and city join with cte analysis--

with delay_data as (
    select destination_city, delay_reason,
    count(*) as total
    from logistics_db.logistics_db
    where delivery_status != 'On Time'
    and delay_reason is not null
    and delay_reason != ''
    group by destination_city, delay_reason
),
ranked as (
    select *,
    dense_rank() over (partition by destination_city order by total desc) as rnk
    from delay_data
)
select destination_city, delay_reason, total
from ranked
where rnk = 1
order by total desc;


-- monthly trend with cte and running total--
with monthly as (
    select substring(dispatch_date, 4, 7) as month_year,
    min(dispatch_date) as sort_date,
    count(*) as total_orders,
    sum(case when delivery_status = 'On Time' then 1 else 0 end) as on_time,
    sum(case when delivery_status = 'Failed' then 1 else 0 end) as failed,
    round(sum(cost_inr), 2) as total_cost
    from logistics_db.logistics_db
    group by month_year
)
select month_year, total_orders, on_time, failed, total_cost,
sum(total_orders) over (order by sort_date) as running_total_orders,
sum(total_cost) over (order by sort_date) as running_total_cost
from monthly
order by sort_date;


-- yarn type and packaging combination analysis--
with yarn_pack as (
    select yarn_type, packaging,
    count(*) as total_orders,
    sum(total_weight_kg) as total_weight,
    round(avg(cost_inr), 2) as avg_cost,
    sum(case when delivery_status = 'Failed' then 1 else 0 end) as failed
    from logistics_db.logistics_db
    group by yarn_type, packaging
)
select *,
dense_rank() over (order by total_orders desc) as popularity_rank
from yarn_pack
order by popularity_rank;

