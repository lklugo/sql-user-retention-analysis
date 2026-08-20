-- Question 9: How many users churned each month?
/*
Findings:
- January churn cannot be calculated because the dataset does not include
  activity from December 2024.
- Churn generally increased throughout the year 2025.
- The growth in churn began to level off during the final three months
  of the year.
*/

--THIS gets each unique monthly logins from users. the date function is there to start each date with a first date
WITH monthly_logins AS(
SELECT DISTINCT user_id, DATE(login_date, 'start of month') AS login_month
FROM user_logins)

--This get the prev month, and a list of people this month. We're checking who waas active last month and who didn't return at the current month
--this will show churn for the month after their last active month. For example, active in March but not April = churned in April.
--the AND prev.login_month < '2025-12-01' is too excluded january because we don't have value before that.
SELECT STRFTIME('%m', DATE(prev.login_month, '+1 month')) AS month_number, COUNT(prev.user_id) AS churned_users
FROM monthly_logins prev
LEFT JOIN monthly_logins curr 
	ON prev.user_id = curr.user_id 
	AND curr.login_month = DATE(prev.login_month, '+1 month')
WHERE curr.user_id IS NULL AND prev.login_month < '2025-12-01'
GROUP BY STRFTIME('%m', DATE(prev.login_month, '+1 month'))
ORDER BY month_number;