-- query one
SELECT department, AVG(grade) AS average_grade
FROM grades_by_dept
WHERE department = 'Computer Science'
GROUP BY department;
-- query two
SELECT major, COUNT(student_id) AS student_count
FROM students_by_major
GROUP BY major;
-- query three
SELECT department, SUM(credits) AS total_credits
FROM courses
GROUP BY department;
-- query four
SELECT department, course_id, AVG(grade) AS average_grade
FROM enrollments
WHERE department = 'Computer Science' AND year = 2023 AND semester = 'Fall'
GROUP BY department, course_id
ALLOW FILTERING;
-- query five
SELECT major, AVG(gpa) AS average_gpa, COUNT(student_id) AS student_count
FROM students_by_major
WHERE major = 'Mathematics'
GROUP BY major;
-- query six
SELECT department, course_id,
       MIN(grade) AS min_grade,
       MAX(grade) AS max_grade,
       AVG(grade) AS average_grade
FROM grades_by_dept
GROUP BY department, course_id;
