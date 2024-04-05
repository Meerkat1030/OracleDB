create or replace trigger insert_movie
before update on movie
for each row
declare
    avg_len movie.length%type;
    pragma autonomous_transaction;
begin
    select avg(length) into avg_len
    from movie;
    
    if :new.length < :old.length then
        :new.length := :old.length;/*before에서만 이런 형태가 가능*/
        update movieexec
        set networth = 0
        where certno = :new.producerno;
        commit;/*다른 테이블의 내용을 건드리는 작업이 일어나면 롤백을 시켜버리기때문에 commit을 시켜서 롤백을 방지*/
    end if;
end;