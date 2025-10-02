-- **********************************************
-- *********** QUESTION & ANSWERS ***************
-- **********************************************


/*
 1. Which Countries have won the highest Number of Medals ?
    1.1 This can give a clear idea of country rankings based on their Medal winnings in various sports.
    1.2 This can give a demonstration of which countries are better at sports.
*/

-- ******
-- SM Q1 ******
-- ******
WITH mp AS 
    (
    SELECT
        nr.region AS Country,
        SUM(CASE WHEN sm.medal= 'Gold'   THEN 1 ELSE 0 END) AS Gold_Medals,
        SUM(CASE WHEN sm.medal= 'Silver' THEN 1 ELSE 0 END) AS Silver_Medals,
        SUM(CASE WHEN sm.medal= 'Bronze' THEN 1 ELSE 0 END) AS Bronze_Medals
    FROM 
        summer_male sm 
    LEFT JOIN 
        noc_regions nr ON nr.noc = sm.noc
    GROUP BY
        nr.region
    )
SELECT   
    *,
    floor(((Gold_Medals*3)+(Silver_Medals*2)+(Bronze_Medals*1))/6) AS Medal_Points
FROM 
    mp
ORDER BY 
    Medal_Points DESC;
    
    
    
    

-- ******
-- SF Q1 ******
-- ******
WITH mp AS 
    (
    SELECT
        nr.region AS Country,
        SUM(CASE WHEN sf.medal= 'Gold'   THEN 1 ELSE 0 END) AS Gold_Medals,
        SUM(CASE WHEN sf.medal= 'Silver' THEN 1 ELSE 0 END) AS Silver_Medals,
        SUM(CASE WHEN sf.medal= 'Bronze' THEN 1 ELSE 0 END) AS Bronze_Medals
    FROM 
        summer_female sf 
    LEFT JOIN
        noc_regions nr ON nr.noc = sf.noc
    GROUP BY
        nr.region
    )
SELECT   
    *,
    floor(((Gold_Medals*3)+(Silver_Medals*2)+(Bronze_Medals*1))/6) AS Medal_Points
FROM
    mp
ORDER BY 
    Medal_Points DESC;
  




-- ******
-- WM Q1 ******
-- ******
WITH mp AS 
    (
    SELECT
        nr.region AS Country,
        SUM(CASE WHEN wm.medal= 'Gold'   THEN 1 ELSE 0 END) AS Gold_Medals,
        SUM(CASE WHEN wm.medal= 'Silver' THEN 1 ELSE 0 END) AS Silver_Medals,
        SUM(CASE WHEN wm.medal= 'Bronze' THEN 1 ELSE 0 END) AS Bronze_Medals
    FROM 
        winter_male wm
    LEFT JOIN 
        noc_regions nr ON nr.noc = wm.noc
    GROUP BY
        nr.region
    )
SELECT   
    *,
    floor(((Gold_Medals*3)+(Silver_Medals*2)+(Bronze_Medals*1))/6) AS Medal_Points
FROM
    mp
ORDER BY 
    Medal_Points DESC;





-- ******
-- WF Q1 ******
-- ******
WITH mp AS 
    (
    SELECT
        nr.region AS Country,
        SUM(CASE WHEN wf.medal= 'Gold'   THEN 1 ELSE 0 END) AS Gold_Medals,
        SUM(CASE WHEN wf.medal= 'Silver' THEN 1 ELSE 0 END) AS Silver_Medals,
        SUM(CASE WHEN wf.medal= 'Bronze' THEN 1 ELSE 0 END) AS Bronze_Medals
    FROM
        winter_female wf
    LEFT JOIN 
        noc_regions nr ON nr.noc = wf.noc
    GROUP BY
        nr.region
    )
SELECT   
    *,
    floor(((Gold_Medals*3)+(Silver_Medals*2)+(Bronze_Medals*1))/6) AS Medal_Points
FROM
    mp
ORDER BY 
    Medal_Points DESC;
    
    



