var average number;
var cnt number;
var sname varchar2;

execute get_StarInfo('carrie fisher', :sname,:cnt,:average);

print sname;
print cnt;
print average;
