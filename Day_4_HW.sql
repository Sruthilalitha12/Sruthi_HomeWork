--Q1. Find the names of students who improved their scores every single day (Day 3 > Day 2 AND Day 2 > Day 1). 
--Also, display the name of the Month they were born in using a date function.

select
t1.full_name,
to_char(dob, 'Month') as birth_month,
t2.total_score as day1,
t3.total_score as day2,
t4.total_score as day3
from "RSVP_New" as t1
left join day_1_exam as t2 on t1.hall_ticket_no = t2.hall_ticket_no
left join day_2_exam as t3 on t1.hall_ticket_no = t3.hall_ticket_no
left join day_3_exam as t4 on t1.hall_ticket_no = t4.hall_ticket_no
where t2.total_score < t3.total_score
and t3.total_score < t4.total_score
order by 5 desc


--Q2. List the names and contact numbers of students who attended the Day 1 AND Day 2 exams, but EXCEPT those who showed up for Day 3.

select
full_name,
contact_no
from "RSVP_New"
where hall_ticket_no in(
select hall_ticket_no from day_1_exam
intersect
select hall_ticket_no from day_2_exam
except
select hall_ticket_no from day_3_exam 
)


--Q3. Find the students who registered in the Morning (before 12:00 PM) and scored higher than the average class score of Day 3.

select
t1.full_name,
t1.created_at,
t2.total_score
from
"RSVP_New" as t1
join day_3_exam as t2
on t1.hall_ticket_no = t2.hall_ticket_no
where
extract(hour from created_at) < 12 and
total_score > (select avg(total_score) from day_3_exam)
order by total_score desc


--Q4. Create a master leaderboard. Combine the Hall Ticket Numbers and scores from all 3 days. 
--Use a CASE statement to label them: if the combined score across all 3 days is >120, they are a 'GOAT', otherwise 'Rising Legend'

select
t1.hall_ticket_no,
(sum(t2.total_score) + sum(t3.total_score) + sum(t4.total_score)) as total_points,
case
when (sum(t2.total_score) + sum(t3.total_score) + sum(t4.total_score)) > 120 then 'GOAT'
else 'Rising Legend'
end as final_status
from "RSVP_New" as t1
join day_1_exam as t2
on t1.hall_ticket_no = t2.hall_ticket_no
join day_2_exam as t3
on t1.hall_ticket_no = t3.hall_ticket_no
join day_3_exam as t4
on t1.hall_ticket_no = t4.hall_ticket_no
group by 1
order by 2 desc
