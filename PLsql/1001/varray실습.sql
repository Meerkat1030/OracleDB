declare
    type n_ty is varray(10) of varchar(100);/*크기 10짜리 배열생성*/
    nums n_ty := n_ty();/*이렇게 선언 안하면 오류남 존나중요 */
begin
    nums.extend(2);/*크기 지정만 해주고 생성안됨 배열을 하나의 공간 만들어줌, 딱하나만 만들어줌 (2)를 넣어주면 2칸 생성*/
    nums(1) := '하나';
    nums(2) := '둘';
    nums(3) := '-하나';
    
    for i in nums.first..nums.last loop/*처음거부터 마지막거까지 for*/
        dbms_output.put_line(nums(i));
    end loop;
end;