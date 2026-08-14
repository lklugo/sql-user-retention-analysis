-- Q15 Executive Dashboard
/*
- We see that Monthly Active Users increased throughout 2025.
- New user registrations remained relatively consistent.
- Retention rates were generally stable across the year.
- Reactivated users appeared in many of the months, showing that some inactive users returned.
- Churn occurred every month, indicating a normal level of user attrition.

This dashboard provides a consolidated monthly view of user growth, engagement, retention, and churn. 
It can be used by stakeholders to monitor platform health and identify trends that may require further investigation.
*/


WITH monthly_logins AS (
	SELECT DISTINCT user_id,
		DATE(login_date, 'start of month') AS login_month
    FROM user_logins
),
new_users AS (
	SELECT DATE(signup_date, 'start of month') AS report_month,
		COUNT(user_id) AS new_users
	FROM users
	GROUP BY DATE(signup_date, 'start of month')
),
monthly_active_users AS (
	SELECT login_month AS report_month,
		COUNT(user_id) AS monthly_active_users
	FROM monthly_logins
	GROUP BY login_month
),
retained_users AS (
    SELECT
        curr.login_month AS report_month,
        COUNT(curr.user_id) AS retained_users
    FROM monthly_logins curr
    JOIN monthly_logins prev
        ON curr.user_id = prev.user_id
       AND curr.login_month = DATE(prev.login_month, '+1 month')
    GROUP BY curr.login_month
),
reactivated_users AS (
    SELECT
        curr.login_month AS report_month,
        COUNT(DISTINCT curr.user_id) AS reactivated_users
    FROM monthly_logins curr

    LEFT JOIN monthly_logins prev_month
        ON curr.user_id = prev_month.user_id
       AND curr.login_month = DATE(prev_month.login_month, '+1 month')

    JOIN monthly_logins prior_activity
        ON curr.user_id = prior_activity.user_id
       AND prior_activity.login_month < curr.login_month

    WHERE prev_month.user_id IS NULL
    GROUP BY curr.login_month
),
churned_users AS (
    SELECT
        DATE(prev.login_month, '+1 month') AS report_month,
        COUNT(prev.user_id) AS churned_users
    FROM monthly_logins prev
    LEFT JOIN monthly_logins curr
        ON prev.user_id = curr.user_id
       AND curr.login_month = DATE(prev.login_month, '+1 month')
    WHERE curr.user_id IS NULL
    GROUP BY DATE(prev.login_month, '+1 month')
),
previous_month_active_users AS (
    SELECT
        DATE(login_month, '+1 month') AS report_month,
        COUNT(user_id) AS previous_month_active_users
    FROM monthly_logins
    GROUP BY DATE(login_month, '+1 month')
)

SELECT
    STRFTIME('%m', mau.report_month) AS month_number,

    CASE STRFTIME('%m', mau.report_month)
        WHEN '01' THEN 'JAN'
        WHEN '02' THEN 'FEB'
        WHEN '03' THEN 'MAR'
        WHEN '04' THEN 'APR'
        WHEN '05' THEN 'MAY'
        WHEN '06' THEN 'JUN'
        WHEN '07' THEN 'JUL'
        WHEN '08' THEN 'AUG'
        WHEN '09' THEN 'SEP'
        WHEN '10' THEN 'OCT'
        WHEN '11' THEN 'NOV'
        WHEN '12' THEN 'DEC'
    END AS month_name,

    COALESCE(nu.new_users, 0) AS new_users,
    mau.monthly_active_users,
    COALESCE(ru.retained_users, 0) AS retained_users,
    COALESCE(reac.reactivated_users, 0) AS reactivated_users,
    COALESCE(cu.churned_users, 0) AS churned_users,

    ROUND(
        100.0 * COALESCE(ru.retained_users, 0)
        / NULLIF(pma.previous_month_active_users, 0),
        2
    ) AS retention_percentage

FROM monthly_active_users mau

LEFT JOIN new_users nu
    ON mau.report_month = nu.report_month

LEFT JOIN retained_users ru
    ON mau.report_month = ru.report_month

LEFT JOIN reactivated_users reac
    ON mau.report_month = reac.report_month

LEFT JOIN churned_users cu
    ON mau.report_month = cu.report_month

LEFT JOIN previous_month_active_users pma
    ON mau.report_month = pma.report_month

ORDER BY mau.report_month;

