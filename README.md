# SQL-Views-and-Window-Fuctions

This repository provides a comprehensive overview of SQL Views and Window Functions. These are powerful concepts that allow for efficient data retrieval, manipulation, and analysis within SQL databases.

## Table of Contents

1. [SQL Views](#sql-views)
   - [Definition](#definition)
   - [Common Operations](#common-operations)
   - [Examples](#examples)
2. [SQL Window Functions](#sql-window-functions)
   - [Definition](#definition)
   - [Types of Window Functions](#types-of-window-functions)
   - [Examples](#examples)

---

## SQL Views

### Definition
A **view** in SQL is a virtual table based on the result of a SELECT query. It allows you to store complex queries as a virtual table and query them just like regular tables. Views are particularly useful for simplifying complex joins, aggregations, or filtering logic.

### Common Operations
- **Creating a View**: Use the `CREATE VIEW` statement to create a view.
- **Querying a View**: You can query a view just like a table.
- **Dropping a View**: Use the `DROP VIEW` statement to remove a view.
- **Updating Views**: Some views are updatable, meaning you can insert, update, or delete data directly in the view. However, this depends on the complexity of the view.

### Example: Create a View
```sql
-- Create a view to show employees' basic information
CREATE VIEW employee_view AS
SELECT employee_id, first_name, last_name, department, salary
FROM employees
WHERE status = 'active';
```

## SQL Window Functions
### Definition
A window function performs a calculation across a set of table rows that are related to the current row. Unlike aggregate functions, which return a single result for a group of rows, window functions allow you to retain individual rows while applying aggregate-like functions.

Window functions are commonly used for ranking, running totals, moving averages, and comparisons across rows.

### Types of Window Functions
* Ranking Functions: These include ROW_NUMBER(), RANK(), and DENSE_RANK(), used to assign a rank to each row within a partition.
* Aggregate Functions: These include SUM(), AVG(), COUNT(), MIN(), and MAX(), but they operate over a specified window of rows.
* Analytic Functions: These include LEAD() and LAG(), which allow you to access data from subsequent or preceding rows.
* NTILE(): Divides data into a specified number of buckets.
### Common Operations
* OVER() Clause: Window functions use the OVER() clause to define the window of rows.
* PARTITION BY: Used to divide the result set into partitions to perform the window function on each partition separately.
* ORDER BY: Defines the order of rows within a partition for window functions like ranking and sorting.

### Example: Using ROW_NUMBER()
```
-- Assign row numbers to employees based on their salary
SELECT employee_id, first_name, last_name, salary,
       ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
FROM employees;
```
### Example: Using SUM() with a Window Function
```
-- Calculate a running total of the sales for each employee
SELECT employee_id, sale_date, amount,
       SUM(amount) OVER (PARTITION BY employee_id ORDER BY sale_date) AS running_total
FROM sales;
```
