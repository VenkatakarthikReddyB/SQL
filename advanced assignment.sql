--1.

SELECT sum(population) FROM `bigquery-public-data.census_bureau_usa.population_by_zip_2010` where zipcode = '94085';

--2.

SELECT gender, sum(population) as Head_Count FROM `bigquery-public-data.census_bureau_usa.population_by_zip_2010` where zipcode = '94085'group by gender having gender is not null ;



--3.
select minimum_age, maximum_age, Tot_Population from(
select minimum_age, maximum_age, sum(population) as Tot_Population ,
        ROW_NUMBER() over (order by sum(population) Desc) as ROW_NUM from `bigquery-public-data.census_bureau_usa.population_by_zip_2010` where zipcode = '94085'and (minimum_age is not null and maximum_age is not null) group by minimum_age,maximum_age) where ROW_NUM= 1;


--4.
select minimum_age, maximum_age,Tot_Male_Population from (
select minimum_age, maximum_age, sum(population) as Tot_Male_Population, RANK() OVER (ORDER BY sum(population) DESC) AS rank from `bigquery-public-data.census_bureau_usa.population_by_zip_2010` where (zipcode = '94085' and gender='male')and (minimum_age is not null and maximum_age is not null) group by minimum_age,maximum_age) where rank=1 ;

--5.
select minimum_age, maximum_age, Tot_Female_Population from (
select minimum_age, maximum_age, sum(population) as Tot_Female_Population, rank() over (order by sum(population) desc) as rank from `bigquery-public-data.census_bureau_usa.population_by_zip_2010` where (zipcode = '94085' and gender='female')and (minimum_age is not null and maximum_age is not null) group by minimum_age,maximum_age ) where rank=1;



--6.
select zipcode, Total_Population from(
select zipcode, sum(population) as Total_Population, dense_rank() over (order by sum(population) desc) as dens_rnk from `bigquery-public-data.census_bureau_usa.population_by_zip_2010`  group by zipcode) where dens_rnk=1;

--7.

select minimum_age, maximum_age, Tot_Population from(
select minimum_age, maximum_age, sum(population) as Tot_Population, dense_rank() over (order by sum(population) desc) as dense_rnk from `bigquery-public-data.census_bureau_usa.population_by_zip_2010` where minimum_age is not null and maximum_age is not null group by minimum_age,maximum_age) where dense_rnk<= 5;


--8.
select zipcode, tot_female_pop from(
select zipcode, sum(population) as tot_female_pop, dense_rank() over (order by sum(population) desc) as dense_rnk from `bigquery-public-data.census_bureau_usa.population_by_zip_2010` where gender='female' group by zipcode ) where dense_rnk<=5;


--9.
select zipcode, tot_male_pop from(
select zipcode, sum(population) as tot_male_pop, row_number() over (order by sum(population) ASC) as row_fun from `bigquery-public-data.census_bureau_usa.population_by_zip_2010` where gender='male' group by zipcode having  tot_male_pop>0) where row_fun<=10;
