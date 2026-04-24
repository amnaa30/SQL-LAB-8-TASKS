--Task 2
--(a) Whenever a transaction is inserted, automatically store audit data (user + time).
create table aaudittt_data(
employee_id int,
salary number ,
username varchar2(50),
added_at date);

create or replace trigger neww_triggg
after insert on employees
for each row
begin
   insert into aaudittt_data(employee_id,salary,username,added_at)
   values(:new.employee_id,:new.salary,user,sysdate);
end;
/
insert into employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id)
values(207,'amna','zahid','azaz','345.789.4444','30-jun-05','ac_account',50000,null,101,50);

select * from aaudittt_data;

--(b) Create a DDL trigger that logs all table creation.
create table log_table(
event_type varchar2(50),
object_name varchar2(50),
done_by varchar2(50),
event_time date);

create or replace trigger ddl_trig
after create on schema
begin
     insert into log_table(event_type,object_name,done_by,event_time)
     values(ora_sysevent,ora_dict_obj_name,user,sysdate);
end;
/

--(c) Prevent DROP TABLE operation on critical tables.
create table logg_table(
event_type varchar2(50),
object_name varchar2(50),
username varchar2(50),
event_date date);

create or replace trigger ddl_triggg
before drop on schema
begin 
    insert into logg_table(event_type,object_name,username,event_date)
    values(ora_sysevent,ora_dict_obj_name,user,sysdate);
    raise_application_error(-20001,'cannot drop the table, protected!');
end;
/
    raise_application_error(-20001,'cannot drop the table, protected!');
end;
/
