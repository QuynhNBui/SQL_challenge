SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;

--1. List the following details of each employee: 
-- employee number, last name, first name, gender, and sala
ry.
CREATE VIEW employ_info AS
SELECT em.emp_no, em.last_name, em.first_name, em.gender, s.salary
FROM employees AS em
LEFT JOIN salaries AS s
ON em.emp_no = s.emp_no;
SELECT * FROM employ_info;

-- 2. List employees who were hired in 1986.
CREATE VIEW hire_data AS
SELECT em.emp_no, em.last_name, em.first_name, em.hire_date
FROM employees AS em
WHERE EXTRACT (YEAR FROM hire_date) = 1986;
SELECT * FROM hire_data;

--3. List the manager of each department with the following information:
-- department number, department name, the manager's employee number, 
-- last name, first name, and start and end employment dates.

CREATE VIEW manager_info AS
SELECT dep.dept_no, dep.dept_name, ma.emp_no, em.last_name, em.first_name,
       ma.from_date, ma.to_date
FROM dept_manager AS ma
LEFT JOIN departments AS dep
ON ma.dept_no = dep.dept_no
left JOIN employees AS em
ON ma.emp_no = em.emp_no;
SELECT * FROM manager_info;

--4.List the department of each employee with the following information:
-- employee number, last name, first name, and department name.
CREATE VIEW employee_department_info AS
SELECT em.emp_no, em.last_name, em.first_name, dep.dept_name  
FROM employees AS em
LEFT JOIN dept_emp AS de
ON em.emp_no = de.emp_no
LEFT JOIN departments AS dep
ON de.dept_no = dep.dept_no;
SELECT * FROM employee_department_info;

--5. List all employees whose first name is "Hercules" and last names 
-- begin with "B."

SELECT em.last_name, em.first_name
FROM employees AS em
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

--6. List all employees in the Sales department, including their employee 
--number, last name, first name, and department name.
CREATE VIEW sales_emp AS
SELECT * FROM employee_department_info
where dept_name = 'Sales';
SELECT * FROM sales_emp;

--7 List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and 
-- department name.
CREATE VIEW sales_dev_emp AS
SELECT * FROM employee_department_info
WHERE dept_name = 'Sales'
OR dept_name = 'Development';
SELECT * FROM sales_dev_emp;

--8 In descending order, list the frequency count of employee last 
--names, i.e., how many employees share each last name.
CREATE VIEW last_name_count AS
SELECT last_name, COUNT(emp_no) AS number_of_employee
FROM employees
GROUP BY last_name
ORDER BY number_of_employee DESC;
SELECT * FROM last_name_count;