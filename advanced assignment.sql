--1.

SELECT sum(population) FROM `bigquery-public-data.census_bureau_usa.population_by_zip_2010` where zipcode = '94085';

--2.

SELECT gender, sum(population) as Head_Count FROM `bigquery-public-data.census_bureau_usa.population_by_zip_2010` where zipcode = '94085'group by gender having gender is not null ;



--3.

select minimum_age, maximum_age, sum(population) as Tot_Population from `bigquery-public-data.census_bureau_usa.population_by_zip_2010` where zipcode = '94085'and (minimum_age is not null and maximum_age is not null) group by minimum_age,maximum_age order by Tot_Population desc 
limit 1;


--4.

select minimum_age, maximum_age, sum(population) as Tot_Male_Population from `bigquery-public-data.census_bureau_usa.population_by_zip_2010` where (zipcode = '94085' and gender='male')and (minimum_age is not null and maximum_age is not null) group by minimum_age,maximum_age order by Tot_Male_Population desc 
limit 1;

--5.

select minimum_age, maximum_age, sum(population) as Tot_Female_Population from `bigquery-public-data.census_bureau_usa.population_by_zip_2010` where (zipcode = '94085' and gender='female')and (minimum_age is not null and maximum_age is not null) group by minimum_age,maximum_age order by Tot_Female_Population desc 
limit 1;



--6.

select zipcode, sum(population) as Total_Population from `bigquery-public-data.census_bureau_usa.population_by_zip_2010`  group by zipcode order by Total_Population desc limit 1;

--7.


select minimum_age, maximum_age, sum(population) as Tot_Population from `bigquery-public-data.census_bureau_usa.population_by_zip_2010` where minimum_age is not null and maximum_age is not null group by minimum_age,maximum_age order by Tot_Population desc 
limit 5;


--8.

select zipcode, sum(population) as tot_female_pop from `bigquery-public-data.census_bureau_usa.population_by_zip_2010` where gender='female' group by zipcode order by tot_female_pop desc 
limit 5;


--9.

select zipcode, sum(population) as tot_male_pop from `bigquery-public-data.census_bureau_usa.population_by_zip_2010` where gender='male' group by zipcode having  tot_male_pop>0 order by tot_male_pop 
limit 10;

