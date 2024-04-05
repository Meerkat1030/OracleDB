var sname varchar2;
var pname varchar2;
var len binary_float;

execute get_info('star wars',1977, :sname, :pname, :len);
--여기서 :sname은 밖에서 선언된 sname이다라고 표현

print sname;
print pname;
print len;
