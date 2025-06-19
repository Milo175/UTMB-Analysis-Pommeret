# DATA CLEANING
# CREATE THE NEW TABLE MANUALLY, IMPORT WIZARD WAS GIVING ME TROUBLE
DROP TABLE IF EXISTS `Ultra Marathon Dataset`.utmb_results_table_Pommeret_cleaned;
CREATE TABLE utmb_results_table_Pommeret_cleaned (
    Date DATE,
    Race VARCHAR(400),
    Category VARCHAR(15),
    Distance VARCHAR(15),
    `Elevation Gain` VARCHAR(15),
    Hours INT,
    Minutes INT,
    Seconds INT,
    `Overall Rank` VARCHAR(15),
    `Gender Rank` VARCHAR(15),
    Score INT,
    Country VARCHAR(25)
);

# LOAD THE CSV FILE INTO MY TABLE
LOAD DATA LOCAL INFILE '/Users/milolewinsky/Desktop/Data Analytics/Raw Data/CSV/UTMB_l.pommeret_results.csv'
INTO TABLE utmb_results_table_Pommeret_cleaned
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT *
FROM utmb_results_table_Pommeret_cleaned;

DROP TABLE IF EXISTS utmb_results_table_Pommeret_raw;
CREATE TABLE utmb_results_table_Pommeret_raw AS SELECT * FROM utmb_results_table_Pommeret_cleaned;

# STEP 1: SCROLL THROUGH THE DATA
# I found within column 'category' the value 'France', which is not supposed to be there. 
# Let's see what is happening
SELECT
	*
FROM utmb_results_table_Pommeret_cleaned
WHERE Category = 'France';

# Concerns the races: 'Trail Cenis Tour 2012 - 50 Km' AND 'Weekend Trail du Tour des Glaciers de la Vanoise 2013 - Le Tour des Glaciers de la Vanoise'.
SELECT
	*
FROM utmb_results_table_Pommeret_cleaned
WHERE Race = 'Weekend Trail du Tour des Glaciers de la Vanoise 2013 - Le Tour des Glaciers de la Vanoise' OR Race = 'Trail Cenis Tour 2012 - 50 Km';

# These races have incorrect/missing values on all columns. I assume there was a mistake in the data from the CSV I imported. 
# 'Trail Cenis Tour...' is a duplicate, the second row does have correct values. I will need to delete the duplicate with incorrect values.
# 'Weekend Trail Du Tour...' is not a duplicate - I will need to add the data. For educational purposes, I will do this manually
DELETE FROM utmb_results_table_Pommeret_cleaned 
WHERE Race = 'Trail Cenis Tour 2012 - 50 Km' AND Category = 'France' AND Distance = 'France' 
OR Race = 'Weekend Trail du Tour des Glaciers de la Vanoise 2013 - Le Tour des Glaciers de la Vanoise' AND Category = 'France' AND Distance = 'France';

INSERT INTO utmb_results_table_Pommeret_cleaned
VALUES 
	('2013-06-30', 'Weekend Trail du Tour des Glaciers de la Vanoise 2013 - Le Tour des Glaciers de la Vanoise', '100K', '65.6 KM', '3740 M+', 7, 8, 22, '1 / 351', '1 / 310', 787, 'France');


# STEP 2: CHECK DISTINCT VALUES FOR ALL COLUMNS FOR IRREGULARITIES. BELOW CODE DOES NOT INCLUDE ALL CATEGORIES
SELECT DISTINCT(Category)
FROM utmb_results_table_Pommeret_cleaned;

# STEP 3: CREATE A PRIMARY KEY COLUMN, TO HELP CLEAN THE TABLE AT LATER STAGES AND WITH EDA AFTERWARDS.
ALTER TABLE utmb_results_table_Pommeret_cleaned ADD COLUMN row_num INT AUTO_INCREMENT PRIMARY KEY;
    
ALTER TABLE utmb_results_table_Pommeret_cleaned
MODIFY row_num INT FIRST;

# STEP 4: CHECK FOR AND REMOVE DUPLICATES. I COUNT 6
SELECT COUNT(*)
FROM(
	SELECT
		row_num,
		COUNT(row_num)
	FROM utmb_results_table_Pommeret_cleaned
	GROUP BY row_num
    HAVING COUNT(row_num) > 1
	) as sub;
    
