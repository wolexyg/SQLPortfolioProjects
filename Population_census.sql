---Here is an SQL Data Analysis of the Indian Population census 2011 using Microsoft SQL Server
----This data is gotten from www.census2011.co.in/district.php
---Different Data Analysis were performed ranging from;
---Average growth for entire population
---total Population of India
---Average sex ratio by state
---State with the highest growth rate
---Average literacy ratio by state
---Current total population to previous total population
--Top 3 states which have displayed the highest average growth rate.

select * from dbo.Data1$

select * from dbo.Data2

---Number of rows in this data1
select count(*) from dbo.Data1$
select count(*) from dbo.Data2

--Filtering data for jharkhand and Bihar
select * from dbo.Data1$ where state in('jharkhand','Bihar')

---Total population of india
select sum(population) total_population from dbo.Data2

---Average growth
select avg(growth)*100 Average_growth from dbo.Data1$

---Finding the average growth for the entire country by state.
select state,avg(growth)*100 Average_growth from dbo.Data1$ where state is not null
group by state
---Average Sex ratio by state
select state,round(avg(sex_ratio),0) Average_sex_ratio from dbo.Data1$ where state is not null
group by state
----State with the highest growth rate
select state,round(avg(sex_ratio),0) Average_sex_ratio from dbo.Data1$ where state is not null
group by state order by Average_sex_ratio desc

----Average literacy ratio by state
select state,round(avg(literacy),0) Average_literacy_ratio from dbo.Data1$ where state is not null
group by state order by Average_literacy_ratio desc

--Average literacy ratio greater than 90
select state,round(avg(literacy),0) Average_literacy_ratio from dbo.Data1$ where state is not null
group by state having round(avg(literacy),0)>90 order by Average_literacy_ratio desc

--Top 3 states which have displayed the highest average growth rate.
select top 3 state,avg(growth)*100 average_growth from dbo.Data1$ group by state order by average_growth desc
---OR-
select state,avg(growth)*100 average_growth from dbo.Data1$ group by state order by average_growth desc limit 3
--bottom 3 state with the lowest sex ratio
select top 3 state,round(avg(sex_ratio),0) average_sex_ratio from dbo.Data1$  where state is not null
group by state 
order by average_sex_ratio asc
---Top and bottom 3 states in literacy state
Drop table if exists #topstates
create table #topstates
(state nvarchar(255),
topstates float
)
insert #topstates
select state,round(avg(Literacy),0) average_literacy_ratio from dbo.Data1$  where state is not null
group by state 
order by average_literacy_ratio desc
select top 3 * from #topstates order by #topstates.topstates desc

Drop table if exists #bottomstates
create table #bottomstates
(state nvarchar(255),
bottomstates float
)
insert #bottomstates
select state,round(avg(Literacy),0) average_literacy_ratio from dbo.Data1$  where state is not null
group by state 
order by average_literacy_ratio desc
select top 3 * from #bottomstates order by #bottomstates .bottomstates  asc

--Merging the two tables together using the UNION operator
select * from(
select top 3 * from #topstates order by #topstates.topstates desc) a
UNION
select * from(
select top 3 * from #bottomstates order by #bottomstates .bottomstates  asc) b
---Filtering out the states that starts with letter A
select distinct state from dbo.Data1$ where state like 'a%'


select a.district,a.state,a.sex_ratio,b.population from dbo.Data1$ a inner join dbo.Data2 b on a.district=b.district
--Equating the total number of males to the total number of females
select district,state,round(population/(sex_ratio+1),0)males,round((population*sex_ratio)/(sex_ratio+1),0) females from

(select a.district,a.state,a.sex_ratio/100 sex_ratio,b.population from dbo.Data1$ a inner join dbo.Data2 b on a.district=b.district)c
---Total number of male to the total number of female at the state level
select d.state,sum(d.males)total_males,sum(d.females)total_females from
(select c.district,c.state state,round(c.population/(c.sex_ratio+1),0)males,round((c.population*c.sex_ratio)/(c.sex_ratio+1),0) females from
(select a.district,a.state,a.sex_ratio/100 sex_ratio,b.population from dbo.Data1$ a inner join dbo.Data2 b on a.district=b.district)c)d
group by d.state;

---Total literacy and Illiteracy rate
select a.district,a.state,a.literacy literacy_ratio,b.population from dbo.Data1$ a inner join dbo.Data2 b on a.district=b.district
----Total number of literate people
select d.district,d.state,round(d.literacy_ratio*d.population,0) literate_people,round((1-d.literacy_ratio)*d.population,0) illiterate_people from
(select a.district,a.state,a.literacy/100 literacy_ratio,b.population from dbo.Data1$ a inner join dbo.Data2 b on a.district=b.district) d

---Total literacy and illiteracy rate at the state level
select c.state,sum(illiterate_people)total_literate_pop,sum(illiterate_people)total_illiterate_pop from
(select d.district,d.state,round(d.literacy_ratio*d.population,0) literate_people,round((1-d.literacy_ratio)*d.population,0) illiterate_people from
(select a.district,a.state,a.literacy/100 literacy_ratio,b.population from dbo.Data1$ a inner join dbo.Data2 b on a.district=b.district) d)c
group by c.state

--population in previous census
select d.district,d.state,round(d.population/(1+d.growth),0)previous_census_population,d.population current_census_population from
(select a.district,a.state,a.growth growth,b.population from dbo.Data1$ a inner join dbo.Data2 b on a.district=b.district)d

--Current total population to previous total population
select sum(m.previous_census_population)previous_census_population,sum(m.current_census_population)current_census_population from(
select e.state,sum(e.previous_census_population)previous_census_population,sum(e.current_census_population)current_census_population from
(select d.district,d.state,round(d.population/(1+d.growth),0)previous_census_population,d.population current_census_population from
(select a.district,a.state,a.growth growth,b.population from dbo.Data1$ a inner join dbo.Data2 b on a.district=b.district)d)e
group by e.state)m

---population vs area

select q.*,r.* from(
select '1' as keyy,n.* from
(select sum(m.previous_census_population)previous_census_population,sum(m.current_census_population)current_census_population from(
select e.state,sum(e.previous_census_population)previous_census_population,sum(e.current_census_population)current_census_population from
(select d.district,d.state,round(d.population/(1+d.growth),0)previous_census_population,d.population current_census_population from
(select a.district,a.state,a.growth growth,b.population from dbo.Data1$ a inner join dbo.Data2 b on a.district=b.district)d)e
group by e.state)m)n)q inner join (


select '1' as keyy,z.* from(
select sum(area_Km2)total_area from dbo.Data2)z) r on q.keyy=r.keyy



