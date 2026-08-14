-- Question 1: Are there duplicate login events?
/* 	Definition: Same user_id with the same login_date more than once.
	Result: 1,550 user/date combinations contained multiple login records.
	Interpretation: This may indicate repeated daily login records or duplicate data loading.
	For monthly active user analysis, this does not affect COUNT(DISTINCT user_id),
	but it could affect total login volume if not handled carefully. */

SELECT user_id, login_date, COUNT(*) AS duplicate_count
FROM user_logins
GROUP By user_id, login_date
HAVING duplicate_count > 1