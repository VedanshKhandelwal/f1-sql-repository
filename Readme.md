# F1 Data Analysis — SQL Portfolio

A collection of 31 SQL queries analysing Formula 1 historical data, 
built as part of a Data Analyst portfolio project.

---

## Dataset

- **Source:** [Formula 1 World Championship Dataset — Kaggle](https://www.kaggle.com/datasets/rohanrao/formula-1-world-championship-1950-2020)
- **Tool:** SQLite
- **Tables used:** races, drivers, results, constructors, 
  constructor_results, pit_stops, lap_times, sprint_results,
  driver_standings, constructor_standings, circuits

---

## Business Questions Answered

### Section 1 — Data Profiling & Exploration
- How many races and drivers are in the dataset?
- How has the race calendar changed across seasons?
- Are there any data quality issues in the dataset?

### Section 2 — Aggregations & Rankings
- Which drivers have won the most races of all time?
- Which constructors have accumulated the most points?
- Which drivers have the best average finishing position?
- What are the top 10 single season points performances?

### Section 3 — JOINs & Multi-table Analysis
- Full 2023 season results with driver and constructor details
- Which drivers have raced for multiple teams?
- Race winners by circuit across all seasons
- Fastest pit stops per race in 2023
- Constructors that have never scored a point

### Section 4 — CTEs
- Drivers with more than 500 career points
- Driver race entries per season
- Average pit stop duration per constructor
- Win percentage share per driver across all of F1 history
- Most dominant season performances (400+ points)

### Section 5 — Date Logic
- Races held per year newest to oldest
- Days between consecutive races in the 2023 season
- Races held in the last 5 years
- Month with most F1 races historically
- Most active drivers in the last 10 years

### Section 6 — Subqueries
- Drivers who never finished on the podium
- Constructors who never won a race
- Races where the pole sitter did not win
- Drivers who outperformed the 2023 season average (GP points only)
- Drivers above the all-time  average points per race
- Drivers who outperformed the 2023 season average (GP + Sprint points)

---

## SQL Techniques Demonstrated

- Aggregations — SUM, COUNT, AVG, MIN, MAX
- GROUP BY, HAVING, ORDER BY
- INNER JOIN, LEFT JOIN across 5 tables
- CTEs — single and chained
- Correlated subqueries
- NOT IN subquery pattern
- Self JOIN for consecutive race gap analysis
- Sprint results JOIN for comprehensive points calculation
- Date functions — julianday(), strftime()
- CAST for data type handling
- ROUND for clean numeric output
- Data quality checks — NULL and empty string handling

---

## Key Findings

A detailed analysis of findings from all queries is available in [findings.md](findings.md)

Key highlights:
- Lewis Hamilton leads all-time race wins with 103 wins and he is the only driver to win more than a hundred races
- Ferrari leads all constructors with 10,761 points accumulated over 75 years
- 643 of 859 F1 drivers have never finished on the podium
- The pole sitter failed to win in 649 races across F1 history

---

## How to Run

1. Download the dataset from Kaggle
2. Import the CSV files into SQLite using DB Browser or VS Code 
   with the SQLite extension
3. Open `f1_sql_portfolio.sql` and run queries individually 
   or as a full script

---

## Author

**Vedansh Khandelwal**  
Aspiring Data Analyst | SQL · Power BI · Excel  
[LinkedIn](https://www.linkedin.com/in/vedanshkhandelwal/)