-- Question 11: Which marketing channel brings the most Premium subscribers?
/*
Findings:
- Organic marketing generated the highest number of Premium subscribers.
- Instagram and TikTok ranked second and third, respectively.
- Organic is therefore the largest source of Premium subscribers in the dataset.
*/
SELECT marketing_channel, COUNT(*) as premium_users
FROM users u
JOIN subscriptions s ON u.user_id = s.user_id
WHERE subscription_type = 'Premium'
GROUP BY marketing_channel
ORDER BY premium_users DESC