-- **********
-- RANKING Q1 ******
-- **********
WITH PR AS 
(
    (
    SELECT 
        *,
        floor(((Gold_Medals*3)+(Silver_Medals*2)+(Bronze_Medals*1))/6) AS Medal_Points
    FROM 
        (
    SELECT
        nr.region AS Country,
        SUM(CASE WHEN sm.medal= 'Gold'   THEN 1 ELSE 0 END) AS Gold_Medals,
        SUM(CASE WHEN sm.medal= 'Silver' THEN 1 ELSE 0 END) AS Silver_Medals,
        SUM(CASE WHEN sm.medal= 'Bronze' THEN 1 ELSE 0 END) AS Bronze_Medals
    FROM 
        summer_male sm 
    LEFT JOIN 
        noc_regions nr ON nr.noc = sm.noc
    GROUP BY
        nr.region
        ) AS mp
    ORDER BY
        Medal_Points DESC
    )
    UNION
    (
    SELECT 
        *,
        floor(((Gold_Medals*3)+(Silver_Medals*2)+(Bronze_Medals*1))/6) AS Medal_Points
    FROM (
    SELECT
        nr.region AS Country,
        SUM(CASE WHEN sf.medal= 'Gold'   THEN 1 ELSE 0 END) AS Gold_Medals,
        SUM(CASE WHEN sf.medal= 'Silver' THEN 1 ELSE 0 END) AS Silver_Medals,
        SUM(CASE WHEN sf.medal= 'Bronze' THEN 1 ELSE 0 END) AS Bronze_Medals
    FROM 
        summer_female sf 
    LEFT JOIN 
        noc_regions nr ON nr.noc = sf.noc
    GROUP BY
        nr.region
        ) AS mp
    ORDER BY
        Medal_Points DESC
    )
    UNION
    (
    SELECT 
        *,
        floor(((Gold_Medals*3)+(Silver_Medals*2)+(Bronze_Medals*1))/6) AS Medal_Points
    FROM (
    SELECT
        nr.region AS Country,
        SUM(CASE WHEN wm.medal= 'Gold'   THEN 1 ELSE 0 END) AS Gold_Medals,
        SUM(CASE WHEN wm.medal= 'Silver' THEN 1 ELSE 0 END) AS Silver_Medals,
        SUM(CASE WHEN wm.medal= 'Bronze' THEN 1 ELSE 0 END) AS Bronze_Medals
    FROM 
        winter_male wm 
    LEFT JOIN 
        noc_regions nr ON nr.noc = wm.noc
    GROUP BY
        nr.region
        )  AS mp
    ORDER BY
        Medal_Points DESC
    )
    UNION
    (
    SELECT 
        *,
        floor(((Gold_Medals*3)+(Silver_Medals*2)+(Bronze_Medals*1))/6) AS Medal_Points
    FROM (
    SELECT
        nr.region AS Country,
        SUM(CASE WHEN wf.medal= 'Gold'   THEN 1 ELSE 0 END) AS Gold_Medals,
        SUM(CASE WHEN wf.medal= 'Silver' THEN 1 ELSE 0 END) AS Silver_Medals,
        SUM(CASE WHEN wf.medal= 'Bronze' THEN 1 ELSE 0 END) AS Bronze_Medals
    FROM 
        winter_female wf 
    LEFT JOIN 
        noc_regions nr ON nr.noc = wf.noc
    GROUP BY
        nr.region
        ) AS mp
    ORDER BY
        Medal_Points DESC
    )
)

SELECT 
    Country,
    sum(Medal_Points) AS Total_Medal_Points,
    (
    CASE 
        WHEN SUM(Medal_Points) >= 1000             THEN 'Best'
        WHEN SUM(Medal_Points) BETWEEN 400 AND 999 THEN 'Better'
        WHEN SUM(Medal_Points) BETWEEN 100 AND 399 THEN 'Good'
        WHEN SUM(Medal_Points) BETWEEN 50  AND 99  THEN 'Not Bad'
        WHEN SUM(Medal_Points) BETWEEN 1   AND 49  THEN 'Bad'
        WHEN SUM(Medal_Points) = 0                 THEN 'Worst'
    END
    ) AS Ranking
FROM 
    PR
GROUP BY 
  Country
ORDER BY
  Total_Medal_Points DESC;
  
  
  
  
 
-- ************************************************************************* 

/*
 2. What Sports are most popular 
    2.1 In each country?
    2.2 Of all time?
*/

