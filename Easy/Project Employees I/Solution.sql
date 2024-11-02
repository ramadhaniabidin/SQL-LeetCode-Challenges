DECLARE @Project TABLE
(project_id INT, employee_id INT)
INSERT INTO @Project
VALUES
(1, 1),       
(1, 2),          
(1, 3),         
(2, 1),          
(2, 4)           

DECLARE @Employee TABLE
(employee_id INT, name VARCHAR(MAX), experience_years INT)
INSERT INTO @Employee
VALUES
(1, 'Khaled', 3),              
(2, 'Ali', 2),
(3, 'John', 1),
(4, 'Doe', 2)

--SELECT * FROM @Project
--SELECT * FROM @Employee

--SELECT CAST('15.467' AS DECIMAL(20, 2)), ROUND('15.467', 2)

SELECT P.project_id, ROUND(AVG(E.experience_years * 1.0), 2) AS average_years
FROM @Project P INNER JOIN @Employee E ON P.employee_id = E.employee_id
GROUP BY P.project_id
ORDER BY P.project_id
