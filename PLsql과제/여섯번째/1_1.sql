create or replace trigger New_Movieexec
before insert or update on Movieexec
for each row
declare
    certno movieexec.certno%type;
    ran_addr moviestar.address%type;
    pragma autonomous_transaction;
begin
    select address into ran_addr from (select * from moviestar where gender = 'male' order by dbms_random.random) where rownum = 1;
    :new.address := ran_addr;
end
commit;