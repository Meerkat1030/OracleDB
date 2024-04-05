declare
    type n_ty is table of varchar(50);
    city varchar(50);
    gu varchar(50);
    dong varchar(50);
    names n_ty := n_ty('홍길동', '경성대', '강남길', '강아지');
    phone_no varchar(20);
    ins_sql varchar(200) := 'insert into people values (:1, :2, phone_tab(),addr_tab()) ';
    phone_sql varchar(200) := 'insert into table(select phone_list from people where name = :1) values(phone_ty(:2,:3,:4)) ';
    addr_sql varchar(200) := 'insert into table(select addresses from people where name = :1) values (addr_ty(:2,:3,:4)) ';
begin
    for i in 1..names.last loop
        execute immediate ins_sql using names(i), sysdate-dbms_random.value(1,60*365);
        for j in 1..dbms_random.value(1,5) loop
            phone_no := '010-'||trunc(dbms_random.value(1000,9999))||'-'||trunc(dbms_random.value(1000,9999));
            execute immediate phone_sql using names(i), 'mobile', j, phone_no;
        end loop;/*random한 개수의 전화번호를 뽑아내기*/
        
        for j in 1..dbms_random.value(1,5) loop
            get_address(city, gu, dong);
            execute immediate addr_sql using names(i), city, gu, dong;
        end loop;/*프로시저를 이용한 random한 주소 뽑아내기*/
    end loop;
end;
