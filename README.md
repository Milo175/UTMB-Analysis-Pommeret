#  Ultra Marathon Data Analysis

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
7.	**Country-Based Performance**: Identify whether atlete performs best in home or away races.
8.	**Average Pace by Category**: Calculate average pace (min/km) for each race category.
9.	**Ranking vs. Distance**: Explore whether ranking percentile tends to drop in longer races.
10.	**Climbing Efficiency**: Identify which race had the highest elevation gain per hour (meters/hour).
11.	**Elevation vs. Finish Time**: Examine whether higher total elevation correlates with race results.
12.	**Top 5% Finishes**: Calculate how often the athlete finishes in the top 5% overall.
13.	**Fastest Average Speed**: Identify the race with the fastest average speed (km/h).
14.	**Recovery Time Impact**: Analyze whether shorter recovery periods between races lead to worse results.

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


### 1. **Best and Worst Finish**: Identify the athlete’s best and worst race results.

**Table 1: Best and worst finished races**
| Date       | Race                                                 | finish_percentile   |
|:-----------|:-----------------------------------------------------|:--------------------|
| 2021-10-21 | LE GRAND RAID DE LA RÉUNION  - LA DIAGONALE DES FOUS | 0.06%               |
| 2019-08-11 | MERIBEL TRAIL CHAMPIONNAT FRANCE TRAIL  - 25 KM      | 55.13%              |

* Ludovic's best career finish was at the race 'LE GRAND RAID DE LA RÉUNION  - LA DIAGONALE DES FOUS' on the 21st of October, 2021, where he finished in the top 0.06% percentile of all athletes.
* His worst career finish was on August 11th, 2019, at the 'MERIBEL TRAIL CHAMPIONNAT FRANCE TRAIL', where he finished in the top 55.13% percentile of all athletes.

<br><br>
### 2. **Consistency by Category**: Analyze whether performance is more consistent within certain race categories.

**Table 2: Standard deviation for variable "finish times in minutes" per category**
| Category   |   total_races |   average_finish_time_minutes |   standard_deviation_minutes |
|:-----------|--------------:|------------------------------:|---------------------:|
| 100M       |            23 |                       1052.78 |               529.23 |
| 100K       |            30 |                        533.36 |               112.06 |
| 50K        |            66 |                        293.41 |                79.64 |
| 20K        |            10 |                        136.8  |                56.11 |

* In table two, we find a clear difference in standard deviations in finish times in minutes per category, with a clear pattern showing the higher the race category, the higher the standard deviation.
* This tells us that, on average, the greater the distance of the race, the more variety is found in finish times in total minutes.

<br><br>

**Table 3: Standard deviation for variable "finished percentile" across all genders per category**
| Category   |   total_races | average_percentile_overall |   standard_dev_percentile_overall |
|:-----------|--------------:|---------------------------:|-----------------------:|
| 100M       |            23 |                       1.39 |                   2.77 |
| 50K        |            66 |                       1.87 |                   3.66 |
| 100K       |            30 |                       3.83 |                   8.71 |
| 20K        |            10 |                       8.05 |                  16.3  |

* In table three, the data on his average_percentile_overall finishes shows that Ludovic finishes highest overall in the '100M' category, followed by the '50K', '100K', and finally the '20K'.
* The standard deviations per category follow the same trend/pattern, which shows that the athelete is most consistent in the categories in which he is also the most confident or strong. 

**Note:** It is important to mention that the total count in races is not equal per category, and especially low for the '20K' and the '100M' categories. Only the results for the '50K' category meets the requirements for the results to be reliable. To further illustrate this point, the calculated needed sample size per category is 51, based on a confidence level of 70% and margin of error of 5%. The above conclusion therefore acts more as a soft hypothesis, than a real statistically significant finding.

<br><br>
### 3. **Outlier Races**: Find races where the athlete significantly over- or underperformed compared to their average.

* The question has been answered by grouping the races together by title, over all the years the athlete has been active, and calculating the mean performance in percentile finish. Then, I calculated the z-score of each year Ludovic ran said race, to find which years he over or underperformed. Negative z-scores are in this case positive, as lower percentile finishes indicate better performances.
  
