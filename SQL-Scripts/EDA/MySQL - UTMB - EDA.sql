
# Q1 CALCULATE THE AVERAGE FINISH TIME AND STANDARD DEVATION ACROSS ALL RACES
SELECT
	Category,
    COUNT(*) AS total_races,
    ROUND(AVG(total_minutes),2) AS average_finish_time_minutes,
    ROUND(STDDEV_SAMP(total_minutes),2) AS standard_deviation
FROM utmb_results_table_Pommeret_cleaned
GROUP BY Category
ORDER BY standard_deviation DESC;

# OR THE MANUAL WAY
WITH cte AS (
	SELECT
		Category,
        AVG(total_minutes) as average_minutes
	FROM utmb_results_table_Pommeret_cleaned
    GROUP BY Category
)
SELECT
	c.Category,
    #ROUND(SUM(POWER(total_minutes - c.average_minutes, 2)),2) AS numerator,
    #COUNT(*) -1 AS denominator,
    ROUND(SQRT(SUM(POWER(total_minutes - average_minutes, 2)) / (COUNT(*) -1)),2) AS standard_deviation
FROM utmb_results_table_Pommeret_cleaned AS t
JOIN CTE AS c ON t.Category = C.Category
GROUP BY c.Category
ORDER BY standard_deviation DESC
;

# Q2 FIND OUT WHETHER PERFORMANCE IS MORE CONSISTENT IN SPECIFIC CATEGORIES
SELECT
	Category,
    ROUND(AVG(finished_percentile_overall),2) AS average_percentile_overall,
    ROUND(STDDEV_SAMP(finished_percentile_overall),2) AS standard_dev_overall
FROM utmb_results_table_Pommeret_cleaned
GROUP BY Category
ORDER BY standard_dev_overall;

# Q3 FIND RACES WHERE THE ATHLETE PERFORMED SIGNIFICANTLY ABOVE OR BELOW THEIR AVERAGE
WITH cte AS
( 
	SELECT
		Category,
		AVG(finished_percentile_overall) AS average_percentile_overall,
		STDDEV_SAMP(finished_percentile_overall) AS standard_dev_percentile_overall,
        AVG(total_minutes) AS average_total_minutes,
        STDDEV_SAMP(total_minutes) AS standard_dev_total_minutes
    FROM utmb_results_table_Pommeret_cleaned
    GROUP BY Category
	)
SELECT
	Date,
    Race,
    ROUND((t.finished_percentile_overall - c.average_percentile_overall) / c.standard_dev_percentile_overall, 2) AS z_score_percentile_finish
FROM utmb_results_table_Pommeret_cleaned AS t
JOIN cte AS c
ON c.Category = t.Category
HAVING z_score_percentile_finish < 0
ORDER BY z_score_percentile_finish
LIMIT 5;

# Q4 WHICH RACES WERE EASIEST AND HARDEST OVER THE YEARS?
# DELETED THE YEAR FROM THE RACE TITLE TO GROUP EACH RACE OVER ALL YEARS TOGETHER IN ONE ROW
UPDATE utmb_results_table_Pommeret_cleaned
SET Race = REGEXP_REPLACE(Race, '20..', '');

SELECT 
	Race,
    REGEXP_REPLACE(Race, '20..', '')
FROM utmb_results_table_Pommeret_cleaned;

WITH cte AS
( 
	SELECT
		Category,
		AVG(finished_percentile_overall) AS average_percentile_overall,
		STDDEV_SAMP(finished_percentile_overall) AS standard_dev_percentile_overall,
        AVG(total_minutes) AS average_total_minutes,
        STDDEV_SAMP(total_minutes) AS standard_dev_total_minutes
    FROM utmb_results_table_Pommeret_cleaned
    GROUP BY Category
	),
