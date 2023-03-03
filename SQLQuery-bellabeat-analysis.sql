
------- Exploring the data ------

select * 
from Bellabeat_analyst_proyect2..[dailyActivity]

select * 
from Bellabeat_analyst_proyect2..[dailyCalories]

select * 
from Bellabeat_analyst_proyect2..[dailyIntensities]

select * 
from Bellabeat_analyst_proyect2..[dailySteps]

select * 
from Bellabeat_analyst_proyect2..[heartrate_seconds]

select * 
from Bellabeat_analyst_proyect2..[hourlyCalories]

select * 
from Bellabeat_analyst_proyect2..[hourlyIntensities]

select * 
from Bellabeat_analyst_proyect2..[hourlySteps]

select * 
from Bellabeat_analyst_proyect2..[minuteCaloriesNarrow]

select * 
from Bellabeat_analyst_proyect2..[minuteCaloriesWide]

select * 
from Bellabeat_analyst_proyect2..[minuteIntensitiesNarrow]

select * 
from Bellabeat_analyst_proyect2..[minuteIntensitiesWide]

select * 
from Bellabeat_analyst_proyect2..[minuteMETsNarrow]

select * 
from Bellabeat_analyst_proyect2..[minuteSleep]

select * 
from Bellabeat_analyst_proyect2..[minuteStepsNarrow]

select * 
from Bellabeat_analyst_proyect2..[minuteStepsWide]

select * 
from Bellabeat_analyst_proyect2..[sleepDay]

select * 
from Bellabeat_analyst_proyect2..[weightLogInfo]


------ Casting some colums ------
UPDATE Bellabeat_analyst_proyect2..[dailyActivity] 
SET Id = CONVERT(varchar(MAX),Id)

UPDATE Bellabeat_analyst_proyect2..[dailyCalories] 
SET Id = CONVERT(varchar(MAX),Id)

UPDATE Bellabeat_analyst_proyect2..[dailyIntensities] 
SET Id = CONVERT(varchar(MAX),Id)

UPDATE Bellabeat_analyst_proyect2..[dailySteps] 
SET Id = CONVERT(varchar(MAX),Id)

UPDATE Bellabeat_analyst_proyect2..[hourlyCalories] 
SET ActivityHour = CONVERT(datetime2,ActivityHour,20) --- I converted the data from string to datatime and then to datatime2

UPDATE Bellabeat_analyst_proyect2..[hourlySteps]
SET ActivityHour = CONVERT(datetime2,ActivityHour,20) --- I converted the data from string to datatime and then to datatime2

UPDATE Bellabeat_analyst_proyect2..[hourlyIntensities]
SET ActivityHour = CONVERT(datetime2,ActivityHour,20) --- I converted the data from string to datatime and then to datatime2


------ Checking the participants of the datasets we're going to use -----
SELECT DISTINCT(Id)
From Bellabeat_analyst_proyect2..[dailyActivity]

SELECT COUNT(DISTINCT(Id)) AS Distinct_Ids_DailyActivity
From Bellabeat_analyst_proyect2..[dailyActivity]

SELECT COUNT(DISTINCT(Id)) AS Distinct_Ids_dailyCalories
From Bellabeat_analyst_proyect2..[dailyCalories]

SELECT COUNT(DISTINCT(Id)) AS Distinct_Ids_dailyCalories
From Bellabeat_analyst_proyect2..[dailyIntensities]

SELECT COUNT(DISTINCT(Id)) AS Distinct_Ids_dailyCalories
From Bellabeat_analyst_proyect2..[dailySteps]

SELECT COUNT(DISTINCT(Id)) AS Distinct_Ids_dailyCalories
From Bellabeat_analyst_proyect2..[hourlyCalories]

SELECT COUNT(DISTINCT(Id)) AS Distinct_Ids_dailyCalories
From Bellabeat_analyst_proyect2..[hourlySteps]

SELECT COUNT(DISTINCT(Id)) AS Distinct_Ids_dailyCalories
From Bellabeat_analyst_proyect2..[sleepDay] ---- 24 participants

---------- Checking the amount of records by each user -------------

SELECT Id, COUNT(Id) as records
FROM Bellabeat_analyst_proyect2..[dailyActivity]
GROUP BY Id
HAVING COUNT(*) > 1


SELECT Id, COUNT(Id) as records
FROM Bellabeat_analyst_proyect2..[sleepDay] ---- Excluded, inconsistent data set
GROUP BY Id
HAVING COUNT(*) > 1

------ Cleaning data sets ------
---- Checking duplicates ------

SELECT Id, ActivityDate, COUNT(*) as duplicates
FROM Bellabeat_analyst_proyect2..[dailyActivity]
GROUP BY Id, ActivityDate
HAVING COUNT(*) > 1

SELECT Id, ActivityDay, COUNT(*) as duplicates
FROM Bellabeat_analyst_proyect2..[dailyCalories]
GROUP BY Id, ActivityDay
HAVING COUNT(*) > 1

SELECT Id, ActivityDay, COUNT(*) as duplicates
FROM Bellabeat_analyst_proyect2..[dailyIntensities]
GROUP BY Id, ActivityDay
HAVING COUNT(*) > 1

SELECT Id, ActivityDay, COUNT(*) as duplicates
FROM Bellabeat_analyst_proyect2..[dailySteps]
GROUP BY Id, ActivityDay
HAVING COUNT(*) > 1

SELECT Id, ActivityHour, COUNT(*) as duplicates
FROM Bellabeat_analyst_proyect2..[hourlyCalories]
GROUP BY Id, ActivityHour
HAVING COUNT(*) > 1

