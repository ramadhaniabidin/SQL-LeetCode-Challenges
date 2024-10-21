DECLARE @Signups TABLE
([user_id] INT, [time_stamp] DATETIME)

DECLARE @Confirmations TABLE
([user_id] INT, [time_stamp] DATETIME, [action] VARCHAR(100))

INSERT INTO @Signups
([user_id], [time_stamp])
VALUES
(3, '2020-03-21 10:16:13'),
(7, '2020-01-04 13:57:59'),
(2, '2020-07-29 23:09:44'),
(6, '2020-12-09 10:39:37')

INSERT INTO @Confirmations
([user_id], [time_stamp], [action])
VALUES
(3, '2021-01-06 03:30:46', 'timeout'),
(3, '2021-07-14 14:00:00', 'timeout'), 
(7, '2021-06-12 11:57:29', 'confirmed'),
(7, '2021-06-13 12:58:28', 'confirmed'),
(7, '2021-06-14 13:59:27', 'confirmed'),
(2, '2021-01-22 00:00:00', 'confirmed'),
(2, '2021-02-28 23:59:59', 'timeout')

SELECT S.[user_id], ISNULL(C.[action], 'timeout') AS 'action'
FROM @Signups S LEFT JOIN @Confirmations C ON S.[user_id] = C.[user_id]

SELECT S.[user_id], CAST((CAST((SELECT COUNT(*) 
FROM @Signups A LEFT JOIN @Confirmations B ON A.[user_id] = B.[user_id]
WHERE A.[user_id] = S.[user_id] AND B.[action] = 'confirmed') AS FLOAT) /

(SELECT COUNT(*) 
FROM @Signups A LEFT JOIN @Confirmations B ON A.[user_id] = B.[user_id]
WHERE A.[user_id] = S.[user_id])) AS DECIMAL(10,2))AS 'confirmation_rate'

FROM @Signups S LEFT JOIN @Confirmations C ON S.[user_id] = C.[user_id]
GROUP BY S.[user_id]
ORDER BY 'confirmation_rate' ASC

--SELECT S.[user_id], COUNT(*)
--FROM @Signups S LEFT JOIN @Confirmations C ON S.[user_id] = C.[user_id]
--WHERE ISNULL(C.[action], 'timeout') = 'confirmed'
--GROUP BY S.[user_id]

