drop table MovieInfo;
drop type star_tab;
drop type star_ty;
drop type studio_tab;
drop type studio_ty;

create type star_ty as object (
  name      varchar2(30),
  salary    number
);/*영화배우이름, 계약금액*/
/
create type studio_ty as object (
  name        varchar2(30),
  investment   number
);/*영화사 이름, 투자액수정보*/
/
create or replace type star_tab as table of star_ty;
/
create or replace type studio_tab as table of studio_ty;
/
create table MovieInfo (
  title   varchar2(255),
  year    smallint,
  length  smallint,
  stars   star_tab,
  studios studio_tab)/*영화를 만드는데 참여한 영화사 정보*/
  nested table stars store as s_table
  nested table studios store as st_table;
/
commit;