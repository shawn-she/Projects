Select *
From PortfolioProject.dbo.CovidDeaths
where continent is not null
order by 3, 4

----Select *
----From PortfolioProject.dbo.CovidVaccinations
----order by 3, 4

-- Select Data that we are going to be using
Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject.dbo.CovidDeaths
order by 1, 2


-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country
Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject.dbo.CovidDeaths
--Where location = 'India'
Where location like '%states%'
order by 1, 2


-- Looking at Total Cases vs Population
-- Shows what percentage of population got Covid
Select Location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
Where location like '%states'
order by 1, 2


-- Looking at countries with highest infection rate compared to population
SELECT Location, Population, MAX(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject.dbo.CovidDeaths
Group by Location, Population
--order by 1, 2
order by PercentPopulationInfected desc

-- Showing Countries with Highest Death Count per Population
SELECT location, Max(cast(total_deaths as int)) as TotalDeathCount, Max(total_deaths/population)*1000 as DeathCountPerPopulation
From PortfolioProject..CovidDeaths
where continent is not null
group by location
--order by DeathCountPerPopulation desc
order by TotalDeathCount desc

-- LET'S BREAK THINGS DOWN BY CONTINENT
-- Showing continents with highest death count per population

SELECT continent, Max(cast(total_deaths as int)) as TotalDeathCount, Max(total_deaths/population)*1000 as DeathCountPerPopulation
From PortfolioProject..CovidDeaths
where continent is not null
group by continent
--order by DeathCountPerPopulation desc
order by TotalDeathCount desc
--
SELECT location, Max(cast(total_deaths as int)) as TotalDeathCount, Max(total_deaths/population)*1000 as DeathCountPerPopulation
From PortfolioProject..CovidDeaths
where continent is null
group by location
--order by DeathCountPerPopulation desc
order by TotalDeathCount desc

-- GLOBAL NUMBERS

Select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, 
	sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
From PortfolioProject.dbo.CovidDeaths
where continent is not null
--group by date
order by 1, 2

-- Looking at Total Population vs Vaccinations

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
	sum(convert(bigint, vac.new_vaccinations))
	OVER (Partition by dea.location order by dea.location, dea.date)
	as RollingPeopleVaccinated
	--Max,(RollingPeopleVaccinated/population)*100
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--and vac.new_vaccinations is not null
--and dea.location like 'india'
--order by 3
order by 2, 3

-- USE CTE
With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as (
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
	sum(convert(bigint, vac.new_vaccinations))
	OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac
where location like 'india'

-- TEMP TABLE
Drop table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)
Insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
	sum(convert(bigint, vac.new_vaccinations))
	OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null

select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated



-- Creating view to store data for later visualizations
Create view PercentagePopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
	sum(convert(bigint, vac.new_vaccinations))
	OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null

Select *
From PercentagePopulationVaccinated