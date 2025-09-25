-- QUESTION: Who are the most productive profiles by gender and job type?
-- Are they less stressed, do they sleep more, or spend less time on social media?
-- What patterns emerge among the top productivity scorers?

SELECT 
  gender,
  job_type,
  ROUND(AVG(actual_productivity_score), 2) AS avg_productivity,
  ROUND(AVG(stress_level), 2) AS avg_stress,
  ROUND(AVG(sleep_hours), 2) AS avg_sleep,
  ROUND(AVG(breaks_during_work), 2) AS avg_breaks,
  ROUND(AVG(daily_social_media_time), 2) AS avg_social_time
FROM 
  `ccbd-exam-2025-leonardi.social_media_vs_productivity.productivity_data`
GROUP BY gender, job_type
ORDER BY avg_productivity DESC
LIMIT 10;


-- QUESTION: How does social media usage relate to both perceived and actual productivity?
-- Do people using more social media actually perform worse, or do they just feel less productive?
-- Is there a correlation with stress levels?

SELECT 
  ROUND(daily_social_media_time, 0) AS social_time_bucket,
  COUNT(*) AS users,
  ROUND(AVG(perceived_productivity_score), 2) AS perceived_productivity,
  ROUND(AVG(actual_productivity_score), 2) AS actual_productivity,
  ROUND(AVG(stress_level), 2) AS avg_stress
FROM 
  `ccbd-exam-2025-leonardi.social_media_vs_productivity.productivity_data`
WHERE daily_social_media_time IS NOT NULL
GROUP BY social_time_bucket
ORDER BY social_time_bucket;


-- QUESTION: Which job types experience the most burnout and stress?
-- Is there a paradox where people are stressed but still satisfied with their jobs?
-- Which jobs show the worst combination of burnout and low satisfaction?

SELECT 
  job_type,
  ROUND(AVG(days_feeling_burnout_per_month), 2) AS avg_burnout_days,
  ROUND(AVG(stress_level), 2) AS avg_stress,
  ROUND(AVG(job_satisfaction_score), 2) AS avg_satisfaction,
  COUNT(*) AS total_people
FROM 
  `ccbd-exam-2025-leonardi.social_media_vs_productivity.productivity_data`
GROUP BY job_type
HAVING total_people > 5
ORDER BY avg_burnout_days DESC;