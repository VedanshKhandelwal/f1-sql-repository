# F1 Data Analysis - Key Findings

## Project Overview
- Dataset : Formula 1 World Championship (1950 - 2024)
- Tools: SQLite, VS Code, Excel 
- Queries Written: 31
- Skills Covered: Aggregations, JOINs, CTEs, Subqueries, Date Logic, Data Profiling
## Key Findings:

## Section 1: DATA PROFILING & EXPLORATION

The data provides us insights into Formula 1 World Drivers Championships between 1950 and 2024. In the 75 years of Formula 1, there have been 1125 races in which 859 drivers have participated. These races have been conducted at different circuits in countries around the globe. In recent years the race calendar for each season has featured more races than in past, indicating increasing popularity. In the initial years of the sport there were less than 10 races in a season with 2024 season featuring 24 races. It is the most in the sports history. 

## Section 2: AGGREGATION & RANKINGS

In 75 years of Formula 1, there have been many successful drivers, like Lewis Hamilton, Michael Schumacher, Max Verstappen and Sebastian Vettel. But there is no match of Lewis Hamilton who has won 103 races, making him the only driver to win more than a hundred races beating Michael Schumacher's record of 91 wins. 
Another measure of success in Formula 1 is a drivers average finishing position, where Ayrton Senna leads Alain Prost and Jackie Stewart with their average finishing positions as 1.92, 2.08 and 2.12 respectively. This highlights how consistently good these drivers have been race after race.
Winning WDC is a feat to be proud of but winning it like Max in 2022 & 2023 is a different league. He scored 433 and 530 points, respectively, beating Lewis Hamilton's 2019 record of scoring 413 points in a single season.
But Formula 1 is also a team sport and teams like Ferrari, Mercedes and RedBull have been dominant. With team Ferrari accumulating 10761.27 points through the years, it leads team Mercedes and RedBull by a margin of 3000+ points. It shows how successful Ferrari has been and why they are one of the legacy teams in the sport.
With most points Ferrari also have most wins as a constructor at 246, followed by McLaren at 180 and Mercedes at 126. It shows how successful these teams/ constructors have been in the sports history.

## Section 3: JOINs & MULTI-TABLE ANALYSIS

2023 season was dominated by Max Verstappen and RedBull. Between Max Verstappen and Sergio Perez, RedBull won all the races but one which Ferrari won with Carlos Sainz. That season RedBull were in a league of their own, especially Max Verstappen not only won the WDC but also won all but three races out of which Sergio Perez won two. 

As in any other sports, teams and drivers are allowed to make moves and some of the Formula 1 drivers have changed teams as many as 14 times. Chris Amon leads the tally by racing for 14 different constructors followed by Maurice Trintignant for 13 constructors and Stirling Moss for 12 constructors. 

The first ever Formula 1 race was in 1950 at Silverstone Circuit called British Grand Prix. Nino Farina won the race for Alfa Romeo becoming the first ever Formula 1 race winner. Nino Farina and Juan	Fangio both won three races each out of seven races held that season. 

Now in a Formula 1 race, every part of the car has to be as efficient and quick as possible. A Formula 1 car's tyres are not like regular tyres, they are made to be as quick as possible and therefore, are not as durable as our regular tyres. So drivers have to get their tyres changed during the race and to do so they have to come into their pits. The pit stops can make or break a driver's race and therefore they have to be very quick. The data shows Carlos Sainz had the quickest pit stop in Bahrain Grand Prix, only spending 24.227s. 

Not every team that has competed in Formula 1 has been successful. There are 106 teams that have raced in Formula 1 but have not scored a single point. It shows how fierce the competition is and therefore, is the pinnacle of motorsports. 

## Section 4: CTEs

Another way of measuring a drivers performance is how many points they have scored throughout their career and Lewis Hamilton tops the tally with 4688.5 points, showing his class and consistency. He is followed by Sebastian Vettel with 3098 points and Max	Verstappen with 2726.5. 

As the Formula 1 seasons have expanded from 7 races in 1950 to 24 races in 2024, it is interesting to see who has finished most races in a season. Clearly, Max Verstappen comes out on top with 22 finishes in 2023 followed by Lewis Hamilton with 21 finishes in 2019 & 2021 and 20 finished in 2018 & 2023. A lengthy race calendar means more opportunity for a driver to showcase their skills but also increases workload in a given season impacting their performance. 

As mentioned earlier that pit stops are crucial for drivers as well as teams and one measure of a team's mechanics performance, who perform the pit stop, can be judged by their average pit stop duration. RB F1 Team (now Racing Bulls) leads Mercedes and Red Bulls with average pit stop of 23.389, 23.593 and 23.602 respectively. The extreme proximity in their averages shows how competitive the sport is and the difference is almost negligible for regular folks. 

Lewis Hamilton has won 9.24% of all Formula 1 races followed by Michael Schumacher winning 8.16%  and Max Verstappen winning 5.47%. It goes on to show how great these drivers have been in Formula 1's 75 years of history. 

Lewis Hamilton and Max Verstappen's success can also be seen from how they are the only two drivers to score more than 400 points in a single season.


## SECTION 5: DATE LOGIC

With race calendars expanding and more races being added to a season, the gap between two races is important to plan the logistics of Formula 1 cars as well as team members. With gaps ranging from 7 to 28 days between races each day is crucial and any delays can disrupt a team/ driver's race.

For Formula 1 teams to perform at the highest level, they don't leave any stone unturned. Therefore, looking at which tracks have been used in past 5 years and identifying tracks that are used repeatedly can help increase their performance on track and can also help in financial planning. 

Another interesting insight is identifying the busiest time of the year. In past 75 years, there have been 184 races in July followed by May with 157 races, implying these two are the busiest months for Formula 1.

Max Verstappen has shown his strengths in every area possible and again, in last 10 years he has entered most races at 156 alongside Valtteri Bottas followed by Lance	Stroll,Carlos	Sainz and Lewis	Hamilton all at 155 races. 


## SECTION 6: SUBQUERIES

The competition in Formula 1 is so fierce that 643 drivers out of 859 drivers (to ever participate in a Formula 1 race) have never been on podium. Meaning they have never finished in top 3 in their entire careers. And there are 164 teams/ constructors who have never won a single race. 

The current format of Formula 1 where qualifying decides the grid position for the race makes a big impact on race result. But a pole position (1st position on grid for race) does not always guarantee a race win. There have been 649 races where the pole sitter has not won the race. 

A measure of how successful a driver is to compare them with their peers in the same generation of cars with same regulations in the same season. Out of all the drivers who participated in 2023 season only 8 drivers were above average ( 101 points ). 

To put it into perspective, through out the 75 years of Formula 1 history 68 drivers out of 859 drivers who have participated have averaged more than 1.95 points per race, highlighting how consistent the front runners' performance is. Max Verstappen and Lewis Hamilton top the table with 13+ average points per race followed by Sebastian Vettel with an average of 10.32 points per race. 

## Data Limitations: 
1. The dataset appears incomplete for the 2024 season — not all races are represented, which may affect findings related to recent seasons. Analysis referencing 2024 should be interpreted with this caveat in mind. 
2. The sprint results table may not cover all sprint rounds. 