# Double check to see if the duplicates are in fact duplicates, and not just duplicate race names, by concatenating the date and category. Still Count = 6
SELECT COUNT(*)
FROM(
	SELECT
		CONCAT(Date, Race, Category),
		COUNT(*)
	FROM utmb_results_table_Pommeret_cleaned
	GROUP BY CONCAT(Date, Race, Category)
	HAVING COUNT(*) > 1
	) as sub;

# Remove duplicates by using a ROW_NUMBER + WINDOW function to locate the primary key of each row
DELETE FROM utmb_results_table_Pommeret_cleaned
WHERE row_num IN (
	SELECT row_num
	FROM (
		SELECT
			row_num,
            Race,
			ROW_NUMBER() OVER (PARTITION BY Race, Date, Distance ORDER BY Race) AS num
		FROM utmb_results_table_Pommeret_cleaned
	) as sub
	WHERE num > 1
);

# STEP 5: SPLIT DISTANCE AND ELEVATION GAIN INTO SEPERATE COLUMNS: ONE FOR THE INT VALUES AND ONE FOR THE METRIC CHARACTERS
# This is necessary to answer questions written down for the EDA

# Create the new columns
ALTER TABLE utmb_results_table_Pommeret_cleaned
ADD COLUMN Distance_km FLOAT,
ADD COLUMN Distance_metric VARCHAR(5),
ADD COLUMN Elevation_gain INT,
ADD COLUMN Elevation_gain_metric VARCHAR(5);

UPDATE utmb_results_table_Pommeret_cleaned
SET
    Distance_km = SUBSTRING_INDEX(Distance, ' ', 1),
    Distance_metric = SUBSTRING_INDEX(Distance, ' ', -1),
    Elevation_gain = SUBSTRING_INDEX(`Elevation Gain`, ' ', 1),
    Elevation_gain_metric = SUBSTRING_INDEX(`Elevation Gain`, ' ', -1);

# Remove the old columns
ALTER TABLE utmb_results_table_Pommeret_cleaned
DROP COLUMN Distance,
DROP COLUMN `Elevation Gain`;

# Change the order of the columns for readability
ALTER TABLE utmb_results_table_Pommeret_cleaned
MODIFY Distance_km varchar(15) AFTER Category,
MODIFY Distance_metric varchar(15) AFTER Distance_km,
MODIFY Elevation_gain varchar(15) AFTER Distance_metric,
MODIFY Elevation_gain_metric varchar(15) AFTER Elevation_gain;

# STEP 6: STANDARDIZING CASES FOR RACE AND COUNTRY COLUMNS
UPDATE utmb_results_table_Pommeret_cleaned
SET 
	Race = UPPER(race),
	Country = UPPER(Country);

# STEP 7: I FORGOT TO TRIM FOR WHITESPACES
UPDATE utmb_results_table_Pommeret_cleaned
SET 
	Date = TRIM(Date),
    Race = TRIM(Race),
    Category = TRIM(Category),
    Distance_metric = TRIM(Distance_metric),
    Elevation_gain_metric = TRIM(Elevation_gain_metric),
    `Overall Rank` = TRIM(`Overall Rank`),
    `Gender Rank` = TRIM(`Gender Rank`),
    Country = TRIM(Country);

# STEP 8: ADD AN ADDITIONAL COLUMN WITH TOTAL TIME IN MINUTES TO STANDARDIZE TIME INTO ONE MEASUREMENT
# This is necessary to answer one of the questions later in the EDA
ALTER TABLE utmb_results_table_Pommeret_cleaned ADD COLUMN total_minutes DEC(10,2);

ALTER TABLE utmb_results_table_Pommeret_cleaned
CHANGE COLUMN total_minutes total_minutes DEC(10,2);

WITH cte AS (
	SELECT 
		row_num,
		(Hours * 60 + Minutes + Seconds/60) AS total_minutes
	FROM utmb_results_table_Pommeret_cleaned
)
UPDATE utmb_results_table_Pommeret_cleaned as t
JOIN cte as c
ON c.row_num = t.row_num
SET t.total_minutes = c.total_minutes  
;

