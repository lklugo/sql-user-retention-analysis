-- Question 4: How many Monthly Active Users (MAU) are there?
/*
Findings:

- Monthly Active Users (MAU) increased throughout 2025.
- No month experienced a decline in active users compared with the previous month.
- The largest month-over-month increase in MAU occurred between June and July. That was 796 to 963 active users
*/

SELECT STRFTIME('%m',login_date) AS month_number,
		CASE STRFTIME('%m',login_date) 
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
	COUNT(DISTINCT user_id) AS monthly_active_users
FROM user_logins
GROUP BY STRFTIME('%m',login_date)