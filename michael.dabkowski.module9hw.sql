--Create tables for csv files
create table titles(
	title_id varchar,
	title varchar,
	primary key (title_id)
);

create table departments (
	dept_no varchar,
	dept_name varchar,
	primary key (dept_no)
);

create table dept_emp (
	emp_no int,
	dept_no varchar,
	foreign key (emp_no) references employees (emp_no),
	foreign key (dept_no) references departments (dept_no),
	primary key (emp_no, dept_no)
);
	
create table dept_manager (
	dept_no varchar,
	emp_no int,
	foreign key (emp_no) references employees (emp_no),
	foreign key (dept_no) references departments (dept_no),
	primary key (dept_no, emp_no)
);

create table employees (
	emp_no INT,
	emp_title_Id varchar,
	birth_date date,
	first_name varchar,
	last_name varchar,
	sex varchar,
	hire_date date,
	foreign key (emp_title_id) references titles (title_id),
	primary key (emp_no)
);

create table salaries (
	emp_no int,
	salary int,
	foreign key (emp_no) references employees (emp_no),
		primary key (emp_no)
);
	
--confirm imports worked	
select * from titles
select * from salaries
select * from employees
select * from dept_manager
select * from dept_emp
select * from departments

--List employee number, last name, first name, sex, and salary

select emp.emp_no as employee_number, emp.last_name, emp.first_name, emp.sex, sal.salary
from employees as emp
left join salaries as sal
on emp.emp_no = sal.emp_no
order by salary desc

--list first name, last name, and hire date for employees hired in 1986

select first_name, last_name, hire_date
from employees
where hire_date between '1986-01-01' and '1986-12-31'
order by hire_date

--list manager of each department, department number, department name, employee number, last name, and first name

select departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
from departments
join dept_manager on (departments.dept_no = dept_manager.dept_no)
join employees on (dept_manager.emp_no = employees.emp_no)

--list department number for each employee, employee number, last name, first name, department name

select e.emp_no, e.last_name, e.first_name, d.dept_name, d.dept_no
from employees as e
join dept_emp as de on (e.emp_no = de.emp_no)
join departments as d on (de.dept_no = d.dept_no)
order by dept_no

--list first name, last name, and sex of each employee whos first name is Hercules and whose last name beings with 'B'

Select first_name, last_name, sex
from employees
where first_name = 'Hercules'
and last_name like 'B%'
order by last_name

--list each employee in the sales deaprtment, including their employee number, last name, and first name

select e.emp_no, e.last_name, e.first_name
from employees as e
join dept_emp on (e.emp_no = dept_emp.emp_no)
join departments on (dept_emp.dept_no = departments.dept_no)
where departments.dept_name = 'Sales'


--list each employee in the sales and development departments, including their employee number, last name, first name, and department name

select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees as e
join dept_emp as de on (e.emp_no = de.emp_no)
join departments as d on (de.dept_no = d.dept_no)
where d.dept_name = 'Sales'
or d.dept_name = 'Development'
order by dept_name

--list the frequency counts in descending order of all employee last names (how many employees share each last name).

select count(last_name) as frequency_count, last_name
from employees
group by last_name
order by count(last_name) desc