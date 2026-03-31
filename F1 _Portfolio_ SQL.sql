--===============================================================
-- F1 Data Analysis - SQL PORTFOLIO 
-- Tool : SQLite
-- Author : Vedansh Khandelwal
-- Date : 25th March 2026
-- Description : Data Analyst Portfolio Project analyzing Formula 1 racing data using SQL queries.
-- The project covers data profiling, aggregation, multi-table analysis, CTEs, date logic, and subqueries to extract insights about drivers, constructors, races, and performance trends in F1 history.
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

SELECT  d.forename, d.surname, COUNT ( * ) AS no_of_races_won
FROM results r 
JOIN drivers d ON r.driverId = d.driverId
WHERE r.position = 1 
GROUP BY r.driverId
ORDER BY no_of_races_won DESC
LIMIT 10 ;

--2.2 Which constructor (team) has accumulated the most points across all seasons?
-- Business context: This identifies the most successful teams in F1 history.

SELECT c.name,   SUM ( r.points ) AS total_points_scored 
FROM results r
JOIN constructors c ON r.constructorId = c.constructorId
GROUP BY r.constructorId
ORDER BY total_points_scored DESC;

--2.3 What is the average finishing position for each driver? Only include drivers with at least 50 race entries.
-- Business context: This helps us understand which drivers are consistently performing at a high level.

SELECT  d.forename, d.surname,  AVG ( CAST ( r.position  AS FLOAT )) AS avg_finishing_position
FROM results r
JOIN drivers d ON r.driverId = d.driverId
WHERE r.statusId = 1
GROUP BY r.driverId 
HAVING  COUNT ( r.raceId)  >= 50
ORDER BY avg_finishing_position ASC; 

--2.4 Which drivers scored the most points in a single season? Show the top 10 season performances.
-- Business context: This identifies the best individual season performances by drivers.

SELECT d.surname, r2.year, SUM ( r1.points) AS season_points
FROM results r1
JOIN races r2 ON r1.raceId = r2.raceId
JOIN drivers d ON r1.driverId = d.driverId
GROUP BY r1.driverId, r2.year
ORDER BY season_points DESC
LIMIT 10 ;

--2.5 How many times has each constructor won a race? Rank them highest to lowest.
-- Business context: This identifies the most race winning constructors.

SELECT c.name , COUNT (r.constructorId) AS races_won
FROM results r
JOIN constructors c ON r.constructorId= c.constructorId
WHERE r.position = 1
GROUP BY r.constructorId
ORDER BY races_won DESC;

-- ====================================================
--SECTION 3 : JOINs & MULTI-TABLE ANALYSIS
-- ====================================================

--3.1 Show each race result with the driver's full name, constructor name, race name and year — for the 2023 season only.
-- Business context: This allows us to analyze 2023 season in detail, looking at how drivers and teams performed.

SELECT r1.position, d.forename, d.surname, c.name AS constructors_name, r2.name AS race_name, r2.year
FROM results r1
JOIN races r2 ON r1.raceId = r2.raceId
JOIN drivers d ON d.driverId= r1.driverId
JOIN constructors c ON r1.constructorId = c.constructorId
WHERE r2.year = 2023
ORDER BY r1.positionOrder  ASC;

--3.2 Which drivers have raced for more than one constructor (team) throughout their career?
-- Business context: This helps us identify drivers who have worked with multiple teams.

SELECT  d.forename, d.surname , COUNT ( DISTINCT c.name) AS no_of_constructors
FROM  results r
JOIN  drivers d ON r.driverId = d.driverId
JOIN constructors c ON r.constructorId = c.constructorId 
GROUP BY d.driverId
HAVING no_of_constructors > 1
ORDER BY no_of_constructors DESC;

--3.3 For each race, show the winner's full name, their constructor, and the circuit name.
-- Business context: This allows us to analyze which drivers and teams have been successful at different circuits over time.

SELECT  r2.year, r2.name , d.forename , d.surname , c1.name AS constructors_name, c2.name AS circuit_name
FROM results r1
JOIN races r2 ON r1.raceId = r2.raceId
JOIN drivers d ON r1.driverId = d.driverId
JOIN constructors c1 ON r1.constructorId = c1.constructorId
JOIN circuits c2 ON r2.circuitId= c2.circuitId
WHERE r1.position = 1
ORDER BY r2.year, r2.raceId ;

--3.4 Show the fastest pit stop (in seconds) for each race in the 2023 season, including the driver name and race name.
-- Business context: This allows us to analyze which teams and drivers had the most efficient pit stops in the 2023 season.

