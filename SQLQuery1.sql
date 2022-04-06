select * from portofolio_project..covid_death order by 3,4


select location,date,total_cases_per_million,new_cases,total_deaths,population
from portofolio_project..covid_death order by 1,2 

select location,date,total_cases_per_million,new_cases,total_deaths,population,total_cases
from portofolio_project..covid_death 
order by 1,2 

select location,date,total_cases_per_million,new_cases,total_deaths,population
from portofolio_project..covid_death 
where location like '%Algeria%'
order by 2 asc

select location,date,total_cases ,(total_cases/population)*100 as CasesPercentage
from portofolio_project..covid_death 
where location like '%Algeria%'
order by 1,2 


select location , population, max(total_cases)as HighestInfectionCount , max((total_cases/population)*100) as DeathPercentage
from portofolio_project..covid_death 
group by location , population 
order by DeathPercentage desc

select location , max( cast( total_deaths as int)) as total_death
from portofolio_project..covid_death 
group by location  
order by total_death desc

select location ,continent, total_cases
from portofolio_project..covid_death 
where continent is not null
order by 3 desc

select continent , sum(new_cases)as sum_new_cases
from portofolio_project..covid_death 
group by continent
order by 2 desc

select continent ,date,(total_cases/population)*100 as CasesPercentage
from portofolio_project..covid_death 
where continent is not null 
order by 3 desc

select location , population,max(total_cases) as HighestInfectionCount ,max((total_cases/population))*100 as PercentPopulationInfected
from portofolio_project..covid_death 
group by location ,population
order by PercentPopulationInfected desc

select location ,date, population,max(total_cases) as HighestInfectionCount ,max((total_cases/population))*100 as PercentPopulationInfected
from portofolio_project..covid_death 
group by location ,population,date
order by PercentPopulationInfected desc



select *
from portofolio_project..covid_vaccanation


select *
from portofolio_project..covid_death dea
join portofolio_project..covid_vaccanation vac 
    on dea.location=vac.location
	and dea.date=vac.date