-- ********
-- SM Q2 P1 ******
-- ********
WITH pop AS
(
    SELECT 
        nr.region AS Country,
        sm.sport  AS Sports,
        count(*)  AS total_participation,
        rank() OVER (PARTITION BY nr.region ORDER BY Count(*) DESC) AS ranking
    FROM 
        summer_male sm
    INNER JOIN 
        noc_regions nr ON nr.noc = sm.noc
    GROUP BY
        Country,
        Sports
)

SELECT 
    Country,
    Sports,
    total_participation
FROM
    pop -- popularity
WHERE
    ranking = 1;

  
  
  
  

-- ********
-- SF Q2 P1 ******
-- ********
WITH pop AS
(
    SELECT 
        nr.region AS Country,
        sf.sport  AS Sports,
        count(*)  AS total_participation,
        rank() OVER (PARTITION BY nr.region ORDER BY Count(*) DESC) AS ranking
    FROM 
        summer_female sf
    INNER JOIN 
        noc_regions nr ON nr.noc = sf.noc
    GROUP BY
        Country,
        Sports
)

SELECT 
    Country,
    Sports,
    total_participation
FROM
    pop -- popularity
WHERE
    ranking = 1;
 
 
 
  
  
-- ********
-- WM Q2 P1 ******
-- ********
WITH pop AS
(
    SELECT 
        nr.region AS Country,
        wm.sport  AS Sports,
        count(*)  AS total_participation,
        rank() OVER (PARTITION BY nr.region ORDER BY Count(*) DESC) AS ranking
    FROM 
        winter_male wm 
    INNER JOIN 
        noc_regions nr ON nr.noc = wm.noc
    GROUP BY
        Country,
        Sports
)

SELECT 
    Country,
    Sports,
    total_participation
FROM
    pop -- popularity
WHERE
    ranking = 1;






-- ********
-- WF Q2 P1 ******
-- ********
WITH pop AS
(
    SELECT 
        nr.region AS Country,
        wf.sport  AS Sports,
        count(*)  AS total_participation,
        rank() OVER (PARTITION BY nr.region ORDER BY Count(*) DESC) AS ranking
    FROM 
        winter_female wf 
    INNER JOIN 
        noc_regions nr ON nr.noc = wf.noc
    GROUP BY
        Country,
        Sports
)

SELECT 
    Country,
    Sports,
    total_participation
FROM
    pop -- popularity
WHERE
    ranking = 1;
  
  

-- ************ PART 2 ***************


-- ********
-- SM Q2 P2 ******
-- ********
SELECT 
    sport AS Sport,
    COUNT(sport) AS toal_participants
FROM
    summer_male
GROUP BY 
    Sport
ORDER BY 
    toal_participants DESC;
  
  

  
-- ********  
-- SF Q2 P2 ******
-- ********
SELECT 
    sport AS Sport,
    COUNT(sport) AS toal_participants
FROM
    summer_female
GROUP BY 
    Sport
ORDER BY 
    toal_participants DESC;





-- ********
-- WM Q2 P2 ******
-- ********
SELECT 
    sport AS Sport,
    COUNT(sport) AS toal_participants
FROM
    winter_male
GROUP BY 
    Sport
ORDER BY
    toal_participants DESC;
  
  
  


-- ********  
-- WF Q2 P2 ******
-- ********
SELECT 
    sport AS Sport,
    COUNT(sport) AS toal_participants
FROM
    winter_female
GROUP BY 
    Sport
ORDER BY 
    toal_participants DESC;





-- **********************************************************************
/*
 3. Which country is best in which sport?
*/

-- ********
-- SM Q3 P1 ******
-- ********
WITH rnk AS
(
SELECT 
    *,
    Dense_Rank() OVER(PARTITION BY Sport ORDER BY Medal_Points DESC) AS Ranking
FROM    
    (
    SELECT
        Sport,
        Country,
        floor(((Gold_Medals*3)+(Silver_Medals*2)+(Bronze_Medals*1))/6) AS Medal_Points
    FROM
        (
        SELECT 
            sm.sport  AS Sport,
            nr.region AS Country,
            SUM(CASE WHEN sm.Medal= 'Gold'   THEN 1 ELSE 0 END) AS Gold_Medals,
            SUM(CASE WHEN sm.Medal= 'Silver' THEN 1 ELSE 0 END) AS Silver_Medals,
            SUM(CASE WHEN sm.Medal= 'Bronze' THEN 1 ELSE 0 END) AS Bronze_Medals
        FROM 
            summer_male sm
        INNER JOIN 
            noc_regions nr ON nr.noc = sm.noc
        GROUP BY
            Sport,
            Country
        ORDER BY
            Sport
        ) mdl
    ) mp
)

