# Ultra Marathon Athlete - Ludovic Pommeret - Data Analysis

![](Photos/UTMB-Photo.avif)

## Introduction to the project <a name="introduction"></a>
Welcome to my personal project! 

My name is **Milo**, and I am currently in the process of becoming a Data Analyst through self-education. In this project, I analyzed the race results of ultra marathon runner **Ludovic Pommeret** between 08-12-2007 and today. The reason I chose this specific topic is that I am an **ultra marathon enthousiast** and finisher myself. I specifically chose Ludovic as athlete due to the fact that he has both an **impressive and extensive** list of race results to his name.

The **goal** of the project was to practice and further develop my Data Cleaning and Data Analysis skills in **MySQL**. In order to do so, I formulated **15 questions** for me to answer. These questions are listed in the chapter "Problem Statement".

<br><br>
## Table of Contents <a name="table-of-contents"></a>
- [Introduction to the project](#introduction)
- [Executive Summary](#executive-summary)
- [Data Sourcing](#data-sourcing)
- [Problem Statement](#problem-statement)
- [Data Cleaning & Transformation](#anchor-data-cleaning-transformation)
- [Skills Demonstrated](#skills-demonstrated)
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

**Fifteen questions** or problem statements have been answered through analysis within this dataset.

1.	**Best and Worst Finish**: Identify the athlete’s best and worst race results.
2.	**Consistency by Category**: Analyze whether performance is more consistent within certain race categories.
3.	**Outlier Races**: Find races where the athlete significantly over- or underperformed compared to their average.
4.	**Easiest vs. Hardest Races**: Determine which races were the most and least challenging over the years.
5.	**Performance Over Time**: Investigate whether the athlete's UTMB Index improves over time.
6.	**Seasonal Performance Trends**: Assess if race performance varies depending on the time of year.
7.	**Country-Based Performance**: Identify whether atlete performs best in home or away races.
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

## Exploratory Data Analysis
[> back to table of contents](#table-of-contents)


1. **Best and Worst Finish**: Identify the athlete’s best and worst race results.

**Table 1: best and worst finished races**
| Date       | Race                                                 | finish_percentile   |
|:-----------|:-----------------------------------------------------|:--------------------|
| 2021-10-21 | LE GRAND RAID DE LA RÉUNION  - LA DIAGONALE DES FOUS | 0.06%               |
| 2019-08-11 | MERIBEL TRAIL CHAMPIONNAT FRANCE TRAIL  - 25 KM      | 55.13%              |

* Ludovic's best career finish was at the race 'Le Grand Raid de la Réunion - La Diagonale des Fous' on the 21st of October, 2021, where he finished in the top 0.06% percentile of all athletes.
* His worst career finish was on August 11th, 2019, at the 'Meribel Trail Chapionnat France Trail', where he finished in the top 55.13% percentile of all athletes.

<br><br>
2. **Consistency by Category**: Analyze whether performance is more consistent within certain race categories.

**Table 2: standard deviation for variable "finish times in minutes" per category**
| Category   |   total_races |   average_finish_time_minutes |   standard_deviation_minutes |
|:-----------|--------------:|------------------------------:|---------------------:|
| 100M       |            23 |                       1052.78 |               529.23 |
| 100K       |            30 |                        533.36 |               112.06 |
| 50K        |            66 |                        293.41 |                79.64 |
| 20K        |            10 |                        136.8  |                56.11 |

* In table two, we find a clear difference in standard deviations in finish times in minutes per category, with a clear pattern showing the higher the race category, the higher the standard deviation.
* This tells us that, on average, the greater the distance of the race, the more variety is found in finish times in total minutes.

Note: It is important to mention that the total count in races is not equal per category, and especially low for the '20K' and the '100M' categories. Only the results for the '50K' category meets the requirements for the results to be reliable. To further illustrate this point, the calculated needed sample size per category is 51, based on a confidence level of 70% and margin of error of 5%. The above conclusion therefore acts more as a soft hypothesis, than a real statistically significant finding.


| Category   |   average_percentile_overall |   standard_dev_percentile_overall |
|:-----------|-----------------------------:|-----------------------:|
| 100M       |                         1.39 |                   2.77 |
| 50K        |                         1.87 |                   3.66 |
| 100K       |                         3.83 |                   8.71 |
| 20K        |                         8.05 |                  16.3  |

<br><br>
3. **Outlier Races**: Find races where the athlete significantly over- or underperformed compared to their average.

Significantly **best** races over the years compared to average time for said race:
| Date       | Race                                                 |   z_score_minutes |
|:-----------|:-----------------------------------------------------|------------------:|
| 2018-08-29 | UTMB®  - TDS®                                        |             -2.03 |
| 2022-10-20 | LE GRAND RAID DE LA RÉUNION  - LA DIAGONALE DES FOUS |             -2.03 |
| 2017-10-19 | GRAND RAID DE LA RÉUNION  - LA DIAGONALE DES FOUS    |             -2.03 |
| 2007-08-12 | SIERRE-ZINAL                                         |             -1.47 |
| 2008-08-10 | SIERRE-ZINAL                                         |             -1.34 |

Significantly **worst** races over the years compared to average time for said race:
| Date       | Race                                                 |   z_score_minutes |
|:-----------|:-----------------------------------------------------|------------------:|
| 2020-10-29 | GOLDEN TRAIL CHAMPIONSHIP  - GTC AZORES              |              4.31 |
| 2019-08-11 | MERIBEL TRAIL CHAMPIONNAT FRANCE TRAIL  - 25 KM      |              2.54 |
| 2023-10-19 | LE GRAND RAID DE LA RÉUNION  - LA DIAGONALE DES FOUS |              2.51 |
| 2012-08-31 | THE NORTH FACE ULTRA-TRAIL DU MONT-BLANC®  - UTMB®   |              2.25 |
| 2023-08-20 | TRAIL GALIBIER THABOR  - TRAIL DU GALIBIER-THABOR    |              2.22 |

<br><br>
4. **Easiest vs. Hardest Races**: Determine which races were the most and least challenging over the years.

Consistently **least** challenging races over the years
| Race                                                |   count_z_scores |   average_z_score |
|:----------------------------------------------------|-----------------:|------------------:|
| TRAIL FAVERGES ICEBREAKER  - MARATRAIL DE LA SAMBUY |                5 |             -0.65 |
| TRAIL NIVOLET REVARD  - TRAIL NIVOLET-REVARD        |                5 |             -0.25 |
| ERGYSPORT TRAIL DU VENTOUX  - 46 KM                 |                4 |             -0.8  |
| FESTIVAL DES TEMPLIERS  - GRAND TRAIL DES TEMPLIERS |                3 |             -1.01 |
| SIERRE-ZINAL                                        |                2 |             -1.4  |

Consistently **most** challenging races over the years
| Race                                                 |   count_z_scores |   average_z_score |
|:-----------------------------------------------------|-----------------:|------------------:|
| TRAIL SAINTE VICTOIRE                                |                5 |              0.62 |
| LE GRAND RAID DE LA RÉUNION  - LA DIAGONALE DES FOUS |                3 |              1.32 |
| LA SAINTÉLYON                                        |                3 |              0.5  |
| UTMB®                                                |                2 |              0.5  |
| MAXI-RACE DU LAC D'ANNECY  - TECNICA MAXI-RACE       |                2 |              0.43 |

<br><br>
5. **Performance Over Time**: Investigate whether the athlete's UTMB Index improves over time.

For this question, I transformed the CSV table into a line chart to plot a trend line to discover trends over the last 18 years

![](Photos/Picture%201.png)

<br><br>
6. **Seasonal Performance Trends**: Assess if race performance varies depending on the time of year.

| Season   |   number_of_races | average_percentile_finish   |
|:---------|------------------:|:----------------------------|
| Spring   |                35 | 0.84%                       |
| Summer   |                48 | 3.45%                       |
| Autumn   |                20 | 5.64%                       |
| Winter   |                26 | 2.06%                       |

<br><br>
7. **Country-Based Performance**: Identify whether atlete performs best in home or away races.

| Country_cat   | average_percentile_finish   |
|:--------------|:----------------------------|
| FRANCE        | 2.26%                       |
| AWAY          | 4.18%                       |

<br><br>
8. **Average Pace by Category**: Calculate average pace (min/km) for each race category.

| Category   |   average_pace_minutes |   average_pace_seconds |
|:-----------|-----------------------:|-----------------------:|
| 20K        |                      6 |                      1 |
| 50K        |                      5 |                     51 |
| 100K       |                      6 |                     52 |
| 100M       |                      7 |                      4 |

 <br><br>
9. **Ranking vs. Distance**: Explore whether ranking percentile tends to drop in longer races.

| distance_category   | average_percentile_finish   |
|:--------------------|:----------------------------|
| 0 - 25 km           | 9.42%                       |
| 25 - 50 km          | 1.64%                       |
| 50 - 75 km          | 2.49%                       |
| 75 - 100 km         | 4.25%                       |
| 100 - 125 km        | 2.82%                       |
| 125 - 150 km        | 0.37%                       |
| 150 - 175 km        | 1.89%                       |

<br><br>
10. **Climbing Efficiency**: Identify which race had the highest elevation gain per hour (meters/hour).

| Category   | Race                                                         |   meters_incline_per_hour |
|:-----------|:-------------------------------------------------------------|--------------------------:|
| 20K        | TRANSVULCANIA ULTRAMARATHON LA PALMA ISLAND  - HALF MARATHON |                    913.88 |
| 20K        | VILLACIDRO SKYRACE  - 21K                                    |                    809.1  |
| 20K        | MONTREUX TRAIL FESTIVAL  - FREDDIE'S NIGHT                   |                    796.17 |
| 50K        | SIERRE-ZINAL                                                 |                    759.72 |
| 50K        | TRAIL D'ALBERTVILLE                                          |                    713.24 |

<br><br>
11. **Elevation vs. Finish Time**: Examine whether higher total elevation correlates with slower race results.

|   correlation_elevation_with_results |
|--------------------------------:|
|                         -0.0753 |

<br><br>
12. **Top 5% Finishes**: Calculate how often the athlete finishes in the top 5% overall.

| percentage_top_five_finishes   |
|:-------------------------------|
| 89.92%                         |

<br><br>
13. **Finish Time Statistics**: Compute the average finish time and standard deviation across all races.
![]()

<br><br>
14. **Fastest Average Speed**: Identify the race with the fastest average speed (km/h).

| Date       | Race                                                | Category   |   Distance_km |   km/h |
|:-----------|:----------------------------------------------------|:-----------|--------------:|-------:|
| 2008-12-07 | LA SAINTÉLYON                                       | 50K        |          70   |  13.6  |
| 2009-12-06 | LA SAINTÉLYON                                       | 50K        |          70   |  12.61 |
| 2019-04-14 | TRAIL DROME  - 42 KM                                | 50K        |          42.7 |  12.53 |
| 2020-10-11 | EDF TRAIL VALLÉES D'AIGUEBLANCHE  - ÉCHAPEAUX BELLE | 20K        |          25.8 |  12.39 |
| 2019-04-27 | LA BOUILLONNANTE  - LA BOUILLONNANTE 50             | 50K        |          52.5 |  12.24 |

<br><br>
15. **Recovery Time Impact**: Analyze whether shorter recovery periods between races lead to worse results.
	
| days_between_races   | average_percentile_finish   |
|:---------------------|:----------------------------|
| 0 - 29               | 2.4%                        |
| 30 - 59              | 1.2%                        |
| 60 - 89              | 2.9%                        |
| 90 - 119             | 8.0%                        |
| 120 - 149            | 3.8%                        |
| 150 - 179            | 2.9%                        |
| 180 - 209            | 5.4%                        |
| 210 - 239            | 11.6%                       |
| 270 - 299            | 2.2%                        |


<br><br>
## Further Research Recommendations
[> back to table of contents](#table-of-contents)
