--USING LAG() window function
WITH TemperatureComparison AS (
    SELECT
        id,
        recordDate,
        temperature,
        LAG(temperature) OVER (ORDER BY id) AS previous_temperature
    FROM
        Weather
)
SELECT
    id AS today_id,
    recordDate AS today_date,
    temperature AS today_temperature,
    previous_temperature AS yesterday_temperature
FROM
    TemperatureComparison
WHERE
    temperature > previous_temperature
--LAG() window function is used to access the value of the previous row

--Using CURSOR pointer
DECLARE cursor_id CURSOR FOR
SELECT id FROM Weather
ORDER BY recordDate ASC

DECLARE @table TABLE(id INT)

OPEN cursor_id
DECLARE @id INT
FETCH NEXT FROM cursor_id INTO @id

WHILE @@FETCH_STATUS = 0
BEGIN
	IF @id > 1
	BEGIN
		DECLARE @temp INT = (SELECT temperature FROM Weather WHERE id = @id)
		DECLARE @old_temp INT = (SELECT temperature FROM Weather WHERE id = @id - 1)
		IF @temp > @old_temp
		BEGIN
			INSERT INTO @table VALUES(@id)
		END
	END
	FETCH NEXT FROM cursor_id INTO @id
END

CLOSE cursor_id
DEALLOCATE cursor_id
SELECT * FROM @table
--END

--Using SELF JOIN
SELECT t.*, y.temperature yesterday_temperature
FROM Weather t
LEFT JOIN Weather y ON t.recordDate = DATEADD(DAY, 1, y.recordDate)
WHERE t.temperature > y.temperature
-- END

DECLARE @Weather TABLE(id INT, recordDate DATE, temperature INT)
INSERT INTO @Weather
VALUES
(1, '2000-12-16', 3),
(2, '2000-12-15', -1)
--(3, '2000-12-14', 2)
SELECT t.*, y.temperature yesterday_temperature
FROM @Weather t
JOIN @Weather y ON t.recordDate = DATEADD(DAY, 1, y.recordDate)
WHERE t.temperature > y.temperature
ORDER BY t.recordDate ASC