SELECT 
    Sport,
    Country,
    Medal_Points
FROM
    rnk
WHERE
    Ranking = 1
    AND 
    Medal_Points <> 0;
    
    

    

-- ********
-- SF Q3 P1 ******
-- ********    
WITH rnk AS
(
SELECT 
    *,
    Dense_Rank() OVER(PARTITION BY Sport ORDER BY Medal_Points DESC) AS Ranking
FROM    
    (
    SELECT
        Sport,
        Country,
        floor(((Gold_Medals*3)+(Silver_Medals*2)+(Bronze_Medals*1))/6) AS Medal_Points
    FROM
        (
        SELECT 
            sf.sport  AS Sport,
            nr.region AS Country,
            SUM(CASE WHEN sf.Medal= 'Gold'   THEN 1 ELSE 0 END) AS Gold_Medals,
            SUM(CASE WHEN sf.Medal= 'Silver' THEN 1 ELSE 0 END) AS Silver_Medals,
            SUM(CASE WHEN sf.Medal= 'Bronze' THEN 1 ELSE 0 END) AS Bronze_Medals
        FROM 
            summer_female sf
        INNER JOIN 
            noc_regions nr ON nr.noc = sf.noc
        GROUP BY
            Sport,
            Country
        ORDER BY
            Sport
        ) mdl
    ) mp
)

SELECT 
    Sport,
    Country,
    Medal_Points
FROM
    rnk
WHERE
    Ranking = 1
    AND 
    Medal_Points <> 0;
  
  


  
-- ********
-- WM Q3 P1 ******
-- ********
WITH rnk AS
(
SELECT 
    *,
    Dense_Rank() OVER(PARTITION BY Sport ORDER BY Medal_Points DESC) AS Ranking
FROM    
    (
    SELECT
        Sport,
        Country,
        floor(((Gold_Medals*3)+(Silver_Medals*2)+(Bronze_Medals*1))/6) AS Medal_Points
    FROM
        (
        SELECT 
            wm.sport  AS Sport,
            nr.region AS Country,
            SUM(CASE WHEN wm.Medal= 'Gold'   THEN 1 ELSE 0 END) AS Gold_Medals,
            SUM(CASE WHEN wm.Medal= 'Silver' THEN 1 ELSE 0 END) AS Silver_Medals,
            SUM(CASE WHEN wm.Medal= 'Bronze' THEN 1 ELSE 0 END) AS Bronze_Medals
        FROM 
            winter_male wm
        INNER JOIN 
            noc_regions nr ON nr.noc = wm.noc
        GROUP BY
            Sport,
            Country
        ORDER BY
            Sport
        ) mdl
    ) mp
)

SELECT 
    Sport,
    Country,
    Medal_Points
FROM
    rnk
WHERE
    Ranking = 1
    AND 
    Medal_Points <> 0;
  
  
  

  
-- ********
-- WF Q3 P1 ******
-- ********
WITH rnk AS
(
SELECT 
    *,
    Dense_Rank() OVER(PARTITION BY Sport ORDER BY Medal_Points DESC) AS Ranking
FROM    
    (
    SELECT
        Sport,
        Country,
        floor(((Gold_Medals*3)+(Silver_Medals*2)+(Bronze_Medals*1))/6) AS Medal_Points
    FROM
        (
        SELECT 
            wf.sport  AS Sport,
            nr.region AS Country,
            SUM(CASE WHEN wf.Medal= 'Gold'   THEN 1 ELSE 0 END) AS Gold_Medals,
            SUM(CASE WHEN wf.Medal= 'Silver' THEN 1 ELSE 0 END) AS Silver_Medals,
            SUM(CASE WHEN wf.Medal= 'Bronze' THEN 1 ELSE 0 END) AS Bronze_Medals
        FROM 
            winter_female wf
        INNER JOIN 
            noc_regions nr ON nr.noc = wf.noc
        GROUP BY
            Sport,
            Country
        ORDER BY
            Sport
        ) mdl
    ) mp
)

