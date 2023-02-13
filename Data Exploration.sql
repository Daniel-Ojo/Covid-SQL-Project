/*
Covid 19 Data Exploration
*/

-- Death Percentage
SELECT sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, (sum(new_deaths) / sum(new_cases))*100 as DeathPercentage
FROM `portfolio-project-375106.coviddata.covid_deaths`
WHERE continent is not null
ORDER BY 1, 2

--Total death count
SELECT continent, sum(new_deaths) as TotalDeathCount
FROM `portfolio-project-375106.coviddata.covid_deaths`
WHERE continent IS NOT null
GROUP BY 1
ORDER BY 2 DESC

-- Infection count percentage
SELECT location, MAX(total_cases) as HighestInfectionCount, population, MAX((total_cases/population))*100 as PercentPopulationInfected
FROM `portfolio-project-375106.coviddata.covid_deaths`
GROUP BY 1, 3
ORDER BY 4 DESC

--Percentage population infected and date
SELECT location, population, date, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
FROM `portfolio-project-375106.coviddata.covid_deaths`
GROUP BY 1, 2, 3
ORDER BY 5 DESC

vac vs pop
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
      sum(vac.new_vaccinations) OVER (partition by dea.location ORDER BY dea.location, 
      dea.date) as new_vaccsum
FROM `portfolio-project-375106.coviddata.covid_vaccinations` vac
JOIN `portfolio-project-375106.coviddata.covid_deaths` dea
ON vac.date = dea.date
  AND vac.location = dea.location
WHERE dea.continent IS NOT NULL
ORDER BY 2, 3
