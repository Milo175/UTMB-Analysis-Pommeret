# Ultra Marathon Athlete - Ludovic Pommeret - Data Analysis

![](Photos/UTMB-Photo.avif)

## Introduction to the project <a name="introduction"></a>
Welcome to my personal project! 

My name is **Milo**, and I am currently in the process of becoming a Data Analyst through self-education. In this project, I analyzed the race results of ultra marathon runner **Ludovic Pommeret** between 08-12-2007 and today. The reason I chose this specific topic is that I am an **ultra marathon enthousiast** and finisher myself. I specifically chose Ludovic as athlete due to the fact that he has both an **impressive and extensive** list of race results to his name.

The **goal** of the project was to practice and further develop my Data Cleaning and Data Analysis skills in **MySQL**. In order to do so, I formulated **14 questions** for me to answer. These questions are listed in the chapter "Problem Statement".

<br><br>
## Table of Contents <a name="table-of-contents"></a>
- [Introduction to the project](#introduction)
- [Executive Summary](#executive-summary)
- [Data Sourcing](#data-sourcing)
- [Problem Statement](#problem-statement)
- [Data Cleaning & Transformation](#anchor-data-cleaning-transformation)
- [Skills Demonstrated](#skills-demonstrated)
- [CSV tables](#csv-tables)
- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Further Research Recommendations](#further-research-recommendations)

<br><br>
## Executive Summary
[> back to table of contents](#table-of-contents)

<br><br>
## Data Sourcing
[> back to table of contents](#table-of-contents)

The data used for this analysis has been directly taken from the official UTMB website. This data is available for the general public to view and use. 

Website: [click here to go to the website](https://utmb.world/runner/7829.ludovic.pommeret)

#### Limitation of the dataset
This dataset contains 129 race results, which represents a relatively small sample size. While this allows for meaningful exploratory analysis, the findings should be interpreted with caution. The primary objective of this project was to strengthen and demonstrate proficiency in MySQL.

That said, the analysis may still uncover interesting patterns or soft predictors worth exploring further. These insights should be considered as hypotheses rather than definitive conclusions — ideally validated with a larger dataset or additional performance metrics. Whether you're a data enthusiast or Ludovic Pommeret himself, take the results as an invitation to investigate, not as final truths.

> Data on website last updated: 04.25.2025

<br><br>
## Problem Statement
[> back to table of contents](#table-of-contents)

**Fourteen questions** or problem statements have been answered through analysis within this dataset.
1.	**Best and Worst Finish**: Identify the athlete’s best and worst race results.
2.	**Consistency by Category**: Analyze whether performance is more consistent within certain race categories.
3.	**Outlier Races**: Find races where the athlete significantly over- or underperformed compared to their average.
4.	**Easiest vs. Hardest Races**: Determine which races were the most and least challenging over the years.
5.	**Performance Over Time**: Investigate whether the athlete's UTMB Index improves over time.
6.	**Seasonal Performance Trends**: Assess if race performance varies depending on the time of year.
7.	**Country-Based Performance**: Identify in which countries the athlete performs best and worst.
8.	**Average Pace by Category**: Calculate average pace (min/km) for each race category.
9.	**Ranking vs. Distance**: Explore whether ranking percentile tends to drop in longer races.
10.	**Climbing Efficiency**: Identify which race had the highest elevation gain per hour (meters/hour).
11.	**Elevation vs. Finish Time**: Examine whether higher total elevation correlates with slower race results.
12.	**Top 5% Finishes**: Calculate how often the athlete finishes in the top 5% overall.
13.	**Finish Time Statistics**: Compute the average finish time and standard deviation across all races.
14.	**Fastest Average Speed**: Identify the race with the fastest average speed (km/h).
15.	**Recovery Time Impact**: Analyze whether shorter recovery periods between races lead to worse results.

<br><br>
## Data Cleaning & Transformation <a name="anchor-data-cleaning-transformation"></a>
[> back to table of contents](#table-of-contents)

- Link to the MySQL Script built to clean the data: [MySQL File](SQL-Scripts/Data-Cleaning-Script/MySQL%20-%20UTMB%20-%20Data%20Cleaning.sql)
  
<br><br>
## Skills Demonstrated
[> back to table of contents](#table-of-contents)

### MySQL
#### Data Cleaning
* Created **primary key**
* **Removed duplicates** using ROW_NUMBER() with CTE and window functions
* **Altered and inserted data** into existing tables
* **Standardized data** formats:
  * Case formatting (e.g., UPPER(), TRIM())
  * Dates
  * Metric consistency
  * Data types
* **Modified table schema** (added, changed, split, and deleted columns) for EDA
* Key **SQL clauses and functions** used:
  * CTE, subqueries, WINDOW FUNCTIONS, SUBSTRING_INDEX, CONCAT(), INNER JOIN


#### Exploratory Data Analysis
* Identified trends and patterns in performance across multiple variables
* Applied **descriptive statistics** to explore distributions, variability, and anomalies
* **Analyzed data over time** (by year and season) to uncover temporal trends
* Evaluated **data quality** and adjusted approach based on sample size limitations:
  * Refined questions or modified columns to improve result accuracy
  * Created custom bins/sub-categories for better data segmentation
* Formulated and researched **hypotheses** based on evolving insights
* Performed **arithmetic operations** (AVG(), DIV(), SQRT(), SUM(), POWER()) to calculate key metrics
* Prioritized **clear presentation of findings** to ensure insights were actionable and understandable

#### Descriptive Statistics
* Mean, standard deviation, z-score standardization


<br><br>
- ## CSV tables
[> back to table of contents](#table-of-contents)

<br><br>
## Exploratory Data Analysis
[> back to table of contents](#table-of-contents)

<br><br>
## Further Research Recommendations
[> back to table of contents](#table-of-contents)
