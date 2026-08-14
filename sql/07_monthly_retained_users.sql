-- Question 7: How many retained users returned from the previous month?
/*
Findings:
- The number of retained users generally increased throughout the year 2025.
- The smallest month-over-month increase occurred between October and November,
  when retained users increased from 837 to 864.
*/

--THIS gets each unique monthly logins from users. the date function is there to start each date with a first date
WITH monthly_logins AS (
SELECT DISTINCT user_id, DATE(login_date, 'start of month') AS login_month
FROM user_logins
)

--Here we do a self join to the CTE we created before. The curr is the standard date, and prev for the month before 
-- We join on the user id and if the month is 1 apart
-- then we group by date and count the unique user for that month, DISTINCT is not required here because the CTE
-- already contains one row per user per month.
SELECT STRFTIME('%m', curr.login_month) AS month_number, COUNT(curr.user_id) as retained_users
FROM monthly_logins curr
JOIN monthly_logins prev ON curr.user_id = prev.user_id AND curr.login_month = DATE(prev.login_month, '+1 month')
GROUP BY STRFTIME('%m', curr.login_month)
ORDER BY retained_users DESC ;