DECLARE @Employee TABLE
(
    empId INT, [name] VARCHAR(MAX), [supervisor] INT,
    [salary] INT
)

INSERT INTO @Employee
VALUES
(3, 'Brad', null, 4000),   
(1, 'John',  3, 1000),   
(2, 'Dan', 3, 2000), 
(4, 'Thomas', 3, 4000)

DECLARE @Bonus TABLE(
    empId INT, bonus INT
)
INSERT INTO @Bonus
(empId, bonus)
VALUES
(2, 500),
(4, 2000)

SELECT * FROM @Employee
SELECT * FROM @Bonus

SELECT e.empId, e.name, b.bonus
FROM @Employee e 
LEFT JOIN @Bonus b ON e.empId = b.empId
WHERE ISNULL(b.bonus, 0) < 1000