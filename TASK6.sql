
--Task 6:
--A large enterprise wants to implement a data auditing and tracking system for its employee database. Every time an employee record is inserted, updated, or deleted, the system must automatically record the old and new values,
--the user performing the operation, and the timestamp.The auditing mechanism should work transparently without requiring manual intervention from developers or users. Additionally, the system should correctly handle different operations by distinguishing between 
--inserted, deleted, and updated values.
-- Task:
 --Design and implement a trigger-based solution that:
--Automatically logs all INSERT, UPDATE, and DELETE operations
--Stores both old and new values where applicable
--Records user and timestamp information
--Uses appropriate trigger features to differentiate operations

create table audit_table(
employee_id int,
first_name varchar2(50),
email varchar2(50),
salary number,
username varchar2(50),
action varchar2(50),
timee date);

create or replace trigger inserttrig
before insert on employees
for each row
begin
   dbms_output.put_line('rows being inserted.');
end;
/

create or replace trigger inserttrigg
after insert on employees
for each row
begin
   insert into audit_table(employee_id,first_name,email,salary,username,action,timee)
   values(:new.employee_id,:new.first_name,:new.email,:new.salary,user,'AFTER INSERT',sysdate);
end;
/

create or replace trigger updatetrigg
before update on employees
for each row
begin
   insert into audit_table(employee_id,first_name,email,salary,username,action,timee)
   values(:old.employee_id,:old.first_name,:old.email,:old.salary,user,'BEFORE UPDATE',sysdate);
end;
/

create or replace trigger updateetrigg
after update on employees
for each row
begin
   insert into audit_table(employee_id,first_name,email,salary,username,action,timee)
   values(:new.employee_id,:new.first_name,:new.email,:new.salary,user,'AFTER UPDATE',sysdate);
end;
/

create or replace trigger deltrigg
before delete on employees
for each row
begin
   insert into audit_table(employee_id,first_name,email,salary,username,action,timee)
   values(:old.employee_id,:old.first_name,:old.email,:old.salary,user,'BEFORE DELETE',sysdate);
   raise_application_error(-20001,'cannot delete the table');
end;
/

create or replace trigger deletetrigg
after delete on employees
for each row
begin
   dbms_output.put_line('table has already been deleted.');
end;
/

