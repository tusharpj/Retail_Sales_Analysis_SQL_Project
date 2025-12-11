#Database Creation
use retail_sales_analysis_sql_project;

#Create Table
create table Retail_sales(
transactions_id	int primary key,
sale_date date,	
sale_time time,
customer_id	int,
gender varchar(20),
age	int,
category varchar(20),	
quantiy	 int,
price_per_unit float,	
cogs float,	
total_sales int
);

#This is a command for checking a stricture of a table
desc retail_sales;

#For retrieving all data from table
select * from retail_sales;

#This command is used for checking no.of records or rows in table
select count(*) from retail_sales;

### DATA TRANSFORMATION ###

	#command used for changing the column name
	alter table retail_sales rename column quantiy to quantity;

### DATA CLEANING ###

	#command used for checking null values in a single column
	select * from retail_sales
	where transactions_id is null;

	#command used for checking null values in a mutiple column using (or) operator
	select * from retail_sales
		where 
			transactions_id is null
			or
			 sale_date is null
			or
			sale_time is null
			or
			customer_id is null
			or
			gender is null
			or
			age is null
			or
			category is null
			or
			quantity is null
			or
			price_per_unit is null
			or
			cogs is null
			or
			total_sales is null;
	#this command used for enabling a upadte or delete command in mysql
	set sql_safe_updates=0;
	 
	#command used for deleting a null values if exist in table using where clause and (or) operator 
	delete from retail_sales
		where 
			transactions_id is null
			or
			 sale_date is null
			or
			sale_time is null
			or
			customer_id is null
			or
			gender is null
			or
			age is null
			or
			category is null
			or
			quantity is null
			or
			price_per_unit is null
			or
			cogs is null
			or
			total_sales is null;
        
### DATA EXPLORATION ###
	
    #CHECKING FOR NO.OF SALES
    select count(*) as Total_no_of_sales from retail_sales;
    
    #checking for unique customers
    select count(distinct customer_id) as Unique_Customers from retail_sales;
    
    #CHECKING FOR UNIQUE CATEGORY
    select distinct category from retail_sales;
    
### DATA ANALYSIS & BUSINESS PROBLEM ###

#(1) WRITE A SQL QUERY TO RETRIEVE ALL COLUMNS FOR SALES MADE ON '2022-11-05'
 
 select * from retail_sales 
	where sale_date='2022-11-05';
    
#(2) WRITE A SQL QUERY TO RETRIEVE ALL TRANSACTIONS WHERE THE CATEGORY IS 'CLOHING' AND THE QUANTITY SOLD IS MORE THAN 3 IN THE MONTH OF NOV-2022
 
 select * from retail_sales
	 where  category='clothing'
		 and quantity>3
		 and sale_date>=('2022-11-01')
		 and sale_date<('2022-11-30');
         
#(3) WRITE A SQL QUERY TO CALCULATE THE TOTAL SALES FOR EACH CATEGORY

 select category,sum(total_sales) as Total_Sales 
	from retail_sales
	group by 1;
    
#(4) WRITE A SQL QUERY TO FIND THE AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM 'BEAUTY' CATEGORY

 select category,round(avg(age),2) avg_age_of_customers from retail_sales
 where category='Beauty'
	group by 1;
    
#(5) WRITE A SQL QUERY TO FIND ALL TRANSACTIONS WHERE THE TOTAL SALES IS GREATER THAN 1000

 select * from retail_sales
	where total_sales>1000;
    
#(6) WRITE A SQL QUERY TO FIND THE TOTAL NUMBER OF TRANSACTIONS(transaction_id) MADE BY EACH GENDER IN EACH CATEGORY

 select category,
		 gender,
		count(*) as Transaction_records 
from retail_sales
group by gender,
		category
order by category;
 
#(7) WRITE A SQL QUERY TO CALCULATE THE AVERAGE SALE FOR EACH MONTH.FIND OUT BEST SELLING MONTH IN EACH YEAR.

 
 select 
 yearr,
 monthh,
 average_sale
 from
 (
 select 
	year(sale_date) as yearr,
	month(sale_date) as monthh,
	avg(total_sales) as average_sale,
    rank() over(partition by year(sale_date) order by avg(total_sales) desc) as rankk
from retail_sales
group by 1,2 ) as t1
where rankk=1;

#(8) WRITE A SQL QUERY TO FIND THE TOP 5 CUSTOMERS BASED ON THE HIGHEST TOTAL SALES

 select customer_id,sum(total_sales) as  Highest_Total_Sales
 from retail_sales
 group by customer_id
 order by Highest_Total_Sales desc
 limit 5;
 
#(9) WRITE A SQL QUERY TO FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEM FROM EACH CATEGORY
 
 select category,count(distinct customer_id) as Unique_Customers
 from retail_sales
 group by category;
 
#(10) WRITE A SQL QUERY TO CREATE EACH SHIFT AND NUMBER OF ORDERS (EXAMPLE MORNING <=12, AFTERNOON BETWEEN 12 & 17 , EVENING>17)


with Orders as
(
 select *,
	case 
		when hour(sale_time)<=12  then "Morning Shift"
        when hour(sale_time) between 12 and 17 then "Afternoon shift"
        else "Evening shift"
	end as shifts
 from retail_sales)
 select shifts ,
		count(*) as order_count
from orders 
group by shifts ;


## END OF PROJECT ##
 
 


    

 



 
	
 
 


	
	
    

