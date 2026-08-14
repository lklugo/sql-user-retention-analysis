-- Question 10: What is the monthly retention rate?
/*
Findings:
- The monthly retention rate remained relatively stable at around 60%.
- October had the highest retention rate at 67%.
- February had the lowest retention rate at 52%.
*/

--THIS gets each unique monthly logins from users. the date function is there to start each date with a first date
WITH monthly_logins AS (
SELECT DISTINCT user_id, DATE(login_date, 'start of month') AS login_month
FROM user_logins
), 

--Here we do a self join to the CTE we created before. The curr is the standard date, and prev for the month before 
-- We join on the user id and if the month is 1 apart
-- then we group by date and count the unique user for that month, already contains one row per user per month.
retained_users AS (
SELECT 
	curr.login_month, 
	COUNT(curr.user_id) as retained_users
FROM monthly_logins curr
JOIN monthly_logins prev ON curr.user_id = prev.user_id AND curr.login_month = DATE(prev.login_month, '+1 month')
GROUP BY curr.login_month
ORDER BY curr.login_month
),
--This gets the previous month user, it print out starting for february, but that mean
--for febuary the previous month count was and so on
prev_montly_actives_users AS (
SELECT DATE(login_month, '+1 month') as login_month, COUNT(user_id) as previous_users
FROM monthly_logins
GROUP BY DATE(login_month, '+1 month')
)

--Here we join the retained user CTE and the previous user CTE by month, so this would start in february which is 02
--then we just do a basic math calculation
SELECT 
	STRFTIME('%m', r.login_month) AS month_number, 
	r.retained_users, 
	p.previous_users, 
	ROUND(1.0*r.retained_users/p.previous_users, 2) as retention_rate
FROM retained_users r
JOIN prev_montly_actives_users p ON r.login_month = p.login_month
ORDER BY month_number;

	