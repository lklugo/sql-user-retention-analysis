-- Question 12: Which countries generate the most subscription revenue?
/*
Findings:
- The United States generated the most subscription revenue by a noticeable margin.
- Brazil generated the second-highest subscription revenue, followed by Mexico, and then the UK.
*/


SELECT country, ROUND(SUM(monthly_revenue), 2) AS country_revenue
FROM users u
JOIN subscriptions s ON u.user_id = s.user_id
GROUP BY country
ORDER BY country_revenue DESC