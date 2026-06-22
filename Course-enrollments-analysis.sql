-- 1. Create Database and Use It
-- ---------------------------------------------------------
CREATE DATABASE IF NOT EXISTS Institute_Enrollment_DB;
USE Institute_Enrollment_DB;

-- 2. Drop Tables If They Already Exist (to reset the schema)
-- ---------------------------------------------------------
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS instructors;

SET FOREIGN_KEY_CHECKS = 1;

-- 3. Create Tables
-- ---------------------------------------------------------

-- Table: instructors
CREATE TABLE instructors (
    instructor_id     INT PRIMARY KEY,
    instructor_name   VARCHAR(100) NOT NULL,
    experience_years  INT NOT NULL
);

-- Table: students
CREATE TABLE students (
    student_id   INT PRIMARY KEY,
    name         VARCHAR(100) NOT NULL,
    gender       VARCHAR(10),
    signup_date  DATE NOT NULL,
    city         VARCHAR(50)
);

-- Table: courses
CREATE TABLE courses (
    course_id      INT PRIMARY KEY,
    course_name    VARCHAR(100) NOT NULL,
    category       VARCHAR(50) NOT NULL,
    price          DECIMAL(10,2) NOT NULL,
    instructor_id  INT,
    CONSTRAINT fk_courses_instructors
        FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id)
);

-- Table: enrollments
CREATE TABLE enrollments (
    enrollment_id    INT PRIMARY KEY,
    student_id       INT,
    course_id        INT,
    enrollment_date  DATE NOT NULL,
    progress         INT,           -- 0 to 100
    rating           FLOAT,         -- 1 to 5, can be NULL
    CONSTRAINT fk_enrollments_students
        FOREIGN KEY (student_id) REFERENCES students(student_id),
    CONSTRAINT fk_enrollments_courses
        FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- 4. Insert Sample Data
-- ---------------------------------------------------------

-- Instructors
INSERT INTO instructors (instructor_id, instructor_name, experience_years) VALUES
(11, 'Ananya Sharma', 7),
(12, 'Rahul Verma', 5),
(13, 'Meera Iyer', 3),
(14, 'Karan Singh', 10);

-- Students
INSERT INTO students (student_id, name, gender, signup_date, city) VALUES
(1,  'Arjun',    'Male',   '2024-01-10', 'Hyderabad'),
(2,  'Siri',     'Female', '2024-02-12', 'Bangalore'),
(3,  'Vikas',    'Male',   '2024-01-25', 'Mumbai'),
(4,  'Rhea',     'Female', '2024-03-01', 'Chennai'),
(5,  'Nikhil',   'Male',   '2024-02-18', 'Delhi'),
(6,  'Priya',    'Female', '2024-02-28', 'Hyderabad'),
(7,  'Rahul',    'Male',   '2024-03-05', 'Pune'),
(8,  'Ankita',   'Female', '2024-01-30', 'Bangalore'),
(9,  'Manoj',    'Male',   '2024-03-12', 'Chennai'),
(10, 'Sneha',    'Female', '2024-03-15', 'Mumbai');

-- Courses
INSERT INTO courses (course_id, course_name, category, price, instructor_id) VALUES
(101, 'Python Basics',           'Python',        5000.00, 11),
(102, 'Machine Learning',        'Data Science', 12000.00, 11),
(103, 'SQL for Analysts',        'Data Analytics', 6000.00, 12),
(104, 'Advanced Excel',          'Data Analytics', 4000.00, 13),
(105, 'Deep Learning',           'Data Science', 15000.00, 14),
(106, 'Data Visualization',      'BI & Reporting', 8000.00, 12);

-- Enrollments
INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_date, progress, rating) VALUES
(1,  1, 101, '2024-02-01', 80, 4.5),
(2,  2, 102, '2024-03-07', 50, NULL),
(3,  3, 103, '2024-03-10', 90, 5.0),
(4,  1, 102, '2024-03-11', 20, 3.5),
(5,  4, 104, '2024-03-15', 60, 4.0),
(6,  5, 101, '2024-02-20', 100, 4.8),
(7,  6, 103, '2024-03-01', 0, NULL),
(8,  7, 105, '2024-03-18', 30, 3.0),
(9,  8, 106, '2024-03-05', 70, 4.2),
(10, 9, 102, '2024-03-20', 10, NULL),
(11, 2, 103, '2024-03-22', 40, 4.0),
(12, 3, 101, '2024-02-05', 75, 4.3),
(13, 4, 106, '2024-03-25', 55, 4.1),
(14, 5, 102, '2024-03-26', 35, 3.8),
(15, 6, 105, '2024-03-28', 15, NULL),
(16, 7, 101, '2024-02-25', 60, 4.0),
(17, 8, 104, '2024-03-02', 90, 4.9),
(18, 9, 103, '2024-03-29', 25, 3.7),
(19, 10,106, '2024-03-30', 65, 4.4),
(20, 10,101, '2024-02-15', 85, 4.6);

