# The USE statement tells MySQL to use bank_marketing as the default database for subsequent statements
use bank_marketing;

/* 1. 	Write an SQL query to identify the age group which is taking more loan and then calculate the sum of all of the balances of it? */
/*Select fetches the values of  sum of balanace ,CASE statement goes through conditions and returns a value when the first condition is met 
(like an if-then-else statement) and the result is assigned to age_group. The result set groups by age_group rows that have the same values into summary rows and 
then order by count(age_group) sorts the result-set in descending order. limit 1 is used to get the top most result */
SELECT  sum(balance),
           CASE
                WHEN age >= 18 AND age <= 30 AND (loan='yes' OR housing='yes') THEN '18-30'
                WHEN age > 30  AND age <= 45 AND (loan='yes' OR housing='yes')THEN '30-45'
                WHEN age > 45  AND age <= 60 AND (loan='yes' OR housing='yes')THEN '45-60'
                WHEN age > 60  AND age <= 71 AND (loan='yes' OR housing='yes')THEN '60-71'
                END AS age_group
FROM    bank_sql group by age_group order by count(age_group) desc limit 1;

/* 2.	Write an SQL query to calculate for each record if a loan has been taken less than 100, then  calculate the fine of 15% of the current balance
 and create a temp table and     then add the amount for each month from that temp table? */
 /* To select each record if loan has been taken we filter by checking if housing or loan is yes and to get 100 records limit 100 is used. Temporary table is created
 to calculate fine balance is multiplied by 0.15 and rounded by 2 decimals.To add amount for each month contact_month is used in select query.*/
CREATE TEMPORARY TABLE temp_bank_table
 select * from bank_sql where housing='yes' or loan='yes'
 limit 100;
 select format(0.15*balance,2) as fine_balance from temp_bank_table;
 select format(0.15*balance,2) as fine_balance,contact_month as month from temp_bank_table;

 /* 3.	Write an SQL query to calculate each age group along with each department's highest balance record? */
 /* To make different age groups case statement is used where conditions are passed. Select fetches housing, loan, balance and age_group grouped by
 age_group rows that have the same values into summary rows to get highest balance order by balance descending is used.*/ 
 SELECT  housing,loan,balance,
           CASE
                WHEN age >= 18 AND age <= 30 AND (loan='yes' OR housing='yes') THEN '18-30'
                WHEN age > 30  AND age <= 45 AND (loan='yes' OR housing='yes')THEN '30-45'
                WHEN age > 45  AND age <= 60 AND (loan='yes' OR housing='yes')THEN '45-60'
                WHEN age > 60  AND age <= 71 AND (loan='yes' OR housing='yes')THEN '60-71'
                END AS age_group
FROM    bank_sql group by age_group order by balance desc;

/* 4.	Write an SQL query to find the secondary highest education, where duration is more than 150. The query should contain only married people, 
and then calculate the interest amount? (Formula interest => balance*15%). */
/* Select fetches records from bank_sql filtering for conditions education=secondary,duration>150 and marital-married. The result set is limited to 1 to 
find the topmost result. Then interest is calculated as 15% of balance. */
 select education ,duration,marital,balance from bank_sql where education='secondary' and duration>150 and marital='married' 
 limit 1;
 select education ,duration,marital,(balance*0.15) as interest from bank_data where education='secondary' and duration>150 and marital='married' 
 limit 1;
 
 /* 5.	Write an SQL query to find which profession has taken more loan along with age?*/
 /* To find which profession is taking more loan the result query is grouped by housing. To get more loan the result is ordered by housing and loan*/
 select job,age from bank_sql where housing='yes' or loan='yes' group by job order by housing desc,loan desc
 limit 1;
 
 /* 6.	Write an SQL query to calculate each month's total balance and then calculate in which month the highest amount of transaction was performed?*/
  /* select fetches total balance and month. To find each month's total balance the result is grouped by month ,Order by descending is used to find
  the highest number of transaction*/
  select sum(balance), contact_month from bank_sql group by contact_month order by balance desc;
 


 
 
 
 
 