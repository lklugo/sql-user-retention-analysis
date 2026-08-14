-- Question 13: Which cities have the highest Premium conversion rate?
/*
Findings:
- Brasília had the highest Premium conversion rate among the cities analyzed.
- Brasilia conversion rate is at 47%
- The highest-converting cities were spread across multiple countries,
  with no single country dominating the top rankings.
*/
SELECT
    u.city, COUNT(*) AS total_users,
    SUM(
        CASE
            WHEN s.subscription_type = 'Premium' THEN 1
            ELSE 0
        END
    ) AS premium_users,
    ROUND(
        1.0 * SUM(
            CASE
                WHEN s.subscription_type = 'Premium' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS premium_conversion_rate
FROM users u
JOIN subscriptions s ON u.user_id = s.user_id
GROUP BY u.city
ORDER BY premium_conversion_rate DESC