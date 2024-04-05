create or replace trigger insert_movie
before insert on movie
for each row
declare
    avg_len movie.length%type;
begin
    select avg(length) into avg_len
    from movie;
    
    if :new.length is null or :new.length < avg_len then
        :new.length := avg_len;
    end if;
end;