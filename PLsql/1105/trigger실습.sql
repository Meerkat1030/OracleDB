create or replace trigger logging_moviedb
after insert or delete or UPDATE OF length, studioname on movie/*movie에 대한 insert, delete, length&studioname의 update 이벤트후에 실행이 되어라*/
for each row /*10개의 튜플이나오면 10개에 대하여 트리거가 10번다 돌게 하여라, 반드시 넣어주기*/
declare
begin
    if inserting then
    insert into dml_history values ('insertion', SYSTIMESTAMP, 'MOVIE', '-', '*', :new.title||:new.year);/*dml history의 순서대로 넣어주기*/
    elsif deleting then
    insert into dml_history values ('deletion', SYSTIMESTAMP, 'MOVIE', '-', :old.title||:old.year, '*');/*dml history의 순서대로 넣어주기*/
    elsif updating('length') then
    insert into dml_history values ('update', SYSTIMESTAMP, 'MOVIE', 'LENGTH', :old.length, :new.length);
    elsif updating('studioname') then
    insert into dml_history values ('update', SYSTIMESTAMP, 'MOVIE', 'STUDIONAME', :old.studioname, :new.studioname);
    end if;
end;
