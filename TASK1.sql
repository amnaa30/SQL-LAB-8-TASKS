Task 1 
 --(a) Create a BEFORE INSERT trigger that displays a message when a record is inserted.

create or replace trigger employees_trig 
before insert on employees
for each row
begin 
   dbms_output.put_line('a new record is being inserted/');
end;
/
Insert into employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id)
values(207,'allan','walker','alannwa','780.569.2222','30-jun-05','IT_PROG',50000,null,100,90);
select * from employees where employee_id=207;

 --(b) Create a BEFORE UPDATE trigger that prints username.
 create or replace trigger updatee_trig
 before update on employees
 for each row
 begin
     dbms_output.put_line('username:' || user);
end;
/
update employees
set first_name='amna'
where employee_id=207;

select * from employees where employee_id=207;

--(c) Create a trigger that prevents salary update if salary > 20000.
create or replace trigger updatesalarytrig
before update on employees
for each row
begin 
    if :new.salary > 20000 then
    raise_application_error(-20001,'can not add salary greater than 20000');
    end if;
end;
/

update employees
set salary=25000
where employee_id=207;

select * from employees where employee_id=207;

--(d) Create a trigger that logs deleted employee records into another table.
CREATE TABLE deleted_employees_log(
    employee_id NUMBER,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    salary NUMBER,
    deleted_at DATE
);

CREATE OR REPLACE TRIGGER delete_trig
BEFORE DELETE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO deleted_employees_log
    VALUES(:OLD.employee_id, :OLD.first_name, 
           :OLD.last_name, :OLD.salary, SYSDATE);
END;
/
DELETE FROM employees WHERE employee_id = 207;
SELECT * FROM deleted_employees_log;
DELETE FROM employees WHERE employee_id = 207;
SELECT * FROM deleted_employees_log;
