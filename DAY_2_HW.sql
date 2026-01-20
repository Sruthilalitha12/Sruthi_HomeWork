--Q1: Count how many students passed the exam.
SELECT
COUNT (*) AS no_of_students_passed
FROM day_2_exam
WHERE result_status = 'Pass'

--OUTPUT
no_of_students_passed
24

--Q2: Find the average score of all students who failed.
SELECT 
ROUND(AVG (total_score), 2) AS average_score
FROM day_2_exam
WHERE result_status = 'Fail'

--OUTPUT
average_score
24.67

--Q3: Get the highest score among all students.
SELECT
MAX(total_score) AS highest_score
FROM day_2_exam

--OUTPUT
highest_score
44

--Q4: Get the lowest score among passed students.
SELECT
MIN(total_score) AS lowest_score
FROM day_2_exam

--OUTPUT
lowest_score
19

--Q5: Sum the total marks of all students who scored above 40.
SELECT
SUM(total_score) AS total_marks
FROM day_2_exam
WHERE total_score > 40

--OUTPUT
total_marks
127

--Q6: Count students by result status for those who scored 35 or more.
SELECT
result_status,
COUNT(*) AS student_count
FROM day_2_exam
WHERE total_score >= 35
GROUP BY result_status

--OUTPUT
result_status   student_count
Pass            16

--Q7: Find average score grouped by result status for students with scores between 30 and 40.
SELECT
result_status,
ROUND(AVG(total_score), 3) AS average_score
FROM day_2_exam
WHERE total_score between 30 and 40
GROUP BY result_status

--OUTPUT
result_status   average_score
Pass            34.857

--Q8: Get maximum and minimum scores grouped by result status for students who scored less than 35.
SELECT
result_status,
MAX(total_score) AS max_score,
MIN(total_score) AS min_score
FROM day_2_exam
WHERE total_score < 35
GROUP BY result_status
ORDER BY 1 DESC

--OUTPUT
result_status   max_score   min_score
Pass            34          30
Fail            29          19

--Q9: Count students grouped by result status for those whose names start with 'A'. (took day_1_exam table)
SELECT
result_status,
COUNT(student_name) AS a_names
FROM
day_1_exam
WHERE student_name LIKE 'A%'
GROUP BY result_status

--OUTPUT
result_status   a_names
Pass            7
Fail            2

--Q10: Sum total scores grouped by result status for students who scored exactly 35, 40, or 45.
SELECT
result_status,
SUM(total_score)
FROM day_2_exam
WHERE total_score IN(35, 40, 45) 
GROUP BY result_status

--OUTPUT
result_status   sum
Pass            145

--Q11: Count students by each score value, ordered by score descending.
SELECT
total_score,
COUNT(total_score) AS score_count
FROM
day_2_exam
GROUP BY total_score
ORDER BY total_score DESC

--OUTPUT
total_score   score_count
44            1
42            1
41            1
40            1
39            1
38            2
37            1
36            5
35            3
34            1
33            1
32            3
31            2
30            1
29            1
28            2
27            3
26            1
25            2
24            4
23            2
22            1
19            2

--Q12: Show average score for each result status, ordered by average score.
SELECT
result_status,
ROUND(AVG(total_score), 2) AS average_score
FROM day_2_exam
GROUP BY result_status
ORDER BY AVG(total_score)

--OUTPUT
result_status   average_score
Fail            24.67
Pass            35.79

--Q13: Count how many students got each score, only for scores above 30, ordered by frequency.
SELECT
total_score,
COUNT(total_score) AS count_score
FROM day_2_exam
WHERE total_score > 30
GROUP BY total_score
ORDER BY total_score 
--OUTPUT
total_score   count_score
31            2
32            3
33            1
34            1
35            3
36            5
37            1
38            2
39            1
40            1
41            1
42            1
44            1

--Q14: Get total marks sum for each result status, ordered by sum.
SELECT
result_status,
SUM(total_score) AS total_marks
FROM day_2_exam
GROUP BY result_status
ORDER BY total_marks

--OUTPUT
result_status   total_marks
Fail            444
Pass            859


--Q15: Find minimum score for each result status, ordered by min score.
SELECT
result_status,
MIN(total_score) AS minimum_score
FROM day_2_exam
GROUP BY result_status
ORDER BY MIN(total_score)

--OUTPUT
result_status   minimum_score
Fail            19
Pass            30

--Q16: For passed students only, show count, average, max and min scores grouped by whether score is above 40.
SELECT
total_score,
COUNT(total_score) AS count_score,
ROUND( AVG(total_score), 2) AS average_score,
MAX(total_score) AS highest_score,
MIN(total_score) AS lowest_score
FROM day_2_exam
WHERE result_status = 'Pass' and total_score > 40
GROUP BY total_score

--OUTPUT
total_score   count_score   average_score   highest_score   lowest_score
41            1             41.00           41              41
42            1             42.00           42              42
44            1             44.00           44              44

--Q17: Count and average score for each result status, only for scores not equal to 35.
SELECT
result_status,
COUNT(total_score) AS count_score,
ROUND( AVG(total_score), 3) AS average_score
FROM day_2_exam
WHERE total_score != 35
GROUP BY result_status

--OUTPUT
result_status   count_score   average_score
Fail            18            24.667
Pass            21            35.905

--Q18: Group students by score ranges (0-20, 21-30, 31-40, 41-50) and show count for each range.
SELECT
CASE
WHEN total_score BETWEEN 0 AND 20 THEN '0-20'
WHEN total_score BETWEEN 21 AND 30 THEN '21-30'
WHEN total_score BETWEEN 31 AND 40 THEN '31-40'
WHEN total_score BETWEEN 41 AND 50 THEN '41-50'
END AS score_range,
COUNT(*) AS number_of_students
FROM day_2_exam
GROUP BY score_range

--OUTPUT
score_range   number_of_students
0-20          2
21-30         20
31-40         17
41-50         3

--Q19: For each result status, show count of students with scores greater than 30 and less than 40.
SELECT
result_status,
COUNT(total_score) AS students_score_count
FROM day_2_exam
WHERE total_score > 30 and total_score < 40
GROUP BY result_status

--OUTPUT
result_status   students_score_count
Pass            19

--Q20: Group by first letter of student name and show count and average score for each letter.
SELECT
SUBSTR(student_name, 1, 1) AS first_letter,
COUNT(*) AS student_count,
ROUND(AVG(total_score), 2) AS average_score
FROM day_1_exam
GROUP BY first_letter
ORDER BY first_letter

--OUTPUT
first_letter   student_count   average_score   
A              9               35.22
B              1               43.00
E              1               21.00
F              1               36.00
H              3               41.33
J              1               29.00
K              1               27.00
L              1               39.00
M              6               31.17  
N              4               36.00
P              4               31.00
R              4               30.75
S              12              32.08
T              1               46.00
V              1               28.00
z              2               36.00
