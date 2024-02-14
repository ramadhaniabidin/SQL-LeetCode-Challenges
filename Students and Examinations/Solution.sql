DECLARE @Students TABLE (
    student_id INT,
    student_name VARCHAR(MAX)
)
INSERT INTO @Students
VALUES
    ( 1, 'Alice'),
    ( 2, 'Bob'),
    ( 13, 'John'),
    ( 6, 'Alex')



DECLARE @Subjects TABLE(
    [subject_name] VARCHAR(MAX)
)
INSERT INTO @Subjects
VALUES
    ('Math'),
    ('Physics'),
    ('Programming')


DECLARE @Examinations TABLE(
    [student_id] INT,
    [subject_name] VARCHAR(MAX)
)
INSERT INTO @Examinations
VALUES
    (1, 'Math'),
    (1, 'Physics'),
    (1, 'Programming'),
    (2, 'Programming'),
    (1, 'Physics'),
    (1, 'Math'),
    (13, 'Math'),
    (13, 'Programming'),
    (13, 'Physics'),
    (2, 'Math'),
    (1, 'Math')


-- SELECT st.*, e.subject_name
-- FROM @Examinations e
-- RIGHT JOIN @Students st ON e.student_id = st.student_id

-- SELECT st.*, e.subject_name, COUNT(e.subject_name)
-- FROM @Students st 
-- LEFT JOIN @Examinations e ON st.student_id = e.student_id  
-- GROUP BY st.student_id, st.student_name, e.subject_name

-- SELECT e.*, sub.*
-- FROM @Examinations e
-- LEFT JOIN @Subjects sub ON e.subject_name = sub.subject_name

SELECT s.student_id, s.student_name, sub.subject_name, COUNT(e.subject_name) AS attended_exams
FROM @Students s
CROSS JOIN @Subjects sub
LEFT JOIN @Examinations e ON s.student_id = e.student_id AND sub.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;

-- SELECT s.*
-- FROM @Students s
-- CROSS JOIN @Subjects sub
-- ORDER BY s.student_id