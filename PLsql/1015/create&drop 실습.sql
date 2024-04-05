/*desc user_tables;
select table_name from user_tables;*/
declare
    sql_str varchar(200);
    ins_str varchar(200);
    crt boolean := false;
    tbl_name constant varchar(50) := 'my_table_';
    tbl_attrs constant varchar(200) := ' (ID integer primary key, birthdate date)';/*공백 넣어주기*/
begin
    for i in 1..10 loop
        if crt then
            sql_str := 'create table '|| tbl_name || i || tbl_attrs;/*create table위에 반드시 공백을 하나 넣어줘야함*/
        else
            sql_str := 'drop table '|| tbl_name || i ;/*drop 시키기*/
        end if;/*crt가 true면 create false이면 drop시킨다*/
        execute immediate sql_str;
        
        if crt then
            ins_str := 'insert into '|| tbl_name || i || ' values (:1, :2)';/*:1자리에 :뒤에 문자열을 붙여도 된다*/
            for j in 1..3 loop
                execute immediate ins_str using j,sysdate;
            end loop;
        end if;
    end loop;
end;