-- =========================================================
--                   ASSIGNMENT QUESTIONS
-- =========================================================
-- Instructions for Learners:
-- 1. Do NOT modify the INSERT or CREATE TABLE statements.
-- 2. For each question, write your SQL query directly below the comment.
-- 3. Use SELECT queries only (no UPDATE/DELETE unless explicitly asked).
-- 4. Use proper formatting and aliases where needed.

-- ---------------------------------------------------------
-- SECTION A — BASIC QUERIES
-- ---------------------------------------------------------

-- Q1: Retrieve all student names and cities.
select name, city from students;

-- Q2: List all unique course categories.
select distinct(category) from courses;

-- Q3: Show all courses priced above 7000.
select course_name from courses where (price>7000);

-- Q4: Get all enrollments made in March 2024.
select enrollment_id from enrollments where month(enrollment_date) = 3;

-- Q5: Find students who signed up before 15-Feb-2024.
select student_id from students where signup_date< '2024-02-15';

-- Q6: Count the total number of students.
select count(student_id) from students;

-- Q7: List instructors with more than 5 years of experience.
select instructor_name from instructors where experience_years>5;

-- Q8: Display all courses sorted by price from high to low.
select course_name, price from courses order by price desc;

-- Q9: Retrieve course_name and price for courses in 'Python' category.
select course_name, price from courses where course_name like '%python%';

-- Q10: Show all students belonging to either Hyderabad or Bangalore.
select name, city from students where city in ('Hyderabad', 'Bangalore');


-- ---------------------------------------------------------
-- SECTION B — JOINS
-- ---------------------------------------------------------

-- Q11: Display student name, course name, and enrollment date for all enrollments.
select s.name, c.course_name, en.enrollment_date from courses as c join enrollments as en on en.course_id=c.course_id 
join students as s on s.student_id=en.student_id;

-- Q12: List all courses with their instructor names.
select c.course_name, e.instructor_name from courses as c left join instructors as e  on e.instructor_id=c.instructor_id;

-- Q13: Find students with progress >= 70% along with course names.
select s.name, c.course_name,e.progress from courses as c left join enrollments as e on e.course_id=c.course_id 
left join students as s on s.student_id=e.student_id where progress>= 70;

-- Q14: Show all enrollments where rating is not provided (NULL).
select * from enrollments where rating is null;


-- Q15: For each instructor, show the number of courses they teach.
select instructor_name, count(c.course_name) as no_of_courses_teach from courses as c 
left join instructors as i on c.instructor_id=i.instructor_id group by i.instructor_name;

-- Q16: For each student, list how many courses they have enrolled in.
select s.name, count(e.course_id) from students as s join enrollments as e on s.student_id=e.student_id group by s.name;

-- Q17: Show each course along with the number of enrollments for that course.
select c.course_name, count(e.student_id) from courses as c join enrollments as e on c.course_id=e.course_id group by course_name;

-- Q18: Retrieve student name, course name, and course price for all enrollments.
select s.name, c.course_name, sum(c.price) from courses as c left join enrollments as e on c.course_id=e.course_id 
left join students as s on e.student_id=s.student_id group by s.name, c.course_name ;

-- Q19: Find the instructor who teaches the highest-priced course (show name and course).
select i.instructor_name, c.price from instructors as i left join courses as c on c.instructor_id=i.instructor_id order by c.price desc;

-- Q20: List all students along with the category of courses they have enrolled in.
select s.name, c.category from courses as c left join enrollments as e on c.course_id=e.course_id 
left join students as s on e.student_id=s.student_id;

-- ---------------------------------------------------------
-- SECTION C — AGGREGATIONS & GROUPING
-- ---------------------------------------------------------

