/*	Question 3: How many new users signed up each month?
	Result: Monthly user signups remained relatively consistent at approximately
	250 new users per month.
	July had the highest number of new user with 269 signups,
	while June had the lowest number with 223 signups.
*/

SELECT STRFTIME('%m',signup_date) AS month_number,
	CASE STRFTIME('%m',signup_date) 
		WHEN '01' THEN 'JAN'
		WHEN '02' THEN 'FEB'
		WHEN '03' THEN 'MAR'
		WHEN '04' THEN 'APRIL'
		WHEN '05' THEN 'MAY'
		WHEN '06' THEN 'JUNE'
		WHEN '07' THEN 'JULY'
		WHEN '08' THEN 'AUG'
		WHEN '09' THEN 'SEPT'
		WHEN '10' THEN 'OCT'
		WHEN '11' THEN 'NOV'
		WHEN '12' THEN 'DEC'
	END AS month_name,
	COUNT(user_id) as new_user_count
FROM users
GROUP BY month_number
ORDER BY new_user_count DESC 