SELECT 
    Sport,
    Country,
    Medal_Points
FROM
    rnk
WHERE
    Ranking = 1
    AND 
    Medal_Points <> 0;





-- ************* PART 2 **************

-- ******** 
-- SM Q3 P2 ******
-- ********
WITH rnk AS
(
SELECT 
    *,
    Dense_Rank() OVER(PARTITION BY Country ORDER BY Medal_Points DESC) AS Ranking
FROM    
    (
    SELECT
        Country,
        Sport,
        floor(((Gold_Medals*3)+(Silver_Medals*2)+(Bronze_Medals*1))/6) AS Medal_Points
    FROM
        (
        SELECT
            nr.region AS Country,
            sm.sport  AS Sport,
            SUM(CASE WHEN sm.Medal= 'Gold'   THEN 1 ELSE 0 END) AS Gold_Medals,
            SUM(CASE WHEN sm.Medal= 'Silver' THEN 1 ELSE 0 END) AS Silver_Medals,
            SUM(CASE WHEN sm.Medal= 'Bronze' THEN 1 ELSE 0 END) AS Bronze_Medals
        FROM 
            summer_male sm
        INNER JOIN 
            noc_regions nr ON nr.noc = sm.noc
        GROUP BY
            Country,
            Sport
        ORDER BY
            Country
        ) mdl
    ) mp
)

SELECT 
    Country,
    Sport,
    Medal_Points
FROM
    rnk
WHERE
    Ranking = 1
    AND 
    Medal_Points <> 0;
  
  
  

  
-- ********
-- SF Q3 P2 ******
-- ********
WITH rnk AS
(
SELECT 
    *,
    Dense_Rank() OVER(PARTITION BY Country ORDER BY Medal_Points DESC) AS Ranking
FROM    
    (
    SELECT
        Country,
        Sport,
        floor(((Gold_Medals*3)+(Silver_Medals*2)+(Bronze_Medals*1))/6) AS Medal_Points
    FROM
        (
        SELECT
            nr.region AS Country,
            sf.sport  AS Sport,
            SUM(CASE WHEN sf.Medal= 'Gold'   THEN 1 ELSE 0 END) AS Gold_Medals,
            SUM(CASE WHEN sf.Medal= 'Silver' THEN 1 ELSE 0 END) AS Silver_Medals,
            SUM(CASE WHEN sf.Medal= 'Bronze' THEN 1 ELSE 0 END) AS Bronze_Medals
        FROM 
            summer_female sf
        INNER JOIN 
            noc_regions nr ON nr.noc = sf.noc
        GROUP BY
            Country,
            Sport
        ORDER BY
            Country
        ) mdl
    ) mp
)

SELECT 
    Country,
    Sport,
    Medal_Points
FROM
    rnk
WHERE
    Ranking = 1
    AND 
    Medal_Points <> 0;
  
  
  
  
-- ********
-- WM Q3 P2 ******
-- ********  
WITH rnk AS
(
SELECT 
    *,
    Dense_Rank() OVER(PARTITION BY Country ORDER BY Medal_Points DESC) AS Ranking
FROM    
    (
    SELECT
        Country,
        Sport,
        floor(((Gold_Medals*3)+(Silver_Medals*2)+(Bronze_Medals*1))/6) AS Medal_Points
    FROM
        (
        SELECT
            nr.region AS Country,
            wm.sport  AS Sport,
            SUM(CASE WHEN wm.Medal= 'Gold'   THEN 1 ELSE 0 END) AS Gold_Medals,
            SUM(CASE WHEN wm.Medal= 'Silver' THEN 1 ELSE 0 END) AS Silver_Medals,
            SUM(CASE WHEN wm.Medal= 'Bronze' THEN 1 ELSE 0 END) AS Bronze_Medals
        FROM 
            winter_male wm
        INNER JOIN 
            noc_regions nr ON nr.noc = wm.noc
        GROUP BY
            Country,
            Sport
        ORDER BY
            Country
        ) mdl
    ) mp
)

