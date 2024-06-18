--Day4 Oracle join
select emp_id , emp_name , dept_code dept_id , dept_title from employee
join department on dept_code = dept_id;

select dept_id dept_title from department;

select job_code ,job_name from job;
select emp_id , emp_name , employee.job_code ,job.job_code , job.job_name from employee
join job on employee.job_code = job.job_code; -- job code 이름이 같아서 명시 해야함