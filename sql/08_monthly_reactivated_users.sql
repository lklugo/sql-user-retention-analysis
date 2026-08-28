-- Question 8: How many reactivated users came back?
/*
Findings:
- Reactivated users were present throughout the analyzed months,
  this shows that previously inactive users returned to the platform.
- The most noticeable month-over-month increase occurred between November
  and December, when the number of reactivated users increased by
  nearly 400 users.
*/

WITH monthly_logins AS(
SELECT DISTINCT user_id, DATE(login_date, 'start of month') AS login_month
FROM user_logins
)
--the LEFT join is to see if they logged in last Month. Since we want people that didn't the WHERE is to filter out the people that did
--the 2nd JOIN means they logged in atleast once before the current month
SELECT STRFTIME('%m', curr.login_month) AS month_number, COUNT(DISTINCT curr.user_id) as reactivated_users
FROM monthly_logins curr
LEFT JOIN monthly_logins prev_month 
	ON curr.user_id = prev_month.user_id 
	AND curr.login_month = DATE(prev_month.login_month, '+1 month')
JOIN monthly_logins prior_activity
    ON curr.user_id = prior_activity.user_id
   AND prior_activity.login_month < curr.login_month
WHERE prev_month.user_id IS NULL
GROUP BY STRFTIME('%m', curr.login_month)
ORDER BY month_number;