ALTER TABLE utmb_results_table_Pommeret_cleaned
MODIFY total_minutes decimal(6,2) AFTER Seconds;

# STEP 9: SPLIT RANKING COLUMNS INTO TWO: PLACE FINISHED AND TOTAL PLACES
# Create the columns
ALTER TABLE utmb_results_table_Pommeret_cleaned
ADD COLUMN Overall_rank_finished INT,
ADD COLUMN Overall_rank_total INT,
ADD COLUMN Gender_rank_finished INT,
ADD COLUMN Gender_rank_total INT;

# Modify order of the columns for readability
ALTER TABLE utmb_results_table_Pommeret_cleaned
MODIFY Overall_rank_finished INT AFTER total_minutes,
MODIFY Overall_rank_total INT AFTER Overall_rank_finished,
MODIFY Gender_rank_finished INT AFTER Overall_rank_total,
MODIFY Gender_rank_total INT AFTER Gender_rank_finished;

# Add the values for the new columns
WITH cte AS (
	SELECT
		row_num,
        `Overall Rank`,
		SUBSTRING_INDEX(`Overall Rank`, " / ", 1) as rank_finished,
		SUBSTRING_INDEX(`Overall Rank`, " / ", -1) as rank_total,
		`Gender Rank`,
		SUBSTRING_INDEX(`Gender Rank`, " / ", 1) as gender_finished,
		SUBSTRING_INDEX(`Gender Rank`, " / ", -1) as gender_total
	FROM utmb_results_table_Pommeret_cleaned
)
UPDATE utmb_results_table_Pommeret_cleaned AS t
JOIN cte AS c
ON c.row_num = t.row_num
SET 
	t.Overall_rank_finished = c.rank_finished,
    t.Overall_rank_total = c.rank_total,
    t.Gender_rank_finished = c.gender_finished,
    t.Gender_rank_total = c.gender_total;

# I Ran into a problem with the value 'DNF', since its not an INT datatype. I will have to change the value to NULL.
UPDATE utmb_results_table_Pommeret_cleaned
SET `Overall Rank` = NULL
WHERE `Overall Rank` = 'DNF';

UPDATE utmb_results_table_Pommeret_cleaned
SET `Gender Rank` = NULL
WHERE  `Gender Rank` = 'DNF';

# Finally, we delete the old columns
ALTER TABLE utmb_results_table_Pommeret_cleaned
DROP COLUMN `Overall Rank`, 
DROP COLUMN `Gender Rank`;

# STEP 10: ADD A PERFORMANCE BASED ON PERCENTILE FINISHED
# This will be the primary and most accurate measurement of performance during the EDA
# Create the new columns
ALTER TABLE utmb_results_table_Pommeret_cleaned 
ADD COLUMN finished_percentile_overall DEC(5,2),
ADD COLUMN finished_percentile_gender DEC(5,2);

# Modify order of the columns for readability 
ALTER TABLE utmb_results_table_Pommeret_cleaned 
MODIFY finished_percentile_overall DEC(5,2) AFTER Overall_rank_total,
MODIFY finished_percentile_gender DEC(5,2) AFTER Gender_rank_total;

# Add the values for the new columns
WITH cte AS (
	SELECT
		row_num,
		(Overall_rank_finished / Overall_rank_total * 100) AS finished_percentile_overall,
		(Gender_rank_finished / Gender_rank_total * 100) AS finished_percentile_gender
	FROM utmb_results_table_Pommeret_cleaned
)
UPDATE utmb_results_table_Pommeret_cleaned AS t
JOIN cte AS c
ON c.row_num = t.row_num
SET
	t.finished_percentile_overall = c.finished_percentile_overall,
    t.finished_percentile_gender = c.finished_percentile_gender;

# Double check to see if all went well. Percentile > 100 is error. I got no returns.
SELECT *
FROM utmb_results_table_Pommeret_cleaned
WHERE finished_percentile_overall >= 100
OR finished_percentile_gender >= 100;

# DONE
SELECT *
FROM utmb_results_table_Pommeret_cleaned
