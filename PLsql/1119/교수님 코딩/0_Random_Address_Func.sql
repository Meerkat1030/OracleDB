create or replace function Random_Address
return varchar
is
  type names is table of varchar(50);
  city  names := names('부산시', '서울시', '광주시', '전주시', '대구시', '울산시', '포항시', '제주시', '대전시');
  gu    names := names('해운대구', '남구', '중구', '북구', '수영구', '동작구', '서구', '사상구', '강남구');
  dong  names := names('대연동', '대잠동', '노량진동', '대이동', '민락동', '남천동','용호동', '대방동', '광안동');
  addr  varchar(200);
begin
  addr := city(trunc(DBMS_RANDOM.value(1,city.last+1)));
  addr := addr||' '||gu(trunc(DBMS_RANDOM.value(1,gu.last+1)));
  addr := addr||' '||dong(trunc(DBMS_RANDOM.value(1,dong.last+1)));
  
  return addr;
end;
