--Task 3
-- Create a LOGON trigger that stores login time.

create table loginnn(
username varchar2(50),
login_time date);

create or replace trigger logonn
after logon on database
begin
    insert into loginnn(username,login_time)
    values(user,sysdate);
end;
/
select * from loginnn;
