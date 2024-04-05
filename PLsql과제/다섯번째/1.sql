drop table temp cascade constraints
/
drop table test cascade constraints
/
create table test (
    name    varchar(100) primary key,
    age     number(3) not null,
    address varchar(200),
    check(age > 10 and age < 110)
)
/
create table temp (
    num     number(3) primary key,
    name    varchar(100) references test(name)
)
/   
insert into test values ('H0', 23, '부산시 남구');
insert into temp values (0, 'H0');

declare
    type    n_type is table of test.name%type;
    type    a_type is table of test.age%type;
    test_n   n_type := n_type('H1', 'H2', 'H3', 'H3', 'H4');
    test_a   a_type := a_type(30, NULL, 28, 40, 5);
    temp_n  n_type := n_type();
    
    sql_str     varchar(200) := 'insert into test values (:1, :2, :3)';
    sql_str1     varchar(200) := 'insert into temp values (:1, :2)';
    a_error exception;
    PRAGMA EXCEPTION_INIT (a_error, -2292);
    b_error exception;
    PRAGMA EXCEPTION_INIT (b_error, -1400);
    c_error exception;
    PRAGMA EXCEPTION_INIT (c_error, -2291);
    d_error exception;
    PRAGMA EXCEPTION_INIT (d_error, -1);
    e_error exception;
    PRAGMA EXCEPTION_INIT (e_error, -2290);
begin
    temp_n := test_n;
    for i in test_n.first..test_n.last loop
        begin
            execute immediate sql_str using test_n(i), test_a(i), dbms_random.string('x',5)||' '||dbms_random.string('a',10);
            execute immediate sql_str1 using i, temp_n(i);
            if i = test_n.first then
                delete from test
                where name = test_n(i);
            elsif i = 3 then
                update temp
                set name = 'H5'
                where num = 3;
            end if;
        exception
--            when others then
--            dbms_output.put_line(SQLCODE||' : '||SQLERRM);/*오류코드 번호를 출력해줌 반드시 두줄을 함깨 써야됨*/
            when a_error then
                dbms_output.put_line('무결성 제약조건이 위배되었습니다 - 자식 레코드가 발견되었습니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
            when b_error then
                dbms_output.put_line('NULL을 (TEST.AGE) 안에 삽입 할 수 없습니다.');
            when c_error then
                dbms_output.put_line('무결성 제약조건이 위배 되었습니다. - 부모 키가 없습니다.');
            when d_error then
                dbms_output.put_line('무결성 제약조건에 위배됩니다.');
            when e_error then
                dbms_output.put_line('체크 제약조건이 위배되었습니다. (10 < age < 110)');
            when others then
                dbms_output.put_line('오라클 에러!');
        end;
    end loop;
    dbms_output.put_line(lpad(' ', 50, '*'));
    for t in (select * from test) loop
        dbms_output.put_line(t.name||', '||t.age||', '||t.address);
    end loop;
    dbms_output.put_line(lpad(' ', 50, '*'));
    for t in (select * from temp) loop
        dbms_output.put_line(t.num||', '||t.name);
    end loop;
    commit;
end;