z_score_calculation AS (
	SELECT
		Date,
		Race,
		(t.total_minutes - c.average_total_minutes) / c.standard_dev_total_minutes AS z_score_minutes
	FROM utmb_results_table_Pommeret_cleaned AS t
	JOIN cte AS c
	ON c.Category = t.Category
)
SELECT
	Race,
    COUNT(*) AS count_z_scores,
    ROUND(AVG(z_score_minutes),2) AS average_z_score
FROM z_score_calculation
WHERE z_score_minutes < 0
GROUP BY Race
ORDER BY count_z_scores DESC, average_z_score
LIMIT 5;
;

# Q5 DOES THE ATHLETE'S UTMB SCORE IMPROVE OVER TIME?
SELECT
	YEAR(Date),
    ROUND(AVG(Score)) AS average_score
FROM utmb_results_table_Pommeret_cleaned
GROUP BY YEAR(Date)
ORDER BY YEAR(Date);

# Q6 IS THERE ANY SEASONAL TREND IN PERFORMANCE?
	# 21 march - 31 march + april + may + 1 june - 20 june
	# 21 june - 31 june + july + august + 1 sept - 20 sept
	# 21 sept - 31 sept + okt + nov + 1 dec - 20 dec
	# 21 dec - 31 dec + jan + feb + 1 march - 20 march
SELECT
    CASE
		WHEN (MONTH(Date) = 3 AND DAY(Date) >= 21) OR MONTH(Date) = 4 OR MONTH(Date) = 5 OR (MONTH(Date = 6) AND DAY(Date) <= 20) THEN 'Spring'
        WHEN (MONTH(Date) = 6 AND DAY(Date) >= 21) OR MONTH(Date) = 7 OR MONTH(Date) = 8 OR (MONTH(Date = 9) AND DAY(Date) <= 20) THEN 'Summer'
        WHEN (MONTH(Date) = 9 AND DAY(Date) >= 21) OR MONTH(Date) = 10 OR MONTH(Date) = 11 OR (MONTH(Date = 12) AND DAY(Date) <= 20) THEN 'Autumn'
        #WHEN (MONTH(Date) = 12 AND DAY(Date) >= 21) OR MONTH(Date) = 1 OR MONTH(Date) = 2 OR (MONTH(Date = 3) AND DAY(Date) <= 20) THEN 'Winter'
        ELSE 'Winter'
	END AS Season,
    COUNT(*) as number_of_races,
    CONCAT(ROUND(AVG(finished_percentile_overall),2), '%') as average_percentile_finish
FROM utmb_results_table_Pommeret_cleaned
GROUP BY Season
ORDER BY FIELD(Season, 'Spring', 'Summer', 'Autumn', 'Winter')
;


# Q7 IN WHICH COUNTRY DOES THE ATHLETE PERFORM BEST/WORST?
# GIVEN THE SMALL SAMPLE SIZE, I DECIDED TO SPLIT COUNTRY INTO TWO COLUMNS: FRANCE (HOME) AND OTHERS (AWAY)
ALTER TABLE utmb_results_table_Pommeret_cleaned ADD COLUMN Country_cat VARCHAR(10);

# I DISCOVERED THAT COLUMN 'COUNTRY' HAS TWO VALUES FOR FRANCE: "FRANCE" AND "'FRANCE' + ENTER (\N)". THIS WAS NOT CLEANED CORRECTLY
# I DID NOT KNOW HOW TO CLEAN THIS, SO I HAD TO LOOK UP ONLINE
SELECT DISTINCT Country FROM utmb_results_table_Pommeret_cleaned;

UPDATE utmb_results_table_Pommeret_cleaned
SET Country = TRIM(REPLACE(REPLACE(Country, '\r', ''), '\n', ''));

# BELOW CODE ADDS THE VALUES "FRANCE" OR "OTHER" INTO THE NEW COLUMN
WITH cte AS (
	SELECT
		row_num,
        Country
	FROM utmb_results_table_Pommeret_cleaned
    WHERE TRIM(Country) = 'FRANCE'
)
UPDATE utmb_results_table_Pommeret_cleaned t
JOIN cte c ON t.row_num = c.row_num
SET t.Country_cat = c.Country;