**Table 4: Significantly the best races over the years compared to the average time for said race**
| Date       | Race                                                 |   z_score_percentile_finish |
|:-----------|:-----------------------------------------------------|----------------------------:|
| 2021-10-21 | LE GRAND RAID DE LA RÉUNION  - LA DIAGONALE DES FOUS |                       -0.47 |
| 2022-08-23 | UTMB® MONT BLANC  - TDS®                             |                       -0.46 |
| 2016-08-26 | UTMB®                                                |                       -0.46 |
| 2019-04-27 | LA BOUILLONNANTE  - LA BOUILLONNANTE 50              |                       -0.46 |
| 2019-10-17 | LE GRAND RAID DE LA RÉUNION  - LA DIAGONALE DES FOUS |                       -0.45 |

**Table 5: Significantly the worst races over the years compared to the average time for said race**
| Date       | Race                                                 |   z_score_percentile_finish |
|:-----------|:-----------------------------------------------------|----------------------------:|
| 2007-08-12 | SIERRE-ZINAL                                         |                        4.91 |
| 2009-12-06 | LA SAINTÉLYON                                        |                        4.3  |
| 2022-11-05 | THE AMAZING THAILAND WMRC  - CHIANGMAI WMTRC  LONG   |                        4.08 |
| 2023-10-19 | LE GRAND RAID DE LA RÉUNION  - LA DIAGONALE DES FOUS |                        3.99 |
| 2020-10-29 | GOLDEN TRAIL CHAMPIONSHIP  - GTC AZORES              |                        3.8  |

* In table 4, we find that Ludovic significantly improved his performance for the race 'LE GRAND RAID DE LA RÉUNION  - LA DIAGONALE DES FOUS' in 2021, with a z-score of -0.47.
* Table 5 shows high z-scores of between 4 and 5. 2007 was the worst year for Ludovic running the Sierra Zinal, with a z-score of 4.91.
* When comparing tables 4 and 5, we find that his significantly worst races have much higher z-scores than his significantly best races. This shows Ludovic regularly performs to his highest capabilities, making great performances stand out less than his worst performances.

<br><br>
### 4. **Easiest vs. Hardest Races**: Determine which races were the most and least challenging over the years.

To find out which races Ludovic were generally easier or harder for him, I counted the number of z-scores over the years per race, with one filter that included only negative and one including only positive z-scores, and calculated the average z-score over the years for each race as well.

**Table 6: Consistently least challenging races over the years**
| Race                                                |   count_z_scores |   average_z_score |
|:----------------------------------------------------|-----------------:|------------------:|
| TRAIL FAVERGES ICEBREAKER  - MARATRAIL DE LA SAMBUY |                5 |             -0.65 |
| TRAIL NIVOLET REVARD  - TRAIL NIVOLET-REVARD        |                5 |             -0.25 |
| ERGYSPORT TRAIL DU VENTOUX  - 46 KM                 |                4 |             -0.8  |
| FESTIVAL DES TEMPLIERS  - GRAND TRAIL DES TEMPLIERS |                3 |             -1.01 |
| SIERRE-ZINAL                                        |                2 |             -1.4  |

**Table 7: Consistently most challenging races over the years**
| Race                                                 |   count_z_scores |   average_z_score |
|:-----------------------------------------------------|-----------------:|------------------:|
| TRAIL SAINTE VICTOIRE                                |                5 |              0.62 |
| LE GRAND RAID DE LA RÉUNION  - LA DIAGONALE DES FOUS |                3 |              1.32 |
| LA SAINTÉLYON                                        |                3 |              0.5  |
| UTMB®                                                |                2 |              0.5  |
| MAXI-RACE DU LAC D'ANNECY  - TECNICA MAXI-RACE       |                2 |              0.43 |

* Table 6 shows that the athlete most often has a negative z-score for the 'TRAIL FAVERGES ICEBREAKER  - MARATRAIL DE LA SAMBUY', which shows this was consistently his least challenging race over the years.
* In table 7, we find that the 'TRAIL SAINTE VICTOIRE' race has the highest count of positive z-scores, indicating consistent struggle for the athlete when running this race over the years.

<br><br>
### 5. **Performance Over Time**: Investigate whether the athlete's UTMB Index improves over time.

For this question, I transformed the CSV table into a line chart to plot a trend line to discover trends over the last 18 years

**Graph 1: Athlete's UTMB Index Score over the years of his career**
![](Photos/Picture%201.png)

* The graph shows a steady linear trend line in the athletes 'Score' within the UTMB Index over the years. Given Ludovic's impressive records, this means that from the start of his ultra marathon sports career in 2007 until today, he has consistently been one of the best ultra runners in the world.
  
<br><br>
### 6. **Seasonal Performance Trends**: Assess if race performance varies depending on the time of year.

