--===============================================================
-- F1 Data Analysis - SQL PORTFOLIO 
-- Tool : SQLite
-- Author : Vedansh Khandelwal
-- Date : 25th March 2026
-- Description : Entry-level Data Analyst portfolio
-- ====================================================
--SECTION 1 : DATA PROFILING & EXPLORATION
-- ====================================================

--1.1 How many races are in the dataset in total?
-- Business context: This gives us an idea of the size of the dataset and how much historical data we have to work with.

SELECT 
COUNT(races.raceID) AS Total_Races 
FROM races ;

--1.2 How many unique drivers have competed in F1?
-- Business context: This helps us understand the size of the driver pool.

SELECT 
COUNT ( DISTINCT drivers.driverId) AS total_drivers
FROM drivers ;

--1.3 What does the races table look like? Show the first 10 rows.
-- Business context: This allows us to understand the structure of races table.

SELECT 
* 
FROM races 
LIMIT 10;

--1.4 Which seasons (years) are covered in the dataset, and how many races were held each year?
-- Business context:This helps us understand number of races held in each season and identify any trends.

SELECT 
year, COUNT (DISTINCT  raceId) AS races_that_year
FROM races 
GROUP BY year;

--1.5 Are there any drivers with missing nationality data?
-- Business context: This helps us identify data quality issues that can be addressed before analysis.

SELECT driverRef
FROM drivers 
WHERE nationality IS NULL OR nationality = ‘ ’ ;

-- ====================================================
--SECTION  2 : AGGREGATION & RANKINGS
-- ====================================================

--2.1 Which drivers have won the most races of all time? Show the top 10.
-- Business context: This identifies the most successful drivers in F1 history.

SELECT  drivers.forename, drivers.surname, COUNT ( * ) AS no_of_races_won
FROM results 
JOIN drivers ON results.driverId = drivers.driverId
WHERE results.position = 1 
GROUP BY results.driverId
ORDER BY no_of_races_won DESC
LIMIT 10 ;

--2.2 Which constructor (team) has accumulated the most points across all seasons?
-- Business context: This identifies the most successful teams in F1 history.

SELECT constructors.name,   SUM ( results.points ) AS total_points_scored 
FROM results 
JOIN constructors ON results.constructorId = constructors.constructorId
GROUP BY results.constructorId
ORDER BY total_points_scored DESC;

--2.3 What is the average finishing position for each driver? Only include drivers with at least 50 race entries.
-- Business context: This helps us understand which drivers are consistently performing at a high level.

SELECT  drivers.forename,drivers.surname,  AVG ( CAST ( results.position  AS FLOAT )) AS avg_finishing_position
FROM results 
JOIN drivers ON results.driverId = drivers.driverId
WHERE results.statusId = 1
GROUP BY results.driverId 
HAVING  COUNT ( results.raceId)  >= 50
ORDER BY avg_finishing_position ASC; 

--2.4 Which drivers scored the most points in a single season? Show the top 10 season performances.
-- Business context: This identifies the best individual season performances by drivers.

SELECT drivers.surname, races.year, SUM ( results.points) AS season_points
FROM results 
JOIN races ON results.raceId = races.raceId
JOIN drivers ON results.driverId = drivers.driverId
GROUP BY results.driverId, races.year
ORDER BY season_points DESC
LIMIT 10 ;

--2.5 How many times has each constructor won a race? Rank them highest to lowest.
-- Business context: This identifies the most race winning constructors.

SELECT constructors.name , COUNT (results.constructorId) AS races_won
FROM results
JOIN constructors ON results.constructorId= constructors.constructorId
WHERE results.position = 1
GROUP BY results.constructorId
ORDER BY races_won DESC;

-- ====================================================
--SECTION 3 : JOINs & MULTI-TABLE ANALYSIS
-- ====================================================

--3.1 Show each race result with the driver's full name, constructor name, race name and year — for the 2023 season only.
-- Business context: This allows us to analyze 2023 season in detail, looking at how drivers and teams performed.

SELECT results.position,drivers.forename, drivers.surname, constructors.name AS construntors_name, races.name AS race_name, races.year
FROM results
JOIN races ON results.raceId = races.raceId
JOIN drivers ON drivers.driverId= results.driverId
JOIN constructors ON results.constructorId = constructors.constructorId
WHERE races.year = 2023
ORDER BY results.positionOrder  ASC;

