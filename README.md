# COVID-19 Data Analysis Project

A comprehensive SQL-based analysis of global COVID-19 data, examining infection rates, death rates, vaccination patterns, and continental trends from the pandemic period.

## 📊 Project Overview

This project analyzes global COVID-19 data using SQL to extract meaningful insights about the pandemic's impact across different countries and continents. The analysis includes data exploration, statistical calculations, and data preparation for visualization tools like Tableau.

## 🗂️ Repository Structure

```
Covid_19_Analysis/
├── CovidDeaths_1.csv           # Global COVID-19 deaths and cases data
├── CovidVaccinations.csv       # Global vaccination data
├── covid_Analysis.sql          # Main SQL analysis script
├── tableau table 1.csv         # Global death percentage summary
├── tableau table 2.csv         # Continental death count rankings
├── tableau table 3.csv         # Country infection rate analysis
└── tableau table 4.csv         # Time series death percentage data
```

## 📈 Data Analysis Features

### Core Metrics Analyzed:
- **Death Percentage**: Total deaths vs total cases by location and date
- **Infection Rate**: Total cases vs population percentage
- **Continental Comparisons**: Highest death counts by continent
- **Time Series Analysis**: Daily progression of cases and deaths
- **Vaccination Progress**: Rolling vaccination counts by location

### Key SQL Techniques Used:
- **Window Functions**: `SUM() OVER()` for rolling calculations
- **Common Table Expressions (CTEs)**: For complex data transformations
- **Temporary Tables**: For intermediate result storage
- **Views**: For reusable query components
- **Joins**: Combining deaths and vaccination datasets
- **Aggregations**: Country and continental summaries

## 🔍 Analysis Highlights

### Global Statistics
- **Total Cases**: 150,574,977
- **Total Deaths**: 3,180,206
- **Global Death Rate**: 2.11%

### Continental Rankings (by Total Deaths)
1. **Europe**: 1,016,750 deaths
2. **North America**: 847,942 deaths
3. **South America**: 672,415 deaths
4. **Asia**: 520,269 deaths
5. **Africa**: 121,784 deaths
6. **Oceania**: 1,046 deaths

### Top Countries by Infection Rate
1. **Andorra**: 17.13% population infected
2. **Montenegro**: 15.51% population infected
3. **Czechia**: 15.23% population infected

## 🛠️ Technologies Used

- **SQL**: Primary analysis language
- **CSV**: Data storage format
- **Tableau**: Visualization preparation (output tables)

## 📋 Query Categories

### 1. **Basic Data Exploration**
- Filtering non-null continent data
- Sorting by location and date
- Basic case and death statistics

### 2. **Percentage Calculations**
```sql
-- Death percentage calculation
(total_deaths/total_cases)*100 as DeathPercentage

-- Population infection percentage
(total_cases/population)*100 as CovidPercentage
```

### 3. **Ranking Analysis**
- Countries with highest infection rates
- Countries with highest death counts
- Continental death count rankings

### 4. **Time Series Analysis**
- Daily global numbers
- Rolling vaccination counts
- Percentage calculations over time

### 5. **Advanced Analytics**
- CTE implementations for complex calculations
- Temporary table creation for data processing
- View creation for reusable components

## 📊 Output Files for Visualization

The project generates four Tableau-ready CSV files:

1. **tableau table 1.csv**: Global summary statistics
2. **tableau table 2.csv**: Continental death rankings
3. **tableau table 3.csv**: Country infection rate rankings
4. **tableau table 4.csv**: Time series data for trend analysis

## 🚀 Getting Started

### Prerequisites
- SQL-compatible database system (MySQL, PostgreSQL, SQL Server, etc.)
- CSV import capabilities
- Optional: Tableau for visualization

### Setup Instructions

1. **Clone the repository**:
   ```bash
   git clone https://github.com/maxx-2345/Covid_19_Analysis.git
   cd Covid_19_Analysis
   ```

2. **Import the data**:
   - Import `CovidDeaths_1.csv` as table `covid_death`
   - Import `CovidVaccinations.csv` as table `covid_vaccination`

3. **Run the analysis**:
   - Execute `covid_Analysis.sql` in your SQL environment
   - Queries are organized in logical sections for step-by-step execution

4. **Generate visualization data**:
   - The SQL script will create the tableau table outputs
   - Use these CSV files for creating dashboards and visualizations

## 📊 Sample Queries

### Find Countries with Highest Death Rate:
```sql
SELECT location, 
       MAX(total_deaths) as HighestDeathCount
FROM covid_death
WHERE continent IS NOT NULL 
  AND continent != ''
GROUP BY location
ORDER BY HighestDeathCount DESC;
```

### Calculate Rolling Vaccination Percentage:
```sql
WITH PopvsVac AS (
    SELECT dea.continent, dea.location, dea.date, 
           dea.population, vac.new_vaccinations,
           SUM(vac.new_vaccinations) 
           OVER(PARTITION BY dea.location ORDER BY dea.date) AS RollingPeopleVaccinated
    FROM covid_death dea
    JOIN covid_vaccination vac
      ON dea.location = vac.location
     AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL
)
SELECT *, (RollingPeopleVaccinated/Population)*100 AS VaccinationPercent
FROM PopvsVac
ORDER BY Location, Date;
```

## 📝 Analysis Insights

- **European Impact**: Europe had the highest absolute death toll, highlighting the severe impact of early pandemic waves
- **Small Nation Vulnerability**: Smaller countries like Andorra and Montenegro showed higher infection percentages relative to population
- **Continental Disparities**: Significant differences in death rates between continents, reflecting varying healthcare capabilities and pandemic responses
- **Temporal Patterns**: Death percentages varied significantly over time, showing the evolution of treatment and virus variants

## 🤝 Contributing

This project is part of a data analysis portfolio. Suggestions for improvements or additional analysis dimensions are welcome!

## 📧 Contact

**GitHub**: [@maxx-2345](https://github.com/maxx-2345)

## 🏷️ Tags

`#COVID19` `#DataAnalysis` `#SQL` `#PublicHealth` `#DataScience` `#Pandemic` `#Tableau` `#DataVisualization`

---
*Last Updated: September 2025*