WITH cte AS (
	SELECT
		row_num,
        Country
	FROM utmb_results_table_Pommeret_cleaned
    WHERE Country != 'FRANCE'
)
UPDATE utmb_results_table_Pommeret_cleaned t
JOIN cte c ON t.row_num = c.row_num
SET t.Country_cat = 'OTHER';

# BELOW FOLLOWS THE CODE TO ANSWER THE QUESTION
SELECT
	YEAR(Date) AS Year,
    Country_cat,
    AVG(finished_percentile_overall) AS average_percentile_finish
FROM utmb_results_table_Pommeret_cleaned
GROUP BY YEAR(Date), Country_cat;

SELECT
	Country_cat,
    COUNT(*) AS count_races,
    CONCAT(ROUND(AVG(finished_percentile_overall),2), '%') AS average_percentile_finish
FROM utmb_results_table_Pommeret_cleaned
GROUP BY Country_cat;

# Q8 CALCULATE THE AVERAGE PACE (MIN/KM) PER CATEGORY. THIS CODE DID NOT WORK, SINCE SUBSTRING -1 RETURNS A WHOLE NUMBER, NOT A DECIMAL
SELECT
	Category,
    SUBSTRING_INDEX(average_pace, '.', 1) AS average_pace_minutes,
    (60 / SUBSTRING_INDEX(average_pace, '.', -1)) AS average_pace_seconds
FROM( 
	SELECT 
		Category,
		AVG(total_minutes / Distance_km) AS average_pace
	FROM utmb_results_table_Pommeret_cleaned
	GROUP BY Category
	ORDER BY average_pace
) as sub;

# I FOUND THE FOLLOWING SOLUTION:
SELECT 
	Category,
    FLOOR(average_pace) AS average_pace_minutes,
    ROUND((average_pace - FLOOR(average_pace)) * 60) AS average_pace_seconds
FROM( 
	SELECT 
		Category,
		AVG(total_minutes / Distance_km) AS average_pace
	FROM utmb_results_table_Pommeret_cleaned
	GROUP BY Category
	ORDER BY average_pace
) as sub;

# Q9 DOES RANKING PERCENTILE DROP IN LONGER RACES? 
# FOR THIS QUESTION, I SPLIT THE DISTANCE OF RACES IN BINS OF 25 KM
SELECT
    CONCAT(FLOOR(Distance_km / 25) * 25, ' - ', FLOOR(Distance_km / 25) * 25 + 25) AS distance_category,
    CONCAT(ROUND(AVG(finished_percentile_overall),2), '%') AS average_percentile_finish
FROM utmb_results_table_Pommeret_cleaned
GROUP BY distance_category
ORDER BY CAST(SUBSTRING_INDEX(distance_category, ' ', 1) AS UNSIGNED); # I HAD TO LOOK UP HOW TO FIX MY ORDER BY CLAUSE. I DID NOT KNOW HOW TO DO THIS BY HEART
# FOLLOWING ORDER BY DID NOT WORK: ORDER BY average_percentile_finish
;

# Q10 WHICH RACE HAD THE HIGHEST CLIMBING EFFICIENCY (METERS/HOUR)
SELECT 
    Category,
    Date,
    Race,
	ROUND(AVG(Elevation_gain / (total_minutes/60)),2) AS meters_incline_per_hour
FROM utmb_results_table_Pommeret_cleaned
GROUP BY Race, Category, Date
HAVING meters_incline_per_hour IS NOT NULL
ORDER BY meters_incline_per_hour DESC
LIMIT 8
;

