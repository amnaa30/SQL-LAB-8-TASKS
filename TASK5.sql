--Task 5
 --Design system with:
--DML trigger → maintain backup table

create table backup_table(
employee_id varchar2(50),
salary number,
email varchar2(50),
action varchar2(50),
timee date);

create or replace trigger dmltrig
before insert on employees
for each row
begin 
    dbms_output.put_line('rows are being inserted.');
end;
/

create or replace trigger dmlltrig
after insert on employees
for each row
begin 
    insert into backup_table(employee_id,salary,email,action,timee)
    values(:new.employee_id,:new.salary,:new.email,'AFTER INSERT',sysdate);
end;
/

create or replace trigger dmlltrigg
before update on employees
for each row
begin 
    insert into backup_table(employee_id,salary,email,action,timee)
    values(:old.employee_id,:old.salary,:old.email,'BEFORE UPDATE',sysdate);
end;
/

create or replace trigger dmltriggg
after update on employees
for each row
begin 
    insert into backup_table(employee_id,salary,email,action,timee)
    values(:new.employee_id,:new.salary,:new.email,'AFTER UPDATE',sysdate);
end;
/

create or replace trigger ddmltrig
before delete on employees
for each row
begin 
    insert into backup_table(employee_id,salary,email,action,timee)
    values(:old.employee_id,:old.salary,:old.email,'BEFORE DELETE',sysdate);
    raise_application_error(-20001,'can not delete it');
end;
/

create or replace trigger dmlltri
after delete on employees
for each row
begin 
    dbms_output.put_line('table data has been removed.');
end;
/

--DDL trigger → log schema changes
create table log_tablee(
event_type varchar2(50),
object_name varchar2(50),
username varchar2(50),
timee date);


create or replace trigger ddltriig
before create on schema
begin
       dbms_output.put_line('no trigger as nothing new is created.');
end;
/

create or replace trigger ddllltrig
after create on schema
begin
       insert into log_tablee(event_type,object_name,username,timee)
       values(ora_sysevent,ora_dict_obj_name,user,sysdate);\
end;
/

create or replace trigger ddlltrig
before alter on schema
begin
       insert into log_tablee(event_type,object_name,username,timee)
       values(ora_sysevent,ora_dict_obj_name,user,sysdate);
end;
/

create or replace trigger ddltrigggg
after alter on schema
begin
       insert into log_tablee(event_type,object_name,username,timee)
       values(ora_sysevent,ora_dict_obj_name,user,sysdate);
end;
/

create or replace trigger ddltriggg
before drop on schema
begin
       insert into log_tablee(event_type,object_name,username,timee)
       values(ora_sysevent,ora_dict_obj_name,user,sysdate);
       raise_application_error(-20001,'table cannot be dropped.');
end;
/

create or replace trigger ddltrigg
after drop on schema
begin
       dbms_output.put_line('table has been dropped.');
end;
/

--SYSTEM trigger → log login/logout
create table loginnnn(
username varchar2(50),
timee date);

create or replace trigger loggttrig
after logon on database
begin 
   insert into loginnnn(username,timee)
   values(user,sysdate);
end;
/

create or replace trigger loggttriiig
before logoff on database
begin 
   insert into loginnnn(username,timee)
   values(user,sysdate);
end;
/

--INSTEAD OF trigger on a view

create view trigview as
select e.employee_id,d.department_name
from employees e
join departments d on d.department_id= e.department_id;

create or replace trigger insteadoftrig
instead of insert on trigview
for each row
begin
   insert into employees(employee_id,department_id)
   values(:new.employee_id,90);
end;
/
insert into trigview(employee_id,department_name)
values(207,'IT_PROG');
select * from trigview where employee_id=207;
values(207,'IT_PROG');
select * from trigview where employee_id=207;
