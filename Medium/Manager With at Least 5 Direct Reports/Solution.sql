--Table: Employee

--+-------------+---------+
--| Column Name | Type    |
--+-------------+---------+
--| id          | int     |
--| name        | varchar |
--| department  | varchar |
--| managerId   | int     |
--+-------------+---------+
--id is the primary key (column with unique values) for this table.
--Each row of this table indicates the name of an employee, their department, and the id of their manager.
--If managerId is null, then the employee does not have a manager.
--No employee will be the manager of themself.
 

--Write a solution to find managers with at least five direct reports.

--Return the result table in any order.

--The result format is in the following example.

 

--Example 1:

--Input: 
--Employee table:
--| id  | name  | department | managerId |
--| --- | ----- | ---------- | --------- |
--| 101 | John  | A          | null      |
--| 102 | Dan   | A          | 101       |
--| 103 | James | A          | 101       |
--| 104 | Amy   | A          | 101       |
--| 105 | Anne  | A          | 101       |
--| 106 | Ron   | B          | 101       |
--| 111 | John  | A          | null      |
--| 112 | Dan   | A          | 111       |
--| 113 | James | A          | 111       |
--| 114 | Amy   | A          | 111       |
--| 115 | Anne  | A          | 111       |
--| 116 | Ron   | B          | 111       |
--Output: 
--+------+
--| name |
--+------+
--| John |
--+------+

DECLARE @Employee TABLE
(
	id INT, [name] VARCHAR(100), department VARCHAR(100), managerId INT
)

INSERT INTO @Employee
(id, [name], department, managerId)
VALUES
(101, 'John', 'A', null),
(102, 'Dan', 'A', 101),
(103, 'James', 'A', 101),
(104, 'Amy', 'A', 101),
(105, 'Anne', 'A', 101),
(106, 'Ron', 'B', 101),
(111, 'John', 'A', null),
(112, 'Dan', 'A', 111),
(113, 'James', 'A', 111),
(114, 'Amy', 'A', 111),
(115, 'Anne', 'A', 111),
(116, 'Ron', 'B', 111)


SELECT A.*, B.[name] AS ManagerName FROM @Employee A
INNER JOIN @Employee B ON A.managerId = B.id


SELECT B.name FROM @Employee A
INNER JOIN @Employee B ON A.managerId = B.id
GROUP BY A.managerId, B.name
HAVING COUNT(A.[managerId]) >= 5
