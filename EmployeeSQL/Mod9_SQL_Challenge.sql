DROP TABLE dept_emp 
DROP TABLE departments
DROP TABLE dept_manager
DROP TABLE employees
DROP TABLE salaries 
DROP TABLE titles

CREATE TABLE departments (
	dept_no VARCHAR NOT NULL,
	dept_name VARCHAR NOT NULL, 
	PRIMARY KEY (debt_no)
);

CREATE TABLE dept_emp (
	emp_no INT NOT NULL, 
	dept_no VARCHAR NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE dept_manager (
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL, 
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE employees (
	emp_no INT NOT NULL, 
	emp_title_id VARCHAR NOT NULL, 
	birth_date DATE NOT NULL, 
	first_name VARCHAR NOT NULL, 
	last_name VARCHAR NOT NULL, 
	sex VARCHAR NOT NULL, 
	hire_date DATE NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id),
	PRIMARY KEY (emp_no)
);

CREATE TABLE salaries (
	emp_no INT NOT NULL, 
	salary INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no)
);

CREATE TABLE titles (
	title_id VARCHAR NOT NULL, 
	title VARCHAR NOT NULL, 
	PRIMARY KEY (title_id)
);


--List the employee number, last name, first name, sex, and salary of each employee.
--emp_no, first_name, last_name, sex ALL in employees 
--salary in salaries 
SELECT  employees.emp_no, employees.first_name, employees.last_name, employees.sex, salaries.salary
FROM employees 
LEFT JOIN salaries 
ON employees.emp_no = salaries.emp_no;


--List the first name, last name, and hire date for the employees who were hired in 1986.
-- first_name, last_name, hire data in employees 
SELECT first_name, last_name, hire_date
FROM employees 
WHERE TO_CHAR(hire_date, 'YYYY') LIKE '1986%'


--List the manager of each department along with their department number, department name, employee number, last name, and first name.
--manager of each department (employee number) in dept_manager 
--department name in departments 
--last name, first name in employees 

SELECT dept_manager.emp_no, departments.dept_name, employees.last_name, employees.first_name
FROM dept_manager 
LEFT JOIN departments
ON dept_manager.dept_no = departments.dept_no
LEFT JOIN employees 
ON dept_manager.emp_no = employees.emp_no


--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT dept_emp.dept_no, employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
LEFT JOIN employees
ON dept_emp.emp_no = employees.emp_no
LEFT JOIN departments 
ON dept_emp.dept_no = departments.dept_no

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees 
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'

--List each employee in the Sales department, including their employee number, last name, and first name.
--Sale department = d007
SELECT emp_no, last_name, first_name
FROM employees
WHERE emp_no IN (
	SELECT emp_no
	FROM dept_emp 
	WHERE dept_no = 'd007'
)

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
--Sale department = d007, Development department = d005
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees 
LEFT JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
LEFT JOIN departments 
ON dept_emp.dept_no = departments.dept_no
WHERE dept_emp.dept_no IN('d007', 'd005') 


--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(last_name) AS "Frequency"
FROM employees
GROUP BY last_name
ORDER BY "Frequency" DESC

	
