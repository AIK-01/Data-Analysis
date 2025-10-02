-- *******************************************
-- ********** HYPOTHESES TESTING *************
-- *******************************************

/*
A. Youngsters(18-35) are likelier to win competitions than oldsters(35+).
    - Since Younger people are likely more energetic than older.
*/

-- *****
-- SM H1 *****
-- *****
SELECT 
    *,
    round((`Total Participants`/ `Total Medal Wins`),2) AS Ratio
FROM
(
    SELECT 
        '18-35' AS `Age Range`,
        COUNT(*) AS `Total Participants`,
        SUM(CASE WHEN medal IN('Gold', 'Silver', 'Bronze') THEN 1 ELSE 0 END) AS `Total Medal Wins`
    From 
        summer_male
    WHERE
        age BETWEEN 18 AND 35
) a
UNION
SELECT 
    *,
    round((`Total Participants`/ `Total Medal Wins`),2) AS Ratio
FROM
(
    SELECT 
    '36-53' AS `Age Range`,
    COUNT(*) AS `Total Participants`,
    SUM(CASE WHEN medal IN('Gold', 'Silver', 'Bronze') THEN 1 ELSE 0 END) AS `Total Medal Wins`
    From 
        summer_male
    WHERE
        age BETWEEN 36 AND 53
) b;





-- *****
-- SF H1 *****
-- *****
SELECT 
    *,
    round((`Total Participants`/ `Total Medal Wins`),2) AS Ratio
FROM
(
    SELECT 
        '18-35' AS `Age Range`,
        COUNT(*) AS `Total Participants`,
        SUM(CASE WHEN medal IN('Gold', 'Silver', 'Bronze') THEN 1 ELSE 0 END) AS `Total Medal Wins`
    From 
        summer_female
    WHERE
        age BETWEEN 18 AND 35
) a
UNION
SELECT 
    *,
    round((`Total Participants`/ `Total Medal Wins`),2) AS Ratio
FROM
(
    SELECT 
    '36-53' AS `Age Range`,
    COUNT(*) AS `Total Participants`,
    SUM(CASE WHEN medal IN('Gold', 'Silver', 'Bronze') THEN 1 ELSE 0 END) AS `Total Medal Wins`
    From 
        summer_female
    WHERE
        age BETWEEN 36 AND 53
) b;





-- *****
-- WM H1 *****
-- *****
SELECT 
    *,
    round((`Total Participants`/ `Total Medal Wins`),2) AS Ratio
FROM
(
    SELECT 
        '18-35' AS `Age Range`,
        COUNT(*) AS `Total Participants`,
        SUM(CASE WHEN medal IN('Gold', 'Silver', 'Bronze') THEN 1 ELSE 0 END) AS `Total Medal Wins`
    From 
        winter_male
    WHERE
        age BETWEEN 18 AND 35
) a
UNION
SELECT 
    *,
    round((`Total Participants`/ `Total Medal Wins`),2) AS Ratio
FROM
(
    SELECT 
    '36-53' AS `Age Range`,
    COUNT(*) AS `Total Participants`,
    SUM(CASE WHEN medal IN('Gold', 'Silver', 'Bronze') THEN 1 ELSE 0 END) AS `Total Medal Wins`
    From 
        winter_male
    WHERE
        age BETWEEN 36 AND 53
) b;





-- *****
-- WF H1 *****
-- *****
SELECT 
    *,
    round((`Total Participants`/ `Total Medal Wins`),2) AS Ratio
FROM
(
    SELECT 
        '18-35' AS `Age Range`,
        COUNT(*) AS `Total Participants`,
        SUM(CASE WHEN medal IN('Gold', 'Silver', 'Bronze') THEN 1 ELSE 0 END) AS `Total Medal Wins`
    From 
        winter_female
    WHERE
        age BETWEEN 18 AND 35
) a
UNION
SELECT 
    *,
    round((`Total Participants`/ `Total Medal Wins`),2) AS Ratio
FROM
(
    SELECT 
    '36-53' AS `Age Range`,
    COUNT(*) AS `Total Participants`,
    SUM(CASE WHEN medal IN('Gold', 'Silver', 'Bronze') THEN 1 ELSE 0 END) AS `Total Medal Wins`
    From 
        winter_female
    WHERE
        age BETWEEN 36 AND 53
) b;





-- *****************************************************************************

/*
B. The weight and height of the players matters together.
    - Overweight people are likelier to win less competitions.
*/

-- ****
-- H2 M *****
-- ****
SELECT 
    `Weight Grp(BMI)`,
    `Total Participants`,
    `Total Medal Wins`,
    ROUND((`Total Medal Wins` * 100) / `Total Participants`,2) AS `Success Rate`,
    PIUS
