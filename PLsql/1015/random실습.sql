select trunc(dbms_random.value(1,10)) from dual;/*random값을 뽑아줌 10은 안나오고 9.9999같이 10 아래 수만 해당 10+1로 해주면 max값도 포함해서 나옴*/
-- trunc()를하면 소숫점을 때준다
select dbms_random.string('U',10)from dual;/*10자리 대문자가 랜덤하게 나옴*/
select dbms_random.string('X',10)from dual;/*10자리 대문자+숫자가 랜덤하게 나옴*/
select dbms_random.string('L',10)from dual;/*10자리 소문자가 랜덤하게 나옴*/
select dbms_random.string('X',trunc(dbms_random.value(5,20+1)))from dual;/*가변길이 대문자+숫자가 랜덤하게 나옴*/
select to_char(sysdate, 'yyyy-mm-dd') from dual;/*to_char를 이용해서 내가원하는 형식으로 뽑아낸다)*/
select to_char(systimestamp, 'yy/mm/dd hh:mi:ss') from dual;/*시간까지 뽑아 내기*/
select to_char(12354534.5678, '999,999,999.99') from dual;/*숫자를 원한는형식으로 할때는 숫자 9를 이용*/
select to_char(1235.5678,'000,000,000.00') from dual;/*비는 수만큼 0으로 체운다*/
select '010-'||to_char(trunc(dbms_random.value(1,10000)), '0009')||'-'||to_char(trunc(dbms_random.value(1,10000)), '0009')from dual;/*전화번호 랜덤 생성*/
select to_date('19500101','yyyymmdd') + dbms_random.value(1,50*365)from dual;/*하루에서 50년 사이를 랜덤하게 증가시킴*/
select sysdate-dbms_random.value(1,50*365)from dual;/*오늘 날짜 기준으로 50년까지 뺀다*/

