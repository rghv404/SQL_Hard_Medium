-- *Context:* Oftentimes it's useful to know how much a key metric, such as monthly active users, changes between months.
-- Say we have a table logins in the form: 

-- | user_id | date       |
-- |---------|------------|
-- | 1       | 2018-07-01 |
-- | 234     | 2018-07-02 |
-- | 3       | 2018-07-02 |
-- | 1       | 2018-07-02 |
-- | ...     | ...        |
-- | 234     | 2018-10-04 |

-- *Task*: Find the month-over-month percentage change for monthly active users (MAU). 

with active_users_mom as (
	select date_trunc('month', date) as month, count(user_id) as num_users
	from logins group by date_trunc('month', date)
)
select month, abs(num_users - lag(num_users) over ())/(lag(num_users) over ()) * 100 from active_users_mom;