FROM
    (
    SELECT 
        (
        CASE
            WHEN a.BMI < 18.5                THEN 'Underweight(<18.5)'
            WHEN a.BMI BETWEEN 18.5 AND 24.9 THEN 'Normal(18.5-24.9)'
            WHEN a.BMI BETWEEN 25   AND 29.9 THEN 'Overweight(25-29.9)'
            WHEN a.BMI BETWEEN 30   AND 34.9 THEN 'Obese I(30-34.9)'
            WHEN a.BMI BETWEEN 35   AND 39.9 THEN 'Obese II(35-39.9)'
            WHEN a.BMI >= 40                 THEN 'Obese III(>=40)'
        END
        )           AS `Weight Grp(BMI)`,
        COUNT(*)    AS `Total Participants`,
        SUM(CASE WHEN a.medal IN ('Gold' , 'Silver', 'Bronze') THEN 1 ELSE 0 END) AS `Total Medal Wins`,
        COUNT(DISTINCT a.Sport) AS PIUS
    FROM
        (
        SELECT 
            ROUND(weight / POWER((height / 100), 2), 1) AS BMI,
            medal,
            sport AS Sport
        FROM
            athlete_events
        WHERE
            (
            Weight IS NOT NULL AND 
            Height IS NOT NULL
            ) AND 
            event LIKE "% Men's %"
        ) AS a
    GROUP BY 
        1
    ) b
ORDER BY 
    (
    CASE
        WHEN `Weight Grp(BMI)` LIKE 'Underweight%'  THEN 1
        WHEN `Weight Grp(BMI)` LIKE 'Normal%'       THEN 2
        WHEN `Weight Grp(BMI)` LIKE 'Overweight%'   THEN 3
        WHEN `Weight Grp(BMI)` LIKE 'Obese I(%'     THEN 4
        WHEN `Weight Grp(BMI)` LIKE 'Obese II(%'    THEN 5
        WHEN `Weight Grp(BMI)` LIKE 'Obese III(%'   THEN 6
    END
    ) ASC;
    
    
    
   
   
-- ****
-- H2 F *****
-- ****
SELECT 
    `Weight Grp(BMI)`,
    `Total Participants`,
    `Total Medal Wins`,
    ROUND((`Total Medal Wins` * 100) / `Total Participants`,2) AS `Success Rate`,
    PIUS
FROM
    (
    SELECT 
        (
        CASE
            WHEN a.BMI < 18.5                THEN 'Underweight(<18.5)'
            WHEN a.BMI BETWEEN 18.5 AND 24.9 THEN 'Normal(18.5-24.9)'
            WHEN a.BMI BETWEEN 25   AND 29.9 THEN 'Overweight(25-29.9)'
            WHEN a.BMI BETWEEN 30   AND 34.9 THEN 'Obese I(30-34.9)'
            WHEN a.BMI BETWEEN 35   AND 39.9 THEN 'Obese II(35-39.9)'
            WHEN a.BMI >= 40                 THEN 'Obese III(>=40)'
        END
        )           AS `Weight Grp(BMI)`,
        COUNT(*)    AS `Total Participants`,
        SUM(CASE WHEN a.medal IN ('Gold' , 'Silver', 'Bronze') THEN 1 ELSE 0 END) AS `Total Medal Wins`,
        COUNT(DISTINCT a.Sport) AS PIUS
    FROM
        (
        SELECT 
            ROUND(weight / POWER((height / 100), 2), 1) AS BMI,
            medal,
            sport AS Sport
        FROM
            athlete_events
        WHERE
            (
            Weight IS NOT NULL AND 
            Height IS NOT NULL
            ) AND 
            Event LIKE "% Women's %"
        ) AS a
    GROUP BY 
        1
    ) b
ORDER BY 
    (
    CASE
        WHEN `Weight Grp(BMI)` LIKE 'Underweight%'  THEN 1
        WHEN `Weight Grp(BMI)` LIKE 'Normal%'       THEN 2
        WHEN `Weight Grp(BMI)` LIKE 'Overweight%'   THEN 3
        WHEN `Weight Grp(BMI)` LIKE 'Obese I(%'     THEN 4
        WHEN `Weight Grp(BMI)` LIKE 'Obese II(%'    THEN 5
        WHEN `Weight Grp(BMI)` LIKE 'Obese III(%'   THEN 6
    END
    ) ASC;
   
    



-- ********************************************************************
-- ***************** THANKS FOR REVIEWING THIS CODE *******************
-- ********************************************************************