SELECT 
    Country,
    Sport,
    Medal_Points
FROM
    rnk
WHERE
    Ranking = 1
    AND 
    Medal_Points <> 0;
    
    
    
  
  
-- ********
-- WF Q3 P2 ******
-- ********
WITH rnk AS
(
SELECT 
    *,
    Dense_Rank() OVER(PARTITION BY Country ORDER BY Medal_Points DESC) AS Ranking
FROM    
    (
    SELECT
        Country,
        Sport,
        floor(((Gold_Medals*3)+(Silver_Medals*2)+(Bronze_Medals*1))/6) AS Medal_Points
    FROM
        (
        SELECT
            nr.region AS Country,
            wf.sport  AS Sport,
            SUM(CASE WHEN wf.Medal= 'Gold'   THEN 1 ELSE 0 END) AS Gold_Medals,
            SUM(CASE WHEN wf.Medal= 'Silver' THEN 1 ELSE 0 END) AS Silver_Medals,
            SUM(CASE WHEN wf.Medal= 'Bronze' THEN 1 ELSE 0 END) AS Bronze_Medals
        FROM 
            winter_female wf
        INNER JOIN 
            noc_regions nr ON nr.noc = wf.noc
        GROUP BY
            Country,
            Sport
        ORDER BY
            Country
        ) mdl
    ) mp
)

SELECT 
    Country,
    Sport,
    Medal_Points
FROM
    rnk
WHERE
    Ranking = 1
    AND 
    Medal_Points <> 0;
    
    
    


-- *********************************************************************

/*
 4. What is the beginning and ending year of participation of each country?
*/

-- *****
-- SM Q4 ******
-- *****
SELECT
    nr.region AS Country,
    MIN(year) AS `Beginning Year`,
    (CASE WHEN MAX(year) <> '2016' THEN MAX(year) ELSE 'Still Participating' END ) AS `Ending Year`
FROM
    summer_male sm
INNER JOIN 
    noc_regions nr ON nr.noc = sm.noc
GROUP BY
    nr.region
ORDER BY
    Country;





-- *****
-- SF Q4 ******
-- *****
SELECT
    nr.region AS Country,
    MIN(year) AS `Beginning Year`,
    (CASE WHEN MAX(year) <> '2016' THEN MAX(year) ELSE 'Still Participating' END ) AS `Ending Year`
FROM
    summer_female sf
INNER JOIN 
    noc_regions nr ON nr.noc = sf.noc
GROUP BY
    nr.region
ORDER BY
    Country;
  
  
  


-- *****
-- WM Q4 ******
-- *****
SELECT
    nr.region AS Country,
    MIN(year) AS `Beginning Year`,
    (CASE WHEN MAX(year) <> '2014' THEN MAX(year) ELSE 'Still Participating' END ) AS `Ending Year`
FROM
    winter_male wm
INNER JOIN 
    noc_regions nr ON nr.noc = wm.noc
GROUP BY
    nr.region
ORDER BY
    Country;
  
  
  
  
  
  
  
-- ***** 
-- WF Q4 ******
-- *****
SELECT
    nr.region AS Country,
    MIN(year) AS `Beginning Year`,
    (CASE WHEN MAX(year) <> '2014' THEN MAX(year) ELSE 'Still Participating' END ) AS `Ending Year`
FROM 
    winter_female wf
INNER JOIN 
    noc_regions nr ON nr.noc = wf.noc
GROUP BY
    nr.region
ORDER BY
    Country;





-- ***********************************************************************
/*
 5. What is the average Age, Weight and Height of athletes in different sports?
*/

-- *****
-- SM Q5 ******
-- *****
SELECT 
    sport,
    count(*)             AS `Total Participants`,
    round(avg(age),2)    AS `Average Age`,
    round(avg(height),2) AS `Average Height`,
    round(avg(weight),2) AS `Average Weight`
FROM
    summer_male
GROUP BY
    1 
ORDER BY
    1;
  
  
  
  
  
-- *****
-- SF Q5 ******
-- *****
SELECT 
    sport,
    count(*)             AS `Total Participants`,
    round(avg(age),2)    AS `Average Age`,
    round(avg(height),2) AS `Average Height`,
    round(avg(weight),2) AS `Average Weight`