--3.2 Which drivers have raced for more than one constructor (team) throughout their career?
-- Business context: This helps us identify drivers who have worked with multiple teams.

SELECT  drivers.forename, drivers.surname , COUNT ( DISTINCT constructors.name) AS no_of_constructors
FROM  results
JOIN  drivers ON results.driverId = drivers.driverId
JOIN constructors ON results.constructorId = constructors.constructorId 
GROUP BY drivers.driverId
HAVING no_of_constructors > 1
ORDER BY no_of_constructors DESC;

--3.3 For each race, show the winner's full name, their constructor, and the circuit name.
-- Business context: This allows us to analyze which drivers and teams have been successful at different circuits over time.

SELECT  races.year, races.name , drivers.forename , drivers.surname , constructors.name AS constructors_name, circuits.name AS circuit_name
FROM results
JOIN races ON results.raceId = races.raceId
JOIN drivers ON results.driverId = drivers.driverId
JOIN constructors ON results.constructorId = constructors.constructorId
JOIN circuits ON races.circuitId= circuits.circuitId
WHERE results.position = 1
ORDER BY races.year, races.name ;

--3.4 Show the fastest pit stop (in seconds) for each race in the 2023 season, including the driver name and race name.
-- Business context: This allows us to analyze which teams and drivers had the most efficient pit stops in the 2023 season.

SELECT pit_stops.duration AS pit_duration, races.name, drivers.forename, drivers.surname
FROM pit_stops 
JOIN races ON pit_stops.raceId = races.raceId
JOIN drivers ON pit_stops.driverId = drivers.driverId
WHERE races.year = 2023 AND pit_stops.duration = 
(SELECT MIN ( p2.duration) 
FROM pit_stops  AS p2
WHERE p2.raceId = pit_stops.raceId );

--3.5 Find any constructors that have never scored a point — show their name and nationality.
-- Business context: This helps us identify teams that have struggled to be competitive in F1 history.

SELECT constructors.name, constructors.nationality
FROM constructors
LEFT JOIN results ON constructors.constructorId = results.constructorId
GROUP BY constructors.constructorId
HAVING SUM ( results.points)  = 0 OR SUM ( results.points) IS NULL
ORDER BY constructors.name ASC;

-- ====================================================
--SECTION 4 : CTEs
-- ====================================================

--4.1 Using a CTE, find the total points scored by each driver across their career, then show only drivers who scored more than 500 points.
-- Business context: This identifies the most successful drivers in terms of points scored across their careers, highlighting those who have consistently performed well over time.

WITH driver_points AS (
SELECT driverId, SUM (points) AS total_points
FROM results
GROUP BY driverId
)
SELECT drivers.forename, drivers.surname, total_points
FROM driver_points
JOIN drivers ON driver_points.driverId = drivers.driverId
WHERE total_points > 500
ORDER BY total_points DESC;

--4.2 Using a CTE, calculate how many races each driver entered per season, then show only the seasons where a driver entered more than 15 races.
-- Business context: This helps us identify drivers who were particularly active in certain seasons, which could indicate periods of high performance or significant participation in the sport.

WITH races_entered  AS (
SELECT drivers.forename AS driver_name, races.year AS year , COUNT (*) AS number_of_races
FROM results
JOIN races ON results.raceId = races.raceId
JOIN drivers ON results.driverId = drivers.driverId
WHERE results.statusId = 1 
GROUP BY  results.driverId, races.year
)
SELECT races_entered.driver_name, races_entered.year , number_of_races
FROM races_entered
WHERE number_of_races > 15
ORDER BY driver_name, year;

--4.3 Using a CTE, find the average pit stop duration per constructor, then rank them fastest to slowest.

--4.4 Using a CTE, find each driver's total wins, then calculate what percentage of all wins each driver holds.
-- Business context: This identifies how dominant certain drivers have been.

WITH driver_wins AS (
SELECT driverId, COUNT(*)  AS wins
FROM results
WHERE position = 1
GROUP BY driverId 
),
total_wins AS (
SELECT SUM ( wins) AS grand_total
FROM driver_wins
)
SELECT 
drivers.forename,
drivers.surname,
driver_wins.wins,
--	total_wins.grand_total,
ROUND (	CAST (driver_wins.wins AS FLOAT) / total_wins.grand_total * 100, 2 ) AS win_percentage
FROM driver_wins
JOIN drivers ON driver_wins.driverId  = drivers.driverId
JOIN  total_wins ;

