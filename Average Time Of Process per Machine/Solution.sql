DECLARE @Activity TABLE
(
	id INT IDENTITY(1,1),
	machine_id INT,
	process_id INT,
	activity_type VARCHAR(MAX),
	[timestamp] FLOAT
)

INSERT INTO @Activity
	(machine_id, process_id, activity_type, [timestamp])
VALUES
	(0, 0, 'start', '0.712'),
	(0, 0, 'end', '1.52'),
	(0, 1, 'start', '3.14'),
	(0, 1, 'end', '4.12'),
	(1, 0, 'start', '0.55'),
	(1, 0, 'end', '1.55'),
	(1, 1, 'start', '0.43'),
	(1, 1, 'end', '1.42'),
	(2, 0, 'start', '4.1'),
	(2, 0, 'end', '4.512'),
	(2, 1, 'start', '2.5'),
	(2, 1, 'end', '5')

SELECT *
FROM @Activity

SELECT a.machine_id, ROUND(AVG(b.[timestamp] - a.[timestamp]), 3) AS processing_time
FROM @Activity a JOIN @Activity b 
ON a.machine_id = b.machine_id
AND a.process_id = b.process_id
AND a.activity_type = 'start'
AND b.activity_type = 'end'
GROUP BY a.machine_id
