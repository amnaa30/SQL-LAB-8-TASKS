--Task 7: 
--A financial organization is developing a high-security database system where all database activities must be monitored and controlled. The system should maintain: A backup of critical tables that stays synchronized automatically
--A log of all schema-level changes such as CREATE, ALTER, and DROP Monitoring of user login and logout activities Controlled updates on complex views where direct modifications are not allowed
--This system must ensure data integrity, enforce security policies, and provide full auditing capabilities across the database.
--Task:
 --Design a complete trigger-based solution that:
--Synchronizes a backup table with the main table using DML triggers
--Logs schema changes using DDL triggers
--Tracks user activity using system/event triggers
--Enables controlled modifications on a non-updatable view using INSTEAD OF triggers

create table backup_table(
employee_id int,
first_name varchar2(50),
email varchar2(50),
salary number,
action varchar2(50),
timee date);

create or replace trigger inserttrigg
after insert on employees
for each row
begin
   insert into backup_table(employee_id,first_name,email,salary,action,timee)
   values(:new.employee_id,:new.first_name,:new.email,:new.salary,'AFTER INSERT',sysdate);
end;
/

create or replace trigger updatetrigg
before update on employees
for each row
begin
   insert into backup_table(employee_id,first_name,email,salary,action,timee)
   values(:old.employee_id,:old.first_name,:old.email,:old.salary,'BEFORE UPDATE',sysdate);
end;
/

create or replace trigger updateetrigg
after update on employees
for each row
begin
   insert into backup_table(employee_id,first_name,email,salary,action,timee)
   values(:new.employee_id,:new.first_name,:new.email,:new.salary,'AFTER UPDATE',sysdate);
end;
/

create or replace trigger deltrigg
before delete on employees
for each row
begin
   insert into backup_table(employee_id,first_name,email,salary,action,timee)
   values(:old.employee_id,:old.first_name,:old.email,:old.salary,'BEFORE DELETE',sysdate);
end;
/

--Logs schema changes using DDL triggers

create table loggtable(
event_type varchar2(50),
object_name varchar2(50),
username varchar2(50),
timee date);

create or replace trigger ddlcreatee
after create on schema
begin
    insert into loggtable(event_type,object_name,username,timee)
    values(ora_sysevent,ora_dict_obj_name,user,sysdate);
end;
/

create or replace trigger ddlalterr
after alter on schema
begin
    insert into loggtable(event_type,object_name,username,timee)
    values(ora_sysevent,ora_dict_obj_name,user,sysdate);
end;
/

create or replace trigger ddldrop
before drop on schema
begin
    insert into loggtable(event_type,object_name,username,timee)
    values(ora_sysevent,ora_dict_obj_name,user,sysdate);
end;
/

--Tracks user activity using system/event triggers

create table activity(
username varchar2(50),
action varchar2(50),
timee date);

create or replace trigger loginn
after logon on database
begin 
   insert into activity(username,action,timee)
   values(user,'LOGIN',sysdate);
end;
/

create or replace trigger logginn
before logoff on database
begin 
   insert into activity(username,action,timee)
   values(user,'LOGOFF',sysdate);
end;
/

--Enables controlled modifications on a non-updatable view using INSTEAD OF triggers

create view updationview as
select e.employee_id,e.first_name,e.salary,d.department_name
from employees e
join departments d on d.department_id=e.department_id;

create or replace trigger insteadoftrigg
instead of update on updationview
for each row
begin
   update employees
   set first_name=:new.first_name,
       salary=:new.salary
   where employee_id=:old.employee_id;
end;
/
update updationview
set first_name='amna',
salary=250000
where employee_id=206;

select * from employees where employee_id = 206;
