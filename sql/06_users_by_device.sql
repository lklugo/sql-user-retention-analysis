-- Question 6: Which device type has the highest activity?
/*
Findings:

- Android had the highest number of active users, followed closely by iPhone.
- Web had noticeably fewer active users compared with both Android and iPhone.
*/

SELECT device_type, COUNT(DISTINCT ul.user_id) as active_users
FROM user_logins ul
JOIN users u ON ul.user_id = u.user_id
GROUP BY device_type
ORDER BY active_users DESC