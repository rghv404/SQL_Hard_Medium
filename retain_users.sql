-- *Context:* Say we have login data in the table logins: 

-- | user_id | date       |
-- |---------|------------|
-- | 1       | 2018-07-01 |
-- | 234     | 2018-07-02 |
-- | 3       | 2018-07-02 |
-- | 1       | 2018-07-02 |
-- | ...     | ...        |
-- | 234     | 2018-10-04 |

-- *Task:* Write a query that gets the number of retained users per month. 
-- In this case, retention for a given month is defined as the number of users who logged in that month who also logged in the immediately previous month. 

/*
the goal is to find count of common users logging this month and prev
- In spark world, one can collect set over each month and then
- intersect b/w current and prev month's collected set 
- then find size of that intersected set
*/
with monthly_users as (
	select distinct user_id, date_trunc('month', date) as month from logins
)
select mu1.month, count(distinct mu1.user_id) from monthly_users mu1 join monthly_users mu2 on mu1.user_id = mu2.user_id
and mu1.month = mu2.month - interval 1 month


-- churn users
/*
goal is to find churned users who 
*/
with monthly_users as (
	select distinct user_id, date_trunc('month', date) as month from logins
)
select mu1.month, count(distinct mu1.user_id) from monthly_users mu1 join monthly_users mu2 on mu1.user_id = mu2.user_id
and mu1.month = mu2.month - interval 1 month