**Table 8: Athlete's average percentile finish per season of the year**
| Season   |   number_of_races | average_percentile_finish   |
|:---------|------------------:|:----------------------------|
| Spring   |                35 | 0.84%                       |
| Summer   |                48 | 3.45%                       |
| Autumn   |                20 | 5.64%                       |
| Winter   |                26 | 2.06%                       |

* Table 8 shows that the athlete performs best in races held in the spring (top 0.84%) and winter (top 2.06%) time.
* Ludovic performs lower in  races held in the autumn season, where he finished in the top 5.64% on average.

**Note:** Again, it is important to mention that the total count in races is not equal per category. None of the results in the above table meets the requirements they need for them to be reliable. To further illustrate this point, the calculated needed sample size per category is 51, based on a confidence level of 70% and margin of error of 5%. The above conclusion therefore acts more as a soft hypothesis, than a real statistically significant finding.

<br><br>
### 7. **Country-Based Performance**: Identify whether atlete performs best in home or away races.

**Table 9: Performance in home (France) vs Away races**
| Country_cat   | count_races  | average_percentile_finish   |
|:--------------|-------------:|----------------------------:|
| FRANCE        |           97 | 		       2.26% |
| AWAY          |           32 |		       4.18% |

* Ludovic clearly performs better in Home races in France (top 2.26%) than in Away races outside of France (top 4.18%).

<br><br>
### 8. **Average Pace by Category**: Calculate average pace (min/km) for each race category.

**Table 10: Average pace (min/km) per race category**
| Category   |   average_pace_minutes |   average_pace_seconds |
|:-----------|-----------------------:|-----------------------:|
| 20K        |                      6 |                      1 |
| 50K        |                      5 |                     51 |
| 100K       |                      6 |                     52 |
| 100M       |                      7 |                      4 |

* In table 10 we find that Ludovic's pace in min/km is fastest in category '50K' races, followed by '20K' and '100K' races, and slowest in the longest '100M' category.
* These results follow a logical pattern where the longer the distance of the race, the slower the average pace is due to energy preservation, increased fatigue and higher elevations.

  
 <br><br>
### 9. **Ranking vs. Distance**: Explore whether ranking percentile tends to drop in longer races.

**Table 11: Average percentile finished categorized by race distance**
| distance_category   | average_percentile_finish   |
|:--------------------|:----------------------------|
| 0 - 25 km           | 9.42%                       |
| 25 - 50 km          | 1.64%                       |
| 50 - 75 km          | 2.49%                       |
| 75 - 100 km         | 4.25%                       |
| 100 - 125 km        | 2.82%                       |
| 125 - 150 km        | 0.37%                       |
| 150 - 175 km        | 1.89%                       |

* Table 11 proofs that Ludovic is an Ultra distance, Ultra Marathon runner, as his average finish in percentiles is stronger the greater the race distances.
* The athlete performs best in the 125 - 150 KM category (top 0.37%) and worst in the 0 - 25 KM category (top 9.42%).
* We find a soft downwards trendline in table 11, indicating that performance improves as the distance of races increases.

**Note:** it is important to mention that the count of races between 0 - 25 KM is 10, which is a very small sample size, which has to be taken into consideration when analyzing the downwards trendline in table 11. The above conclusion therefore acts more as a soft hypothesis, than a real statistically significant finding.

<br><br>
### 10. **Climbing Efficiency**: Identify which race had the highest elevation gain per hour (meters/hour).

**Table 12: Top 8 races with the fastest elevation gain pace (meters incline/hour)**
| Category   | Date       | Race                                                         |   meters_incline_per_hour |
|:-----------|:-----------|:-------------------------------------------------------------|--------------------------:|
| 20K        | 2019-05-11 | TRANSVULCANIA ULTRAMARATHON LA PALMA ISLAND  - HALF MARATHON |                    913.88 |
| 20K        | 2022-04-24 | VILLACIDRO SKYRACE  - 21K                                    |                    809.1  |
| 20K        | 2019-07-27 | MONTREUX TRAIL FESTIVAL  - FREDDIE'S NIGHT                   |                    796.17 |
| 50K        | 2007-08-12 | SIERRE-ZINAL                                                 |                    781.51 |
| 50K        | 2008-08-10 | SIERRE-ZINAL                                                 |                    737.94 |
| 50K        | 2013-09-22 | TRAIL D'ALBERTVILLE                                          |                    725    |
| 50K        | 2012-09-23 | TRAIL D'ALBERTVILLE                                          |                    701.48 |
| 50K        | 2009-06-13 | TRAIL FAVERGES ICEBREAKER  - MARATRAIL DE LA SAMBUY          |                    700.69 |