# Q11 DOES HIGHER TOTAL ELEVATION CORRELATE WITH SLOWER FINISH TIMES? 
SELECT
    ROUND(SUM((Elevation_gain - avg_Elevation_gain) * (finished_percentile_overall - avg_finished_percentile_overall)) / 
    SQRT(SUM(POWER(Elevation_gain - avg_Elevation_gain, 2)) * SUM(POWER(finished_percentile_overall - avg_finished_percentile_overall, 2))),4) AS correlation_elevation_results
FROM (
    SELECT 
        Elevation_gain,
        finished_percentile_overall,
        (SELECT AVG(Elevation_gain) FROM utmb_results_table_Pommeret_cleaned) AS avg_Elevation_gain,
        (SELECT AVG(finished_percentile_overall) FROM utmb_results_table_Pommeret_cleaned) AS avg_finished_percentile_overall
    FROM utmb_results_table_Pommeret_cleaned
) AS sub;

# Q12 HOW OFTEN DOES THE ATHLETE PLACE IN THE TOP 5% OVERALL?
with five_cte AS (
	SELECT
	COUNT(*) AS finished_top_five
	FROM utmb_results_table_Pommeret_cleaned
	WHERE finished_percentile_overall < 5
),
total_cte AS(
	SELECT
		COUNT(*) AS total_finishes
		FROM utmb_results_table_Pommeret_cleaned
)
SELECT
	CONCAT(ROUND((f.finished_top_five / t.total_finishes * 100),2), '%') AS percentage_top_five_finishes
FROM five_cte AS f, total_cte AS t
;

# Q13 IDENTIFY:
	# BEST SCORE
	# WORST SCORE
	# RACE WITH THE FASTEST KM/H MEASURED

(SELECT
	Date,
    Race,
    CONCAT(MIN(finished_percentile_overall),'%') as finish_percentile
FROM utmb_results_table_Pommeret_cleaned
GROUP BY Race, Date
HAVING finish_percentile IS NOT NULL
ORDER BY finish_percentile ASC
LIMIT 1)

UNION

(SELECT
	Date,
    Race,
    CONCAT(MAX(finished_percentile_overall),'%') as finish_percentile
FROM utmb_results_table_Pommeret_cleaned
GROUP BY Race, Date
HAVING finish_percentile IS NOT NULL
ORDER BY CAST(SUBSTRING_INDEX(finish_percentile, ' ', 1) AS UNSIGNED) DESC
LIMIT 1)
;

SELECT
	Date,
    Race,
    Category,
    Distance_km,
    Elevation_gain,
    ROUND((Distance_km / (total_minutes/60)),2) AS `km/h`
FROM utmb_results_table_Pommeret_cleaned
ORDER BY `km/h` DESC
LIMIT 25
;

# Q14 DOES SHORTER RECOVERY TIME LEAD TO WORSE RACE RESULTS?
WITH cte AS (
	SELECT
		row_num,
		Date,
		Race,
        finished_percentile_overall,
		date_next_race,
        DATEDIFF(date_next_race, Date) as diffdate,
		CONCAT(FLOOR(DATEDIFF(date_next_race, Date) / 30) * 30, ' - ', FLOOR(DATEDIFF(date_next_race, Date) / 30) * 30 + 29) AS days_between_races
	FROM (
		SELECT
			row_num,
			Date,
			Race,
            finished_percentile_overall,
			LEAD(Date) OVER (ORDER BY Date, row_num) AS date_next_race
		FROM aned) as sub
)
SELECT 
    days_between_races,
    COUNT(*) AS count_races,
    CONCAT(ROUND(AVG(finished_percentile_overall),1), '%') AS average_percentile_finish
FROM cte
WHERE days_between_races IS NOT NULL
GROUP BY days_between_races
ORDER BY CAST(SUBSTRING_INDEX(days_between_races, ' ', 1) AS UNSIGNED); # I had to look up this final ORDER BY clause, I did not know how to do that myself.
# will not use: ORDER BY percentile_finish_overall

SELECT *
FROM utmb_results_table_Pommeret_cleaned