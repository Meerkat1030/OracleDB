create or replace trigger insert_movie/*befor와 다르게 이미 디비에 들어간것을 다시 고치는것 before은 들어가기전에 고쳐서 넣는거*/
after update on movie
for each row
declare
    avg_len movie.length%type;
    pragma autonomous_transaction;
begin
    /*
    select avg(length) into avg_len
    from movie;
    */
    
    if :new.length < :old.length then
--        :new.length := :old.length;
        update movie
        set length = :old.length
        where title = :new.title and year = :new.year;
        commit;/*결론 : after를 이용해선 안됨 답이 없음*/
    end if;
end;