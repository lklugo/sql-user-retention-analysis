-- Question 5: Which cities have the most active users?
/*
Findings:

- The top five cities by active users are Chicago, Los Angeles, Miami,
  São Paulo, and New York.
- The U.S. cities make up the majority of the highest-ranking cities
  by active users.
- This suggests that user activity is particularly concentrated
  across major U.S. cities in this dataset.
*/



SELECT city, count(DISTINCT ul.user_id) AS active_users
FROM user_logins ul
JOIN users u ON ul.user_id = u.user_id
GROUP BY city
ORDER BY active_users DESC