FROM
    summer_female
GROUP BY
    1
ORDER BY
    1;
  
  
  
  
  
-- *****
-- WM Q5 ******
-- *****
SELECT 
    sport,
    count(*)             AS `Total Participants`,
    round(avg(age),2)    AS `Average Age`,
    round(avg(height),2) AS `Average Height`,
    round(avg(weight),2) AS `Average Weight`
FROM 
    winter_male
GROUP BY
    1
ORDER BY
    1;
  
  
  
  
  
-- *****
-- WF Q5 ******
-- *****
SELECT 
    sport,
    count(*)             AS `Total Participants`,
    round(avg(age),2)    AS `Average Age`,
    round(avg(height),2) AS `Average Height`,
    round(avg(weight),2) AS `Average Weight`
FROM 
    winter_female 
GROUP BY
    1
ORDER BY
    1;
  




-- **********************************************************************

/*
 6. Is there anything hidden in the age range?
*/

-- *****
-- SM Q6 ******
-- *****
SELECT 
    age,
    count(*)              AS `Total Participants`,
    count(DISTINCT Sport) AS `PIUS`
FROM
    summer_male
WHERE
    age IS NOT NULL
GROUP BY
    1
ORDER BY
    1;
  




-- *****
-- SF Q6 ******
-- *****
SELECT 
    age,
    count(*)              AS `Total Participants`,
    count(DISTINCT Sport) AS `PIUS`
FROM
    summer_female
WHERE
    age IS NOT NULL
GROUP BY
    1
ORDER BY
    1;
  




-- *****
-- WM Q6 ******
-- *****
SELECT 
    age,
    count(*)              AS `Total Participants`,
    count(DISTINCT Sport) AS `PIUS`
FROM
    winter_male
WHERE
    age IS NOT NULL
GROUP BY
    1
ORDER BY
    1;





-- *****
-- WF Q6 ******
-- *****
SELECT 
    age,
    count(*)              AS `Total Participants`,
    count(DISTINCT Sport) AS `PIUS`
FROM
    winter_female
WHERE
    age IS NOT NULL
GROUP BY
    1
ORDER BY
    1;





-- **********************************************
-- ********** ANALYZING MIXED EVENTS ************
-- **********************************************

-- ******************
-- Participation Rate ******
-- ******************
SELECT 
    year,
    sum(CASE WHEN Season = 'Summer' AND Sex = 'M' THEN 1 ELSE 0 END) AS `Summer Male`,
    sum(CASE WHEN Season = 'Summer' AND Sex = 'F' THEN 1 ELSE 0 END) AS `Summer Female`,
    sum(CASE WHEN Season = 'Winter' AND Sex = 'M' THEN 1 ELSE 0 END) AS `Winter Male`,
    sum(CASE WHEN Season = 'Winter' AND Sex = 'F' THEN 1 ELSE 0 END) AS `Winter Female`
FROM
    athlete_events
WHERE 
    event LIKE '% Mixed %'
GROUP BY
    year
ORDER BY
    year;
    
    
-- *****************************************************************************

    
/*    
 1. When the Mixed events were first introduced in the olympics in different seasons?
*/

SELECT 
    'Summer' AS Season,
    MIN(year) AS `Intital Year`
FROM 
    athlete_events
WHERE
    event LIKE '% Mixed %'
    AND
    Season = "Summer"
UNION
SELECT 
    'Winter' AS Season,
    MIN(year) AS `Intital Year`
FROM 
    athlete_events
WHERE
    event LIKE '% Mixed %'
    AND
    Season = "Winter";




-- *********************************************************************


/*
 2. Which country when started and stopped participating in such events?
*/

-- *******
-- ME Q2 S ******
-- *******
SELECT 
    nr.region AS Country,
    MIN(Year) AS `Starting Year`,
    (CASE WHEN MAX(Year) <> '2016' THEN MAX(Year) ELSE 'Still Participating' END) AS `Ending Year`
FROM 
    athlete_events ae
INNER JOIN 
    noc_regions nr ON nr.noc = ae.noc
WHERE 
    event LIKE '% Mixed %'
    AND
    season = 'Summer'