SELECT Id, ActivityHour, COUNT(*) as duplicates
FROM Bellabeat_analyst_proyect2..[hourlySteps]
GROUP BY Id, ActivityHour
HAVING COUNT(*) > 1

SELECT Id, ActivityHour, COUNT(*) as duplicates
FROM Bellabeat_analyst_proyect2..[hourlyIntensities]
GROUP BY Id, ActivityHour
HAVING COUNT(*) > 1


SELECT * FROM Bellabeat_analyst_proyect2..[sleepDay]


------ Preparing the data for analysis --------
---- Adding day_of_week to some data sets -------

ALTER TABLE Bellabeat_analyst_proyect2..[dailySteps]
ADD day_of_week varchar(50)

UPDATE Bellabeat_analyst_proyect2..[dailySteps]			---- setting the day to one column
SET day_of_week = DATENAME(WEEKDAY, ActivityDay)

ALTER TABLE Bellabeat_analyst_proyect2..[hourlySteps]
ADD hour_record varchar(MAX)

UPDATE Bellabeat_analyst_proyect2..[hourlySteps]		----- setting the hour to one column
SET hour_record = SUBSTRING(ActivityHour, 12, 5)

ALTER TABLE Bellabeat_analyst_proyect2..[hourlyCalories]
ADD hour_record varchar(MAX)

UPDATE Bellabeat_analyst_proyect2..[hourlyCalories]		----- setting the hour to one column
SET hour_record = SUBSTRING(ActivityHour, 12, 5)


ALTER TABLE Bellabeat_analyst_proyect2..[dailyIntensities]
ADD day_of_week varchar(MAX)

UPDATE Bellabeat_analyst_proyect2..[dailyIntensities]		----- setting the hour to one column
SET day_of_week = DATENAME(WEEKDAY, ActivityDay)



ALTER TABLE Bellabeat_analyst_proyect2..[hourlyIntensities]
ADD hour_record varchar(MAX)

UPDATE Bellabeat_analyst_proyect2..[hourlyIntensities]		----- setting the hour to one column
SET hour_record = SUBSTRING(ActivityHour, 12, 5)


ALTER TABLE Bellabeat_analyst_proyect2..[dailyIntensities]
ADD min_worn int

UPDATE Bellabeat_analyst_proyect2..[dailyIntensities]		----- setting the minutes worn
SET min_worn = SedentaryMinutes  + LightlyActiveMinutes + FairlyActiveMinutes + VeryActiveMinutes

------------------------------------------------------------


SELECT Id, AVG(StepTotal), day_of_week
FROM Bellabeat_analyst_proyect2..[dailySteps] 
GROUP BY day_of_week, Id
ORDER BY Id, day_of_week


SELECT day_of_week, AVG(StepTotal) as avg_step_total ----------- Average steps by day of week
FROM Bellabeat_analyst_proyect2..[dailySteps] 
GROUP BY day_of_week
ORDER BY day_of_week



SELECT hour_record, AVG(StepTotal) as avg_step_total ----------- Average steps by hour
FROM Bellabeat_analyst_proyect2..[hourlySteps] 
GROUP BY hour_record
ORDER BY hour_record


SELECT hour_record, AVG(Calories) as avg_calories ----------- Average calories by hour
FROM Bellabeat_analyst_proyect2..[hourlyCalories] 
GROUP BY hour_record
ORDER BY hour_record


SELECT day_of_week, AVG(SedentaryMinutes) as avg_sedentary, AVG(LightlyActiveMinutes) as avg_Lightly, ----------- Average activity by day of week (minutes)
 AVG(FairlyActiveMinutes) as avg_fairly, AVG(VeryActiveMinutes) as avg_veryActive	
FROM Bellabeat_analyst_proyect2..dailyIntensities
GROUP BY day_of_week
ORDER BY day_of_week


WITH dailyIntensities_hour (day_of_week, avg_sedentary, avg_Lightly, avg_fairly, avg_veryActive)
as
(
	SELECT day_of_week, 
	AVG(CAST(SedentaryMinutes/60 as numeric(36,2))) as avg_sedentary, 
	AVG(CAST(LightlyActiveMinutes/60 as numeric(36,2))) as avg_Lightly, 
	AVG(CAST(FairlyActiveMinutes/60 as numeric(36,2))) as avg_fairly, 
	AVG(CAST(VeryActiveMinutes/60 as numeric(36,2))) as avg_veryActive	
	FROM Bellabeat_analyst_proyect2..dailyIntensities
	GROUP BY day_of_week
)
SELECT * INTO #temp_dailyIntensities_hour
FROM
dailyIntensities_hour

DROP TABLE #temp_dailyIntensities_hour


SELECT *
FROM #temp_dailyIntensities_hour  ----------- Average activity by day of week (hours)


SELECT Id, COUNT(Id) as days_used,
CASE
	WHEN COUNT(Id) >= 1 AND COUNT(Id) <= 10 THEN 'Low Use'
	WHEN COUNT(ID) >= 11 AND COUNT(Id) <= 20 THEN 'Moderate Use'
	WHEN COUNT(ID) >= 21  THEN 'High Use'
END as use_category
FROM Bellabeat_analyst_proyect2..[dailyActivity]
GROUP BY Id
HAVING COUNT(*) > 1

----------- average daily use of the band per mins and hours ---------- 24 hours * 60 min = 1440 min
SELECT id, AVG(CAST(min_worn as numeric(36,2))) as avg_min_worn, (AVG(CAST(min_worn as numeric(36,2))))/60 as avg_hour_worn,
((AVG(CAST(min_worn as numeric(36,2))))/1440)*100 as percents
FROM Bellabeat_analyst_proyect2..dailyIntensities 
GROUP BY id


SELECT * FROM Bellabeat_analyst_proyect2..dailyIntensities 