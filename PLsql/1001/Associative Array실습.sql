declare
    type n_ty is table of varchar(50) index by varchar(50);/*문자열의 첨자값도 varchar로 해주었다*/
    nums n_ty;
    i varchar(50);/*첨자값을 임시로 넣을 변수 자료형을 같게*/
begin
    nums('One') := '하나';/*튜플의 one을 하나로 바꿔주엇다*/
    nums('Two') := '둘';
    nums('Three') := '셋';
    nums('Four') := '넷';
    nums('Five') := '다섯';
    
    i := nums.first;
    while i is not null loop/*null이 아닐때까지 loop하거라*/
        dbms_output.put_line(nums(i));
        i := nums.next(i); /*i의 index값을 다음걸로 바꿔줌 i++같은거*/
    end loop;

end;