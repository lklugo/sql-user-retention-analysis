/*	Question 2: Are there any missing or invalid values?
	Result: No missing or invalid values were identified in the three datasets.
	Interpretation: The data passed the validation checks that were performed and can be used
	for further analysis without additional handling of missing or invalid values.
*/

-- Check Missing value is user table
SELECT *
FROM users
WHERE user_id IS NULL OR signup_date IS NULL
	OR country IS NULL OR city IS NULL
	OR device_type IS NULL OR marketing_channel IS NULL;
	
--Check Missing value in user_login table
SELECT *
FROM user_logins
WHERE login_id IS NULL
	OR user_id IS NULL
	OR login_date IS NULL;
--Check missing values in subscriptions table
SELECT *
FROM subscriptions
WHERE user_id IS NULL
	OR subscription_type IS NULL
	OR monthly_revenue IS NULL;
	
-- Check if any invalid device type
SELECT DISTINCT device_type
FROM users;

-- Check if any invalid marketing_channel type
SELECT DISTINCT marketing_channel
FROM users;

-- Check if any invalid countries 
SELECT DISTINCT country
FROM users;

--Check if the Free subscription_type made any money
SELECT * 
FROM subscriptions
WHERE subscription_type = 'Free' AND monthly_revenue > 0;

--Check if the Premium subscription_type
SELECT * 
FROM subscriptions
WHERE subscription_type = 'Premium' AND monthly_revenue = 0;