SELECT pit_stops.duration AS pit_duration, r.name, d.forename, d.surname
FROM pit_stops 
JOIN races r ON pit_stops.raceId = r.raceId
JOIN drivers d ON pit_stops.driverId = d.driverId
WHERE r.year = 2023 AND pit_stops.duration = 
(SELECT MIN ( p.duration) 
FROM pit_stops p
WHERE p.raceId = pit_stops.raceId );

--3.5 Find any constructors that have never scored a point — show their name and nationality.
-- Business context: This helps us identify teams that have struggled to be competitive in F1 history.

SELECT c.name, c.nationality
FROM constructors c
LEFT JOIN results r ON c.constructorId = r.constructorId
GROUP BY c.constructorId
HAVING SUM ( r.points)  = 0 OR SUM ( r.points) IS NULL
ORDER BY c.name ASC;

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
SELECT d.forename AS name, d.surname AS surname, r2.year AS year , COUNT (*) AS number_of_races
FROM results r1
JOIN races r2 ON r1.raceId = r2.raceId
JOIN drivers d ON r1.driverId = d.driverId
WHERE r1.statusId = 1 
GROUP BY  r1.driverId, r2.year
)
SELECT races_entered.name, races_entered.surname,races_entered.year , number_of_races
FROM races_entered
WHERE number_of_races > 15
ORDER BY number_of_races DESC;

--4.3 Using a CTE, find the average pit stop duration per constructor, then rank them fastest to slowest.
-- Business context: This helps us identify which teams have been most efficient in their pit stops.

WITH constructors_pit_duration AS (
SELECT  r1.constructorId AS constructor,  p1. duration AS duration
FROM results r1
JOIN pit_stops p1 ON r1.raceId = p1.raceId AND r1.driverId=p1.driverId
)
SELECT constructors.name, AVG ( duration ) AS avg_duration
FROM constructors_pit_duration
JOIN constructors ON constructors_pit_duration.constructor = constructors.constructorId
GROUP BY constructors_pit_duration.constructor
ORDER BY avg_duration ASC;

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
JOIN  total_wins 
ORDER BY win_percentage DESC;


--4.5 Using two CTEs, find the highest points scorer per season, then show only the seasons where that driver scored more than 400 points.
-- Business context: This identifies the most dominant season performances by drivers.