-- Q21: Calculate total revenue generated from all enrollments
--      (assume revenue is simply the course price per enrollment).
select sum(price) as revenue from courses as c left join enrollments as e on c.course_id=e.course_id ;

-- Q22: Find the average price of courses in each category.
-- Write your query below:
select category, avg(price) from courses group by category;


-- Q23: Count the number of enrollments per month in 2024.
-- Write your query below:
select  month(enrollment_date) as enrollment_month, count(enrollment_id) as total_enrollments from enrollments 
where year(enrollment_date) = 2024group by month(enrollment_date) order by enrollment_month;


-- Q24: Get the average rating for each course (ignore NULL ratings).
-- Write your query below:
select course_id, avg(rating) as average_rating from enrollments where rating is not null group by course_id;

-- Q25: For each student, find their maximum and minimum progress across all enrollments.
-- Write your query below:
select student_id, min(progress) as minimum_progress, max(progress) as maximum_progress from enrollments group by student_id;

-- Q26: Identify courses that have more than 2 enrollments.
-- Write your query below:
select course_id, count(enrollment_id) as total_enrollments from enrollments group by course_id having count(enrollment_id) > 2;

-- Q27: Get gender-wise student counts.
-- Write your query below:
select gender, count(gender) as count from students group by gender;


-- Q28: List cities that have more than 1 student.
-- Write your query below:
select city, count(student_id) as student_count from students where city is not null group by city having count(student_id) > 1;

-- Q29: Show category-wise total number of enrollments.
-- Write your query below:
select c.category,count(e.student_id) from courses c inner join enrollments e on e.course_id = c.course_id  group by c.category;

-- Q30: Find the course that has the highest average rating.
-- Write your query below:
select c.course_name, avg(e.rating) as avg_rating from courses c inner join enrollments e on e.course_id = c.course_id group by c.course_name 
order by avg_rating desc limit 1;

-- ---------------------------------------------------------
-- SECTION D — SUBQUERIES
-- ---------------------------------------------------------

-- Q31: Get students who enrolled in the most expensive course.
select student_id, name from students where student_id in 
(select student_id from enrollments where course_id=(select course_id from courses order by price desc limit 1));

-- Q32: List courses whose price is above the average course price.
-- Write your query below:
select course_id, course_name from courses where price > (select avg(price) from courses) order by price desc;


-- Q33: Find students who have not enrolled in any course.
-- (Hint: Use a subquery or LEFT JOIN.)
-- Write your query below:
select student_id, name from students where student_id not in (select distinct student_id from enrollments);


-- Q34: Get instructors whose courses have an average rating above 4.0.
-- Write your query below:
select instructor_id, instructor_name from instructors where instructor_id in 
(select c.instructor_id from enrollments e inner join courses c on c.course_id = e.course_id group by c.instructor_id 
having avg(e.rating) > 4.0);

-- Q35: Show all courses where at least one student has 100% progress.
-- Write your query below:
select course_id, course_name from courses where 
course_id in( select distinct course_id from enrollments where progress = 100); 

-- Q36: Retrieve students who have enrolled in more than 1 course.
-- Write your query below:
select student_id, name from students where 
student_id in (select student_id from enrollments group by student_id having count(student_id) > 1);


-- Q37: Find courses that have no enrollments.
-- Write your query below:
select course_id, course_name from courses where 
course_id in (select distinct course_id from enrollments group by course_id having count(course_id)=0); 


-- Q38: List the top 3 most expensive courses.
-- Write your query below:
select course_id, course_name, price from courses order by price desc limit 3;


-- Q39: Fetch students who enrolled in courses taught by the most experienced instructor.
-- Write your query below:
select student_id, name from students where student_id in 
(select student_id from enrollments where course_id in
(select course_id from courses where instructor_id =
(select instructor_id from instructors order by experience_years desc limit 1)));



-- Q40: Identify the latest enrollment made on the platform
--      (show student name, course name, and enrollment_date).
-- Write your query below:
select s.name as student_name, c.course_name as course_name, e.enrollment_date as enrollment_date from enrollments e
inner join students s on e.student_id = s.student_id 
inner join courses c on e.course_id = c.course_id order by e.enrollment_date desc limit 1;