* Ludovic shows the fastest elevation gain pace for races in the '20K' and '50K' category, with his fastest pace ever recorded being 913.88 meters/hour at the 'TRANSVULCANIA ULTRAMARATHON LA PALMA ISLAND  - HALF MARATHON' on the 11th of May, 2019.
* The results in table 12 are similar to the general hypothesis, which states that the shorter the race, the lower the average elevation in meters and the more energy the athlete has to push himself over the elevation as fast as possible.

<br><br>
### 11. **Elevation vs. Finish Time**: Examine whether higher total elevation correlates with race results.

|   correlation_elevation_with_results |
|--------------------------------:|
|                         -0.0753 |

* The correlation coefficient between elevation gain and race results (finished percentile) is -0.0753, which indicates a very weak to relationship between the two variables and that higher elevation gain very slightly increases race results. However, the correlation value is so low that it is safe to assume no actual relationship exists.

<br><br>
### 12. **Top 5% Finishes**: Calculate how often the athlete finishes in the top 5% overall.

| percentage_top_five_percentage_finishes   |
|:-------------------------------|
| 89.92%                         |

* Ludovic has finished in the top 5 percentile for 89.92% of all the races he has run.  

<br><br>
### 13. **Fastest Average Speed**: Identify the race with the fastest average speed (km/h).

**Table 13: Top 5 races with highest average speed (km/h)**
| Date       | Race                                                | Category   |  Elevation_gain | Distance_km |   km/h |
|:-----------|:----------------------------------------------------|:-----------|----------------:|------------:|-------:|
| 2008-12-07 | LA SAINTÉLYON                                       | 50K        |          1500   |        70   |  13.6  |
| 2009-12-06 | LA SAINTÉLYON                                       | 50K        |          1500   |        70   |  12.61 |
| 2019-04-14 | TRAIL DROME  - 42 KM                                | 50K        |          2170   |        42.7 |  12.53 |
| 2020-10-11 | EDF TRAIL VALLÉES D'AIGUEBLANCHE  - ÉCHAPEAUX BELLE | 20K        |          1380   |        25.8 |  12.39 |
| 2019-04-27 | LA BOUILLONNANTE  - LA BOUILLONNANTE 50             | 50K        |          2570   |        52.5 |  12.24 |

* Table 13 shows that the top 5 races with the highest average speed (km/h) fall within the '50K' and '20K' categories.
* Ludovic ran his fastest pace during the 'LA SAINTÉLYON' in 2008 (13.6 km/h) and in 2009 (12.61 km/h). His pace was faster than his forth fastest paced race "EDF TRAIL VALLÉES D'AIGUEBLANCHE  - ÉCHAPEAUX BELLE" in 2020, which had a shorter distance and lower elevation gain. 

<br><br>
### 14. **Recovery Time Impact**: Analyze whether shorter recovery periods between races lead to worse results.

For this analysis, I categorized the days between races in bins of 30 days in order to group the races together for analysis.

**Table 14: Recovery Time versus race performance**
| days_between_races   |   count_races | average_percentile_finish   |
|:---------------------|--------------:|:----------------------------|
| 0 - 29               |            74 | 2.4%                        |
| 30 - 59              |            27 | 1.2%                        |
| 60 - 89              |             6 | 2.9%                        |
| 90 - 119             |             3 | 8.0%                        |
| 120 - 149            |             6 | 3.8%                        |
| 150 - 179            |             4 | 2.9%                        |
| 180 - 209            |             3 | 5.4%                        |
| 210 - 239            |             4 | 11.6%                       |
| 270 - 299            |             1 | 2.2%                        |

* The athlete performs best when given 30 - 59 days of recovery before his race, followed by 0 - 29 and 270 - 299 days.
* Ludovic's worst performances came after a resting period between 210 - 239 days and 90 - 119 days.
* The results in table 14 do not show a clear trend or pattern in recovery time versus race performance.

**Note:** given the sample size for each bin is not close to equal, and most races find themselves in the 0-29 and 30-59 days bins, the results in the table cannot be considered as statistically significant findings. The analysis of question 14 has purely been for educational purposes on writing MySQL queries.

<br><br>
## Further Research Recommendations
[> back to table of contents](#table-of-contents)