WITH drivers_points_scored AS (
SELECT r2.year AS year, r1.driverId AS driverID, SUM ( r1.points)  AS total_points
FROM results r1
JOIN races r2 ON r1.raceId = r2.raceId
GROUP BY r2.year, r1.driverId 
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
-- Business context: This helps us identify which seasons were the busiest.

SELECT year, count(*) AS races
FROM races
GROUP BY year
ORDER BY year DESC;

--5.2 How many days between each consecutive race in the 2023 season? 
-- Business context: This allows us to analyze the rest and recovery time drivers had between races in 2023.

SELECT
r1.name,  r1. date, CAST (  julianday( r2.date) - julianday( r1.date) AS INT )  AS days_bw_races, r2.name AS next_race
FROM races r1
LEFT JOIN races r2 ON r1.year=r2.year AND r1.round +1 = r2.round 
WHERE r1.year = 2023
ORDER BY r1.round;

--5.3 Which races were held in the last 5 years? 
-- Business context: This helps us identify tracks that are new additions to the F1 calender.

SELECT
raceId, name, date
FROM races
WHERE year BETWEEN  CAST ( (strftime ('%Y','now') - 5)  AS INT)  AND CAST (  strftime ('%Y','now')  AS INT)
ORDER BY date ASC;

--5.4 Which month of the year has historically hosted the most F1 races? 
-- Business context: This allows us to identify the busiest month in the F1 calendar.

SELECT  strftime('%m', date)  AS month , COUNT ( * ) AS races_held
FROM races
GROUP BY month
ORDER BY races_held DESC;

--5.5 How many races has each driver entered in the last 10 years only?
-- Business context: This helps us identify which drivers have been most active in past 10 years.
SELECT d1.forename AS name , d1.surname , COUNT (*) AS races_entered
FROM races r1
JOIN results r2 ON r1.raceId=r2.raceId
JOIN drivers d1 ON r2.driverId = d1.driverId
WHERE CAST ( r1.year AS INT ) > ( CAST (strftime( '%Y', 'now')  AS INT )- 10) 
GROUP BY d1.driverId 
ORDER BY races_entered DESC ;
-- ====================================================
--SECTION 6 : SUBQUERIES 
-- ====================================================

--6.1 Which drivers have never finished on the podium (top 3)? 
-- Business context: This helps us identify drivers who have competed in F1 but have never achieved a top 3 finish.

SELECT DISTINCT r.driverId ,  d.forename, d.surname
FROM results r 
JOIN drivers d ON r.driverId = d.driverId
WHERE r.driverId NOT IN ( 
SELECT driverId 
FROM results 
WHERE position IN (1, 2,  3)

)
ORDER BY r.driverId ;

--6.2 Which constructors have never won a race? (use a subquery, not LEFT JOIN) 
-- Business context: This helps us identify teams that have competed in F1 but have never won.

SELECT DISTINCT r.constructorId , c.name
FROM results r
JOIN constructors c ON r.constructorId= c.constructorId
WHERE r.constructorId NOT IN (
SELECT constructorId 
FROM results
WHERE position = 1 )
ORDER BY r.constructorId;

--6.3 Find all races where the pole sitter (grid position 1) did not win the race. 
-- Business context: This allows us to analyze how often the driver starting in pole position fails to convert it into a win.

-- note: grid and position are stored as TEXT in this table therefore CAST applied
SELECT r1.raceId , r1.name, r1.year
FROM races r1
WHERE raceID NOT IN (
SELECT raceId 
FROM results 
WHERE CAST (grid AS INT ) = 1 AND  CAST (position AS INT) = 1
) 
ORDER BY raceID;

--6.4 Which drivers scored more points than the average points (GPs only) per driver in the 2023 season? 
-- Business context: This helps us identify which drivers performed above average in the 2023 season.

SELECT d.forename , d.surname , SUM ( r1. points) AS total_points
FROM drivers d
JOIN results r1 ON d.driverId = r1.driverId 
JOIN races r2 ON r1.raceId = r2.raceId
WHERE r2.year = 2023 AND r1.statusId = 1
GROUP BY d.driverId
HAVING total_points >
-- avg points scored by a driver in the season 
(
SELECT  CAST (SUM (r3.points)  AS FLOAT) / COUNT ( DISTINCT r3.driverId)
FROM results r3
JOIN races r4 ON r3.raceId = r4.raceId
WHERE  r4.year = 2023 AND r3.statusId = 1 ) ;


--6.5 Find drivers whose average points per race is higher than the overall average across all seasons.
-- Business context: This helps us identify drivers who have consistently performed above the average level across their careers.

SELECT d.forename , d.surname , AVG ( r1.points)  as avg_points
FROM drivers d
JOIN results r1 ON d.driverId = r1.driverId
WHERE r1.statusId = 1 
GROUP BY d.driverId
HAVING avg_points >
-- avg points scored by a driver per race
(
SELECT  AVG ( points)
FROM results 
WHERE statusId = 1 ) 
ORDER BY avg_points DESC;

--6.6 Which drivers scored more points than the average points (GPs + Sprints) per driver in the 2023 season? 
-- Business context: This helps us identify which drivers performed above average in the 2023 season.

WITH raceID_2023 AS (SELECT r.raceId AS raceId
FROM races r
WHERE r.year = 2023
) , sprint_totals AS (
SELECT d.driverId AS driverId, SUM (s.points) AS sprint_points
FROM drivers d
JOIN results r1 ON d.driverId = r1.driverId
JOIN sprint_results s ON d.driverId = s.driverId
JOIN raceID_2023 r ON r1.raceId = r.raceId
WHERE  r1.raceId = s.raceId
GROUP BY d.driverId ) 
SELECT d.forename , d.surname , SUM ( r1. points) AS gp_points, sprint_totals.sprint_points,  ( SUM ( r1. points) + sprint_totals.sprint_points) AS total
FROM drivers d
JOIN results r1 ON d.driverId = r1.driverId 
JOIN races r2 ON r1.raceId = r2.raceId
JOIN sprint_totals ON sprint_totals.driverId = d.driverId
WHERE r2.year = 2023 AND r1.statusId = 1
GROUP BY d.driverId
HAVING total >
-- avg points scored by a driver in the season 
(
SELECT   CAST ((SUM (r3.points)  + COALESCE (SUM (s.points), 0) ) AS FLOAT)  / COUNT ( DISTINCT r3.driverId) 
FROM results r3
JOIN races r4 ON r3.raceId = r4.raceId
LEFT JOIN sprint_results s ON r3.raceId = s.raceId AND r3.driverId = s.driverId
WHERE  r4.year = 2023 AND r3.statusId = 1 ) 

ORDER BY total DESC;