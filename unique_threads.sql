

-- SQL Schema

-- Table: messenger_sends
-- +------------------+---------+
-- | Column Name      | Type    |
-- +------------------+---------+
-- |sender_id         |int      |  
-- |receiver_id       |int      |    
-- +------------------+---------+

-- Write a query to find how many unique conversation threads there are.

-- Hint: Note that there are threads that sender_id and receiver is inverse. This should be one thread.

-- Example

-- Table: messenger_sends
-- +-----------+-----------+
-- |sender_id  |receiver_id|
-- +-----------+-----------+
-- |1          |2          |	2, 1
-- |1          |2          |	2, 1
-- |2          |1          |	1, 2 repeated again
-- |4          |2          |	not considered
-- |3          |2          |	2, 3
-- |2          |3          |	3, 2
-- |1          |3          |	not considered
-- |1          |4          |	not considered
-- |1          |4          |	not considered
-- |4          |3          |	not considered
-- |4          |3          |	not considered
-- +-----------+-----------+

-- Is it considered a thread even if the receiver does not reply?
-- Do we have reverse entry even if the reciver does not reply back to the sender? 

/*
- self join on sender_id of table first instance with receiver_id of table's second instance to get threads (assuming reply back is a thread and not just sending a message)
- we select unq thread pairs by 
*/
with unq_threads as {
	select distinct least(m1.sender_id, m2.sender_id) as sender_id, greatest(m1.receiver_id, m2.receiver_id) receiver_id from messenger_sends m1
	join messenger_sends m2 on m1.sender_id = m2.receiver_id and m2.sender_id = m1.receiver_id
}
select count(*) from unq_threads;

/*
Now if even a message sent is considered a thread i.e. it is not necessary to receive 
*/

