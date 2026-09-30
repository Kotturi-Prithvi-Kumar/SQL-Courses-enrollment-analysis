# 🎓 Course Enrollment Analysis (SQL)

> SQL analysis of course enrollment trends — schema design, joins, aggregations and window functions.

## The Problem
Given enrollment records across courses, answer the questions a program manager would actually ask: which courses are growing, where do students drop off, and what do enrollment patterns look like over time?

## The Data
Relational schema (`Schema.sql`) with enrollment/course tables; analysis queries in `Course-enrollments-analysis.sql`.

## Approach
- Designed a normalized schema for courses, students and enrollments.
- Wrote analytical queries using **JOINs, GROUP BY aggregations, CTEs and window functions** (running totals, rankings, period-over-period comparisons).

## Key Findings
- [e.g. Top 3 courses by enrollment — fill in]
- [e.g. Enrollment trend: growing/declining segments — fill in]
- [e.g. Any notable drop-off or seasonality — fill in]

## Tech Stack
SQL (MySQL/PostgreSQL/SQLite compatible)

## Project Structure
```
├── Schema.sql                     # Table definitions
└── Course-enrollments-analysis.sql # Analysis queries
```

## How to Run
Load `Schema.sql` into your database of choice, then run the queries in `Course-enrollments-analysis.sql` section by section.