-- ---------------------------------------------------------
-- SECTION E — WINDOW FUNCTIONS (If Supported)
-- ---------------------------------------------------------

-- Q41: Rank courses by price in descending order.
-- Write your query below:
select course_id, course_name, price, dense_rank() over (order by price desc) as price_rank from courses;


-- Q42: For each category, rank courses by number of enrollments (highest first).
-- Write your query below:
with CourseEnrollments as( select c.category, c.course_id, c.course_name,count(e.enrollment_id) as total_enrollments
										from courses c left join enrollments e on c.course_id = e.course_id 
                                        group by c.category, c.course_id, c.course_name)
 select category, course_id, course_name, total_enrollments, dense_rank() over (partition by category order by total_enrollments desc) 
 as course_rank from CourseEnrollments;
 

-- Q43: Show running total of revenue by enrollment_date (ordered by date).
-- Write your query below:
select e.enrollment_id, e.enrollment_date, c.course_name,c.price, sum(c.price) over 
(order by e.enrollment_date asc rows between unbounded preceding and current row) as running_revenue_total
from enrollments e inner join courses c on e.course_id = c.course_id;

-- Q44: Compute average progress per student and rank them by this average (highest first).
-- Write your query below:
with StudentAverages as (select s.student_id, s.name, avg(e.progress) as average_progress from 
students s inner join enrollments e on s.student_id = e.student_id group by s.student_id, s.name)
	select student_id, name, round(average_progress, 2) as svg_progress, dense_rank() over (order by average_progress desc) 
    as student_rank from StudentAverages;


-- Q45: For each instructor, find the highest-priced course they teach
--      using a window function.
-- Write your query below:
with RankedInstructorCourses as (select instructor_id, course_id, course_name, category, price, dense_rank() over 
(partition by instructor_id order by price desc) as price_rank from courses)
select instructor_id, course_id, course_name, category, price from RankedInstructorCourses 
where price_rank = 1;


-- Q46: For each course, show the difference between its price and the average price of all courses.
-- Write your query below:
select course_id, course_name, category, price, round(avg(price) over(), 2) as global_avg_price, 
round(price - avg(price) over (),2) as price_difference from courses;


-- Q47: For all enrollments, list student name, course name, and a row number ordered by enrollment_date.
-- Write your query below:
select row_number() over(order by e.enrollment_date asc) as row_num, s.name as student_name, c.course_name, e.enrollment_date
from enrollments e inner join students s on e.student_id = e.student_id
inner join courses c on e.course_id = c.course_id;

-- ---------------------------------------------------------
-- SECTION F — CASE EXPRESSIONS & BUSINESS LOGIC
-- ---------------------------------------------------------

-- Q48: Categorize each enrollment's progress into:
--      0–39: 'Beginner'
--      40–79: 'Intermediate'
--      80–100: 'Advanced'
-- Show student name, course name, progress, and category.
-- Write your query below:
select 
    s.name as student_name,
    c.course_name,
    e.progress,
    case 
        when e.progress between 0 and 39 then 'Beginner'
        when  e.progress between 40 and 79 then 'Intermediate'
        when  e.progress between 80 and 100 then 'Advanced'
        else 'Unknown'
    end as progress_category
from 
    enrollments e
inner join
students s ON e.student_id = s.student_id
inner join 
courses c ON e.course_id = c.course_id;

-- Q49: Create labels for course price:
--      < 5000     -> 'Low'
--      5000–10000 -> 'Medium'
--      > 10000    -> 'High'
-- Show course_name, price, and price_label.
-- Write your query below:
select course_name, price, case 
												when price <= 5000 then "Low"
                                                when price between 5001 and 10000 then "Medium"
                                                when price >= 10000 then "High"
                                                else "unpriced"
                                                end as price_lable
from courses;
                                                

-- Q50: Show a report with:
--      student name, course name, rating,
--      and rating_status = 'Rated' if rating is NOT NULL
--      else 'Not Rated'.
-- Write your query below:
select s.name as student_name, c.course_name, e.rating, case 
																									when e.rating is not null then "Rated"
                                                                                                    else "Not Rated"
                                                                                                    end as rating_status
from enrollments e inner join students s on e.student_id = s.student_id
inner join courses c on e.course_id = c.course_id;

-- =========================================================
-- END OF ASSIGNMENT
-- =========================================================
