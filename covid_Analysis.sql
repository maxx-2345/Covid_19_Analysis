select *
from covid_death
where continent is not null
order by 3,4;

select *
from covid_vaccination
order by 3,4;

select location,date, total_cases, new_cases, total_deaths,population
from covid_death
order by 1,2;


-- total cases vs total deaths

select location,date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from covid_death
where continent is not null and continent != ''
order by 1,2;


-- total cases vs population

select location,date, total_cases, population, (total_cases/population)*100 as CovidPercentage
from covid_death
where continent is not null and continent != ''
order by 1,2;

-- Countries with highest infection rate compared to population

select location, population,MAX(total_cases) as HighestInfectionCount,  
MAX((total_cases/population))*100 as CovidPercentage
from covid_death
where continent is not null and continent != ''
group by location,population
order by 4 desc;


-- Countries with highest death count

select location, MAX(total_deaths) as HighestDeathCount
from covid_death
where continent is not null and continent != ''
group by location
order by 2 desc;

-- By continent
-- Showing the continents with highest death count per population
select continent, MAX(total_deaths) as HighestDeathCount
from covid_death
where continent is not null and continent != ''
group by continent
order by 2 desc;

-- Global Numbers

select  date,sum(new_cases) as total_cases,sum(new_deaths) as total_deaths, (sum(new_deaths)/sum(new_cases))*100 as DeathPercentage
from covid_death
group by date
order by 1;

select  sum(new_cases) as total_cases,sum(new_deaths) as total_deaths, (sum(new_deaths)/sum(new_cases))*100 as DeathPercentage
from covid_death
order by 1;



-- Total population vs vaccinations

select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations ,
sum(vac.new_vaccinations) 
over(partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
from covid_death dea
join covid_vaccination vac
	on dea.location = vac.location
    and dea.date = vac.date
where dea.continent is not null and dea.continent != ''
order by 2,3
;



-- with cte

with PopvsVac(Continent,Location,Date,Population, New_vaccinations,RollingPeopleVaccinated)
as
(
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations ,
sum(vac.new_vaccinations) 
over(partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
from covid_death dea
join covid_vaccination vac
	on dea.location = vac.location
    and dea.date = vac.date
where dea.continent is not null and dea.continent != ''
-- order by 2,3
)
select *, (RollingPeopleVaccinated/Population)*100
from PopvsVac
order by Location, Date
;


-- with temp table

drop table if exists PercentPopulationVaccinated;


CREATE TEMPORARY TABLE PercentPopulationVaccinated (
    Continent VARCHAR(100),
    Location VARCHAR(200),
    Date DATE,
    Population BIGINT,
    New_vaccinations BIGINT,
    RollingPeopleVaccinated BIGINT
);

INSERT INTO PercentPopulationVaccinated (Continent, Location, Date, Population, New_vaccinations, RollingPeopleVaccinated)
SELECT 
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(vac.new_vaccinations) 
        OVER (PARTITION BY dea.location ORDER BY dea.date) AS RollingPeopleVaccinated
FROM covid_death dea
JOIN covid_vaccination vac
    ON dea.location = vac.location
   AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
  AND dea.continent != '';

SELECT *, (RollingPeopleVaccinated / Population) * 100 AS VaccinationPercent
FROM PercentPopulationVaccinated
ORDER BY Location, Date;



-- Creating a view

create view PercentPopulationVaccinated as
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations ,
sum(vac.new_vaccinations) 
over(partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
from covid_death dea
join covid_vaccination vacpercentpopulationvaccinated
	on dea.location = vac.location
    and dea.date = vac.date
where dea.continent is not null and dea.continent != '';
-- order by 2,3

SELECT * FROM covid_19.percentpopulationvaccinated;