--4.5 Using two CTEs, find the highest points scorer per season, then show only the seasons where that driver scored more than 400 points.
-- Business context: This identifies the most dominant season performances by drivers.

WITH drivers_points_scored AS (
SELECT races.year AS year, results.driverId AS driverID, SUM ( results.points)  AS total_points
FROM results
JOIN races ON results.raceId = races.raceId
GROUP BY races.year, results.driverId 
) ,
top_scorers AS ( 
SELECT MAX ( total_points) AS  max_points, year AS year, driverId
FROM drivers_points_scored 
GROUP BY year
)
SELECT drivers.forename, drivers.surname, top_scorers.year, top_scorers.max_points
FROM top_scorers 
JOIN drivers ON  top_scorers.driverId = drivers.driverId
WHERE max_points > 400 
ORDER BY max_points DESC;

-- ====================================================
--SECTION 5 : DATE LOGIC
-- ====================================================

--5.1 How many races were held each year? Show results from newest to oldest. 

SELECT year, count(*) AS races
FROM races
GROUP BY year
ORDER BY year DESC;

--5.2 How many days between each consecutive race in the 2023 season? 

--5.3 Which races were held in the last 5 years? 

--5.4 Which month of the year has historically hosted the most F1 races? 

--5.5How many races has each driver entered in the last 10 years only?

-- ====================================================
--SECTION 6 : SUBQUERIES 
-- ====================================================

--6.1 Which drivers have never finished on the podium (top 3)? 
-- Business context: This helps us identify drivers who have competed in F1 but have never achieved a top 3 finish.

SELECT DISTINCT results.driverId ,  drivers.forename, drivers.surname
FROM results 
JOIN drivers ON results.driverId = drivers.driverId
WHERE results.driverId NOT IN ( 
SELECT driverId 
FROM results 
WHERE position IN (1, 2,  3)

)
ORDER BY results.driverId ;

--6.2 Which constructors have never won a race? (use a subquery, not LEFT JOIN) 
-- Business context: This helps us identify teams that have competed in F1 but have never won.

SELECT DISTINCT results.constructorId , constructors.name
FROM results
JOIN constructors ON results.constructorId= constructors.constructorId
WHERE results.constructorId NOT IN (
SELECT constructorId 
FROM results
WHERE position = 1 )
ORDER BY results.constructorId;

--6.3 Find all races where the pole sitter (grid position 1) did not win the race. 
-- Business context: This allows us to analyze how often the driver starting in pole position fails to convert it into a win.

-- note: grid and position are stored as TEXT in this table therefore CAST applied
SELECT races.raceId , races.name, races.year
FROM races
WHERE raceID NOT IN (
SELECT raceId 
FROM results 
WHERE CAST (grid AS INT ) = 1 AND  CAST (position AS INT) = 1
) 
ORDER BY raceID;

--6.4 Which drivers scored more points than the average points per driver in the 2023 season? 
-- Business context: This helps us identify which drivers performed above average in the 2023 season.

SELECT drivers.forename , drivers.surname , SUM ( results. points) AS total_points
FROM drivers 
JOIN results ON drivers.driverId = results.driverId 
JOIN races ON results.raceId = races.raceId
WHERE races.year = 2023 AND results.statusId = 1
GROUP BY drivers.driverId
HAVING total_points >
-- avg points scored by a driver in the season 
(
SELECT  CAST (SUM (results.points)  AS FLOAT) / COUNT ( DISTINCT driverId)
FROM results 
JOIN races ON results.raceId = races.raceId
WHERE  races.year = 2023 AND results.statusId = 1 ) ;

--6.5 Find drivers whose average points per race is higher than the overall fleet average across all seasons.
-- Business context: This helps us identify drivers who have consistently performed above the average level across their careers.

SELECT drivers.forename , drivers.surname , AVG ( results.points)  as avg_points
FROM drivers 
JOIN results ON drivers.driverId = results.driverId
WHERE statusId = 1 
GROUP BY drivers.driverId
HAVING avg_points >
-- avg points scored by a driver per race
(
SELECT  AVG ( points)
FROM results 
WHERE statusId = 1 ) 
ORDER BY avg_points DESC;