GROUP BY
    nr.region
ORDER BY
    Country;
    




-- *******    
-- ME Q2 W ******
-- *******
SELECT 
    nr.region AS Country,
    MIN(Year) AS `Starting Year`,
    (CASE WHEN MAX(Year) <> '2014' THEN MAX(Year) ELSE 'Still Participating' END) AS `Ending Year`
FROM 
    athlete_events ae
INNER JOIN 
    noc_regions nr ON nr.noc = ae.noc
WHERE 
    event LIKE '% Mixed %'
    AND
    season = 'Winter'
GROUP BY
    nr.region
ORDER BY 
    Country;
    
    
    
    
-- ************************************************************************** 
 
 
/*
 3. How many Unique Sports are there in this event category?
*/

-- *******
-- ME Q3 S ******
-- *******
SELECT 
    DISTINCT sport AS Sport
FROM 
    athlete_events
WHERE
    event LIKE '% Mixed %'
    AND
    season = 'Summer';
    




-- *******
-- ME Q3 W ******
-- *******
SELECT 
    DISTINCT sport AS Sport
FROM 
    athlete_events
WHERE
    event LIKE '% Mixed %'
    AND
    season = 'Winter';
    
    
    
    

-- ************************************************************************
    
/*    
 4. Who is the best in it?
*/

-- *******
-- ME Q4 S ******
-- *******
WITH rnk AS
(
SELECT 
    *,
    Dense_Rank() OVER(PARTITION BY Sport ORDER BY Medal_Points DESC) AS Ranking
FROM    
    (
    SELECT
        Sport,
        Country,
        floor(((Gold_Medals*3)+(Silver_Medals*2)+(Bronze_Medals*1))/6) AS Medal_Points
    FROM
        (
        SELECT 
            ae.sport  AS Sport,
            nr.region AS Country,
            SUM(CASE WHEN ae.Medal= 'Gold'   THEN 1 ELSE 0 END) AS Gold_Medals,
            SUM(CASE WHEN ae.Medal= 'Silver' THEN 1 ELSE 0 END) AS Silver_Medals,
            SUM(CASE WHEN ae.Medal= 'Bronze' THEN 1 ELSE 0 END) AS Bronze_Medals
        FROM 
            athlete_events ae
        INNER JOIN 
            noc_regions nr ON nr.noc = ae.noc
        WHERE
            ae.event LIKE '% Mixed %'
            AND
            ae.season = 'Summer'
        GROUP BY
            Sport,
            Country
        ORDER BY
            Sport
        ) mdl
    ) mp
)

SELECT 
    Sport,
    Country,
    Medal_Points
FROM
    rnk
WHERE
    Ranking = 1;
    
    
    


-- *******    
-- ME Q4 W ******
-- *******
WITH rnk AS
(
SELECT 
    *,
    Dense_Rank() OVER(PARTITION BY Sport ORDER BY Medal_Points DESC) AS Ranking
FROM    
    (
    SELECT
        Sport,
        Country,
        floor(((Gold_Medals*3)+(Silver_Medals*2)+(Bronze_Medals*1))/6) AS Medal_Points
    FROM
        (
        SELECT 
            ae.sport  AS Sport,
            nr.region AS Country,
            SUM(CASE WHEN ae.Medal= 'Gold'   THEN 1 ELSE 0 END) AS Gold_Medals,
            SUM(CASE WHEN ae.Medal= 'Silver' THEN 1 ELSE 0 END) AS Silver_Medals,
            SUM(CASE WHEN ae.Medal= 'Bronze' THEN 1 ELSE 0 END) AS Bronze_Medals
        FROM 
            athlete_events ae
        INNER JOIN 
            noc_regions nr ON nr.noc = ae.noc
        WHERE
            ae.event LIKE '% Mixed %'
            AND
            ae.season = 'Winter'
        GROUP BY
            Sport,
            Country
        ORDER BY
            Sport
        ) mdl
    ) mp
)

SELECT 
    Sport,
    Country,
    Medal_Points
FROM
    rnk
WHERE
    Ranking = 1;
    
    
    
    
    
-- ********************************************************************
-- ***************** THANKS FOR REVIEWING THIS CODE *******************
-- ********************************************************************