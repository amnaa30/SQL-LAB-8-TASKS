
-Task 4
 --Create a system where:
--INSERT/UPDATE/DELETE triggers log data
--Uses :NEW and :OLD
--Maintain audit table

create table loggtable(
employee_id varchar2(50),
salary number,
email varchar2(50),
action varchar2(50),
logtime date);

create or replace trigger systrig
before insert on employees
for each row
begin 
    dbms_output.put_line('rows are being inserted.');
end;
/

create or replace trigger systriggg
after insert on employees
for each row
begin 
    insert into loggtable(employee_id,salary,email,action,logtime)
    values(:new.employee_id,:new.salary,:new.email,'AFTER INSERT',sysdate);
end;
/

create or replace trigger systrigg
before update on employees
for each row
begin 
    insert into loggtable(employee_id,salary,email,action,logtime)
    values(:old.employee_id,:old.salary,:old.email,'BEFORE UPDATE',sysdate);
end;
/

create or replace trigger systrigggg
after update on employees
for each row
begin 
    insert into loggtable(employee_id,salary,email,action,logtime)
    values(:new.employee_id,:new.salary,:new.email,'AFTER UPDATE',sysdate);
end;
/

create or replace trigger systriggggg
before delete on employees
for each row
begin 
    insert into loggtable(employee_id,salary,email,action,logtime)
    values(:old.employee_id,:old.salary,:old.email,'BEFORE DELETE',sysdate);
    raise_application_error(-20001,'can not delete it');
end;
/

create or replace trigger systrigggggg
after delete on employees
for each row
begin 
    dbms_output.put_line('table data has been removed.');
end;
/
end;
/
