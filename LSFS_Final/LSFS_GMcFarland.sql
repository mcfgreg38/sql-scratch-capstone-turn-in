/* TASK #1. */

 SELECT *
 FROM subscriptions
 GROUP BY segment
 LIMIT 100;

/* TASK #2. */

 SELECT MIN(subscription_start), 
   MAX(subscription_start)
 FROM subscriptions;

/* TASK #3. */

WITH months AS (
  SELECT '2017-01-01' AS first_day,
         '2017-01-31' AS last_day
  UNION
  SELECT '2017-02-01' AS first_day,
         '2017-02-28' AS last_day
  UNION
  SELECT '2017-03-01' AS first_day,
         '2017-03-31' AS last_day
)

SELECT * 
FROM months;

/* TASK #4. */

WITH months AS (
  SELECT '2017-01-01' AS first_day,
         '2017-01-31' AS last_day
  UNION
  SELECT '2017-02-01' AS first_day,
         '2017-02-28' AS last_day
  UNION
  SELECT '2017-03-01' AS first_day,
         '2017-03-31' AS last_day
),

cross_join AS (
  SELECT * 
  FROM subscriptions CROSS JOIN months
)

SELECT *
FROM cross_join
LIMIT 100;

/* TASK #5. */

WITH months AS (
  SELECT '2017-01-01' AS first_day,
         '2017-01-31' AS last_day
  UNION
  SELECT '2017-02-01' AS first_day,
         '2017-02-28' AS last_day
  UNION
  SELECT '2017-03-01' AS first_day,
         '2017-03-31' AS last_day
),

cross_join AS (
  SELECT * 
  FROM subscriptions CROSS JOIN months
),

status AS (
  SELECT id, 
    first_day AS month,
    CASE
      WHEN (segment = 87)
  	AND (
       	    (subscription_start < first_day)
       	    AND (subscription_end IS NULL)
       	) THEN 1
  	ELSE 0
    END AS is_active_87,
  
    CASE 
      WHEN (segment = 30)
  	AND (
            (subscription_start < first_day)
            AND (subscription_end IS NULL)
        ) THEN 1
  	ELSE 0
    END AS is_active_30

  FROM cross_join
)

SELECT * 
FROM status
LIMIT 100;

/* TASK #6.*/

WITH months AS (
  SELECT '2017-01-01' AS first_day,
         '2017-01-31' AS last_day
  UNION
  SELECT '2017-02-01' AS first_day,
         '2017-02-28' AS last_day
  UNION
  SELECT '2017-03-01' AS first_day,
         '2017-03-31' AS last_day
),

cross_join AS (
  SELECT * 
  FROM subscriptions CROSS JOIN months
),

status AS (
  SELECT id, first_day AS month,
    CASE
      WHEN (segment = 87)
  	AND (
            (subscription_start < first_day)
            AND (subscription_end IS NULL)
            ) THEN 1
      ELSE 0
      END AS is_active_87,
  	
    CASE
      WHEN (segment = 87)
  	AND (
            (subscription_end BETWEEN first_day
            AND last_day)        
            ) THEN 1
      ELSE 0
      END AS is_canceled_87,
  
    CASE 
      WHEN (segment = 30)
  	AND (
            (subscription_start < first_day)
            AND (subscription_end IS NULL)
            ) THEN 1
      ELSE 0
      END AS is_active_30,
  
    CASE
      WHEN (segment = 30)
  	AND (
            (subscription_end BETWEEN first_day
            AND last_day)        
            ) THEN 1
      ELSE 0
      END AS is_canceled_30

  FROM cross_join
)

SELECT * 
FROM status
LIMIT 100;

/* TASK #7.*/

WITH months AS (
  SELECT '2017-01-01' AS first_day,
         '2017-01-31' AS last_day
  UNION
  SELECT '2017-02-01' AS first_day,
         '2017-02-28' AS last_day
  UNION
  SELECT '2017-03-01' AS first_day,
         '2017-03-31' AS last_day
),

cross_join AS (
  SELECT * 
  FROM subscriptions CROSS JOIN months
),

status AS (
  SELECT id, first_day AS month,
    CASE
      WHEN (segment = 87)
  	AND (
            (subscription_start < first_day)
            AND (subscription_end IS NULL)
            ) THEN 1
      ELSE 0
      END AS is_active_87,
  	
    CASE
      WHEN (segment = 87)
  	AND (
            (subscription_end BETWEEN first_day
            AND last_day)        
            ) THEN 1
      ELSE 0
      END AS is_canceled_87,
  
    CASE 
      WHEN (segment = 30)
  	AND (
            (subscription_start < first_day)
            AND (subscription_end IS NULL)
            ) THEN 1
      ELSE 0
      END AS is_active_30,
  
    CASE
      WHEN (segment = 30)
  	AND (
            (subscription_end BETWEEN first_day
            AND last_day)        
            ) THEN 1
      ELSE 0
      END AS is_canceled_30

  FROM cross_join
),

status_aggregate AS (
  SELECT SUM(is_active_87) AS sum_active_87,
  	 SUM(is_active_30) AS sum_active_30,
  	 SUM(is_canceled_87) AS sum_canceled_87,
  	 SUM(is_canceled_30) AS sum_canceled_30
  FROM status
)
SELECT * 
FROM status_aggregate;

/* TASK #8. */

WITH months AS (
  SELECT '2017-01-01' AS first_day,
         '2017-01-31' AS last_day
  UNION
  SELECT '2017-02-01' AS first_day,
         '2017-02-28' AS last_day
  UNION
  SELECT '2017-03-01' AS first_day,
         '2017-03-31' AS last_day
),

cross_join AS (
  SELECT * 
  FROM subscriptions CROSS JOIN months
),


status AS (
  SELECT id, first_day AS month,
    CASE
      WHEN (segment = 87)
  	AND (
            (subscription_start < first_day)
            AND (subscription_end IS NULL)
            ) THEN 1
      ELSE 0
      END AS is_active_87,
  	
    CASE
      WHEN (segment = 87)
  	AND (
            (subscription_end BETWEEN first_day
            AND last_day)        
            ) THEN 1
      ELSE 0
      END AS is_canceled_87,
  
    CASE 
      WHEN (segment = 30)
  	AND (
            (subscription_start < first_day)
            AND (subscription_end IS NULL)
            ) THEN 1
      ELSE 0
      END AS is_active_30,
  
    CASE
      WHEN (segment = 30)
  	AND (
            (subscription_end BETWEEN first_day
            AND last_day)        
            ) THEN 1
      ELSE 0
      END AS is_canceled_30

  FROM cross_join
),

status_aggregate AS (
  SELECT SUM(is_active_87) AS sum_active_87,
  	 SUM(is_active_30) AS sum_active_30,
  	 SUM(is_canceled_87) AS sum_canceled_87,
  	 SUM(is_canceled_30) AS sum_canceled_30
  FROM status
)

SELECT 1.0 * sum_canceled_87 / sum_active_87,
       1.0 * sum_canceled_30 / sum_active_30
FROM status_aggregate;

